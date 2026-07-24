package com.fitcimm.controller;

import com.fitcimm.model.Plan;
import com.fitcimm.service.PlanService;
import com.fitcimm.service.PlanService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/PlanServlet")
public class PlanServlet extends HttpServlet {

    private final PlanService planService;

    public PlanServlet() {
        this.planService = new PlanService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "nuevo":
                    request.getRequestDispatcher("views/plan-form.jsp").forward(request, response);
                    break;

                case "editar":
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    Plan planEditar = planService.obtenerPorId(idEditar);
                    request.setAttribute("plan", planEditar);
                    request.getRequestDispatcher("views/plan-form.jsp").forward(request, response);
                    break;

                case "inactivar":
                    int idInactivar = Integer.parseInt(request.getParameter("id"));
                    planService.inactivarPlan(idInactivar);
                    request.setAttribute("mensajeExito", "Plan inactivado correctamente.");
                    listarPlanes(request, response);
                    break;

                case "listar":
                default:
                    listarPlanes(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("mensajeError", "Error: " + e.getMessage());
            listarPlanes(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            guardarOActualizarPlan(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void listarPlanes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Plan> lista = planService.listarPlanes();
        request.setAttribute("listaPlanes", lista);
        request.getRequestDispatcher("views/plan-list.jsp").forward(request, response);
    }

    private void guardarOActualizarPlan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idPlan");
        String nombre = request.getParameter("nombre");
        String duracionStr = request.getParameter("duracionDias");
        String valorStr = request.getParameter("valor");

        Plan plan = new Plan();
        if (idStr != null && !idStr.trim().isEmpty()) {
            plan.setIdPlan(Integer.parseInt(idStr));
        }

        plan.setNombre(nombre);

        try {
            int duracion = (duracionStr != null && !duracionStr.trim().isEmpty()) ? Integer.parseInt(duracionStr) : 0;
            double valor = (valorStr != null && !valorStr.trim().isEmpty()) ? Double.parseDouble(valorStr) : 0.0;

            plan.setDuracionDias(duracion);
            plan.setValor(valor);

            if (plan.getIdPlan() > 0) {
                planService.actualizarPlan(plan);
                request.setAttribute("mensajeExito", "Plan actualizado correctamente.");
            } else {
                planService.registrarPlan(plan); // EVALÚA RN-07 Y RN-08
                request.setAttribute("mensajeExito", "Plan registrado correctamente.");
            }

            listarPlanes(request, response);

        } catch (Exception e) {
            request.setAttribute("mensajeError", e.getMessage());
            request.setAttribute("plan", plan);
            request.getRequestDispatcher("views/plan-form.jsp").forward(request, response);
        }
    }
}
