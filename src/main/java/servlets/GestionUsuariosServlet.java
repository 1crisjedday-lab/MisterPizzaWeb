package servlets;

import dao.UsuarioDAO;
import modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GestionUsuariosServlet", urlPatterns = {"/GestionUsuariosServlet"})
public class GestionUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Control de Acceso: Solo Administradores (rol_id = 3)
        HttpSession session = request.getSession(false);
        Usuario admin = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;
        
        if (admin == null || admin.getRolId() != 3) {
            response.sendRedirect("login_personal.jsp?error=no_autorizado");
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> lista = dao.listarUsuarios();
        
        request.setAttribute("usuariosList", lista);
        request.getRequestDispatcher("admin_usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Control de Acceso: Solo Administradores (rol_id = 3)
        HttpSession session = request.getSession(false);
        Usuario admin = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;
        
        if (admin == null || admin.getRolId() != 3) {
            response.sendRedirect("login_personal.jsp?error=no_autorizado");
            return;
        }

        String idUsuarioStr = request.getParameter("id_usuario");
        
        if (idUsuarioStr != null && !idUsuarioStr.trim().isEmpty()) {
            try {
                int idUsuario = Integer.parseInt(idUsuarioStr);
                UsuarioDAO dao = new UsuarioDAO();
                
                // Evitar que el administrador se elimine a sí mismo
                if (idUsuario == admin.getId()) {
                    response.sendRedirect("GestionUsuariosServlet?error=autoeliminar");
                    return;
                }
                
                boolean eliminado = dao.eliminarUsuario(idUsuario);
                if (eliminado) {
                    response.sendRedirect("GestionUsuariosServlet?success=eliminado");
                } else {
                    response.sendRedirect("GestionUsuariosServlet?error=eliminar");
                }
                return;
                
            } catch (NumberFormatException e) {
                System.err.println("Error al parsear el ID del usuario: " + idUsuarioStr);
            }
        }
        
        response.sendRedirect("GestionUsuariosServlet");
    }
}
