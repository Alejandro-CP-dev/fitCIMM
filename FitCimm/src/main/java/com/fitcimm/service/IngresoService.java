/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.service;
import com.fitcimm.dao.IngresoDAO;
import com.fitcimm.dao.MembresiaDAO;
import com.fitcimm.dao.SocioDAO;
import com.fitcimm.model.Ingreso;
import com.fitcimm.model.Membresia;
import com.fitcimm.model.Socio;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
/**
 *
 * @author Usuario
 */
public class IngresoService {
    
    private final IngresoDAO ingresoDAO;
    private final SocioDAO socioDAO;
    private final MembresiaDAO membresiaDAO;
    private final MembresiaService membresiaService;
    
    public IngresoService() {
        this.ingresoDAO = new IngresoDAO();
        this.socioDAO = new SocioDAO();
        this.membresiaDAO = new MembresiaDAO();
        this.membresiaService = new MembresiaService();
    }

    /** Resultado de un ingreso exitoso: nombre del socio y días que le restan (RF-13). */
    public static class ResultadoAcceso {
        private final String nombreSocio;
        private final long diasRestantes;

        public ResultadoAcceso(String nombreSocio, long diasRestantes) {
            this.nombreSocio = nombreSocio;
            this.diasRestantes = diasRestantes;
        }

        public String getNombreSocio() {
            return nombreSocio;
        }

        public long getDiasRestantes() {
            return diasRestantes;
        }
    }
    
    public ResultadoAcceso registrarAcceso(String documento) throws Exception{
        if (documento == null || documento.trim().isEmpty()) {
            throw new Exception("Debe ingresar un número de documento.");
        }
        // 1. Verificar si existe el socio
        Socio socio = socioDAO.buscarPorDocumento(documento.trim());
        if (socio == null) {
            throw new Exception("No existe ningún socio registrado con el documento: " + documento);
        }
        if (!socio.isActivo()) {
            throw new Exception("El socio se encuentra inactivo en el sistema.");
        }
        // 2. Verificar duplicidad de ingreso en el mismo día
        if (ingresoDAO.yaIngresoHoy(socio.getIdSocio())) {
            throw new Exception("El socio " + socio.getNombres() + " " + socio.getApellidos() + " ya registró su ingreso el día de hoy.");
        }
        // 3. Verificar membresía 
        Membresia ultimaMembresia = membresiaDAO.obtenerUltimaMembresia(socio.getIdSocio());
        if (ultimaMembresia == null) {
            throw new Exception("ACCESO DENEGADO: El socio no cuenta con ninguna membresía adquirida.");
        }
        String estado = membresiaService.calcularEstado(ultimaMembresia);
        if ("VENCIDA".equals(estado)) {
            throw new Exception("ACCESO DENEGADO: La membresía del socio venció el " + ultimaMembresia.getFechaFin() + ".");
        }
        // 4. Si la membresía está VIGENTE o POR VENCER, se autoriza e inserta el ingreso
        Ingreso nuevoIngreso = new Ingreso();
        nuevoIngreso.setSocio(socio);
        nuevoIngreso.setFechaIngreso(LocalDate.now());
        nuevoIngreso.setHoraIngreso(LocalTime.now());
        boolean exito = ingresoDAO.registrarIngreso(nuevoIngreso);
        if (!exito) {
            throw new Exception("Error al registrar la entrada en la base de datos.");
        }

        // 5. Calcular días restantes para devolverlos en el mensaje de bienvenida
        long diasRestantes = ChronoUnit.DAYS.between(LocalDate.now(), ultimaMembresia.getFechaFin());
        String nombreCompleto = socio.getNombres() + " " + socio.getApellidos();
        return new ResultadoAcceso(nombreCompleto, diasRestantes);
    }
    
    public List<Ingreso> listarIngresosDelDia() {
        List<Ingreso> lista = ingresoDAO.listarIngresoDia();
        completarDiasRestantes(lista);
        return lista;
    }

    /** RF-14: ingresos de una fecha específica elegida en el calendario. */
    public List<Ingreso> listarPorFecha(LocalDate fecha) {
        List<Ingreso> lista = ingresoDAO.listarIngresoPorFecha(fecha);
        completarDiasRestantes(lista);
        return lista;
    }

    public List<Ingreso> listarTodos() {
        List<Ingreso> lista = ingresoDAO.listarTodos();
        completarDiasRestantes(lista);
        return lista;
    }

    /**
     * Para cada ingreso, busca la última membresía del socio y calcula
     * cuántos días le restan (puede ser negativo si ya venció).
     * Si el socio nunca ha comprado un plan, queda en null.
     */
    private void completarDiasRestantes(List<Ingreso> lista) {
        for (Ingreso ingreso : lista) {
            Membresia ultima = membresiaDAO.obtenerUltimaMembresia(ingreso.getSocio().getIdSocio());
            if (ultima != null) {
                long dias = ChronoUnit.DAYS.between(LocalDate.now(), ultima.getFechaFin());
                ingreso.setDiasRestantesMembresia(dias);
            }
        }
    }
}