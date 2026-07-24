<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fitcimm.model.Plan" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Planes - FitCIMM</title>
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
            h1, h2, h3, h4, h5, .navbar-brand { font-family: 'Poppins', sans-serif; }

            /* NAVBAR (idéntica al resto del sistema) */
            .navbar { background: var(--fc-navy) !important; padding-top: .85rem; padding-bottom: .85rem; }
            .navbar-brand { font-weight: 800; letter-spacing: .3px; display: flex; align-items: center; gap: .5rem; }
            .navbar-brand .bi { color: var(--fc-orange); font-size: 1.4rem; }
            .navbar-nav .nav-link {
                font-weight: 500; color: rgba(255,255,255,.75) !important;
                margin: 0 .15rem; border-radius: 8px; padding: .5rem .9rem !important;
                transition: all .2s ease;
            }
            .navbar-nav .nav-link:hover { color: #fff !important; background: rgba(255,255,255,.08); }
            .navbar-nav .nav-link.active { color: #fff !important; background: var(--fc-orange); }

            /* PAGE HEADER */
            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
                margin: 1.8rem 0 1.4rem;
            }
            .page-header h2 { font-weight: 700; margin: 0; }
            .page-header .subtitle { color: var(--fc-muted); font-size: .92rem; margin-top: .15rem; }

            .btn-fc-primary {
                background: var(--fc-orange);
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 10px;
                padding: .55rem 1.1rem;
                transition: opacity .2s ease;
            }
            .btn-fc-primary:hover { opacity: .88; color: #fff; }

            .btn-fc-outline {
                border: 1px solid #d8dde8;
                color: var(--fc-text);
                font-weight: 600;
                border-radius: 10px;
                padding: .55rem 1.1rem;
                background: #fff;
                transition: all .2s ease;
            }
            .btn-fc-outline:hover { border-color: var(--fc-navy); color: var(--fc-navy); background: #fff; }

            /* ALERTS */
            .alert { border: none; border-radius: 12px; }

            /* TABLE CARD */
            .table-card {
                border: none;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 18px rgba(16, 35, 62, .06);
            }
            table thead { background: var(--fc-navy) !important; }
            table thead th {
                color: #fff;
                font-weight: 600;
                font-size: .82rem;
                text-transform: uppercase;
                letter-spacing: .5px;
                border: none;
                padding: .9rem 1rem;
            }
            table tbody td {
                vertical-align: middle;
                padding: .8rem 1rem;
                font-size: .92rem;
            }
            table tbody tr:hover { background: rgba(124,92,255,.05) !important; }

            .plan-chip {
                display: inline-flex;
                align-items: center;
                gap: .4rem;
                font-weight: 600;
            }
            .plan-chip .bi { color: var(--fc-purple); }

            .price-tag {
                font-weight: 700;
                color: var(--fc-navy);
                font-size: .98rem;
            }

            .duration-badge {
                background: rgba(47,111,237,.1);
                color: var(--fc-blue);
                font-weight: 600;
                font-size: .8rem;
                padding: .3rem .65rem;
                border-radius: 20px;
            }

            .badge-fc-activo {
                background: rgba(15,191,143,.12);
                color: var(--fc-mint);
                font-weight: 600;
                padding: .4rem .7rem;
                border-radius: 20px;
            }
            .badge-fc-inactivo {
                background: rgba(220,53,69,.1);
                color: #dc3545;
                font-weight: 600;
                padding: .4rem .7rem;
                border-radius: 20px;
            }

            .btn-action {
                border-radius: 8px;
                font-weight: 600;
                font-size: .78rem;
                padding: .35rem .7rem;
                border: none;
            }
            .btn-edit { background: rgba(255,122,26,.12); color: var(--fc-orange); }
            .btn-edit:hover { background: var(--fc-orange); color: #fff; }
            .btn-delete { background: rgba(220,53,69,.1); color: #dc3545; }
            .btn-delete:hover { background: #dc3545; color: #fff; }
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
                        <li class="nav-item"><a class="nav-link" href="IngresoServlet">Control de Acceso</a></li>
                        <li class="nav-item"><a class="nav-link" href="SocioServlet?accion=listar">Socios</a></li>
                        <li class="nav-item"><a class="nav-link" href="MembresiaServlet?accion=listar">Membresías</a></li>
                        <li class="nav-item"><a class="nav-link active" href="PlanServlet?accion=listar">Planes</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">

            <div class="page-header">
                <div>
                    <h2><i class="bi bi-clipboard2-data-fill text-primary me-2"></i>Gestión de Planes de Suscripción</h2>
                    <div class="subtitle">Tarifario y duraciones disponibles para las membresías</div>
                </div>
                <div>
                    <a href="SocioServlet?accion=listar" class="btn btn-fc-outline me-2">
                        <i class="bi bi-people me-1"></i>Ir a Socios
                    </a>
                    <a href="PlanServlet?accion=nuevo" class="btn btn-fc-primary">
                        <i class="bi bi-plus-lg me-1"></i>Nuevo Plan
                    </a>
                </div>
            </div>

            <% String msgExito = (String) request.getAttribute("mensajeExito"); %>
            <% if (msgExito != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i><%= msgExito%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% String msgError = (String) request.getAttribute("mensajeError"); %>
            <% if (msgError != null) {%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><%= msgError%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <div class="card table-card mb-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Duración</th>
                                    <th>Valor</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Plan> lista = (List<Plan>) request.getAttribute("listaPlanes");
                                    if (lista != null && !lista.isEmpty()) {
                                        for (Plan p : lista) {
                                %>
                                <tr>
                                    <td class="text-muted">#<%= p.getIdPlan()%></td>
                                    <td>
                                        <span class="plan-chip"><i class="bi bi-award-fill"></i><%= p.getNombre()%></span>
                                    </td>
                                    <td><span class="duration-badge"><%= p.getDuracionDias()%> días</span></td>
                                    <td><span class="price-tag">$<%= String.format("%.2f", p.getValor())%></span></td>
                                    <td>
                                        <% if (p.isActivo()) { %>
                                        <span class="badge-fc-activo"><i class="bi bi-check-circle-fill me-1"></i>Activo</span>
                                        <% } else { %>
                                        <span class="badge-fc-inactivo"><i class="bi bi-x-circle-fill me-1"></i>Inactivo</span>
                                        <% }%>
                                    </td>
                                    <td>
                                        <a href="PlanServlet?accion=editar&id=<%= p.getIdPlan()%>" class="btn btn-action btn-edit">
                                            <i class="bi bi-pencil-fill"></i> Editar
                                        </a>
                                        <% if (p.isActivo()) {%>
                                        <a href="PlanServlet?accion=inactivar&id=<%= p.getIdPlan()%>"
                                           class="btn btn-action btn-delete"
                                           onclick="return confirm('¿Inactivar este plan?');">
                                            <i class="bi bi-slash-circle"></i> Inactivar
                                        </a>
                                        <% } %>
                                    </td>
                                </tr>
                                <%      }
                                } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                        No hay planes registrados.
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
