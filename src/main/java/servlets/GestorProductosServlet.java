package servlets;

import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "GestorProductosServlet", urlPatterns = {"/GestorProductosServlet"})
public class GestorProductosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // 1. Capturamos los datos enviados desde el formulario (todos son texto)
        String idStr = request.getParameter("id_producto");
        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String ingredientes = request.getParameter("ingredientes");
        String categoria = request.getParameter("categoria");
        
        // AHORA SOLO CAPTURAMOS LA URL COMO TEXTO
        String imagenUrlFinal = request.getParameter("imagen_producto");

        // Validación de seguridad por si el campo llega vacío
        if (imagenUrlFinal == null || imagenUrlFinal.trim().isEmpty()) {
            imagenUrlFinal = "https://i.imgur.com/gK9J2M6.png"; // URL de imagen por defecto
        }

        try (Connection con = Conexion.getConnection()) {
            if (idStr == null || idStr.isEmpty()) {
                // INSERTAR NUEVO PRODUCTO
                String sql = "INSERT INTO pizzas (nombre, precio, ingredientes, imagen_url, categoria) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, nombre);
                    ps.setDouble(2, Double.parseDouble(precioStr));
                    ps.setString(3, ingredientes);
                    ps.setString(4, imagenUrlFinal.trim());
                    ps.setString(5, categoria); 
                    ps.executeUpdate();
                }
            } else {
                // ACTUALIZAR PRODUCTO EXISTENTE
                int id = Integer.parseInt(idStr);
                String sql = "UPDATE pizzas SET nombre=?, precio=?, ingredientes=?, imagen_url=?, categoria=? WHERE id=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, nombre);
                    ps.setDouble(2, Double.parseDouble(precioStr));
                    ps.setString(3, ingredientes);
                    ps.setString(4, imagenUrlFinal.trim());
                    ps.setString(5, categoria); 
                    ps.setInt(6, id);
                    ps.executeUpdate();
                }
            }
            response.sendRedirect("admin_productos.jsp");
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("admin_productos.jsp?error=true");
        }
    }
}
