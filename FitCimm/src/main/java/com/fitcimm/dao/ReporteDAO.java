package com.fitcimm.dao;

import com.fitcimm.config.Conexion;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReporteDAO {

    // RF-15: Reporte de socios activos con membresía vigente
    public List<Map<String, Object>> obtenerSociosVigentes() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT s.documento, CONCAT(s.nombres, ' ', s.apellidos) AS nombre_socio, "
                + "s.telefono, p.nombre AS plan, m.fecha_inicio, m.fecha_fin, "
                + "DATEDIFF(m.fecha_fin, CURDATE()) AS dias_restantes "
                + "FROM socio s "
                + "INNER JOIN membresia m ON s.id_socio = m.id_socio "
                + "INNER JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE s.activo = TRUE AND m.fecha_fin >= CURDATE() "
                + "ORDER BY m.fecha_fin ASC";

        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("documento", rs.getString("documento"));
                fila.put("nombreSocio", rs.getString("nombre_socio"));
                fila.put("telefono", rs.getString("telefono"));
                fila.put("plan", rs.getString("plan"));
                fila.put("fechaInicio", rs.getDate("fecha_inicio").toLocalDate());
                fila.put("fechaFin", rs.getDate("fecha_fin").toLocalDate());
                fila.put("diasRestantes", rs.getInt("dias_restantes"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // RF-16: Total recaudado en un rango de fechas agrupado por plan
    public List<Map<String, Object>> obtenerRecaudoPorRango(LocalDate fechaInicio, LocalDate fechaFin) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT p.nombre AS plan, COUNT(m.id_membresia) AS total_ventas, "
                + "SUM(m.valor_pagado) AS total_recaudado "
                + "FROM membresia m "
                + "INNER JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE m.fecha_inicio BETWEEN ? AND ? "
                + "GROUP BY p.id_plan, p.nombre "
                + "ORDER BY total_recaudado DESC";

        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(fechaInicio));
            ps.setDate(2, Date.valueOf(fechaFin));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> fila = new HashMap<>();
                    fila.put("plan", rs.getString("plan"));
                    fila.put("totalVentas", rs.getInt("total_ventas"));
                    fila.put("totalRecaudado", rs.getDouble("total_recaudado"));
                    lista.add(fila);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // RF-17: Plan más vendido del mes actual
    public Map<String, Object> obtenerPlanMasVendidoMes() {
        Map<String, Object> resultado = null;
        String sql = "SELECT p.nombre AS plan, COUNT(m.id_membresia) AS total_ventas, "
                + "SUM(m.valor_pagado) AS total_recaudado "
                + "FROM membresia m "
                + "INNER JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE MONTH(m.fecha_inicio) = MONTH(CURDATE()) "
                + "AND YEAR(m.fecha_inicio) = YEAR(CURDATE()) "
                + "GROUP BY p.id_plan, p.nombre "
                + "ORDER BY total_ventas DESC LIMIT 1";

        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                resultado = new HashMap<>();
                resultado.put("plan", rs.getString("plan"));
                resultado.put("totalVentas", rs.getInt("total_ventas"));
                resultado.put("totalRecaudado", rs.getDouble("total_recaudado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }
}
