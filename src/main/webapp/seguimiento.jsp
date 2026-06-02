<%@page import="config.Conexion"%>
<%@page import="modelos.Usuario"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if(user == null) { response.sendRedirect("login_cliente.jsp"); return; }

    // Inicializamos variables de forma segura
    String estadoActual = "";
    int pedidoId = 0;
    double totalPedido = 0.0;
    String direccionPedido = "";
    boolean tienePedido = false;

    // UNA SOLA CONEXIÓN A LA BASE DE DATOS PARA TODO EL ARCHIVO
    try (Connection con = Conexion.getConnection()) {
        String sql = "SELECT id, estado, total, direccion FROM pedidos WHERE usuario_id = ? ORDER BY id DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, user.getId());
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            tienePedido = true;
            pedidoId = rs.getInt("id");
            // .trim() elimina espacios fantasma y aseguramos que no sea nulo
            estadoActual = rs.getString("estado") != null ? rs.getString("estado").trim() : "";
            totalPedido = rs.getDouble("total");
            direccionPedido = rs.getString("direccion");
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Seguimiento - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
    <script>
        localStorage.removeItem('misterPizzaCarrito')
        // Lógica de actualización automática
        <% if (tienePedido && !estadoActual.equalsIgnoreCase("Entregado")) { %>
            setInterval(function() { window.location.reload(); }, 10000);
        <% } else if (tienePedido && estadoActual.equalsIgnoreCase("Entregado")) { %>
            setTimeout(function() { window.location.href = "catalogo.jsp"; }, 6000);
        <% } %>
    </script>
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col">

    <header class="bg-black text-white p-4 flex justify-between items-center border-b-4 border-red-600 shadow-2xl">
        <a href="catalogo.jsp" class="text-sm font-bold text-zinc-400 hover:text-white transition-colors">⬅️ Menú</a>
        <h1 class="font-black text-xl italic tracking-wider">MISTER PIZZA</h1>
        <div class="w-10"></div>
    </header>

    <main class="flex-1 max-w-3xl w-full mx-auto mt-12 px-4">
        
        <% if (!tienePedido || estadoActual.isEmpty()) { %>
            <div class="text-center py-20 bg-zinc-900 border border-zinc-800 rounded-xl shadow-lg">
                <div class="text-6xl mb-4">🤷‍♂️</div>
                <p class="text-zinc-400 text-lg mb-6">No tienes pedidos en curso ahora mismo.</p>
                <a href="catalogo.jsp" class="bg-red-600 text-white px-8 py-3 rounded-md font-bold hover:bg-red-700 transition-colors shadow-lg uppercase tracking-wider inline-block">
                    ¡Hacer un pedido ahora!
                </a>
            </div>

        <% } else if (estadoActual.equalsIgnoreCase("Entregado")) { %>
            <div class="bg-zinc-900 p-10 rounded-xl shadow-2xl border border-red-600/30 text-center animate-bounce-short">
                <div class="text-8xl mb-6">🎉</div>
                <h1 class="text-3xl md:text-4xl font-black text-white mb-4 uppercase">¡Pedido Entregado!</h1>
                <p class="text-zinc-400 mb-8">Gracias por confiar en Mister Pizza. ¡Que disfrutes tu comida!</p>
                
                <div class="bg-red-600/10 text-red-500 border border-red-600/30 p-4 rounded-md font-bold text-sm inline-block mb-8 uppercase tracking-widest">
                    ✅ Tu pizza ha llegado a su destino
                </div>

                <div class="text-zinc-500 text-sm italic">Volviendo al menú principal...</div>
            </div>

        <% } else { %>
            <h1 class="text-2xl md:text-3xl font-black text-white text-center mb-8 uppercase tracking-wide">Sigue tu Pizza en Vivo 🛵</h1>
            
            <div class="bg-zinc-900 p-6 md:p-8 rounded-xl shadow-2xl border border-zinc-800">
                
                <div class="flex justify-between items-center mb-10 border-b border-zinc-800 pb-4">
                    <div>
                        <p class="text-zinc-500 text-xs font-bold uppercase tracking-widest">Pedido #<%= pedidoId %></p>
                        <h2 class="text-xl font-bold text-white">Estado Actual</h2>
                    </div>
                    <div class="text-right">
                        <p class="text-xs text-zinc-500 font-bold uppercase tracking-widest">Total Pagado</p>
                        <p class="font-black text-red-500 text-xl">S/ <%= String.format("%.2f", totalPedido) %></p>
                    </div>
                </div>

                <div class="relative mb-12 px-2 md:px-4">
                    <div class="h-3 bg-zinc-800 rounded-full overflow-hidden">
                        <div class="h-full bg-red-600 transition-all duration-1000 shadow-[0_0_10px_rgba(220,38,38,0.8)]" 
                             style="width: <%= estadoActual.equalsIgnoreCase("Pendiente") ? "15%" : estadoActual.equalsIgnoreCase("Cocinando") ? "45%" : "75%" %>">
                        </div>
                    </div>
                    
                    <div class="flex justify-between mt-6 text-[10px] md:text-xs font-black uppercase tracking-widest">
                        <div class="<%= estadoActual.equalsIgnoreCase("Pendiente") ? "text-red-500 scale-110" : "text-zinc-600" %> text-center transition-all">
                            <div class="text-2xl mb-1">📝</div>Recibido
                        </div>
                        <div class="<%= estadoActual.equalsIgnoreCase("Cocinando") ? "text-red-500 scale-110" : "text-zinc-600" %> text-center transition-all">
                            <div class="text-2xl mb-1">🔥</div>Cocina
                        </div>
                        <div class="<%= estadoActual.equalsIgnoreCase("En Camino") ? "text-red-500 scale-110" : "text-zinc-600" %> text-center transition-all">
                            <div class="text-2xl mb-1">🛵</div>Reparto
                        </div>
                        <div class="text-zinc-600 text-center">
                            <div class="text-2xl mb-1">✅</div>Llegó
                        </div>
                    </div>
                </div>

                <div class="bg-black p-5 rounded-md border border-zinc-800">
                    <div class="flex items-start gap-3">
                        <span class="text-xl">📍</span>
                        <div>
                            <p class="text-xs font-bold text-zinc-500 uppercase tracking-widest">Enviar a:</p>
                            <p class="text-white font-medium text-sm mt-1"><%= direccionPedido %></p>
                        </div>
                    </div>
                </div>

                <div class="mt-8 text-center flex items-center justify-center gap-3">
                    <div class="w-4 h-4 border-2 border-red-600 border-t-transparent rounded-full animate-spin"></div>
                    <span class="text-zinc-500 text-xs font-bold uppercase tracking-widest">Buscando actualizaciones...</span>
                </div>
            </div>
        <% } %>
    </main>
</body>
</html>