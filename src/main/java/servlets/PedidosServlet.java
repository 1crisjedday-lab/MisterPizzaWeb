package servlets;

import config.Conexion;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PedidosServlet")
public class PedidosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        try (Connection con = Conexion.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT id, cliente_nombre, items, total, estado FROM pedidos")) {
            
            StringBuilder json = new StringBuilder("[");
            while (rs.next()) {
                json.append(String.format("{\"id\":%d, \"cliente\":\"%s\", \"items\":\"%s\", \"total\":%.2f, \"estado\":\"%s\"}%s",
                    rs.getInt("id"), 
                    rs.getString("cliente_nombre"), 
                    rs.getString("items"), 
                    rs.getDouble("total"), 
                    rs.getString("estado"), 
                    rs.isLast() ? "" : ","));
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
            
        } catch (Exception e) {
            System.err.println("Error en PedidosServlet: " + e.getMessage());
            response.getWriter().write("[]");
        }
    }
}