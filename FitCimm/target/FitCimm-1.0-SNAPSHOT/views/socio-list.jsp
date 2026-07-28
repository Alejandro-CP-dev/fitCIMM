<%-- 
    Document   : socio-list
    Created on : 22 jul 2026, 16:20:30
    Author     : Usuario
--%>

<%@page import="java.util.List"%>
<%@page import="com.fitcimm.model.Socio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gimnasio FitCIMM - Gestión de Socios</title>
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

            /* NAVBAR (idéntica al index) */
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
            .btn-fc-primary:hover {background: var(--fc-orange); opacity: .88; color: #fff; }

            /* ALERTS */
            .alert { border: none; border-radius: 12px; }

            /* SEARCH CARD */
            .search-card {
                border: none;
                border-radius: 16px;
                box-shadow: 0 4px 18px rgba(16, 35, 62, .06);
            }
            .search-card .form-control {
                border-radius: 10px 0 0 10px;
                border-color: #e2e6ee;
                padding: .6rem .9rem;
            }
            .search-card .form-control:focus {
                border-color: var(--fc-blue);
                box-shadow: 0 0 0 .2rem rgba(47,111,237,.15);
            }
            .btn-search {
                background: var(--fc-navy);
                color: #fff;
                border-radius: 0 10px 10px 0;
                font-weight: 600;
                border: none;
            }
            .btn-search:hover { background: var(--fc-navy-2); color: #fff; }

            /* TABLE CARD */
            .table-card {
                border: none;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 18px rgba(16, 35, 62, .06);
            }
            table thead {
                background: var(--fc-navy) !important;
            }
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
            table tbody tr:hover { background: rgba(47,111,237,.05) !important; }

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
                        <li class="nav-item"><a class="nav-link active" href="SocioServlet?accion=listar">Socios</a></li>
                        <li class="nav-item"><a class="nav-link" href="MembresiaServlet?accion=listar">Membresías</a></li>
                        <li class="nav-item"><a class="nav-link" href="PlanServlet?accion=listar">Planes</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">

            <div class="page-header">
                <div>
                    <h2><i class="bi bi-people-fill text-primary me-2"></i>Gestión de Socios</h2>
                    <div class="subtitle">Registro, búsqueda y administración de socios del gimnasio</div>
                </div>
                <a href="SocioServlet?accion=nuevo" class="btn btn-fc-primary">
                    <i class="bi bi-plus-lg me-1"></i>Nuevo Socio
                </a>
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

            <div class="card search-card mb-4">
                <div class="card-body">
                    <form action="SocioServlet" method="GET" class="row g-0">
                        <input type="hidden" name="accion" value="buscar">
                        <div class="col-md-10">
                            <input type="text" name="criterio" class="form-control" placeholder="Buscar por documento o apellido...">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-search w-100">
                                <i class="bi bi-search me-1"></i>Buscar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card table-card mb-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Documento</th>
                                    <th>Nombre Completo</th>
                                    <th>Teléfono</th>
                                    <th>Correo</th>
                                    <th>Fecha Nac.</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Socio> lista = (List<Socio>) request.getAttribute("listaSocios");
                                    if (lista != null && !lista.isEmpty()) {
                                        for (Socio s : lista) {
                                %>
                                <tr>
                                    <td class="text-muted">#<%= s.getIdSocio()%></td>
                                    <td class="fw-semibold"><%= s.getDocumento()%></td>
                                    <td><%= s.getNombres() + " " + s.getApellidos()%></td>
                                    <td><%= s.getTelefono() != null ? s.getTelefono() : "-"%></td>
                                    <td><%= s.getCorreo() != null ? s.getCorreo() : "-"%></td>
                                    <td><%= s.getFechaNacimiento()%></td>
                                    <td>
                                        <% if (s.isActivo()) { %>
                                        <span class="badge-fc-activo"><i class="bi bi-check-circle-fill me-1"></i>Activo</span>
                                        <% } else { %>
                                        <span class="badge-fc-inactivo"><i class="bi bi-x-circle-fill me-1"></i>Inactivo</span>
                                        <% }%>
                                    </td>
                                    <td>
                                        <a href="SocioServlet?accion=editar&id=<%= s.getIdSocio()%>" class="btn btn-action btn-edit">
                                            <i class="bi bi-pencil-fill"></i> Editar
                                        </a>
                                        <% if (s.isActivo()) {%>
                                        <a href="SocioServlet?accion=inactivar&id=<%= s.getIdSocio()%>"
                                           class="btn btn-action btn-delete"
                                           onclick="return confirm('¿Inactivar a este socio?');">
                                            <i class="bi bi-slash-circle"></i> Inactivar
                                        </a>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                        No se encontraron socios registrados.
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
