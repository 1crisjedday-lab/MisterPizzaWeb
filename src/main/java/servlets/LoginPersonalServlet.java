package servlets;

import config.Conexion;
import modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "LoginPersonalServlet", urlPatterns = {"/LoginPersonalServlet"})
public class LoginPersonalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String clave = request.getParameter("password");

        String sql = "SELECT id, nombre, telefono, rol_id, fecha_registro FROM usuarios WHERE correo = ? AND clave = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, clave);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int rolUsuario = rs.getInt("rol_id");

                    // FILTRO DE SEGURIDAD: Solo dejamos pasar al rol 2 (Cocinero) y 3 (Admin)
                    if (rolUsuario == 2 || rolUsuario == 3) {
                        
                        Usuario usuario = new Usuario(
                            rs.getInt("id"), 
                            rs.getString("nombre"), 
                            email, 
                            rs.getString("telefono"), 
                            rolUsuario, 
                            rs.getTimestamp("fecha_registro")
                        );
                        HttpSession session = request.getSession();
                        session.setAttribute("usuarioLogueado", usuario);

                        if (rolUsuario == 3) {
                            response.sendRedirect("AdminDashboardServlet"); // Admin al dashboard
                        } else {
                            response.sendRedirect("cocina_kanban.jsp"); // Cocinero a su panel
                        }
                    } else {
                        // Si un cliente (rol 1) intenta entrar por aquí, lo botamos
                        response.sendRedirect("login_personal.jsp?error=credenciales");
                    }
                } else {
                    response.sendRedirect("login_personal.jsp?error=credenciales");
                }
            }
        } catch (Exception e) {
            System.err.println("Error en acceso de personal: " + e.getMessage());
            response.sendRedirect("login_personal.jsp?error=bd");
        }
    }
}