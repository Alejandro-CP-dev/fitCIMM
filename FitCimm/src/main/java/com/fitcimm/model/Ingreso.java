/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.model;

import java.sql.Date;

/**
 *
 * @author Usuario
 */
public class Ingreso {
    private int idIngreso;
    private Socio socio;
    private Date fechaIngreso;
    private Date horaIngreso;

    public Ingreso() {
    }

    // Getters y Setters
    public int getIdIngreso() { return idIngreso; }
    public void setIdIngreso(int idIngreso) { this.idIngreso = idIngreso; }

    public Socio getSocio() { return socio; }
    public void setSocio(Socio socio) { this.socio = socio; }

    public Date getFechaIngreso() { return fechaIngreso; }
    public void setFechaIngreso(Date fechaIngreso) { this.fechaIngreso = fechaIngreso; }

    public Date getHoraIngreso() { return horaIngreso; }
    public void setHoraIngreso(Date horaIngreso) { this.horaIngreso = horaIngreso; }
}
