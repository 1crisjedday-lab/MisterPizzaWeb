<%@page import="java.util.List"%>
<%@page import="modelos.ItemCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    modelos.Usuario usuario = (modelos.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) { response.sendRedirect("login_cliente.jsp"); return; }
    
    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carritoCompras");
    if (carrito == null || carrito.isEmpty()) { response.sendRedirect("catalogo.jsp"); return; }
    
    double totalGeneral = 0;
    for (ItemCarrito item : carrito) { 
        totalGeneral += (item.getPrecio() * item.getCantidad()); 
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen pb-12">

    <header class="bg-black text-white p-4 sticky top-0 z-20 flex justify-between items-center border-b-4 border-red-600 shadow-2xl">
        <a href="carrito.jsp" class="text-sm font-bold text-zinc-400 hover:text-white transition-colors">⬅️ Volver al Carrito</a>
        <h1 class="text-xl font-black italic tracking-wider uppercase">Mister Pizza</h1>
        <div class="w-24"></div>
    </header>

    <main class="max-w-5xl mx-auto mt-8 px-4 grid grid-cols-1 md:grid-cols-2 gap-8">
        
        <div class="space-y-6">
            <div class="bg-zinc-900 border border-zinc-800 rounded-xl p-6 shadow-lg">
                <h2 class="text-xl font-black text-white mb-4 uppercase tracking-wide">📍 Dirección de Envío</h2>
                
                <form id="form-final" action="ConfirmarPedidoServlet" method="POST">
                    
                    <textarea name="direccion" id="direccion" required 
                        placeholder="Ej: Av. El Sol 123, Int 4, Puno (Frente al parque)"
                        class="w-full bg-zinc-950 border border-zinc-800 text-white p-4 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700 resize-none h-24 mb-6"></textarea>
                    
                    <h2 class="text-xl font-black text-white mb-4 uppercase tracking-wide">💳 Método de Pago</h2>
                    <div class="grid grid-cols-2 gap-3 mb-6">
                        <label class="cursor-pointer">
                            <input type="radio" name="metodo" value="Yape" class="peer sr-only" checked onchange="toggleYape(true)">
                            <div class="p-4 border border-zinc-800 bg-zinc-950 rounded-md text-center peer-checked:border-red-600 peer-checked:ring-1 peer-checked:ring-red-600 hover:bg-zinc-900 transition-all">
                                <span class="block text-3xl mb-2">📱</span> 
                                <span class="font-bold text-white text-sm uppercase tracking-widest">Yape</span>
                            </div>
                        </label>
                        <label class="cursor-pointer">
                            <input type="radio" name="metodo" value="Efectivo" class="peer sr-only" onchange="toggleYape(false)">
                            <div class="p-4 border border-zinc-800 bg-zinc-950 rounded-md text-center peer-checked:border-red-600 peer-checked:ring-1 peer-checked:ring-red-600 hover:bg-zinc-900 transition-all">
                                <span class="block text-3xl mb-2">💵</span> 
                                <span class="font-bold text-white text-sm uppercase tracking-widest">Efectivo</span>
                            </div>
                        </label>
                    </div>

                    <div id="seccion-yape" class="bg-zinc-950 border border-zinc-800 p-6 rounded-md text-center mb-6">
                        <div class="bg-[#742384] text-white w-full py-2 rounded-t-md font-bold text-sm mb-4 flex items-center justify-center gap-2 uppercase tracking-widest">
                            Paga con Yape
                        </div>
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=YAPE_MISTER_PIZZA" class="mx-auto border-4 border-white shadow-sm mb-4 rounded-md" />
                        <p class="text-xs text-zinc-400 font-bold uppercase tracking-widest">Mister Pizza S.A.C - 987 654 321</p>
                    </div>

                    <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-4 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.4)] transition-all">
                        Confirmar y Finalizar Pedido
                    </button>
                </form>
            </div>
        </div>

        <div>
            <div class="bg-black text-white p-6 rounded-2xl shadow-[0_0_20px_rgba(0,0,0,0.8)] border border-zinc-800 h-fit sticky top-24">
                <h3 class="text-sm font-black mb-4 border-b border-zinc-800 pb-4 uppercase tracking-widest text-zinc-400 text-center">Resumen de Compra</h3>
                
                <div class="space-y-4 mb-6 max-h-64 overflow-y-auto pr-2 custom-scrollbar">
                    <% for (ItemCarrito item : carrito) { %>
                        <div class="border-b border-zinc-800 pb-3">
                            <div class="flex justify-between font-black text-white text-lg">
                                <span><%= item.getCantidad() %>x <%= item.getNombre() %></span>
                                <span class="text-red-500">S/ <%= String.format("%.2f", item.getPrecio() * item.getCantidad()) %></span>
                            </div>
                            <p class="text-xs text-zinc-500 mt-1 italic"><%= item.getDescripcion() %></p>
                        </div>
                    <% } %>
                </div>

                <div class="flex justify-between items-end border-t border-zinc-800 pt-4">
                    <span class="text-sm font-bold uppercase tracking-widest text-zinc-400">Total Final</span>
                    <span class="text-4xl font-black text-white">S/ <%= String.format("%.2f", totalGeneral) %></span>
                </div>
            </div>
        </div>
    </main>

    <script>
        function toggleYape(show) {
            document.getElementById('seccion-yape').style.display = show ? 'block' : 'none';
        }
    </script>
</body>
</html>