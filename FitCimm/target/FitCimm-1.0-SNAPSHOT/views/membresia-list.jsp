<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fitcimm.model.Membresia" %>
<%@ page import="com.fitcimm.service.MembresiaService" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Membresías - FitCIMM</title>
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
                --fc-amber: #f5a623;
                --fc-red: #e5484d;
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

            .btn-fc-primary {
                background: var(--fc-orange);
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 10px;
                padding: .55rem 1.1rem;
                transition: opacity .2s ease;
            }
            .btn-fc-primary:hover {
                background: var(--fc-orange);
                opacity: .88;
                color: #fff;
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

            /* SEARCH BAR */
            .search-box {
                max-width: 380px;
            }
            .search-box .input-group-text {
                border-right: none;
                color: var(--fc-muted);
            }
            .search-box .form-control {
                border-left: none;
                border-radius: 0 10px 10px 0;
            }
            .search-box .input-group-text {
                border-radius: 10px 0 0 10px;
            }
            .search-box .form-control:focus {
                border-color: var(--fc-orange);
                box-shadow: 0 0 0 .2rem rgba(255,122,26,.15);
            }

            /* ALERTS */
            .alert {
                border: none;
                border-radius: 12px;
            }

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
                font-size: .9rem;
            }
            table tbody tr:hover {
                background: rgba(47,111,237,.05) !important;
            }

            .socio-cell {
                display: flex;
                flex-direction: column;
            }
            .socio-cell .nombre {
                font-weight: 600;
            }
            .socio-cell .doc {
                color: var(--fc-muted);
                font-size: .78rem;
            }

            .plan-chip {
                display: inline-flex;
                align-items: center;
                gap: .4rem;
                font-weight: 600;
                color: var(--fc-purple);
            }

            .price-tag {
                font-weight: 700;
                color: var(--fc-navy);
            }

            .date-cell {
                color: var(--fc-muted);
                font-size: .86rem;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: .35rem;
                font-weight: 600;
                font-size: .8rem;
                padding: .4rem .75rem;
                border-radius: 20px;
            }
            .status-vigente {
                background: rgba(15,191,143,.12);
                color: var(--fc-mint);
            }
            .status-porvencer {
                background: rgba(245,166,35,.15);
                color: var(--fc-amber);
            }
            .status-vencida {
                background: rgba(229,72,77,.12);
                color: var(--fc-red);
            }
            .status-desconocido {
                background: rgba(107,116,136,.12);
                color: var(--fc-muted);
            }

            #sinResultados {
                display: none;
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
                        <li class="nav-item"><a class="nav-link" href="IngresoServlet">Control de Acceso</a></li>
                        <li class="nav-item"><a class="nav-link" href="SocioServlet?accion=listar">Socios</a></li>
                        <li class="nav-item"><a class="nav-link active" href="MembresiaServlet?accion=listar">Membresías</a></li>
                        <li class="nav-item"><a class="nav-link" href="PlanServlet?accion=listar">Planes</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">

            <div class="page-header">
                <div>
                    <h2><i class="bi bi-credit-card-fill text-warning me-2"></i>Historial de Membresías</h2>
                    <div class="subtitle">Ventas de planes y estado de vigencia de cada socio</div>
                </div>
                <div>
                    <a href="SocioServlet?accion=listar" class="btn btn-fc-outline me-2">
                        <i class="bi bi-people me-1"></i>Socios
                    </a>
                    <a href="PlanServlet?accion=listar" class="btn btn-fc-outline me-2">
                        <i class="bi bi-clipboard2-data me-1"></i>Planes
                    </a>
                    <a href="MembresiaServlet?accion=nuevo" class="btn btn-fc-primary">
                        <i class="bi bi-plus-lg me-1"></i>Vender Membresía
                    </a>
                </div>
            </div>

            <% String msgExito = (String) request.getAttribute("mensajeExito"); %>
            <% if (msgExito != null && !msgExito.isEmpty()) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i><%= msgExito%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% String msgError = (String) request.getAttribute("mensajeError"); %>
            <% if (msgError != null && !msgError.isEmpty()) {%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><%= msgError%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <div class="search-box mb-3">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                    <input type="text" id="buscarMembresia" class="form-control"
                           placeholder="Buscar por documento o apellido...">
                </div>
            </div>

            <div class="card table-card mb-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" id="tablaMembresias">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Socio</th>
                                    <th>Plan</th>
                                    <th>Fecha Inicio</th>
                                    <th>Fecha Fin</th>
                                    <th>Valor Pagado</th>
                                    <th>Estado (RN-04)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Membresia> lista = (List<Membresia>) request.getAttribute("listaMembresias");
                                    MembresiaService mService = (MembresiaService) request.getAttribute("membresiaService");

                                    if (lista != null && !lista.isEmpty()) {
                                        for (Membresia m : lista) {
                                            if (m != null) {
                                                // Cálculo seguro del estado
                                                String estado = "DESCONOCIDO";
                                                if (mService != null) {
                                                    estado = mService.calcularEstado(m);
                                                }

                                                // Asignación de clase visual según estado
                                                String badgeClass = "status-desconocido";
                                                String badgeIcon = "bi-question-circle-fill";
                                                if ("VIGENTE".equals(estado)) {
                                                    badgeClass = "status-vigente";
                                                    badgeIcon = "bi-check-circle-fill";
                                                } else if ("POR VENCER".equals(estado)) {
                                                    badgeClass = "status-porvencer";
                                                    badgeIcon = "bi-exclamation-circle-fill";
                                                } else if ("VENCIDA".equals(estado)) {
                                                    badgeClass = "status-vencida";
                                                    badgeIcon = "bi-x-circle-fill";
                                                }

                                                // Extracción segura del Socio
                                                String nombreSocio = "Socio no disponible";
                                                String docSocio = "";
                                                String apellidosSocio = "";
                                                if (m.getSocio() != null) {
                                                    String nombres = (m.getSocio().getNombres() != null) ? m.getSocio().getNombres() : "";
                                                    String apellidos = (m.getSocio().getApellidos() != null) ? m.getSocio().getApellidos() : "";
                                                    String doc = (m.getSocio().getDocumento() != null) ? m.getSocio().getDocumento() : "Sin Doc";
                                                    nombreSocio = nombres + " " + apellidos;
                                                    docSocio = doc;
                                                    apellidosSocio = apellidos;
                                                }

                                                // Extracción segura del Plan
                                                String nombrePlan = (m.getPlan() != null && m.getPlan().getNombre() != null)
                                                        ? m.getPlan().getNombre() : "Plan no asignado";

                                                // Texto usado por el filtro de búsqueda (documento + apellidos, en minúsculas)
                                                String textoBusqueda = (docSocio + " " + apellidosSocio).toLowerCase();
                                %>
                                <tr data-search="<%= textoBusqueda%>">
                                    <td class="text-muted">#<%= m.getIdMembresia()%></td>
                                    <td>
                                        <div class="socio-cell">
                                            <span class="nombre"><%= nombreSocio%></span>
                                            <% if (!docSocio.isEmpty()) {%>
                                            <span class="doc"><%= docSocio%></span>
                                            <% }%>
                                        </div>
                                    </td>
                                    <td><span class="plan-chip"><i class="bi bi-award-fill"></i><%= nombrePlan%></span></td>
                                    <td class="date-cell"><%= (m.getFechaInicio() != null) ? m.getFechaInicio() : "Sin fecha"%></td>
                                    <td class="date-cell"><%= (m.getFechaFin() != null) ? m.getFechaFin() : "Sin fecha"%></td>
                                    <td><span class="price-tag">$<%= String.format("%.2f", m.getValorPagado())%></span></td>
                                    <td><span class="status-badge <%= badgeClass%>"><i class="bi <%= badgeIcon%>"></i><%= estado%></span></td>
                                </tr>
                                <%
                                        }
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                        No hay membresías vendidas aún.
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                        <div id="sinResultados" class="text-center text-muted py-5">
                            <i class="bi bi-search fs-2 d-block mb-2"></i>
                            No se encontraron membresías con ese documento o apellido.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('buscarMembresia').addEventListener('input', function (e) {
                var texto = e.target.value.trim().toLowerCase();
                var filas = document.querySelectorAll('#tablaMembresias tbody tr[data-search]');
                var visibles = 0;

                filas.forEach(function (fila) {
                    var coincide = fila.getAttribute('data-search').indexOf(texto) !== -1;
                    fila.style.display = coincide ? '' : 'none';
                    if (coincide) {
                        visibles++;
                    }
                });

                document.getElementById('sinResultados').style.display =
                        (visibles === 0 && filas.length > 0) ? 'block' : 'none';
            });
        </script>
    </body>
</html>
