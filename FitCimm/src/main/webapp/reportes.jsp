<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>
<%
    // Recuperar atributos enviados por el Servlet
    List<Map<String, Object>> sociosVigentes = (List<Map<String, Object>>) request.getAttribute("sociosVigentes");
    List<Map<String, Object>> recaudoRango = (List<Map<String, Object>>) request.getAttribute("recaudoRango");
    Map<String, Object> planTop = (Map<String, Object>) request.getAttribute("planTop");
    
    Double granTotalObj = (Double) request.getAttribute("granTotal");
    double granTotal = (granTotalObj != null) ? granTotalObj : 0.0;
    
    String tabActiva = (String) request.getAttribute("tabActiva");
    if (tabActiva == null) tabActiva = "vigentes";
    
    Object fInicio = request.getAttribute("fechaInicio");
    Object fFin = request.getAttribute("fechaFin");
    String fechaInicioStr = (fInicio != null) ? fInicio.toString() : "";
    String fechaFinStr = (fFin != null) ? fFin.toString() : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>FitCIMM - Módulo de Reportes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-bar-chart-line-fill text-primary"></i> Módulo de Reportes y Métricas</h2>
        <a href="index.jsp" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> Volver al Inicio</a>
    </div>

    <ul class="nav nav-tabs nav-fill mb-4" id="reportesTab" role="tablist">
        <li class="nav-item">
            <button class="nav-link <%= "vigentes".equals(tabActiva) ? "active" : "" %>" id="vigentes-tab" data-bs-toggle="tab" data-bs-target="#vigentes" type="button">
                <i class="bi bi-people-fill"></i> Socios Vigentes 
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link <%= "recaudo".equals(tabActiva) ? "active" : "" %>" id="recaudo-tab" data-bs-toggle="tab" data-bs-target="#recaudo" type="button">
                <i class="bi bi-cash-stack"></i> Recaudo por Fechas 
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link <%= "top".equals(tabActiva) ? "active" : "" %>" id="top-tab" data-bs-toggle="tab" data-bs-target="#top" type="button">
                <i class="bi bi-trophy-fill text-warning"></i> Plan Más Vendido 
            </button>
        </li>
    </ul>

    <div class="tab-content" id="reportesTabContent">
        
        <div class="tab-pane fade <%= "vigentes".equals(tabActiva) ? "show active" : "" %>" id="vigentes">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Listado de Socios Activos con Membresía Vigente</h5>
                </div>
                <div class="card-body">
                    <table class="table table-hover table-striped align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Documento</th>
                                <th>Socio</th>
                                <th>Teléfono</th>
                                <th>Plan Adquirido</th>
                                <th>Vencimiento</th>
                                <th>Días Restantes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (sociosVigentes != null && !sociosVigentes.isEmpty()) {
                                    for (Map<String, Object> s : sociosVigentes) {
                                        int dias = (s.get("diasRestantes") != null) ? (int) s.get("diasRestantes") : 0;
                            %>
                                <tr>
                                    <td><strong><%= s.get("documento") %></strong></td>
                                    <td><%= s.get("nombreSocio") %></td>
                                    <td><%= s.get("telefono") != null ? s.get("telefono") : "N/A" %></td>
                                    <td><span class="badge bg-info text-dark"><%= s.get("plan") %></span></td>
                                    <td><%= s.get("fechaFin") %></td>
                                    <td>
                                        <span class="badge <%= dias <= 5 ? "bg-warning text-dark" : "bg-success" %>">
                                            <%= dias %> días
                                        </span>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr><td colspan="6" class="text-center text-muted">No hay socios con membresía vigente actualmente.</td></tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="tab-pane fade <%= "recaudo".equals(tabActiva) ? "show active" : "" %>" id="recaudo">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <form action="ReporteServlet" method="GET" class="row g-3 align-items-end">
                        <input type="hidden" name="tipo" value="recaudo">
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Fecha Inicio:</label>
                            <input type="date" name="fechaInicio" class="form-control" value="<%= fechaInicioStr %>" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Fecha Fin:</label>
                            <input type="date" name="fechaFin" class="form-control" value="<%= fechaFinStr %>" required>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-success w-100"><i class="bi bi-filter"></i> Filtrar Recaudo</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recaudo Agrupado por Plan</h5>
                    <h5 class="mb-0">Gran Total: $<%= String.format("%.2f", granTotal) %></h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-hover">
                        <thead class="table-secondary">
                            <tr>
                                <th>Plan</th>
                                <th class="text-center">Suscripciones / Ventas</th>
                                <th class="text-end">Total Recaudado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (recaudoRango != null && !recaudoRango.isEmpty()) {
                                    for (Map<String, Object> r : recaudoRango) {
                                        double total = (r.get("totalRecaudado") != null) ? (double) r.get("totalRecaudado") : 0.0;
                            %>
                                <tr>
                                    <td><strong><%= r.get("plan") %></strong></td>
                                    <td class="text-center"><%= r.get("totalVentas") %></td>
                                    <td class="text-end fw-bold text-success">
                                        $<%= String.format("%.2f", total) %>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr><td colspan="3" class="text-center text-muted">No se registraron ventas en el rango de fechas seleccionado.</td></tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="tab-pane fade <%= "top".equals(tabActiva) ? "show active" : "" %>" id="top">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card border-warning shadow text-center">
                        <div class="card-header bg-warning text-dark fw-bold">
                            <i class="bi bi-star-fill"></i> PLAN ESTRELLA DEL MES ACTUAL
                        </div>
                        <div class="card-body py-4">
                            <% if (planTop != null && !planTop.isEmpty()) { 
                                double totalTop = (planTop.get("totalRecaudado") != null) ? (double) planTop.get("totalRecaudado") : 0.0;
                            %>
                                <h1 class="display-4 text-primary font-weight-bold"><%= planTop.get("plan") %></h1>
                                <hr>
                                <p class="fs-5">Total de Ventas: <strong><%= planTop.get("totalVentas") %> suscripciones</strong></p>
                                <p class="fs-5">Ingreso Generado: <strong class="text-success">$<%= String.format("%.2f", totalTop) %></strong></p>
                            <% } else { %>
                                <p class="text-muted fs-5 my-3">Aún no hay ventas registradas en el mes actual.</p>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>