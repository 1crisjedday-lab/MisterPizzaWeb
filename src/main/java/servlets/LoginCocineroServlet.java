package servlets;

import config.Conexion;
import modelos.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "LoginCocinero", urlPatterns = {"/LoginCocinero"})
public class LoginCocineroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        try (Connection con = Conexion.getConnection()) {
            String sql = "SELECT id, nombre, rol_id FROM usuarios WHERE correo = ? AND clave = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, clave);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int rolId = rs.getInt("rol_id");
                
                if (rolId == 2 || rolId == 3) {
                    Usuario user = new Usuario(rs.getInt("id"), rs.getString("nombre"), correo, rolId);
                    request.getSession().setAttribute("usuarioLogueado", user);
                    response.sendRedirect("cocina_kanban.jsp");
                } else {
                    request.setAttribute("error", "No tienes permisos de acceso.");
                    request.getRequestDispatcher("login_cocinero.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Credenciales incorrectas.");
                request.getRequestDispatcher("login_cocinero.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("login_cocinero.jsp").forward(request, response);
        }
    }
}