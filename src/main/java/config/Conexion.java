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
            
            // Intentar obtener credenciales desde variables de entorno (Railway)
            String dbUrl = System.getenv("JDBC_DATABASE_URL");
            String dbUser = System.getenv("PGUSER");
            if (dbUser == null) dbUser = System.getenv("POSTGRES_USER");
            String dbPass = System.getenv("PGPASSWORD");
            if (dbPass == null) dbPass = System.getenv("POSTGRES_PASSWORD");
            
            String finalUrl = URL;
            String finalUser = USER;
            String finalPass = PASS;
            
            if (dbUrl != null && !dbUrl.isEmpty()) {
                finalUrl = dbUrl;
                if (finalUrl.contains("@")) {
                    con = DriverManager.getConnection(finalUrl);
                    System.out.println("Conexión establecida correctamente usando JDBC_DATABASE_URL con credenciales embebidas.");
                    return con;
                }
                if (dbUser != null) finalUser = dbUser;
                if (dbPass != null) finalPass = dbPass;
            } else {
                String databaseUrl = System.getenv("DATABASE_URL");
                if (databaseUrl != null && !databaseUrl.isEmpty()) {
                    if (databaseUrl.startsWith("postgresql://")) {
                        finalUrl = "jdbc:" + databaseUrl;
                    } else {
                        finalUrl = databaseUrl;
                    }
                    con = DriverManager.getConnection(finalUrl);
                    System.out.println("Conexión establecida correctamente usando DATABASE_URL.");
                    return con;
                } else {
                    String host = System.getenv("PGHOST");
                    if (host == null) host = System.getenv("POSTGRES_HOST");
                    if (host != null && !host.isEmpty()) {
                        String port = System.getenv("PGPORT");
                        if (port == null) port = System.getenv("POSTGRES_PORT");
                        if (port == null) port = "5432";
                        
                        String db = System.getenv("PGDATABASE");
                        if (db == null) db = System.getenv("POSTGRES_DB");
                        if (db == null) db = System.getenv("POSTGRES_DATABASE");
                        
                        finalUrl = "jdbc:postgresql://" + host + ":" + port + "/" + db;
                        if (dbUser != null) finalUser = dbUser;
                        if (dbPass != null) finalPass = dbPass;
                    }
                }
            }
            
            // 2. Intentar establecer la conexión
            con = DriverManager.getConnection(finalUrl, finalUser, finalPass);
            System.out.println("Conexión establecida correctamente.");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver de PostgreSQL no encontrado. " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }
}