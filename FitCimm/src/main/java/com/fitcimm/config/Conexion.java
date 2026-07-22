/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fitcimm.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author Usuario
 */
public class Conexion {

    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    static {
        try (InputStream input = Conexion.class.getClassLoader().getResourceAsStream("db.properties")) {
            Properties prop = new Properties();

            if (input == null) {
                throw new RuntimeException("No se encontró el archivo db.properties en la carpeta de recursos.");
            }

            prop.load(input);

            driver = prop.getProperty("db.driver");
            url = prop.getProperty("db.url");
            user = prop.getProperty("db.user");
            password = prop.getProperty("db.password");

            // Registrar el driver JDBC
            Class.forName(driver);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al cargar la configuración de la BD: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
