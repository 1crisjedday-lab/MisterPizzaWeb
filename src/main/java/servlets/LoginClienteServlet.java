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
        String sql = "SELECT id, nombre, telefono, rol_id, fecha_registro, clave FROM usuarios WHERE correo = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashAlmacenado = rs.getString("clave");
                    boolean claveValida = false;
                    
                    if (hashAlmacenado != null && hashAlmacenado.startsWith("$2a$")) {
                        claveValida = org.mindrot.jbcrypt.BCrypt.checkpw(clave, hashAlmacenado);
                    } else {
                        // Fallback para contraseñas heredadas sin encriptar
                        claveValida = clave.equals(hashAlmacenado);
                    }

                    if (claveValida) {
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
                        session.setMaxInactiveInterval(900); // 15 minutos en segundos
                        session.setAttribute("usuarioLogueado", usuario);

                        // 2. Enrutamiento directo: Todo el que entra por aquí va al catálogo
                        response.sendRedirect("catalogo.jsp");
                    } else {
                        // Contraseña incorrecta
                        response.sendRedirect("login_cliente.jsp?error=credenciales");
                    }
                } else {
                    // Correo incorrecto
                    response.sendRedirect("login_cliente.jsp?error=credenciales");
                }
            }

        } catch (Exception e) {
            System.err.println("Error en el login del cliente: " + e.getMessage());
            response.sendRedirect("login_cliente.jsp?error=bd");
        }
    }
}