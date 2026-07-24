/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.dao;

import com.fitcimm.config.Conexion;
import com.fitcimm.model.Plan;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class PlanDAO {

    public boolean insertar(Plan plan) {
        String sql = "INSERT INTO plan (nombre, duracion_dias, valor, activo) VALUES (?, ?, ?, ?)";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setDouble(3, plan.getValor());
            ps.setBoolean(4, plan.isActivo());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Plan> listarTodos() {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT * FROM plan";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearPlan(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Plan> listarActivos() {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT * FROM plan WHERE activo = true";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearPlan(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Plan bucarPorId(int idPlan) {
        String sql = "SELECT * FROM plan WHERE id_plan = ?";
        Plan plan = null;
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idPlan);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    plan = mapearPlan(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plan;
    }

    public boolean actualizar(Plan plan) {
        String sql = "UPDATE plan SET nombre = ?, duracion_dias = ?, valor = ? WHERE id_plan = ?";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setDouble(3, plan.getValor());
            ps.setInt(4, plan.getIdPlan());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean inactivar(int idPlan) {
        String sql = "UPDATE plan SET activo = false WHERE id_plan = ?";
        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idPlan);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Plan mapearPlan(ResultSet rs) throws SQLException {
        Plan plan = new Plan();
        plan.setIdPlan(rs.getInt("id_plan"));
        plan.setNombre(rs.getString("nombre"));
        plan.setDuracionDias(rs.getInt("duracion_dias"));
        plan.setValor(rs.getDouble("valor"));
        plan.setActivo(rs.getBoolean("activo"));
        return plan;
    }

    public Plan buscarPorId(int idPlan) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
