<%-- 
    Document   : socio-form
    Created on : 22 jul 2026, 16:23:15
    Author     : Usuario
--%>

<%@page import="com.fitcimm.model.Socio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Formulario de Socio - FitCIMM</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container mt-5" style="max-width: 600px;">
            <%
                Socio socio = (Socio) request.getAttribute("socio");
                boolean esEdicion = (socio != null && socio.getIdSocio() > 0);
            %>

            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><%= esEdicion ? "Editar Socio" : "Nuevo Registro de Socio"%></h4>
                </div>
                <div class="card-body">

                    <% String msgError = (String) request.getAttribute("mensajeError"); %>
                    <% if (msgError != null) {%>
                    <div class="alert alert-danger" role="alert">
                        ⚠️ <%= msgError%>
                    </div>
                    <% }%>

                    <form action="SocioServlet" method="POST">
                        <input type="hidden" name="accion" value="guardar">
                        <input type="hidden" name="idSocio" value="<%= esEdicion ? socio.getIdSocio() : ""%>">

                        <div class="mb-3">
                            <label class="form-label">Número de Documento (*):</label>
                            <input type="text" name="documento" class="form-control" required
                                   value="<%= socio != null && socio.getDocumento() != null ? socio.getDocumento() : ""%>">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombres (*):</label>
                                <input type="text" name="nombres" class="form-control" required
                                       value="<%= socio != null && socio.getNombres() != null ? socio.getNombres() : ""%>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellidos (*):</label>
                                <input type="text" name="apellidos" class="form-control" required
                                       value="<%= socio != null && socio.getApellidos() != null ? socio.getApellidos() : ""%>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Teléfono:</label>
                                <input type="text" name="telefono" class="form-control"
                                       value="<%= socio != null && socio.getTelefono() != null ? socio.getTelefono() : ""%>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Correo Electrónico:</label>
                                <input type="email" name="correo" class="form-control"
                                       value="<%= socio != null && socio.getCorreo() != null ? socio.getCorreo() : ""%>">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Fecha de Nacimiento (*) <small class="text-muted">(Mayor de 15 años)</small>:</label>
                            <input type="date" name="fechaNacimiento" class="form-control" required
                                   value="<%= socio != null && socio.getFechaNacimiento() != null ? socio.getFechaNacimiento() : ""%>">
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="SocioServlet?accion=listar" class="btn btn-secondary">Cancelar</a>
                            <button type="submit" class="btn btn-success">Guardar Socio</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
