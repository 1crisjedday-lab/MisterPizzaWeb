package servlets;

import modelos.ItemCarrito;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProcesarPedidoPersonalizadoServlet", urlPatterns = {"/ProcesarPedidoPersonalizadoServlet"})
public class ProcesarPedidoPersonalizadoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // JS nos envía la información ya procesada lista para guardar
        String pizzaBase = request.getParameter("pizza_base");
        String descripcion = request.getParameter("descripcion_generada");
        String precioStr = request.getParameter("precio_total");

        double precio = Double.parseDouble(precioStr);

        // Armamos el nombre, ej: "Pizza Hawaiana (Personalizada)"
        String nombreFinal = "Pizza " + pizzaBase + " (Custom)";

        ItemCarrito nuevoItem = new ItemCarrito(nombreFinal, descripcion, precio, 1);

        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carritoCompras");
        
        if (carrito == null) {
            carrito = new ArrayList<>();
        }
        
        carrito.add(nuevoItem);
        session.setAttribute("carritoCompras", carrito);

        response.sendRedirect("carrito.jsp");
    }
}