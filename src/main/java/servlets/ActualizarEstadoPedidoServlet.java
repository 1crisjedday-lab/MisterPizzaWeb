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

@WebServlet(name = "ActualizarEstadoPedidoServlet", urlPatterns = {"/ActualizarEstadoPedidoServlet"})
public class ActualizarEstadoPedidoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String nuevoEstado = request.getParameter("estado");

        try (Connection con = Conexion.getConnection()) {
            String sql = "UPDATE pedidos SET estado = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nuevoEstado);
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Regresa al panel de cocina
        response.sendRedirect("cocina_kanban.jsp");
    }
}