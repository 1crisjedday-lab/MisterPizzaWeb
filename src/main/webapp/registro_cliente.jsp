<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registro - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 min-h-screen flex flex-col items-center justify-center p-4 relative overflow-hidden">
    
    <div class="absolute top-[-10%] left-[-10%] w-96 h-96 bg-red-600/20 rounded-full blur-[100px] z-0"></div>
    <div class="absolute bottom-[-10%] right-[-10%] w-96 h-96 bg-red-900/20 rounded-full blur-[100px] z-0"></div>

    <div class="w-full max-w-md z-10 my-8">
        <div class="text-center mb-8">
            <div class="text-6xl mb-4">🍕</div>
            <h1 class="text-4xl font-black text-white italic tracking-wider uppercase">Mister Pizza</h1>
            <p class="text-zinc-400 mt-2 font-medium">Crea tu cuenta para hacer pedidos</p>
        </div>

        <div class="bg-zinc-900/80 backdrop-blur-md p-8 rounded-2xl shadow-2xl border border-zinc-800">
            <form action="RegistroServlet" method="POST" class="space-y-5">
                
                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2">Nombre Completo</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                        <input type="text" name="nombre" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="Ej: Juan Pérez" />
                    </div>
                </div>

                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2">Correo Electrónico</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                        <input type="email" name="email" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="ejemplo@correo.com" />
                    </div>
                </div>

                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2">DNI</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2"></path></svg>
                        <input type="text" name="dni" maxlength="8" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="12345678" />
                    </div>
                </div>

                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2">Contraseña</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                        <input type="password" name="password" required 
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="••••••••" />
                    </div>
                </div>

                <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-3 px-4 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.4)] transition-all mt-2">
                    Registrarse
                </button>
            </form>
            
            <div class="mt-6 text-center">
                <p class="text-zinc-400 text-sm">¿Ya tienes cuenta? 
                    <a href="login_cliente.jsp" class="text-red-500 font-bold hover:text-red-400 transition-colors ml-1">Inicia sesión</a>
                </p>
            </div>
        </div>

        <a href="index.jsp" class="block text-center w-full mt-6 text-zinc-500 hover:text-white font-bold transition-colors text-sm">
            &larr; Volver al Inicio
        </a>
    </div>
</body>
</html>