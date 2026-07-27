/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.dao;

import com.fitcimm.config.Conexion;
import com.fitcimm.model.Ingreso;
import com.fitcimm.model.Socio;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class IngresoDAO {

    public boolean registrarIngreso(Ingreso ingreso) {
        String consulta = "INSERT INTO ingreso (id_socio, fecha_ingreso, hora_ingreso) VALUES (?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta);) {

            ps.setInt(1, ingreso.getSocio().getIdSocio());
            ps.setDate(2, Date.valueOf(ingreso.getFechaIngreso()));
            ps.setTime(3, Time.valueOf(ingreso.getHoraIngreso()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Ingreso> listarIngresoDia() {
        List<Ingreso> lista = new ArrayList<>();
        String consulta = "SELECT i.*, s.documento, s.nombres, s.apellidos "
                + "FROM ingreso i "
                + "JOIN socio s ON i.id_socio = s.id_socio "
                + "WHERE i.fecha_ingreso = CURDATE() "
                + "ORDER BY i.hora_ingreso DESC";
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearIngreso(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Ingreso> listarTodos() {
        List<Ingreso> lista = new ArrayList<>();
        String sql = "SELECT i.*, s.documento, s.nombres, s.apellidos "
                + "FROM ingreso i "
                + "JOIN socio s ON i.id_socio = s.id_socio "
                + "ORDER BY i.fecha_ingreso DESC, i.hora_ingreso DESC";

        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearIngreso(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean yaIngresoHoy(int idSocio) {
        String sql = "SELECT COUNT(*) FROM ingreso WHERE id_socio = ? AND fecha_ingreso = CURDATE()";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Ingreso mapearIngreso(ResultSet rs) throws SQLException {
        Ingreso i = new Ingreso();
        i.setIdIngreso(rs.getInt("id_ingreso"));

        Socio s = new Socio();
        s.setIdSocio(rs.getInt("id_socio"));
        s.setDocumento(rs.getString("documento"));
        s.setNombres(rs.getString("nombres"));
        s.setApellidos(rs.getString("apellidos"));
        i.setSocio(s);

        i.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
        i.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());

        return i;
    }
}
