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

@WebServlet(name = "GuardarCarritoServlet", urlPatterns = {"/GuardarCarritoServlet"})
public class GuardarCarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configuramos UTF-8 para que las tildes y las 'ñ' viajen bien
        request.setCharacterEncoding("UTF-8");
        
        String datosSeguros = request.getParameter("carritoJson");
        List<ItemCarrito> listaJava = new ArrayList<>();

        if (datosSeguros != null && !datosSeguros.isEmpty()) {
            try {
                // 1. Separamos cada pizza usando el doble palito (||)
                // Usamos \\|\\| porque el palito es un caracter especial en Java
                String[] pizzas = datosSeguros.split("\\|\\|");

                for (String pizzaStr : pizzas) {
                    // 2. Separamos los 4 atributos de la pizza usando un solo palito (|)
                    String[] datos = pizzaStr.split("\\|");

                    // Si la lectura fue correcta, la longitud debe ser 4
                    if (datos.length >= 4) {
                        ItemCarrito item = new ItemCarrito();
                        item.setNombre(datos[0]);
                        item.setDescripcion(datos[1]); // Aquí van los ingredientes con comas y no pasa nada
                        item.setPrecio(Double.parseDouble(datos[2]));
                        item.setCantidad(Integer.parseInt(datos[3]));

                        listaJava.add(item);
                    }
                }
            } catch (Exception e) {
                System.err.println("Error procesando el carrito seguro: " + e.getMessage());
            }
        }

        // Guardamos en la sesión y redirigimos
        HttpSession session = request.getSession();
        session.setAttribute("carritoCompras", listaJava);
        response.sendRedirect("carrito.jsp");
    }
}