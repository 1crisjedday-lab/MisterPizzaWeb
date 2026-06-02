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

@WebServlet(name = "EliminarProductoServlet", urlPatterns = {"/EliminarProductoServlet"})
public class EliminarProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id != null && !id.isEmpty()) {
            String sql = "DELETE FROM pizzas WHERE id = ?";
            
            try (Connection con = Conexion.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                
            } catch (Exception e) {
                System.err.println("Error al eliminar producto: " + e.getMessage());
            }
        }
        // Redirigimos de vuelta a la tabla
        response.sendRedirect("admin_productos.jsp");
    }
}   