<%@page import="modelos.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Control de Acceso: Solo Administradores (rol_id = 3)
    Usuario admin = (Usuario) session.getAttribute("usuarioLogueado");
    if (admin == null || admin.getRolId() != 3) {
        response.sendRedirect("login_personal.jsp?error=no_autorizado");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Gestión de Usuarios Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col md:flex-row">

    <!-- BARRA LATERAL (ASIDE) -->
    <aside class="w-full md:w-64 bg-black text-white flex flex-col justify-between p-4 md:min-h-screen border-b md:border-r border-zinc-800 shadow-2xl md:sticky md:top-0">
        <div>
            <div class="flex items-center gap-2 mb-8 px-2 mt-2">
                <span class="text-2xl">🍕</span>
                <span class="font-black text-xl tracking-wider uppercase">Admin Panel</span>
            </div>
            <nav class="space-y-2 flex flex-row md:flex-col overflow-x-auto md:overflow-visible pb-2 md:pb-0">
                <a href="AdminDashboardServlet" class="flex items-center gap-3 px-4 py-3 text-zinc-400 hover:bg-zinc-900 hover:text-white rounded-md font-medium transition-colors whitespace-nowrap">
                    📊 Dashboard Ventas
                </a>
                <a href="admin_productos.jsp" class="flex items-center gap-3 px-4 py-3 text-zinc-400 hover:bg-zinc-900 hover:text-white rounded-md font-medium transition-colors whitespace-nowrap">
                    📦 Gestionar Catálogo
                </a>
                <a href="GestionUsuariosServlet" class="flex items-center gap-3 px-4 py-3 bg-red-600 text-white rounded-md font-bold transition-colors shadow-[0_0_10px_rgba(220,38,38,0.3)] whitespace-nowrap">
                    👥 Gestionar Usuarios
                </a>
                <a href="cocina_kanban.jsp" class="flex items-center gap-3 px-4 py-3 text-zinc-400 hover:bg-zinc-900 hover:text-white rounded-md font-medium transition-colors whitespace-nowrap">
                    👨‍🍳 Panel de Cocina
                </a>
            </nav>
        </div>
        <div class="mt-4 md:mt-0">
            <a href="LogoutServlet" class="flex items-center justify-center w-full py-3 bg-zinc-900 hover:bg-zinc-800 border border-zinc-800 rounded-md text-sm text-zinc-400 hover:text-white transition-colors font-bold uppercase tracking-widest">
                Cerrar Sesión
            </a>
        </div>
    </aside>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="flex-1 p-6 md:p-8 overflow-x-hidden">
        <header class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 border-b border-zinc-800 pb-6 gap-4">
            <div>
                <h1 class="text-3xl font-black text-white uppercase tracking-wide">Gestión de Usuarios</h1>
                <p class="text-zinc-400 text-sm mt-1">Monitorea y administra el acceso de clientes, cocineros y administradores.</p>
            </div>
            <div class="bg-zinc-900 px-4 py-2 rounded-md shadow-sm text-sm font-bold text-zinc-300 border border-zinc-800 flex items-center gap-2">
                👤 Administrador: <span class="text-red-500 font-extrabold"><%= admin.getNombre() %></span>
            </div>
        </header>

        <!-- MENSAJES DE ESTADO (ALERTAS) -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if ("eliminado".equals(success)) {
        %>
            <div class="bg-green-500/10 border border-green-500/30 text-green-400 p-4 rounded-lg mb-6 text-sm font-semibold flex items-center gap-2 animate-pulse">
                <span>✅</span> Usuario eliminado exitosamente de la base de datos. Los pedidos relacionados fueron desvinculados correctamente.
            </div>
        <% } %>
        <% if ("autoeliminar".equals(error)) { %>
            <div class="bg-red-500/10 border border-red-500/30 text-red-400 p-4 rounded-lg mb-6 text-sm font-semibold flex items-center gap-2">
                <span>⚠️</span> Error: No puedes eliminar tu propia cuenta de administrador mientras estás en sesión.
            </div>
        <% } else if ("eliminar".equals(error)) { %>
            <div class="bg-red-500/10 border border-red-500/30 text-red-400 p-4 rounded-lg mb-6 text-sm font-semibold flex items-center gap-2">
                <span>❌</span> Error al intentar eliminar el usuario. Inténtalo de nuevo o verifica los registros del servidor.
            </div>
        <% } %>

        <!-- TABLA DE USUARIOS -->
        <div class="bg-zinc-900 rounded-xl shadow-lg border border-zinc-800 overflow-x-auto custom-scrollbar">
            <table class="w-full text-left border-collapse min-w-[800px]">
                <thead>
                    <tr class="bg-black border-b-2 border-zinc-800 text-zinc-400 text-xs uppercase tracking-widest">
                        <th class="p-4 font-bold">ID</th>
                        <th class="p-4 font-bold">Nombre</th>
                        <th class="p-4 font-bold">Correo Electrónico</th>
                        <th class="p-4 font-bold">Teléfono</th>
                        <th class="p-4 font-bold">Rol</th>
                        <th class="p-4 font-bold">Fecha de Registro</th>
                        <th class="p-4 font-bold text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-zinc-800 text-sm text-zinc-300">
                    <%
                        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuariosList");
                        if (usuarios != null && !usuarios.isEmpty()) {
                            for (Usuario u : usuarios) {
                                String rolBadge = "";
                                if (u.getRolId() == 3) {
                                    rolBadge = "<span class='bg-red-500/10 text-red-400 text-xs px-2.5 py-1 rounded-full font-black border border-red-500/30 tracking-wider'>ADMIN</span>";
                                } else if (u.getRolId() == 2) {
                                    rolBadge = "<span class='bg-yellow-500/10 text-yellow-400 text-xs px-2.5 py-1 rounded-full font-black border border-yellow-500/30 tracking-wider'>COCINERO</span>";
                                } else {
                                    rolBadge = "<span class='bg-zinc-800 text-zinc-400 text-xs px-2.5 py-1 rounded-full font-bold border border-zinc-700/50 tracking-wider'>CLIENTE</span>";
                                }
                                
                                String tel = (u.getTelefono() != null && !u.getTelefono().trim().isEmpty()) ? u.getTelefono() : "Sin registro";
                                String fechaStr = u.getFechaRegistro() != null 
                                    ? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(u.getFechaRegistro()) 
                                    : "No disponible";
                    %>
                        <tr class="hover:bg-zinc-800/40 transition-colors">
                            <td class="p-4 font-mono text-zinc-500 font-bold">#<%= u.getId() %></td>
                            <td class="p-4 font-bold text-white"><%= u.getNombre() %></td>
                            <td class="p-4">
                                <a href="mailto:<%= u.getCorreo() %>" class="text-zinc-400 hover:text-red-400 transition-colors underline decoration-zinc-700">
                                    <%= u.getCorreo() %>
                                </a>
                            </td>
                            <td class="p-4 text-zinc-400 font-mono"><%= tel %></td>
                            <td class="p-4"><%= rolBadge %></td>
                            <td class="p-4 text-xs text-zinc-500"><%= fechaStr %></td>
                            <td class="p-4 text-center">
                                <% if (u.getId() != admin.getId()) { %>
                                    <button onclick="confirmarEliminar(<%= u.getId() %>, '<%= u.getNombre().replace("'", "\\'") %>')" 
                                            class="bg-red-950/30 hover:bg-red-600 text-red-500 hover:text-white px-3 py-2 rounded-md transition-all font-bold text-xs uppercase tracking-widest border border-red-900/50 hover:shadow-[0_0_15px_rgba(220,38,38,0.4)]">
                                        🗑️ Eliminar
                                    </button>
                                <% } else { %>
                                    <span class="text-xs text-zinc-600 italic">Sesión activa</span>
                                <% } %>
                            </td>
                        </tr>
                    <% 
                            }
                        } else { 
                    %>
                        <tr>
                            <td colspan="7" class="p-8 text-center text-zinc-500 font-medium">
                                No se encontraron usuarios registrados en el sistema.
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>

    <!-- FORMULARIO OCULTO PARA ELIMINACIÓN SEGURA -->
    <form id="formEliminar" action="GestionUsuariosServlet" method="POST" class="hidden">
        <input type="hidden" id="inputEliminarId" name="id_usuario" value="" />
    </form>

    <!-- SCRIPT DE CONFIRMACIÓN -->
    <script>
        function confirmarEliminar(id, nombre) {
            if (confirm("⚠️ ¿Estás seguro de eliminar a este usuario (" + nombre + ")? \n\nEsta acción desvinculará sus pedidos para conservar el historial de ventas y borrará permanentemente sus datos de acceso. Esta acción no se puede deshacer.")) {
                document.getElementById('inputEliminarId').value = id;
                document.getElementById('formEliminar').submit();
            }
        }
    </script>
</body>
</html>
