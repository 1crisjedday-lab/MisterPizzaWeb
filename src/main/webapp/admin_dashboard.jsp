<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Dashboard Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
    <script>
        // Recarga la página automáticamente cada 15 segundos para buscar nuevas ventas
        setInterval(function(){
            window.location.reload();
        }, 15000);
    </script>
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex">

    <aside class="w-64 bg-black text-white flex flex-col justify-between p-4 min-h-screen sticky top-0 border-r border-zinc-800 shadow-2xl custom-scrollbar overflow-y-auto">
        <div>
            <div class="flex items-center gap-2 mb-8 px-2 mt-4">
                <span class="text-3xl">🍕</span>
                <span class="font-black text-xl tracking-wider uppercase">Mister Pizza</span>
            </div>
            <nav class="space-y-2">
                <a href="AdminDashboardServlet" class="flex items-center gap-3 px-4 py-3 bg-red-600 text-white rounded-md font-bold transition-colors shadow-[0_0_10px_rgba(220,38,38,0.3)]">
                    📊 Dashboard Ventas
                </a>
                <a href="admin_productos.jsp" class="flex items-center gap-3 px-4 py-3 text-zinc-400 hover:bg-zinc-900 hover:text-white rounded-md font-medium transition-colors">
                    📦 Gestionar Menú
                </a>
            </nav>
        </div>
        <div class="mt-4">
            <a href="LogoutServlet" class="flex items-center justify-center w-full py-3 bg-zinc-900 hover:bg-zinc-800 border border-zinc-800 rounded-md text-sm text-zinc-400 hover:text-white transition-colors font-bold uppercase tracking-widest">
                Cerrar Sesión
            </a>
        </div>
    </aside>

    <main class="flex-1 p-8">
        <header class="flex justify-between items-center mb-8 border-b border-zinc-800 pb-6">
            <div>
                <h1 class="text-3xl font-black text-white uppercase tracking-wide">Panel de Control</h1>
                <p class="text-zinc-400 text-sm mt-1">Resumen estadístico del rendimiento del negocio.</p>
            </div>
            <div class="bg-zinc-900 px-4 py-2 rounded-md shadow-sm text-sm font-bold text-zinc-300 border border-zinc-800 flex items-center gap-2">
                📅 Periodo: <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>
            </div>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-zinc-900 p-6 rounded-xl shadow-lg border border-zinc-800 flex flex-col justify-between hover:border-red-600 transition-colors">
                <p class="text-xs font-bold text-zinc-500 uppercase tracking-widest">Ventas de Hoy</p>
                <h3 class="text-3xl font-black text-white my-3">S/ ${not empty gananciaHoy ? gananciaHoy : "0.00"}</h3>
                <span class="text-xs text-red-500 font-bold bg-red-500/10 inline-block px-2 py-1 rounded w-fit">
                    ✨ ${not empty totalPedidosDia ? totalPedidosDia : 0} pedidos procesados
                </span>
            </div>

            <div class="bg-zinc-900 p-6 rounded-xl shadow-lg border border-zinc-800 flex flex-col justify-between hover:border-red-600 transition-colors">
                <p class="text-xs font-bold text-zinc-500 uppercase tracking-widest">Balance Mensual</p>
                <h3 class="text-3xl font-black text-white my-3">S/ ${not empty gananciaMes ? gananciaMes : "0.00"}</h3>
                <span class="text-xs text-zinc-400 font-medium">Acumulado del mes en curso</span>
            </div>

            <div class="bg-zinc-900 p-6 rounded-xl shadow-lg border border-zinc-800 flex flex-col justify-between hover:border-red-600 transition-colors">
                <p class="text-xs font-bold text-zinc-500 uppercase tracking-widest">Rendimiento Anual</p>
                <h3 class="text-3xl font-black text-white my-3">S/ ${not empty gananciaAnio ? gananciaAnio : "0.00"}</h3>
                <span class="text-xs text-zinc-400 font-medium">Meta global anual</span>
            </div>
        </div>

        <div class="bg-zinc-900 rounded-xl shadow-lg border border-zinc-800 p-6">
            <h2 class="text-lg font-black text-white mb-2 uppercase tracking-wide">Análisis de Operaciones</h2>
            <p class="text-sm text-zinc-400">Las métricas mostradas se actualizan en tiempo real basándose en los estados de cierre de órdenes procesadas en el panel de cocina.</p>
        </div>
    </main>
</body>
</html>