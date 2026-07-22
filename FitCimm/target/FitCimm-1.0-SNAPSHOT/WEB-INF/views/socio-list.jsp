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
        <title>Gimnasio FitCIMM - Gestión de Socios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Gestión de Socios</h2>
                <a href="SocioServlet?accion=nuevo" class="btn btn-primary">+ Nuevo Socio</a>
            </div>

            <% String msgExito = (String) request.getAttribute("mensajeExito"); %>
            <% if (msgExito != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= msgExito%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% String msgError = (String) request.getAttribute("mensajeError"); %>
            <% if (msgError != null) {%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= msgError%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <form action="SocioServlet" method="GET" class="row g-2">
                        <input type="hidden" name="accion" value="buscar">
                        <div class="col-md-10">
                            <input type="text" name="criterio" class="form-control" placeholder="Buscar por documento o apellido...">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-secondary w-100">Buscar</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
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
                                <td><%= s.getIdSocio()%></td>
                                <td><%= s.getDocumento()%></td>
                                <td><%= s.getNombres() + " " + s.getApellidos()%></td>
                                <td><%= s.getTelefono() != null ? s.getTelefono() : "-"%></td>
                                <td><%= s.getCorreo() != null ? s.getCorreo() : "-"%></td>
                                <td><%= s.getFechaNacimiento()%></td>
                                <td>
                                    <% if (s.isActivo()) { %>
                                    <span class="badge bg-success">Activo</span>
                                    <% } else { %>
                                    <span class="badge bg-danger">Inactivo</span>
                                    <% }%>
                                </td>
                                <td>
                                    <a href="SocioServlet?accion=editar&id=<%= s.getIdSocio()%>" class="btn btn-sm btn-warning">Editar</a>
                                    <% if (s.isActivo()) {%>
                                    <a href="SocioServlet?accion=inactivar&id=<%= s.getIdSocio()%>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('¿Inactivar a este socio?');">Inactivar</a>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="8" class="text-center text-muted py-3">No se encontraron socios registrados.</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
