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
import java.sql.ResultSet;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboardServlet"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        double gananciaHoy = 0.0;
        double gananciaMes = 0.0;
        double gananciaAnio = 0.0;
        int totalPedidosDia = 0;

        // NOTA: Cambiamos "fecha_pedido" por "fecha" para coincidir con la BD
        String sqlHoy = "SELECT COALESCE(SUM(total), 0) AS total, COUNT(id) AS cantidad FROM pedidos WHERE DATE(fecha) = CURRENT_DATE";
        String sqlMes = "SELECT COALESCE(SUM(total), 0) AS total FROM pedidos WHERE EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE)";
        String sqlAnio = "SELECT COALESCE(SUM(total), 0) AS total FROM pedidos WHERE EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE)";

        try (Connection con = Conexion.getConnection()) {
            
            // 1. Ganancias del día
            try (PreparedStatement ps = con.prepareStatement(sqlHoy); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    gananciaHoy = rs.getDouble("total");
                    totalPedidosDia = rs.getInt("cantidad");
                }
            }
            
            // 2. Ganancias del mes
            try (PreparedStatement ps = con.prepareStatement(sqlMes); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    gananciaMes = rs.getDouble("total");
                }
            }
            
            // 3. Ganancias del año
            try (PreparedStatement ps = con.prepareStatement(sqlAnio); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    gananciaAnio = rs.getDouble("total");
                }
            }

            // Enviamos las variables calculadas a la interfaz JSP
            request.setAttribute("gananciaHoy", gananciaHoy);
            request.setAttribute("gananciaMes", gananciaMes);
            request.setAttribute("gananciaAnio", gananciaAnio);
            request.setAttribute("totalPedidosDia", totalPedidosDia);
            
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error al calcular métricas del dashboard: " + e.getMessage());
            response.sendRedirect("login_personal.jsp?error=dashboard");
        }
    }
}