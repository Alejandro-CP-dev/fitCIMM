/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.model;
import java.time.LocalDate;
import java.time.LocalTime;
/**
 *
 * @author Usuario
 */
public class Ingreso {
    private int idIngreso;
    private Socio socio;
    private LocalDate fechaIngreso;
    private LocalTime horaIngreso;

    // No corresponde a una columna de la tabla ingreso: se calcula al vuelo
    // en IngresoService a partir de la última membresía del socio.
    private Long diasRestantesMembresia;

    public Ingreso() {
    }
    // Getters y Setters
    public int getIdIngreso() {
        return idIngreso;
    }
    public void setIdIngreso(int idIngreso) {
        this.idIngreso = idIngreso;
    }
    public Socio getSocio() {
        return socio;
    }
    public void setSocio(Socio socio) {
        this.socio = socio;
    }
    public LocalDate getFechaIngreso() {
        return fechaIngreso;
    }
    public void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }
    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }
    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    public Long getDiasRestantesMembresia() {
        return diasRestantesMembresia;
    }
    public void setDiasRestantesMembresia(Long diasRestantesMembresia) {
        this.diasRestantesMembresia = diasRestantesMembresia;
    }
}