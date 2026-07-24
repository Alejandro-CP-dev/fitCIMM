package com.fitcimm.controller;

import com.fitcimm.model.Membresia;
import com.fitcimm.model.Plan;
import com.fitcimm.model.Socio;
import com.fitcimm.service.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/MembresiaServlet")
public class MembresiaServlet extends HttpServlet {

    private final MembresiaService membresiaService;
    private final SocioService socioService;
    private final PlanService planService;

    public MembresiaServlet() {
        this.membresiaService = new MembresiaService();
        this.socioService = new SocioService();
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
                    // Cargar listas de socios y planes activos para los combobox
                    cargarFormularioVenta(request, response);
                    break;

                case "listar":
                default:
                    listarMembresias(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("mensajeError", "Error: " + e.getMessage());
            listarMembresias(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            try {
                int idSocio = Integer.parseInt(request.getParameter("idSocio"));
                int idPlan = Integer.parseInt(request.getParameter("idPlan"));

                membresiaService.registrarVenta(idSocio, idPlan); // EVALÚA RN-02 Y RN-03
                request.setAttribute("mensajeExito", "Membresía registrada correctamente.");
                listarMembresias(request, response);

            } catch (Exception e) {
                request.setAttribute("mensajeError", e.getMessage());
                cargarFormularioVenta(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

    private void listarMembresias(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Membresia> lista = membresiaService.listarTodas();

        // Asignamos el servicio al request o calculamos el estado para cada una
        request.setAttribute("listaMembresias", lista);
        request.setAttribute("membresiaService", membresiaService); // Para invocar calcularEstado en el JSP
        request.getRequestDispatcher("views/membresia-list.jsp").forward(request, response);
    }

    private void cargarFormularioVenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Socio> sociosActivos = socioService.listarSocios();
        List<Plan> planesActivos = planService.listarPlanesActivos();

        request.setAttribute("listaSocios", sociosActivos);
        request.setAttribute("listaPlanes", planesActivos);
        request.getRequestDispatcher("views/membresia-form.jsp").forward(request, response);
    }
}
