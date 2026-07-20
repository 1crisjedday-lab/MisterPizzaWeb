<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Personal - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-zinc-950 min-h-screen flex flex-col items-center justify-center p-4 relative overflow-hidden">
    
    <div class="absolute top-[-10%] left-[-10%] w-96 h-96 bg-red-600/20 rounded-full blur-[100px] z-0"></div>
    <div class="absolute bottom-[-10%] right-[-10%] w-96 h-96 bg-red-900/20 rounded-full blur-[100px] z-0"></div>

    <div class="w-full max-w-md z-10">
        <div class="text-center mb-8">
            <div class="text-6xl mb-4">👨‍🍳</div>
            <h1 class="text-4xl font-black text-white italic tracking-wider uppercase">Mister Pizza</h1>
            <p class="text-zinc-400 mt-2 font-medium">Acceso exclusivo para el personal</p>
        </div>

        <div class="bg-zinc-900/80 backdrop-blur-md p-8 rounded-2xl shadow-2xl border border-zinc-800">
            
            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) { 
            %>
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error de Acceso',
                            text: '<%= error %>',
                            confirmButtonColor: '#dc2626',
                            background: '#18181b',
                            color: '#fff'
                        });
                    });
                </script>
            <% } %>

            <form action="LoginCocinero" method="POST" class="space-y-6">
                
                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2" for="correo">Correo Electrónico</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                        
                        <input type="email" id="correo" name="correo" required maxlength="100" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="admin@misterpizza.com" />
                    </div>
                </div>

                <div>
                    <label class="block text-zinc-400 text-xs font-bold uppercase tracking-widest mb-2" for="clave">Contraseña</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                        
                        <input type="password" id="clave" name="clave" required minlength="4" maxlength="50"
                               class="w-full bg-zinc-950 border border-zinc-800 text-white pl-10 pr-4 py-3 rounded-md focus:outline-none focus:border-red-600 focus:ring-1 focus:ring-red-600 transition-colors placeholder-zinc-700" 
                               placeholder="••••••••" />
                    </div>
                </div>

                <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-3 px-4 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.4)] transition-all">
                    Acceder al Sistema
                </button>
            </form>
        </div>

        <a href="index.jsp" class="block text-center w-full mt-6 text-zinc-500 hover:text-white font-bold transition-colors text-sm">
            &larr; Volver al Inicio
        </a>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(event) {
            if (!this.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                
                let errorMessage = "Por favor, completa correctamente todos los campos obligatorios.";
                const invalidInput = this.querySelector(':invalid');
                if (invalidInput) {
                    const label = this.querySelector(`label[for="${invalidInput.id}"]`) || invalidInput.closest('div').querySelector('label');
                    const labelText = label ? label.textContent.replace(':', '').trim() : invalidInput.name;
                    
                    if (invalidInput.validity.valueMissing) {
                        errorMessage = `El campo "${labelText}" es obligatorio y no puede estar vacío.`;
                    } else if (invalidInput.validity.typeMismatch || invalidInput.validity.patternMismatch) {
                        errorMessage = `El formato del campo "${labelText}" no es válido.`;
                    } else if (invalidInput.validity.tooShort) {
                        errorMessage = `La contraseña es demasiado corta (mínimo ${invalidInput.minLength} caracteres).`;
                    } else if (invalidInput.validity.tooLong) {
                        errorMessage = `El campo "${labelText}" supera la longitud permitida.`;
                    }
                }
                
                Swal.fire({
                    icon: 'warning',
                    title: 'Formulario Incompleto',
                    text: errorMessage,
                    confirmButtonColor: '#dc2626',
                    background: '#18181b',
                    color: '#fff'
                });
                return false;
            }
        });
    </script>
</body>
</html>