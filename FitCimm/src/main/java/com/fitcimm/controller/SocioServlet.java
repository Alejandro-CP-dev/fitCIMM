/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.controller;

import com.fitcimm.model.Socio;
import com.fitcimm.service.SocioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author Usuario
 */
@WebServlet("/SocioServlet")
public class SocioServlet extends HttpServlet{
    private final SocioService socioService;

    public SocioServlet() {
        this.socioService = new SocioService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }
        
        try {
            switch (accion) {
                case "nuevo":
                    // Mostrar formulario para registrar un nuevo socio
                    request.getRequestDispatcher("views/socio-form.jsp").forward(request, response);
                    break;

                case "editar":
                    // Cargar los datos del socio para editarlos (RF-04)
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    Socio socioEditar = socioService.obtenerPorId(idEditar);
                    request.setAttribute("socio", socioEditar);
                    request.getRequestDispatcher("views/socio-form.jsp").forward(request, response);
                    break;

                case "inactivar":
                    // Borrado lógico de un socio (RF-05 / RN-05)
                    int idInactivar = Integer.parseInt(request.getParameter("id"));
                    socioService.inactivarSocio(idInactivar);
                    request.setAttribute("mensajeExito", "Socio inactivado correctamente.");
                    listarSocios(request, response);
                    break;

                case "buscar":
                    // Buscar por documento o apellido (RF-06)
                    String criterio = request.getParameter("criterio");
                    List<Socio> resultados = socioService.buscarSocios(criterio);
                    request.setAttribute("listaSocios", resultados);
                    request.getRequestDispatcher("views/socio-list.jsp").forward(request, response);
                    break;

                case "listar":
                default:
                    listarSocios(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("mensajeError", "Error : " + e.getMessage());
            listarSocios(request, response);
        }
    }
    
    //Manejo de peticiones (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        
        if ("guardar".equals(accion)) {
            guardarOActualizarSocio(request, response);
        } else {
        }
    }
    
    private void listarSocios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Socio> lista = socioService.listarSocios();
        request.setAttribute("listaSocios", lista);
        request.getRequestDispatcher("views/socio-list.jsp").forward(request, response);
    }
    private void guardarOActualizarSocio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("idSocio");
        String documento = request.getParameter("documento");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String fechaNacStr = request.getParameter("fechaNacimiento");

        Socio socio = new Socio();
        if (idStr != null && !idStr.trim().isEmpty()) {
            socio.setIdSocio(Integer.parseInt(idStr));
        }
        
        socio.setDocumento(documento);
        socio.setNombres(nombres);
        socio.setApellidos(apellidos);
        socio.setTelefono(telefono);
        socio.setCorreo(correo);

        try {
            if (fechaNacStr != null && !fechaNacStr.trim().isEmpty()) {
                socio.setFechaNacimiento(LocalDate.parse(fechaNacStr));
            }

            // Si tiene ID > 0 es actualización, de lo contrario es nuevo registro
            if (socio.getIdSocio() > 0) {
                socioService.actualizarSocio(socio);
                request.setAttribute("mensajeExito", "Socio actualizado exitosamente.");
            } else {
                socioService.registrarSocio(socio); // AQUÍ SE EVALÚAN RN-01 Y RN-09
                request.setAttribute("mensajeExito", "Socio registrado exitosamente.");
            }

            // Redireccionar al listado tras éxito
            listarSocios(request, response);

        } catch (Exception e) {
            // Requisito técnico: Capturar la excepción de la capa Service y enviarla al JSP sin caer la app
            request.setAttribute("mensajeError", e.getMessage());
            request.setAttribute("socio", socio); // Mantener datos tipeados en el formulario
            request.getRequestDispatcher("views/socio-form.jsp").forward(request, response);
        }
    }
}
