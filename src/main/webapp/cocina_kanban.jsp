<%@page import="modelos.Usuario"%>
<%
    // VALIDACIÓN DE SEGURIDAD BASADA EN TU ROL_ID (1 = Admin, 2 = Cocinero)
    Usuario empleado = (Usuario) session.getAttribute("usuarioLogueado");
    if (empleado == null || (empleado.getRolId() != 1 && empleado.getRolId() != 2)) {
        response.sendRedirect("login_personal.jsp");
        return;
    }
%>
<%@page import="config.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cocina - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
    <script>
        // Auto-refresco cada 10 segundos
        setInterval(function(){ location.reload(); }, 10000);
    </script>
</head>
<body class="bg-zinc-950 min-h-screen p-4 md:p-6 text-zinc-100">

    <header class="flex flex-col md:flex-row justify-between items-center mb-8 border-b-2 border-zinc-800 pb-4 gap-4">
        <div class="flex items-center gap-3">
            <span class="text-3xl">👨‍🍳</span>
            <h1 class="text-2xl font-black uppercase tracking-wider text-white">Monitor de Cocina</h1>
        </div>
        <div class="flex gap-4">
             <button onclick="window.location.reload()" class="bg-zinc-800 px-4 py-2 rounded-md text-sm font-bold hover:bg-zinc-700 transition-colors border border-zinc-700">🔄 Refrescar</button>
             <a href="LogoutServlet" class="bg-red-600 px-4 py-2 rounded-md text-sm font-bold hover:bg-red-700 transition-colors">Salir</a>
        </div>
    </header>

    <main class="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">
        
        <section class="bg-zinc-900/50 p-4 rounded-xl border border-zinc-800 h-full">
            <h2 class="text-red-500 font-black uppercase tracking-widest text-sm mb-4">📝 Nuevos Pedidos</h2>
            <div class="space-y-4">
                <%
                    try (Connection con = Conexion.getConnection()) {
                        String sql = "SELECT p.id, p.direccion, u.nombre as cliente FROM pedidos p JOIN usuarios u ON p.usuario_id = u.id WHERE p.estado = 'Pendiente' ORDER BY p.id ASC";
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()) {
                            int id = rs.getInt("id");
                %>
                    <div class="bg-zinc-900 p-4 rounded-md border-l-4 border-red-500 shadow-lg border-y border-r border-zinc-800 flex flex-col">
                        <div class="flex justify-between mb-3 border-b border-zinc-800 pb-2">
                            <span class="font-black text-red-500">#<%= id %></span>
                            <span class="text-xs text-zinc-400 font-bold uppercase"><%= rs.getString("cliente") %></span>
                        </div>
                        
                        <div class="bg-black p-2 rounded-md mb-3 border border-zinc-800">
                            <p class="text-[11px] text-zinc-400 leading-tight">
                                <span class="text-red-500 font-black tracking-widest uppercase text-[10px]">📍 Dirección:</span><br>
                                <%= rs.getString("direccion") %>
                            </p>
                        </div>

                        <div class="text-sm mb-4 space-y-2 flex-1">
                            <% 
                                PreparedStatement psDet = con.prepareStatement("SELECT producto_nombre, descripcion FROM detalle_pedidos WHERE pedido_id = ?");
                                psDet.setInt(1, id);
                                ResultSet rsDet = psDet.executeQuery();
                                while(rsDet.next()) {
                            %>
                                <div>
                                    <p class="text-white font-bold text-xs">• <%= rsDet.getString("producto_nombre") %></p>
                                    <p class="text-zinc-500 text-[11px] italic ml-3"><%= rsDet.getString("descripcion") %></p>
                                </div>
                            <% } %>
                        </div>
                        <a href="ActualizarEstadoPedidoServlet?id=<%= id %>&estado=Cocinando" class="block text-center bg-red-600 hover:bg-red-700 text-white text-xs font-black tracking-widest py-3 rounded-md transition-colors uppercase mt-auto">
                            Empezar a Cocinar 🔥
                        </a>
                    </div>
                <% } } catch(Exception e) { e.printStackTrace(); } %>
            </div>
        </section>

        <section class="bg-zinc-900/50 p-4 rounded-xl border border-zinc-800 h-full">
            <h2 class="text-yellow-500 font-black uppercase tracking-widest text-sm mb-4">🔥 En el Horno</h2>
            <div class="space-y-4">
                <%
                    try (Connection con = Conexion.getConnection()) {
                        String sql = "SELECT p.id, p.direccion, u.nombre as cliente FROM pedidos p JOIN usuarios u ON p.usuario_id = u.id WHERE p.estado = 'Cocinando' ORDER BY p.id ASC";
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()) {
                            int id = rs.getInt("id");
                %>
                    <div class="bg-zinc-900 p-4 rounded-md border-l-4 border-yellow-500 border-y border-r border-zinc-800 flex flex-col">
                        <div class="flex justify-between mb-3 border-b border-zinc-800 pb-2">
                            <span class="font-black text-yellow-500">#<%= id %></span>
                            <span class="text-xs text-zinc-400 font-bold uppercase"><%= rs.getString("cliente") %></span>
                        </div>

                        <div class="bg-black p-2 rounded-md mb-4 border border-zinc-800 flex-1">
                            <p class="text-[11px] text-zinc-400 leading-tight">
                                <span class="text-yellow-500 font-black tracking-widest uppercase text-[10px]">📍 Dirección:</span><br>
                                <%= rs.getString("direccion") %>
                            </p>
                        </div>

                        <a href="ActualizarEstadoPedidoServlet?id=<%= id %>&estado=En Camino" class="block text-center bg-yellow-600 hover:bg-yellow-700 text-white text-xs font-black tracking-widest py-3 rounded-md uppercase transition-colors mt-auto">
                            Listo para Reparto 🛵
                        </a>
                    </div>
                <% } } catch(Exception e) { e.printStackTrace(); } %>
            </div>
        </section>

        <section class="bg-zinc-900/50 p-4 rounded-xl border border-zinc-800 h-full">
            <h2 class="text-green-500 font-black uppercase tracking-widest text-sm mb-4">🛵 En Reparto</h2>
            <div class="space-y-4">
                <%
                    try (Connection con = Conexion.getConnection()) {
                        String sql = "SELECT p.id, p.direccion, u.nombre as cliente FROM pedidos p JOIN usuarios u ON p.usuario_id = u.id WHERE p.estado = 'En Camino' ORDER BY p.id ASC";
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()) {
                            int id = rs.getInt("id");
                %>
                    <div class="bg-zinc-900 p-4 rounded-md border-l-4 border-green-500 border-y border-r border-zinc-800 flex flex-col">
                        <div class="flex justify-between mb-3 border-b border-zinc-800 pb-2">
                            <span class="font-black text-green-500">#<%= id %></span>
                            <span class="text-xs text-zinc-400 font-bold uppercase"><%= rs.getString("cliente") %></span>
                        </div>

                        <div class="bg-black p-2 rounded-md mb-4 border border-zinc-800 flex-1">
                            <p class="text-[11px] text-zinc-400 leading-tight">
                                <span class="text-green-500 font-black tracking-widest uppercase text-[10px]">📍 Dirección:</span><br>
                                <%= rs.getString("direccion") %>
                            </p>
                        </div>

                        <a href="ActualizarEstadoPedidoServlet?id=<%= id %>&estado=Entregado" class="block text-center bg-green-600 hover:bg-green-700 text-white text-xs font-black tracking-widest py-3 rounded-md uppercase transition-colors mt-auto">
                            Marcar Entregado ✅
                        </a>
                    </div>
                <% } } catch(Exception e) { e.printStackTrace(); } %>
            </div>
        </section>

    </main>
</body>
</html>