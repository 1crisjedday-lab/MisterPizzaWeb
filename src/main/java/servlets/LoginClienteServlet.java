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

@WebServlet(name = "LoginClienteServlet", urlPatterns = {"/LoginClienteServlet"})
public class LoginClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String clave = request.getParameter("password");

        // Consulta SQL para verificar el cliente con sus datos completos
        String sql = "SELECT id, nombre, telefono, rol_id, fecha_registro FROM usuarios WHERE correo = ? AND clave = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, clave);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    
                    // 1. Iniciamos la sesión con el objeto Usuario completo
                    Usuario usuario = new Usuario(
                        rs.getInt("id"), 
                        rs.getString("nombre"), 
                        email, 
                        rs.getString("telefono"), 
                        rs.getInt("rol_id"), 
                        rs.getTimestamp("fecha_registro")
                    );
                    HttpSession session = request.getSession();
                    session.setAttribute("usuarioLogueado", usuario);

                    // 2. Enrutamiento directo: Todo el que entra por aquí va al catálogo
                    response.sendRedirect("catalogo.jsp");
                    
                } else {
                    // Contraseña o correo incorrecto
                    response.sendRedirect("login_cliente.jsp?error=credenciales");
                }
            }

        } catch (Exception e) {
            System.err.println("Error en el login del cliente: " + e.getMessage());
            response.sendRedirect("login_cliente.jsp?error=bd");
        }
    }
}