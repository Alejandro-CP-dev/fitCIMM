/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.service;

import com.fitcimm.dao.PlanDAO;
import com.fitcimm.model.Plan;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class PlanService {

    private final PlanDAO planDAO;
    
    public PlanService() {
        this.planDAO = new PlanDAO();
    }
    
    public void registrarPlan(Plan plan) throws Exception {
        // Validaciones básicas
        if (plan.getNombre() == null || plan.getNombre().trim().isEmpty()) {
            throw new Exception("El nombre del plan es obligatorio.");
        }

        // REGLA RN-07: Duración en días > 0
        if (plan.getDuracionDias() <= 0) {
            throw new Exception("RN-07: La duración del plan debe ser mayor a 0 días.");
        }

        // REGLA RN-08: Valor del plan > 0
        if (plan.getValor() <= 0) {
            throw new Exception("RN-08: El valor del plan debe ser mayor a $0.");
        }

        plan.setActivo(true);

        boolean exito = planDAO.insertar(plan);
        if (!exito) {
            throw new Exception("Error en la base de datos al registrar el plan.");
        }
    }


    public void actualizarPlan(Plan plan) throws Exception {
        Plan existente = planDAO.buscarPorId(plan.getIdPlan());
        if (existente == null) {
            throw new Exception("El plan a actualizar no existe.");
        }

        // REGLA RN-07
        if (plan.getDuracionDias() <= 0) {
            throw new Exception("RN-07: La duración del plan debe ser mayor a 0 días.");
        }

        // REGLA RN-08
        if (plan.getValor() <= 0) {
            throw new Exception("RN-08: El valor del plan debe ser mayor a $0.");
        }

        boolean exito = planDAO.actualizar(plan);
        if (!exito) {
            throw new Exception("Error en la base de datos al actualizar el plan.");
        }
    }


    public List<Plan> listarPlanes() {
        return planDAO.listarTodos();
    }


    public List<Plan> listarPlanesActivos() {
        return planDAO.listarActivos();
    }


    public Plan obtenerPorId(int idPlan) {
        return planDAO.buscarPorId(idPlan);
    }


    public boolean inactivarPlan(int idPlan) {
        return planDAO.inactivar(idPlan);
    }
    
}
