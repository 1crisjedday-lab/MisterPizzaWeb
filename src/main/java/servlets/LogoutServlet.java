package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtenemos la sesión actual
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate(); // Destruye la sesión (olvida al usuario)
        }
        
        // Redirige al login principal
        response.sendRedirect("login_cliente.jsp");
    }
}