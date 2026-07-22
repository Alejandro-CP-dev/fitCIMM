/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.dao;

import com.fitcimm.config.Conexion;
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
public class SocioDAO {

    public boolean insertar(Socio socio) {
        String consulta = "INSERT INTO socio (documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(consulta)) {

            ps.setString(1, socio.getDocumento());
            ps.setString(2, socio.getNombres());
            ps.setString(3, socio.getApellidos());
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getCorreo());
            ps.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            ps.setBoolean(7, socio.isActivo());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Socio> listarTodos() {
        List<Socio> lista = new ArrayList<>();
        String consulta = "SELECT * FROM socio";

        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Socio socio = mapearSocio(rs);
                lista.add(socio);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Socio buscarPorId(int idSocio) {
        String consulta = "SELECT * FROM socio WHERE id_socio = ?";
        Socio socio = null;
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta);) {
            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    socio = mapearSocio(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return socio;
    }

    public Socio buscarPorDocumento(String documento) {
        String consulta = "SELECT * FROM socio WHERE documento = ?";
        Socio socio = null;
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(consulta);) {
            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    socio = mapearSocio(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return socio;
    }

    public boolean actualizar(Socio socio) {
        String consulta = "UPDATE socio SET documento = ?, nombres = ?, apellidos = ?, "
                + "telefono = ?, correo = ?, fecha_nacimiento = ?, WHERE id_socio = ?";
        try (Connection conn = Conexion.getConnection();
                PreparedStatement ps = conn.prepareStatement(consulta)){
            
            ps.setString(1, socio.getDocumento());
            ps.setString(2, socio.getNombres());
            ps.setString(3, socio.getApellidos());
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getCorreo());
            ps.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            ps.setInt(7, socio.getIdSocio());
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.getStackTrace();
            return false;
        }
    }

    public boolean inactivar(int idSocio) {
        String sql = "UPDATE socio SET activo = false WHERE id_socio = ?";

        try (Connection cn = Conexion.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idSocio);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Socio> buscarPorCriterio(String textoBusqueda) {
        List<Socio> lista = new ArrayList<>();
        String sql = "SELECT * FROM socio WHERE documento LIKE ? OR apellidos LIKE ?";

        try (Connection cn = Conexion.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String busqueda = "%" + textoBusqueda + "%";
            ps.setString(1, busqueda);
            ps.setString(2, busqueda);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearSocio(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Método auxiliar para evitar repetir código al leer el ResultSet
    private Socio mapearSocio(ResultSet rs) throws SQLException {
        Socio socio = new Socio();
        socio.setIdSocio(rs.getInt("id_socio"));
        socio.setDocumento(rs.getString("documento"));
        socio.setNombres(rs.getString("nombres"));
        socio.setApellidos(rs.getString("apellidos"));
        socio.setTelefono(rs.getString("telefono"));
        socio.setCorreo(rs.getString("correo"));
        Date fechaSql = rs.getDate("fecha_nacimiento");
        if (fechaSql != null) {
            socio.setFechaNacimiento(fechaSql.toLocalDate());
        }

        socio.setActivo(rs.getBoolean("activo"));
        return socio;
    }

}
