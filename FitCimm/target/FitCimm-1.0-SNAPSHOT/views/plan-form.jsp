<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fitcimm.model.Plan" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulario de Plan - FitCIMM</title>
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
                background: rgba(124,92,255,.2);
                color: #fff;
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
            .form-hint {
                color: var(--fc-muted);
                font-weight: 400;
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #e2e6ee;
                padding: .65rem .9rem;
                font-size: .95rem;
            }
            .form-control:focus {
                border-color: var(--fc-purple);
                box-shadow: 0 0 0 .2rem rgba(124,92,255,.15);
            }

            .input-icon-group {
                position: relative;
            }
            .input-icon-group .bi {
                position: absolute;
                left: .9rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--fc-muted);
            }
            .input-icon-group .form-control {
                padding-left: 2.4rem;
            }

            .alert {
                border: none;
                border-radius: 12px;
            }

            .btn-fc-primary {
                background: var(--fc-purple);
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
        <div class="container" style="max-width: 520px;">
            <%
                Plan plan = (Plan) request.getAttribute("plan");
                boolean esEdicion = (plan != null && plan.getIdPlan() > 0);
            %>
            <div class="card form-card">
                <div class="card-header">
                    <div class="icon-badge">
                        <i class="bi <%= esEdicion ? "bi-pencil-fill" : "bi-clipboard2-plus-fill"%>"></i>
                    </div>
                    <div>
                        <h4><%= esEdicion ? "Editar Plan" : "Nuevo Plan"%></h4>
                        <div class="subtitle">Catálogo de planes de suscripción</div>
                    </div>
                </div>
                <div class="card-body">
                    <% String msgError = (String) request.getAttribute("mensajeError"); %>
                    <% if (msgError != null) {%>
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= msgError%>
                    </div>
                    <% }%>
                    <form action="PlanServlet" method="POST">
                        <input type="hidden" name="accion" value="guardar">
                        <input type="hidden" name="idPlan" value="<%= esEdicion ? plan.getIdPlan() : ""%>">

                        <div class="mb-3">
                            <label class="form-label">Nombre del Plan <span class="required">*</span></label>
                            <div class="input-icon-group">
                                <i class="bi bi-award"></i>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej: Mensual, Trimestral..." required
                                       value="<%= plan != null && plan.getNombre() != null ? plan.getNombre() : ""%>">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Duración en Días <span class="required">*</span> <span class="form-hint">(mayor a 0)</span></label>
                            <div class="input-icon-group">
                                <i class="bi bi-calendar-range"></i>
                                <input type="number" name="duracionDias" class="form-control" placeholder="Ej: 30" required
                                       value="<%= plan != null && plan.getDuracionDias() > 0 ? plan.getDuracionDias() : ""%>">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Valor del Plan ($) <span class="required">*</span> <span class="form-hint">(mayor a 0)</span></label>
                            <div class="input-icon-group">
                                <i class="bi bi-cash-coin"></i>
                                <input type="number" step="0.01" name="valor" class="form-control" placeholder="Ej: 75000" required
                                       value="<%= plan != null && plan.getValor() > 0 ? plan.getValor() : ""%>">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="PlanServlet?accion=listar" class="btn btn-fc-cancel">
                                <i class="bi bi-arrow-left me-1"></i>Cancelar
                            </a>
                            <button type="submit" class="btn btn-fc-primary">
                                <i class="bi bi-check-lg me-1"></i>Guardar Plan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
