<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fitcimm.model.Socio" %>
<%@ page import="com.fitcimm.model.Plan" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nueva Membresía - FitCIMM</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --fc-navy: #10233e;
                --fc-navy-2: #17335a;
                --fc-orange: #ff7a1a;
                --fc-orange-2: #ffb066;
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
                min-height: 100vh;
                display: flex;
                align-items: center;
                padding: 2.5rem 1rem;
            }
            h1, h2, h3, h4, h5 {
                font-family: 'Poppins', sans-serif;
            }

            .form-card {
                border: none;
                border-radius: 18px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(16, 35, 62, .1);
                width: 100%;
            }

            .form-card .card-header {
                background: linear-gradient(120deg, var(--fc-navy) 0%, var(--fc-navy-2) 100%);
                border: none;
                padding: 1.5rem 1.75rem;
                display: flex;
                align-items: center;
                gap: .75rem;
            }
            .form-card .card-header .icon-badge {
                width: 42px;
                height: 42px;
                border-radius: 12px;
                background: rgba(255,122,26,.22);
                color: var(--fc-orange-2);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.15rem;
            }
            .form-card .card-header h4 {
                color: #fff;
                font-weight: 700;
                margin: 0;
            }
            .form-card .card-header .subtitle {
                color: rgba(255,255,255,.65);
                font-size: .82rem;
            }

            .form-card .card-body {
                padding: 2rem 1.75rem;
            }

            .form-label {
                font-weight: 600;
                font-size: .88rem;
                color: var(--fc-text);
                margin-bottom: .4rem;
            }
            .form-label .required {
                color: var(--fc-orange);
            }

            .form-select, .form-control {
                border-radius: 10px;
                border: 1px solid #e2e6ee;
                padding: .65rem .9rem;
                font-size: .95rem;
            }
            .form-select:focus, .form-control:focus {
                border-color: var(--fc-orange);
                box-shadow: 0 0 0 .2rem rgba(255,122,26,.15);
            }

            .alert {
                border: none;
                border-radius: 12px;
            }
            .alert-info-fc {
                background: rgba(47,111,237,.08);
                color: var(--fc-blue);
                border-radius: 12px;
                padding: .75rem 1rem;
                font-size: .85rem;
                display: flex;
                align-items: flex-start;
                gap: .6rem;
            }
            .alert-info-fc .bi {
                font-size: 1.05rem;
                margin-top: .05rem;
            }

            .btn-fc-primary {
                background: var(--fc-orange);
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 10px;
                padding: .65rem 1.4rem;
                transition: opacity .2s ease;
            }
            .btn-fc-primary:hover {
                opacity: .88;
                color: #fff;
            }

            .btn-fc-cancel {
                border: 1px solid #d8dde8;
                color: var(--fc-text);
                font-weight: 600;
                border-radius: 10px;
                padding: .65rem 1.4rem;
                background: #fff;
                transition: all .2s ease;
            }
            .btn-fc-cancel:hover {
                border-color: var(--fc-navy);
                color: var(--fc-navy);
                background: #fff;
            }
        </style>
    </head>
    <body>

        <div class="container" style="max-width: 570px;">
            <div class="card form-card">
                <div class="card-header">
                    <div class="icon-badge">
                        <i class="bi bi-credit-card-2-front-fill"></i>
                    </div>
                    <div>
                        <h4>Venta de Membresía</h4>
                        <div class="subtitle">Asignar un plan activo a un socio activo</div>
                    </div>
                </div>
                <div class="card-body">

                    <%-- Mensaje de Error (si el Service arroja alguna RN incumplida) --%>
                    <% String msgError = (String) request.getAttribute("mensajeError"); %>
                    <% if (msgError != null && !msgError.isEmpty()) {%>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= msgError%>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% } %>

                    <form action="MembresiaServlet" method="POST">
                        <input type="hidden" name="accion" value="guardar">

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person-fill me-1"></i>Seleccionar Socio <span class="required">*</span></label>
                            <select name="idSocio" class="form-select" required>
                                <option value="">-- Seleccione un socio --</option>
                                <%
                                    List<Socio> socios = (List<Socio>) request.getAttribute("listaSocios");
                                    if (socios != null) {
                                        for (Socio s : socios) {
                                            // Solo mostrar socios con estado activo
                                            if (s != null && s.isActivo()) {
                                %>
                                <option value="<%= s.getIdSocio()%>">
                                    <%= s.getNombres()%> <%= s.getApellidos()%> — Doc: <%= s.getDocumento()%>
                                </option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-award-fill me-1"></i>Seleccionar Plan <span class="required">*</span></label>
                            <select name="idPlan" class="form-select" required>
                                <option value="">-- Seleccione un plan --</option>
                                <%
                                    List<Plan> planes = (List<Plan>) request.getAttribute("listaPlanes");
                                    if (planes != null) {
                                        for (Plan p : planes) {
                                            // Solo mostrar planes con estado activo
                                            if (p != null && p.isActivo()) {
                                %>
                                <option value="<%= p.getIdPlan()%>">
                                    <%= p.getNombre()%> (<%= p.getDuracionDias()%> días) — $<%= String.format("%.2f", p.getValor())%>
                                </option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="alert-info-fc mb-3">
                            <i class="bi bi-info-circle-fill"></i>
                            <span>La fecha de fin se calculará automáticamente a partir de la fecha de hoy.</span>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="MembresiaServlet?accion=listar" class="btn btn-fc-cancel">
                                <i class="bi bi-arrow-left me-1"></i>Cancelar
                            </a>
                            <button type="submit" class="btn btn-fc-primary">
                                <i class="bi bi-check-lg me-1"></i>Registrar Venta
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
