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
    
    
    public void registrarAcceso(String documento) throws Exception{
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
    }
    
    public List<Ingreso> listarIngresosDelDia() {
        return ingresoDAO.listarIngresoDia();
    }

    /** RF-14: ingresos de una fecha específica elegida en el calendario. */
    public List<Ingreso> listarPorFecha(LocalDate fecha) {
        return ingresoDAO.listarIngresoPorFecha(fecha);
    }

    public List<Ingreso> listarTodos() {
        return ingresoDAO.listarTodos();
    }
}