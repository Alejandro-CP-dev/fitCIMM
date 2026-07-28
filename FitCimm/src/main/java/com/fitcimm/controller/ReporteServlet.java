package com.fitcimm.controller;

import com.fitcimm.dao.ReporteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@WebServlet("/ReporteServlet")
public class ReporteServlet extends HttpServlet {

    private final ReporteDAO reporteDAO = new ReporteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");
        if (tipo == null || tipo.isEmpty()) {
            tipo = "vigentes"; // Tab por defecto
        }

        // RF-15: Socios Vigentes
        List<Map<String, Object>> sociosVigentes = reporteDAO.obtenerSociosVigentes();
        request.setAttribute("sociosVigentes", sociosVigentes);

        // RF-16: Recaudo por Rango
        String inicioStr = request.getParameter("fechaInicio");
        String finStr = request.getParameter("fechaFin");

        LocalDate inicio = (inicioStr != null && !inicioStr.trim().isEmpty())
                ? LocalDate.parse(inicioStr)
                : LocalDate.now().withDayOfMonth(1); // Primer día del mes

        LocalDate fin = (finStr != null && !finStr.trim().isEmpty())
                ? LocalDate.parse(finStr)
                : LocalDate.now();

        List<Map<String, Object>> recaudo = reporteDAO.obtenerRecaudoPorRango(inicio, fin);

        // Calcular la suma global recaudada en el rango
        double granTotal = recaudo.stream()
                .mapToDouble(m -> (Double) m.get("totalRecaudado"))
                .sum();

        request.setAttribute("fechaInicio", inicio);
        request.setAttribute("fechaFin", fin);
        request.setAttribute("recaudoRango", recaudo);
        request.setAttribute("granTotal", granTotal);

        // RF-17: Plan más vendido del mes
        Map<String, Object> planTop = reporteDAO.obtenerPlanMasVendidoMes();
        request.setAttribute("planTop", planTop);

        request.setAttribute("tabActiva", tipo);
        request.getRequestDispatcher("reportes.jsp").forward(request, response);
    }
}
