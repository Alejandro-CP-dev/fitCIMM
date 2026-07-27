<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fitcimm.model.Ingreso" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Control de Acceso - FitCIMM</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --fc-navy: #10233e;
                --fc-navy-2: #17335a;
                --fc-orange: #ff7a1a;
                --fc-mint: #0fbf8f;
                --fc-mint-2: #13d6a3;
                --fc-blue: #2f6fed;
                --fc-purple: #7c5cff;
                --fc-bg: #f4f6fa;
                --fc-text: #2a3242;
                --fc-muted: #6b7488;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: var(--fc-bg);
                color: var(--fc-text);
            }
            h1, h2, h3, h4, h5, .navbar-brand {
                font-family: 'Poppins', sans-serif;
            }

            /* NAVBAR (idéntica al resto del sistema) */
            .navbar {
                background: var(--fc-navy) !important;
                padding-top: .85rem;
                padding-bottom: .85rem;
            }
            .navbar-brand {
                font-weight: 800;
                letter-spacing: .3px;
                display: flex;
                align-items: center;
                gap: .5rem;
            }
            .navbar-brand .bi {
                color: var(--fc-orange);
                font-size: 1.4rem;
            }
            .navbar-nav .nav-link {
                font-weight: 500;
                color: rgba(255,255,255,.75) !important;
                margin: 0 .15rem;
                border-radius: 8px;
                padding: .5rem .9rem !important;
                transition: all .2s ease;
            }
            .navbar-nav .nav-link:hover {
                color: #fff !important;
                background: rgba(255,255,255,.08);
            }
            .navbar-nav .nav-link.active {
                color: #fff !important;
                background: var(--fc-orange);
            }

            /* PAGE HEADER */
            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
                margin: 1.8rem 0 1.4rem;
            }
            .page-header h2 {
                font-weight: 700;
                margin: 0;
            }
            .page-header .subtitle {
                color: var(--fc-muted);
                font-size: .92rem;
                margin-top: .15rem;
            }

            .btn-fc-outline {
                border: 1px solid #d8dde8;
                color: var(--fc-text);
                font-weight: 600;
                border-radius: 10px;
                padding: .55rem 1.1rem;
                background: #fff;
                transition: all .2s ease;
            }
            .btn-fc-outline:hover {
                border-color: var(--fc-navy);
                color: var(--fc-navy);
                background: #fff;
            }

            .alert {
                border: none;
                border-radius: 12px;
            }

            /* SCAN CARD */
            .scan-card {
                border: none;
                border-radius: 18px;
                overflow: hidden;
                box-shadow: 0 10px 28px rgba(15,191,143,.16);
                margin-bottom: 1.75rem;
            }
            .scan-card .card-header {
                background: linear-gradient(120deg, var(--fc-mint) 0%, var(--fc-mint-2) 100%);
                border: none;
                padding: 1.3rem 1.75rem;
                display: flex;
                align-items: center;
                gap: .75rem;
            }
            .scan-card .card-header .icon-badge {
                width: 42px;
                height: 42px;
                border-radius: 12px;
                background: rgba(255,255,255,.25);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
            }
            .scan-card .card-header h5 {
                color: #fff;
                font-weight: 700;
                margin: 0;
            }
            .scan-card .card-header .subtitle {
                color: rgba(255,255,255,.85);
                font-size: .8rem;
            }
            .scan-card .card-body {
                padding: 1.75rem;
                background: #fff;
            }

            .scan-input {
                border-radius: 12px;
                border: 2px solid #e2e6ee;
                padding: .95rem 1.2rem;
                font-size: 1.1rem;
                transition: border-color .2s ease;
            }
            .scan-input:focus {
                border-color: var(--fc-mint);
                box-shadow: 0 0 0 .2rem rgba(15,191,143,.15);
            }

            .btn-validate {
                background: var(--fc-mint);
                border: none;
                color: #fff;
                font-weight: 700;
                border-radius: 12px;
                font-size: 1.05rem;
                transition: opacity .2s ease;
            }
            .btn-validate:hover {
                opacity: .88;
                color: #fff;
            }

            .alert-scan-success {
                background: rgba(15,191,143,.1);
                color: #0a8a67;
                border-radius: 12px;
                font-weight: 600;
                font-size: 1.02rem;
                padding: .9rem 1.1rem;
                display: flex;
                align-items: center;
                gap: .6rem;
            }
            .alert-scan-error {
                background: rgba(220,53,69,.08);
                color: #c8323f;
                border-radius: 12px;
                font-weight: 600;
                font-size: 1.02rem;
                padding: .9rem 1.1rem;
                display: flex;
                align-items: center;
                gap: .6rem;
            }

            /* TOGGLE BUTTON */
            .btn-toggle-hoy {
                background: var(--fc-navy);
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 12px;
                padding: .8rem 1.4rem;
                display: inline-flex;
                align-items: center;
                gap: .5rem;
                transition: background .2s ease;
            }
            .btn-toggle-hoy:hover {
                background: var(--fc-navy-2);
                color: #fff;
            }
            .btn-toggle-hoy .badge-count {
                background: var(--fc-mint);
                color: #fff;
                border-radius: 20px;
                padding: .15rem .6rem;
                font-size: .8rem;
            }

            /* TABLE CARD */
            .table-card {
                border: none;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 18px rgba(16, 35, 62, .06);
            }
            .table-card .card-header {
                background: var(--fc-navy);
                border: none;
                padding: 1.1rem 1.5rem;
                display: flex;
                align-items: center;
                gap: .6rem;
            }
            .table-card .card-header h5 {
                color: #fff;
                font-weight: 700;
                margin: 0;
                font-size: 1rem;
            }
            .table-card .card-header .bi {
                color: var(--fc-mint);
            }

            table thead th {
                color: var(--fc-muted);
                font-weight: 600;
                font-size: .78rem;
                text-transform: uppercase;
                letter-spacing: .5px;
                border: none;
                border-bottom: 1px solid #edf0f5;
                padding: .8rem 1.5rem;
            }
            table tbody td {
                vertical-align: middle;
                padding: .8rem 1.5rem;
                font-size: .92rem;
            }
            table tbody tr:hover {
                background: rgba(15,191,143,.05) !important;
            }

            .time-chip {
                display: inline-flex;
                align-items: center;
                gap: .4rem;
                background: rgba(15,191,143,.12);
                color: var(--fc-mint);
                font-weight: 700;
                padding: .3rem .7rem;
                border-radius: 20px;
                font-size: .85rem;
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">
                    <i class="bi bi-lightning-charge-fill"></i> FitCIMM Paipa
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link active" href="IngresoServlet">Control de Acceso</a></li>
                        <li class="nav-item"><a class="nav-link" href="SocioServlet?accion=listar">Socios</a></li>
                        <li class="nav-item"><a class="nav-link" href="MembresiaServlet?accion=listar">Membresías</a></li>
                        <li class="nav-item"><a class="nav-link" href="PlanServlet?accion=listar">Planes</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">

            <div class="page-header">
                <div>
                    <h2><i class="bi bi-door-open-fill text-success me-2"></i>Control de Acceso (Recepción)</h2>
                    <div class="subtitle">Valida el ingreso diario de los socios por número de documento</div>
                </div>
                <div>
                    <a href="SocioServlet?accion=listar" class="btn btn-fc-outline me-2">
                        <i class="bi bi-people me-1"></i>Socios
                    </a>
                    <a href="MembresiaServlet?accion=listar" class="btn btn-fc-outline me-2">
                        <i class="bi bi-credit-card me-1"></i>Membresías
                    </a>
                    <a href="PlanServlet?accion=listar" class="btn btn-fc-outline">
                        <i class="bi bi-clipboard2-data me-1"></i>Planes
                    </a>
                </div>
            </div>

            <div class="card scan-card">
                <div class="card-header">
                    <div class="icon-badge">
                        <i class="bi bi-upc-scan"></i>
                    </div>
                    <div>
                        <h5>Registrar Entrada</h5>
                        <div class="subtitle">Escanee o digite el documento del socio</div>
                    </div>
                </div>
                <div class="card-body">
                    <form action="IngresoServlet" method="POST" class="row g-3">
                        <div class="col-md-9">
                            <input type="text" name="documento" class="form-control scan-input"
                                   placeholder="Ingrese o escanee el número de documento del socio..." autofocus required>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-validate btn-lg w-100">
                                <i class="bi bi-check2-circle me-1"></i>Validar Ingreso
                            </button>
                        </div>
                    </form>

                    <% String msgExito = (String) request.getAttribute("mensajeExito"); %>
                    <% if (msgExito != null) {%>
                    <div class="alert-scan-success mt-3">
                        <i class="bi bi-check-circle-fill fs-5"></i><%= msgExito%>
                    </div>
                    <% } %>

                    <% String msgError = (String) request.getAttribute("mensajeError"); %>
                    <% if (msgError != null) {%>
                    <div class="alert-scan-error mt-3">
                        <i class="bi bi-exclamation-triangle-fill fs-5"></i><%= msgError%>
                    </div>
                    <% } %>
                </div>
            </div>

            <%
                List<Ingreso> ingresos = (List<Ingreso>) request.getAttribute("listaIngresos");
                int totalIngresosHoy = (ingresos != null) ? ingresos.size() : 0;
                String fechaSeleccionada = (String) request.getAttribute("fechaSeleccionada");
            %>

            <div class="mb-4 d-flex align-items-center flex-wrap gap-3">
                <button class="btn btn-toggle-hoy" type="button"
                        data-bs-toggle="collapse" data-bs-target="#panelIngresosHoy"
                        aria-expanded="false" aria-controls="panelIngresosHoy">
                    <i class="bi bi-clock-history"></i>
                    Socios que han ingresado
                    <span class="badge-count"><%= totalIngresosHoy %></span>
                </button>

                <form method="get" action="IngresoServlet" class="d-flex align-items-center gap-2">
                    <label class="form-label mb-0 fw-semibold" style="color: var(--fc-muted);">Ver por fecha:</label>
                    <input type="date" name="fecha" class="form-control" style="max-width: 180px;"
                           value="<%= fechaSeleccionada %>">
                    <button type="submit" class="btn btn-fc-outline">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <div class="collapse show" id="panelIngresosHoy">
                <div class="card table-card mb-4">
                    <div class="card-header">
                        <i class="bi bi-clock-history"></i>
                        <h5>Ingresos registrados el <%= fechaSeleccionada %></h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Hora de Ingreso</th>
                                        <th>Documento</th>
                                        <th>Socio</th>
                                        <th>Fecha</th>
                                        <th>Días restantes membresía</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (ingresos != null && !ingresos.isEmpty()) {
                                            for (Ingreso ing : ingresos) {
                                                Long dias = ing.getDiasRestantesMembresia();
                                    %>
                                    <tr>
                                        <td><span class="time-chip"><i class="bi bi-clock-fill"></i><%= ing.getHoraIngreso()%></span></td>
                                        <td class="fw-semibold"><%= ing.getSocio().getDocumento()%></td>
                                        <td><%= ing.getSocio().getNombres() + " " + ing.getSocio().getApellidos()%></td>
                                        <td class="text-muted"><%= ing.getFechaIngreso()%></td>
                                        <td>
                                            <% if (dias == null) { %>
                                                <span class="badge bg-secondary">Sin membresía</span>
                                            <% } else if (dias < 0) { %>
                                                <span class="badge bg-danger">Vencida</span>
                                            <% } else if (dias <= 5) { %>
                                                <span class="badge bg-warning text-dark"><%= dias %> día(s)</span>
                                            <% } else { %>
                                                <span class="badge bg-success"><%= dias %> día(s)</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <%      }
                                        } else {
                                    %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-5">
                                            <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                            No hay ingresos registrados en esta fecha.
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
