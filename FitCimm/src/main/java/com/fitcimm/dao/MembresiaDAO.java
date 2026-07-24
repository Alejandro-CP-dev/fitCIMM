/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.dao;

import com.fitcimm.config.Conexion;
import com.fitcimm.model.Membresia;
import com.fitcimm.model.Plan;

import com.fitcimm.model.Socio;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class MembresiaDAO {

    public boolean registrar(Membresia membresia) {
        String consulta = "INSERT INTO membresia (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta)) {

            ps.setInt(1, membresia.getSocio().getIdSocio());
            ps.setInt(2, membresia.getPlan().getIdPlan());
            ps.setDate(3, Date.valueOf(membresia.getFechaInicio()));
            ps.setDate(4, Date.valueOf(membresia.getFechaFin()));
            ps.setDouble(5, membresia.getValorPagado());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Membresia> listarTodas() {
        List<Membresia> lista = new ArrayList<>();

        String consulta = "SELECT m.*, s.documento, s.nombres, s.apellidos, p.nombre AS plan_nombre, p.duracion_dias "
                + "FROM membresia m "
                + "JOIN socio s ON m.id_socio = s.id_socio "
                + "JOIN plan p ON m.id_plan = p.id_plan "
                + "ORDER BY m.id_membresia DESC";

        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearMembresia(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Membresia> listarPorSocio(int idSocio) {
        List<Membresia> lista = new ArrayList<>();
        String consulta = "SELECT m.*, s.documento, s.nombres, s.apellidos, p.nombre AS plan_nombre, p.duracion_dias "
                + "FROM membresia m "
                + "JOIN socio s ON m.id_socio = s.id_socio "
                + "JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE m.id_socio = ? ORDER BY m.fecha_fin DESC";

        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearMembresia(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Membresia obtenerUltimaMembresia(int idSocio) {
        String consulta = "SELECT m.*, s.documento, s.nombres, s.apellidos, p.nombre AS plan_nombre, p.duracion_dias "
                + "FROM membresia m "
                + "JOIN socio s ON m.id_socio = s.id_socio "
                + "JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE m.id_socio = ? ORDER BY m.fecha_fin DESC LIMIT 1";
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearMembresia(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Membresia mapearMembresia(ResultSet rs) throws SQLException {
        Membresia m = new Membresia();
        m.setIdMembresia(rs.getInt("id_membresia"));

        Socio s = new Socio();
        s.setIdSocio(rs.getInt("id_socio"));
        s.setDocumento(rs.getString("documento"));
        s.setNombres(rs.getString("nombres"));
        s.setApellidos(rs.getString("apellidos"));
        m.setSocio(s);

        Plan p = new Plan();
        p.setIdPlan(rs.getInt("id_plan"));
        p.setNombre(rs.getString("plan_nombre"));
        p.setDuracionDias(rs.getInt("duracion_dias"));
        m.setPlan(p);

        // Validar si la fecha de inicio no es nula en la BD
        Date fInicio = rs.getDate("fecha_inicio");
        if (fInicio != null) {
            m.setFechaInicio(fInicio.toLocalDate());
        }

        // Validar si la fecha de fin no es nula en la BD
        Date fFin = rs.getDate("fecha_fin");
        if (fFin != null) {
            m.setFechaFin(fFin.toLocalDate());
        }
        m.setValorPagado(rs.getDouble("valor_pagado"));

        return m;
    }
}
