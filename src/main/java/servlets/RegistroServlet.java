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
import java.sql.SQLException;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibimos los datos del formulario (deben coincidir con el atributo 'name' del JSP)
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String dni = request.getParameter("dni");
        String clave = request.getParameter("password");

        // 2. Definimos la consulta SQL (Asegúrate de que la tabla 'usuarios' tenga estas columnas)
        String sql = "INSERT INTO usuarios (nombre, correo, telefono, dni, clave, rol_id) VALUES (?, ?, ?, ?, ?, 1)";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            // 3. Asignamos los parámetros
            ps.setString(1, nombre);
            ps.setString(2, correo);
            ps.setString(3, telefono);
            ps.setString(4, dni);
            ps.setString(5, clave);

            // 4. Ejecutamos la inserción
            int filas = ps.executeUpdate();

            if (filas > 0) {
                // Si tuvo éxito, enviamos al usuario al Login
                response.sendRedirect("login_cliente.jsp");
            } else {
                // Si no se insertó nada
                response.sendRedirect("registro_cliente.jsp?error=registro_fallido");
            }

        } catch (SQLException e) {
            // Log de error en consola de servidor para depuración
            System.err.println("Error al registrar usuario: " + e.getMessage());
            // Redirigimos con un parámetro de error
            response.sendRedirect("registro_cliente.jsp?error=bd");
        }
    }
}