<%@page import="java.util.List"%>
<%@page import="modelos.ItemCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    modelos.Usuario usuario = (modelos.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login_cliente.jsp");
        return;
    }
    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carritoCompras");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mi Carrito - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen pb-12">

    <div class="bg-black text-white p-4 sticky top-0 z-20 flex justify-between items-center border-b-4 border-red-600 shadow-2xl">
        <a href="catalogo.jsp" class="text-sm font-bold text-zinc-400 hover:text-white flex items-center gap-2 transition-colors">
            ⬅️ Seguir Comprando
        </a>
        <h1 class="text-xl font-black italic tracking-wider">MI CARRITO 🛒</h1>
        <div class="w-24"></div> 
    </div>

    <div class="max-w-4xl mx-auto mt-8 px-4">
        <h2 class="text-2xl font-bold text-white mb-6">Resumen de tu Pedido</h2>

        <% if (carrito == null || carrito.isEmpty()) { %>
            <div class="bg-zinc-900 border border-zinc-800 rounded-xl p-12 text-center shadow-lg">
                <div class="text-6xl mb-4">🛒</div>
                <h3 class="text-xl font-bold text-white mb-2">Tu carrito está vacío</h3>
                <p class="text-zinc-400 mb-6 text-sm">Aún no has agregado ninguna deliciosa pizza a tu pedido.</p>
                <a href="catalogo.jsp" class="bg-red-600 text-white px-8 py-3 rounded-md font-bold hover:bg-red-700 transition-colors inline-block mt-4">
                    Ver Menú
                </a>
            </div>
        <% } else { %>
            <div class="bg-zinc-900 border border-zinc-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 space-y-4">
                    <% 
                        double totalGeneral = 0;
                        int index = 0; // Índice clave para saber qué pizza eliminar de la memoria
                        for (ItemCarrito item : carrito) { 
                            double subtotal = item.getPrecio() * item.getCantidad();
                            totalGeneral += subtotal;
                    %>
                        <div class="flex flex-col md:flex-row justify-between items-start md:items-center p-4 bg-zinc-950 border border-zinc-800 rounded-lg group hover:border-red-600/50 transition-colors">
                            <div class="flex-1 pr-4">
                                <h3 class="font-black text-lg text-white"><%= item.getNombre() %></h3>
                                <p class="text-xs text-zinc-400 mt-1"><%= item.getDescripcion() %></p>
                            </div>
                            
                            <div class="flex items-center gap-4 mt-4 md:mt-0 w-full md:w-auto justify-between border-t border-zinc-800 md:border-t-0 pt-4 md:pt-0">
                                <span class="bg-zinc-800 text-zinc-300 px-3 py-1 rounded-md text-sm font-bold">
                                    Cant: <%= item.getCantidad() %>
                                </span>
                                <span class="font-black text-red-500 text-lg w-24 text-right">S/ <%= String.format("%.2f", subtotal) %></span>
                                
                                <button onclick="eliminarItem(<%= index %>)" title="Quitar del pedido" class="text-zinc-500 hover:text-red-500 hover:bg-red-500/10 p-2 rounded-md transition-all flex items-center justify-center border border-transparent hover:border-red-500/30">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                </button>
                            </div>
                        </div>
                    <% 
                            index++; 
                        } 
                    %>
                </div>
                
                <div class="bg-black p-6 border-t border-zinc-800 flex flex-col md:flex-row justify-between items-center gap-6">
                    <div>
                        <p class="text-zinc-400 text-sm font-bold uppercase tracking-widest">Total a Pagar</p>
                        <p class="text-3xl font-black text-white">S/ <%= String.format("%.2f", totalGeneral) %></p>
                    </div>
                    
                    <a href="checkout.jsp" class="w-full md:w-auto bg-red-600 hover:bg-red-700 text-white font-bold py-4 px-10 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.3)] transition-all text-center uppercase tracking-wider">
                        Continuar con el Pago 💳
                    </a>
                </div>
            </div>
        <% } %>
    </div>

    <form id="formOcultoCarrito" action="GuardarCarritoServlet" method="POST" style="display: none;">
        <input type="hidden" name="carritoJson" id="inputCarritoJson">
    </form>

    <script>
        function eliminarItem(index) {
            // 1. Obtenemos el carrito actual de la memoria del navegador
            let carritoGlobal = JSON.parse(localStorage.getItem('misterPizzaCarrito')) || [];
            
            // 2. Eliminamos 1 elemento exactamente en la posición 'index'
            carritoGlobal.splice(index, 1);
            
            // 3. Guardamos el nuevo carrito actualizado en el navegador
            localStorage.setItem('misterPizzaCarrito', JSON.stringify(carritoGlobal));
            
            // 4. Formateamos y enviamos al Servlet para que actualice la sesión en el servidor
            const datosSeguros = carritoGlobal.map(item => {
                return item.nombre + "|" + item.ingredientes + "|" + item.precio + "|" + item.cantidad;
            }).join("||");
            
            // 5. Enviamos el formulario. La página parpadeará rápido y el producto ya no estará.
            document.getElementById('inputCarritoJson').value = datosSeguros;
            document.getElementById('formOcultoCarrito').submit();
        }
    </script>
</body>
</html>