package servlets;

import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "CatalogoServlet", urlPatterns = {"/CatalogoServlet"})
public class CatalogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Le decimos al navegador que le vamos a enviar datos en formato JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection con = Conexion.getConnection();
             PrintWriter out = response.getWriter()) {

            // 1. AÑADIMOS 'categoria' A LA CONSULTA SQL
            String sql = "SELECT id, nombre, ingredientes, precio, imagen_url, categoria FROM pizzas WHERE disponible = TRUE";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Construimos la estructura JSON manualmente leyendo los datos de PostgreSQL
            StringBuilder json = new StringBuilder();
            json.append("[");
            boolean first = true;

            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                json.append("{");
                json.append("\"id\":").append(rs.getInt("id")).append(",");
                json.append("\"nombre\":\"").append(rs.getString("nombre")).append("\",");
                json.append("\"ingredientes\":\"").append(rs.getString("ingredientes")).append("\",");
                json.append("\"precio\":").append(rs.getDouble("precio")).append(",");
                
                // Evitamos errores si alguna pizza no tiene imagen registrada
                String img = rs.getString("imagen_url");
                if (img == null) {
                    img = "";
                }
                json.append("\"imagen_url\":\"").append(img).append("\",");

                // 2. AÑADIMOS LA CATEGORÍA AL JSON CON UN VALOR POR DEFECTO SEGURO
                String cat = rs.getString("categoria");
                if (cat == null) {
                    cat = "Pizzas Clásicas";
                }
                json.append("\"categoria\":\"").append(cat).append("\"");

                json.append("}");
                
                first = false;
            }
            json.append("]");

            // Enviamos el JSON terminado a la página JSP
            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            System.out.println("Error en CatalogoServlet: " + e.getMessage());
            // Si hay un error, devolvemos un código 500 para que el frontend lo sepa
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}