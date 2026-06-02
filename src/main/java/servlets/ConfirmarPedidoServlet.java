package servlets;

import config.Conexion;
import modelos.ItemCarrito;
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
import java.sql.Statement;
import java.util.List;

@WebServlet(name = "ConfirmarPedidoServlet", urlPatterns = {"/ConfirmarPedidoServlet"})
public class ConfirmarPedidoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carritoCompras");
        String direccion = request.getParameter("direccion");
        String metodo = request.getParameter("metodo");

        if (user == null || carrito == null || direccion == null) {
            response.sendRedirect("login_cliente.jsp");
            return;
        }

        double total = 0;
        for (ItemCarrito item : carrito) total += item.getSubtotal();

        try (Connection con = Conexion.getConnection()) {
            con.setAutoCommit(false); // Iniciamos transacción

            // 1. Insertar el Pedido General
            String sqlPedido = "INSERT INTO pedidos (usuario_id, total, direccion, metodo_pago) VALUES (?, ?, ?, ?) RETURNING id";
            int pedidoId = 0;
            try (PreparedStatement ps = con.prepareStatement(sqlPedido)) {
                ps.setInt(1, user.getId());
                ps.setDouble(2, total);
                ps.setString(3, direccion);
                ps.setString(4, metodo);
                
                ResultSet rs = ps.executeQuery();
                if (rs.next()) pedidoId = rs.getInt(1);
            }

            // 2. Insertar los Detalles
            String sqlDetalle = "INSERT INTO detalle_pedidos (pedido_id, producto_nombre, descripcion, precio, cantidad) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sqlDetalle)) {
                for (ItemCarrito item : carrito) {
                    ps.setInt(1, pedidoId);
                    ps.setString(2, item.getNombre());
                    ps.setString(3, item.getDescripcion());
                    ps.setDouble(4, item.getPrecio());
                    ps.setInt(5, item.getCantidad());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit(); // Todo bien, guardamos definitivamente
            session.removeAttribute("carritoCompras"); // Vaciamos el carrito
            response.sendRedirect("seguimiento.jsp"); // ¡Al seguimiento!

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=true");
        }
    }
}