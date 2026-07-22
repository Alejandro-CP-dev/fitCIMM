/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.model;

/**
 *
 * @author Usuario
 */
public class Plan {

    private int idPlan;
    private String nombre;
    private int duracionDias;
    private double valor;
    private boolean activo;

    public Plan() {
    }

    public Plan(int idPlan, String nombre, int duracionDias, double valor, boolean activo) {
        this.idPlan = idPlan;
        this.nombre = nombre;
        this.duracionDias = duracionDias;
        this.valor = valor;
        this.activo = activo;
    }

    // Getters y Setters
    public int getIdPlan() {
        return idPlan;
    }

    public void setIdPlan(int idPlan) {
        this.idPlan = idPlan;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getDuracionDias() {
        return duracionDias;
    }

    public void setDuracionDias(int duracionDias) {
        this.duracionDias = duracionDias;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
