package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    
    // Configura estos datos según tu instalación de PostgreSQL
    private static final String URL = "jdbc:postgresql://dpg-d9nuu361egvs738r1mjg-a.ohio-postgres.render.com:5432/misterpizza_db";
    private static final String USER = "misterpizza_db_user";
    // REEMPLAZA 'tu_password' por la contraseña que pusiste al instalar PostgreSQL
    private static final String PASS = "cuV6UE2Sx6ACFqvE43KyLNYsnO440UfR";

    public static Connection getConnection() {
        Connection con = null;
        try {
            // 1. Cargar explícitamente el driver
            Class.forName("org.postgresql.Driver");
            
            // Intentar obtener credenciales desde variables de entorno (Railway)
            String dbUrl = System.getenv("JDBC_DATABASE_URL");
            String databaseUrl = System.getenv("DATABASE_URL");
            
            String finalUrl = URL;
            String finalUser = USER;
            String finalPass = PASS;
            
            // Si dbUrl está definida, intentamos usarla primero
            if (dbUrl != null && !dbUrl.isEmpty()) {
                con = getParsedConnection(dbUrl);
                if (con != null) return con;
                finalUrl = dbUrl;
            } 
            // Si no, intentamos con DATABASE_URL
            else if (databaseUrl != null && !databaseUrl.isEmpty()) {
                con = getParsedConnection(databaseUrl);
                if (con != null) return con;
                if (databaseUrl.startsWith("postgresql://")) {
                    finalUrl = "jdbc:" + databaseUrl;
                } else {
                    finalUrl = databaseUrl;
                }
            } 
            // Fallback a variables individuales (PGHOST, etc.) o local
            else {
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
                    
                    String dbUser = System.getenv("PGUSER");
                    if (dbUser == null) dbUser = System.getenv("POSTGRES_USER");
                    if (dbUser != null) finalUser = dbUser;
                    
                    String dbPass = System.getenv("PGPASSWORD");
                    if (dbPass == null) dbPass = System.getenv("POSTGRES_PASSWORD");
                    if (dbPass != null) finalPass = dbPass;
                }
            }
            
            // 2. Intentar establecer la conexión fallback
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

    private static Connection getParsedConnection(String rawUrl) {
        String urlToParse = rawUrl;
        if (urlToParse.startsWith("jdbc:")) {
            urlToParse = urlToParse.substring(5);
        }
        
        if (urlToParse.startsWith("postgresql://")) {
            try {
                String cleanPart = urlToParse.substring(13); // Remove postgresql://
                
                int atIdx = cleanPart.indexOf("@");
                if (atIdx != -1) {
                    String credentials = cleanPart.substring(0, atIdx);
                    String hostPortDb = cleanPart.substring(atIdx + 1);
                    
                    String dbUser = "";
                    String dbPass = "";
                    int colonIdx = credentials.indexOf(":");
                    if (colonIdx != -1) {
                        dbUser = credentials.substring(0, colonIdx);
                        dbPass = credentials.substring(colonIdx + 1);
                    } else {
                        dbUser = credentials;
                    }
                    
                    String jdbcUrl = "jdbc:postgresql://" + hostPortDb;
                    System.out.println("Conexión establecida usando URL parseada: " + jdbcUrl);
                    return DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
                }
            } catch (Exception e) {
                System.err.println("Error parseando credenciales de la URL: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return null;
    }
}
