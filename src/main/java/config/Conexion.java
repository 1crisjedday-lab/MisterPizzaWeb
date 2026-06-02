package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    
    // Configura estos datos según tu instalación de PostgreSQL
    private static final String URL = "jdbc:postgresql://localhost:5432/mister_pizza";
    private static final String USER = "postgres";
    // REEMPLAZA 'tu_password' por la contraseña que pusiste al instalar PostgreSQL
    private static final String PASS = "admin"; 

    public static Connection getConnection() {
        Connection con = null;
        try {
            // 1. Cargar explícitamente el driver
            Class.forName("org.postgresql.Driver");
            
            // 2. Intentar establecer la conexión
            con = DriverManager.getConnection(URL, USER, PASS);
            
            System.out.println("Conexión establecida correctamente.");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver de PostgreSQL no encontrado. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos: " + e.getMessage());
        }
        return con;
    }
}