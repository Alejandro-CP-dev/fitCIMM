package com.fitcimm.controller;

import com.fitcimm.model.Ingreso;
import com.fitcimm.service.IngresoService;
import com.fitcimm.service.IngresoService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/IngresoServlet")
public class IngresoServlet extends HttpServlet {

    private final IngresoService ingresoService;

    public IngresoServlet() {
        this.ingresoService = new IngresoService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Ingreso> listaHoy = ingresoService.listarIngresosDelDia();
        request.setAttribute("listaIngresos", listaHoy);
        request.getRequestDispatcher("views/ingreso-control.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String documento = request.getParameter("documento");

        try {
            ingresoService.registrarAcceso(documento); // EVALÚA RN-06
            request.setAttribute("mensajeExito", "✅ ACCESO PERMITIDO: Ingreso registrado exitosamente.");
        } catch (Exception e) {
            request.setAttribute("mensajeError", "❌ " + e.getMessage());
        }

        doGet(request, response);
    }
}
