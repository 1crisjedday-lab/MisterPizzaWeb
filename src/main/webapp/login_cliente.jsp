<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Iniciar Sesión - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 min-h-screen flex flex-col items-center justify-center p-4 relative overflow-hidden">
    
    <div class="absolute top-[-10%] left-[-10%] w-96 h-96 bg-red-600/20 rounded-full blur-[100px] z-0"></div>
    <div class="absolute bottom-[-10%] right-[-10%] w-96 h-96 bg-red-900/20 rounded-full blur-[100px] z-0"></div>

    <div class="w-full max-w-md z-10">
        <div class="text-center mb-8">
            <div class="text-6xl mb-4">🍕</div>
            <h1 class="text-4xl font-black text-white italic tracking-wider uppercase">Mister Pizza</h1>
            <p class="text-zinc-400 mt-2 font-medium">Inicia sesión para hacer tu pedido</p>
        </div>

        <div class="bg-zinc-900/80 backdrop-blur-md p-8 rounded-2xl shadow-2xl border border-zinc-800">
            
            <% 
                String error = request.getParameter("error");
                if (error != null) { 
                    String msg = "Ocurrió un error en el sistema.";
                    if ("credenciales".equals(error)) {
                        msg = "Correo o contraseña incorrectos. Por favor, intente de nuevo.";
                    } else if ("bd".equals(error)) {
                        msg = "Error de conexión con la base de datos.";
                    }
            %>
                <div class="bg-red-500/10 border border-red-500/50 text-red-500 p-3 rounded-md text-sm font-bold text-center mb-6">
                    <%= msg %>
                </div>
            <% } %>

            <form action="LoginClienteServlet" method="POST" class="space-y-6">
                
                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2" for="email">Correo Electrónico</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                        
                        <input type="email" id="email" name="email" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="ejemplo@correo.com" />
                    </div>
                </div>

                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2" for="password">Contraseña</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                        
                        <input type="password" id="password" name="password" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="••••••••" />
                    </div>
                </div>

                <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-3 px-4 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.4)] transition-all">
                    Iniciar Sesión
                </button>
            </form>
            
            <div class="mt-6 text-center">
                <p class="text-zinc-400 text-sm">¿No tienes cuenta? 
                    <a href="registro_cliente.jsp" class="text-red-500 font-bold hover:text-red-400 transition-colors ml-1">Regístrate aquí</a>
                </p>
            </div>
        </div>

        <a href="index.jsp" class="block text-center w-full mt-6 text-zinc-500 hover:text-white font-bold transition-colors text-sm">
            &larr; Volver a selección
        </a>
    </div>
</body>
</html>