/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.service;

import com.fitcimm.dao.SocioDAO;
import com.fitcimm.model.Socio;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class SocioService {
    private final SocioDAO socioDAO;
    
    public SocioService() {
        this.socioDAO = new SocioDAO();
    }
    
    public void registrarSocio(Socio socio) throws Exception {
        // 1. Validar campos requeridos básicos
        if (socio.getDocumento() == null || socio.getDocumento().trim().isEmpty()) {
            throw new Exception("El número de documento es obligatorio.");
        }
        if (socio.getNombres() == null || socio.getNombres().trim().isEmpty()) {
            throw new Exception("El nombre es obligatorio.");
        }
        if (socio.getApellidos() == null || socio.getApellidos().trim().isEmpty()) {
            throw new Exception("El apellido es obligatorio.");
        }


        Socio existente = socioDAO.buscarPorDocumento(socio.getDocumento().trim());
        if (existente != null) {
            throw new Exception("RN-01: Ya existe un socio registrado con el documento " + socio.getDocumento());
        }


        if (socio.getFechaNacimiento() == null) {
            throw new Exception("La fecha de nacimiento es obligatoria.");
        }
        
        long edad = ChronoUnit.YEARS.between(socio.getFechaNacimiento(), LocalDate.now());
        if (edad <= 15) { // Debe ser estrictamente mayor de 15 años (> 15)
            throw new Exception("RN-09: El socio debe ser mayor de 15 años para poder registrarse (Edad actual: " + edad + " años).");
        }

        // Por defecto, todo socio nuevo nace activo
        socio.setActivo(true);


        boolean exito = socioDAO.insertar(socio);
        if (!exito) {
            throw new Exception("Ocurrió un error en la base de datos al guardar el socio.");
        }
    }
    
    public void actualizarSocio(Socio socio) throws Exception{
        
        Socio socioExistente = socioDAO.buscarPorId(socio.getIdSocio());
        
        if (socioExistente == null) {
            throw new Exception("EL socio que intenta actualiar no existe");
            
        }
        
        if (!socioExistente.getDocumento().equals(socio.getDocumento())) {
            Socio mismoDocumento = socioDAO.buscarPorDocumento(socio.getDocumento());
            if (mismoDocumento != null && mismoDocumento.getIdSocio() != socio.getIdSocio()) {
                throw new Exception("EL nuevo número de documento ya esta asignado a otro socio");
            }
        }

        long edad = ChronoUnit.YEARS.between(socio.getFechaNacimiento(), LocalDate.now());
        if (edad <= 15) {
            throw new Exception("El socio debe ser mayor de 15 años.");
        }

        boolean exito = socioDAO.actualizar(socio);
        if (!exito) {
            throw new Exception("Error al actualizar la información del socio.");
        }
    }
    
    public List<Socio> listarSocios() {
        return socioDAO.listarTodos();
    }

    public Socio obtenerPorId(int idSocio) {
        return socioDAO.buscarPorId(idSocio);
    }
}
