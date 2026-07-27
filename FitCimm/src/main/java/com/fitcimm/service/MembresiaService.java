/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.service;
import com.fitcimm.dao.MembresiaDAO;
import com.fitcimm.dao.PlanDAO;
import com.fitcimm.dao.SocioDAO;
import com.fitcimm.model.Membresia;
import com.fitcimm.model.Plan;
import com.fitcimm.model.Socio;
import java.time.LocalDate;
import java.util.List;
/**
 *
 * @author Usuario
 */
public class MembresiaService {
    private final MembresiaDAO membresiaDAO;
    private final SocioDAO socioDAO;
    private final PlanDAO planDAO;
    public MembresiaService() {
        this.membresiaDAO = new MembresiaDAO();
        this.socioDAO = new SocioDAO();
        this.planDAO = new PlanDAO();
    }
    public void registrarVenta(int idSocio, int idPlan) throws Exception {
        Socio socio = socioDAO.buscarPorId(idSocio);
        if (socio == null || !socio.isActivo()) {
            throw new Exception("El socio seleccionado no existe o es encuentra inactivo");
        }
        Plan plan = planDAO.buscarPorId(idPlan);
        if (plan == null || !plan.isActivo()) {
            throw new Exception("El plan seleccionado no existe o está inactivo");
        }

        // RN-03: si el socio ya tiene una membresía vigente o por vencer,
        // la nueva NO se bloquea; simplemente empieza el día siguiente
        // al vencimiento de la actual, encadenando los días.
        Membresia ultima = membresiaDAO.obtenerUltimaMembresia(idSocio);
        LocalDate fechaInicio;
        if (ultima != null && !ultima.getFechaFin().isBefore(LocalDate.now())) {
            fechaInicio = ultima.getFechaFin().plusDays(1);
        } else {
            fechaInicio = LocalDate.now();
        }

        Membresia nuevaMembresia = new Membresia();
        nuevaMembresia.setSocio(socio);
        nuevaMembresia.setPlan(plan);
        nuevaMembresia.setValorPagado(plan.getValor());
        nuevaMembresia.setFechaInicio(fechaInicio);

        // RN-02: la fecha de fin siempre se calcula, nunca se digita a mano.
        LocalDate fechaFin = fechaInicio.plusDays(plan.getDuracionDias());
        nuevaMembresia.setFechaFin(fechaFin);

        boolean exito = membresiaDAO.registrar(nuevaMembresia);
        if (!exito) {
            throw new Exception("Error al pasar el registro de la membresía en la base de datos.");
        }
    }
    public List<Membresia> listarTodas() {
        return membresiaDAO.listarTodas();
    }
    public List<Membresia> listarPorSocio(int idSocio) {
        return membresiaDAO.listarPorSocio(idSocio);
    }
    public String calcularEstado(Membresia membresia) {
        if (membresia == null || membresia.getFechaFin() == null) {
            return "DESCONOCIDO";
        }
        LocalDate hoy = LocalDate.now();
        LocalDate fechaFin = membresia.getFechaFin();
        if (fechaFin.isBefore(hoy)) {
            return "VENCIDA";
        }
        // Calcular los días restantes entre hoy y la fecha de fin
        long diasRestantes = java.time.temporal.ChronoUnit.DAYS.between(hoy, fechaFin);
        if (diasRestantes >= 0 && diasRestantes <= 5) {
            return "POR VENCER";
        } else {
            return "VIGENTE";
        }
    }
}