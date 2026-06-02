<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mister Pizza - Inicio</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col relative overflow-hidden">
    
    <div class="absolute top-[-15%] left-[-10%] w-[500px] h-[500px] bg-red-600/10 rounded-full blur-[120px] z-0 pointer-events-none"></div>
    <div class="absolute bottom-[-15%] right-[-10%] w-[500px] h-[500px] bg-red-900/10 rounded-full blur-[120px] z-0 pointer-events-none"></div>

    <header class="bg-black text-white p-4 md:p-6 shadow-2xl relative z-10 border-b-4 border-red-600 flex justify-between items-center">
        <div class="flex items-center gap-3">
            <span class="text-3xl md:text-4xl">🍕</span>
            <span class="font-black text-xl md:text-2xl italic tracking-wider uppercase">Mister Pizza</span>
        </div>
        <div class="flex gap-4 items-center">
            <a href="login_personal.jsp" class="hidden md:block text-xs font-bold text-zinc-500 hover:text-zinc-300 transition-colors uppercase tracking-widest">
                Acceso Personal
            </a>
            <a href="login_cliente.jsp" class="bg-red-600 hover:bg-red-700 text-white px-5 py-2.5 rounded-md font-black text-sm transition-colors shadow-[0_0_10px_rgba(220,38,38,0.4)] uppercase tracking-wider">
                Iniciar Sesión
            </a>
        </div>
    </header>

    <main class="flex-1 flex flex-col items-center justify-center text-center px-4 relative z-10 my-12 md:my-0">
        <h1 class="text-5xl md:text-7xl font-black text-white mb-6 tracking-tight uppercase leading-tight">
            Tu pizza favorita,<br>
            <span class="text-red-600 italic drop-shadow-[0_0_15px_rgba(220,38,38,0.3)]">lista en minutos.</span>
        </h1>
        
        <p class="text-zinc-400 max-w-2xl text-lg md:text-xl mb-12 font-medium">
            Ingresa a nuestro catálogo, elige tus ingredientes frescos y nosotros nos encargamos del resto. ¡El verdadero sabor italiano directo a tu mesa!
        </p>
        
        <div class="flex flex-col sm:flex-row gap-4 w-full sm:w-auto">
            <a href="login_cliente.jsp" class="bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-4 px-10 rounded-md shadow-[0_0_20px_rgba(220,38,38,0.4)] transition-transform transform hover:-translate-y-1">
                Hacer un Pedido Ahora
            </a>
            <a href="registro_cliente.jsp" class="bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 text-white font-bold uppercase tracking-widest py-4 px-10 rounded-md transition-colors">
                Crear Cuenta
            </a>
        </div>
        
        <div class="mt-12 md:hidden">
            <a href="login_personal.jsp" class="text-xs font-bold text-zinc-600 hover:text-zinc-400 transition-colors uppercase tracking-widest border-b border-zinc-800 pb-1">
                Acceso para Empleados
            </a>
        </div>
    </main>

</body>
</html>