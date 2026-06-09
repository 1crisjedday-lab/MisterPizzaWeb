<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    modelos.Usuario usuario = (modelos.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login_cliente.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mister Pizza - Sabor Premium</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
    <!-- Fuentes Modernas -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Outfit', sans-serif;
        }
        /* Efecto de scroll suave */
        html {
            scroll-behavior: smooth;
        }
        /* Ocultar barra de scroll pero mantener funcionalidad */
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        /* Animación sutil de levitación en la imagen Hero */
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(1deg); }
            50% { transform: translateY(-15px) rotate(-1deg); }
        }
        .animate-float {
            animation: float 6s ease-in-out infinite;
        }
        /* Desenfoque de fondo glassmorphism */
        .glass-nav {
            background: rgba(0, 0, 0, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }
        /* Tarjeta premium */
        .premium-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .premium-card:hover {
            transform: translateY(-8px);
            border-color: rgba(239, 68, 68, 0.4);
            box-shadow: 0 15px 30px -10px rgba(239, 68, 68, 0.2);
        }
        .zoom-img {
            transition: transform 0.5s ease;
        }
        .premium-card:hover .zoom-img {
            transform: scale(1.08);
        }
    </style>
</head>
<body class="min-h-screen bg-zinc-950 text-zinc-100 pb-24 overflow-x-hidden">

    <!-- HEADER / BARRA DE NAVEGACIÓN GLASSMORPHIC -->
    <header class="glass-nav border-b border-zinc-900 fixed top-0 left-0 w-full z-50 transition-all duration-300">
        <div class="max-w-7xl mx-auto px-4 md:px-8 h-20 flex justify-between items-center">
            
            <!-- Logo -->
            <a href="#" class="flex items-center gap-2">
                <span class="text-3xl animate-bounce-short">🍕</span>
                <div>
                    <h1 class="text-xl md:text-2xl font-black italic tracking-widest uppercase text-white">
                        Mister <span class="text-red-500">Pizza</span>
                    </h1>
                </div>
            </a>
            
            <!-- Navegación Central -->
            <nav class="hidden md:flex items-center gap-8 text-sm font-bold tracking-wide text-zinc-400">
                <a href="#" class="hover:text-red-500 transition-colors uppercase">Inicio</a>
                <a href="#menu-seccion" class="hover:text-red-500 transition-colors uppercase">Menú</a>
                <a href="personalizar_pizza.jsp" class="hover:text-red-500 transition-colors uppercase flex items-center gap-1.5">
                    <span class="text-xs">✨</span> Personalizar
                </a>
                <a href="seguimiento.jsp" class="hover:text-red-500 transition-colors uppercase flex items-center gap-1">
                    <span>🛵</span> Pedidos
                </a>
            </nav>

            <!-- Menú de Usuario / Cierre de Sesión -->
            <div class="flex items-center gap-4">
                <div class="hidden sm:flex flex-col text-right">
                    <span class="text-xs text-zinc-500 font-bold uppercase tracking-wider">Cliente</span>
                    <span class="text-sm text-white font-extrabold"><%= usuario.getNombre() %></span>
                </div>
                
                <button onclick="toggleCartDrawer(true)" class="relative bg-zinc-900 border border-zinc-800 hover:bg-zinc-800 p-2.5 rounded-full transition-all text-lg flex items-center justify-center">
                    🛒
                    <span id="headerCartCount" class="absolute -top-1.5 -right-1.5 bg-red-600 text-white text-[10px] font-black px-1.5 py-0.5 rounded-full min-w-5 h-5 flex items-center justify-center border border-zinc-950">0</span>
                </button>
                
                <a href="seguimiento.jsp" class="hidden md:flex bg-zinc-900 border border-zinc-800 hover:bg-zinc-800 p-2.5 rounded-full transition-all text-lg">
                    🛵
                </a>

                <a href="LogoutServlet" class="bg-red-600/10 text-red-500 border border-red-500/20 hover:bg-red-600 hover:text-white px-4 py-2 rounded-lg text-xs font-bold transition-all uppercase tracking-widest">
                    Salir
                </a>
            </div>
        </div>
    </header>

    <!-- HERO SECTION (BANNER PRINCIPAL) -->
    <section class="relative pt-32 pb-20 px-4 md:px-8 overflow-hidden bg-radial-gradient">
        <!-- Luces de fondo -->
        <div class="absolute top-[20%] left-[-10%] w-96 h-96 bg-red-600/15 rounded-full blur-[120px] z-0 pointer-events-none"></div>
        <div class="absolute bottom-[10%] right-[-10%] w-96 h-96 bg-orange-600/10 rounded-full blur-[120px] z-0 pointer-events-none"></div>

        <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-12 items-center relative z-10">
            <!-- Texto Hero -->
            <div class="lg:col-span-7 text-center lg:text-left space-y-6">
                <div class="inline-flex items-center gap-2 bg-red-500/10 border border-red-500/20 px-4 py-1.5 rounded-full text-red-500 text-xs font-black uppercase tracking-widest">
                    <span>🔥</span> ¡El verdadero sabor artesanal!
                </div>
                <h1 class="text-4xl sm:text-6xl font-black text-white leading-tight uppercase tracking-tight">
                    Masa Crujiente,<br>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-orange-500">Ingredientes Premium</span>
                </h1>
                <p class="text-zinc-400 text-base sm:text-lg max-w-xl mx-auto lg:mx-0 font-medium leading-relaxed">
                    Disfruta de las pizzas más deliciosas de la ciudad, hechas con ingredientes 100% frescos y horneadas a la perfección. ¡O diseña tu propia combinación!
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start pt-2">
                    <a href="#menu-seccion" class="bg-red-600 hover:bg-red-700 text-white px-8 py-4 rounded-xl font-black uppercase tracking-wider text-sm transition-all shadow-[0_0_25px_rgba(220,38,38,0.45)] hover:scale-[1.03] text-center">
                        Explorar Menú 🍕
                    </a>
                    <a href="personalizar_pizza.jsp" class="bg-zinc-900 border border-zinc-800 hover:bg-zinc-800 text-zinc-300 hover:text-white px-8 py-4 rounded-xl font-black uppercase tracking-wider text-sm transition-all text-center">
                        Armar mi propia Pizza ✨
                    </a>
                </div>
            </div>

            <!-- Imagen Hero -->
            <div class="lg:col-span-5 flex justify-center items-center">
                <div class="relative w-72 sm:w-96 h-72 sm:h-96 animate-float">
                    <div class="absolute inset-0 bg-red-600/20 rounded-full blur-[40px] pointer-events-none"></div>
                    <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=600&q=80" 
                         alt="Pizza Premium" 
                         class="w-full h-full object-cover rounded-full border-4 border-zinc-900 shadow-2xl drop-shadow-[0_20px_20px_rgba(220,38,38,0.3)]" />
                </div>
            </div>
        </div>
    </section>

    <!-- CARACTERÍSTICAS / DETALLES PREMIUM -->
    <section class="py-12 px-4 md:px-8 bg-black/40 border-y border-zinc-900">
        <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 text-center md:text-left">
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">🛵</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Entrega Express</h4>
                    <p class="text-zinc-400 text-sm mt-1">Tu pizza caliente directamente en tu mesa en menos de 30 minutos garantizados.</p>
                </div>
            </div>
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">🍅</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Ingredientes Premium</h4>
                    <p class="text-zinc-400 text-sm mt-1">Utilizamos quesos seleccionados y verduras frescas del huerto día tras día.</p>
                </div>
            </div>
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">👨‍🍳</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Masa Artesanal</h4>
                    <p class="text-zinc-400 text-sm mt-1">Preparada a mano con un proceso de fermentación lenta de 24 horas.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SECCIÓN DEL MENÚ / CATÁLOGO -->
    <section id="menu-seccion" class="py-20 px-4 md:px-8 max-w-7xl mx-auto scroll-mt-24">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-12 gap-6">
            <div>
                <span class="text-red-500 text-xs font-black uppercase tracking-widest block mb-2">Carta de la Casa</span>
                <h2 class="text-3xl md:text-4xl font-black text-white uppercase tracking-tight">Nuestro Menú Especial</h2>
            </div>
            
            <!-- OPCIONES / TABS DE CATEGORÍA (ARRIBA DEL CATÁLOGO) -->
            <div class="bg-zinc-900/50 p-1.5 rounded-xl border border-zinc-800 w-full md:w-auto">
                <ul class="flex overflow-x-auto no-scrollbar text-xs font-bold text-zinc-400 gap-1">
                    <li onclick="filtrarCatalogo('Todos', this)" class="tab-btn px-5 py-3 rounded-lg text-red-500 bg-red-600/10 border border-red-500/20 whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider font-extrabold">
                        🍕 Ver todo
                    </li>
                    <li onclick="filtrarCatalogo('Promociones', this)" class="tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider">
                        🔥 Promociones
                    </li>
                    <li onclick="filtrarCatalogo('Pizzas Clásicas', this)" class="tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider">
                        🧀 Clásicas
                    </li>
                    <li onclick="filtrarCatalogo('Especialidades', this)" class="tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider">
                        ✨ Especiales
                    </li>
                    <li onclick="filtrarCatalogo('Bebidas', this)" class="tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider">
                        🥤 Bebidas
                    </li>
                </ul>
            </div>
        </div>

        <h3 id="titulo-categoria" class="text-zinc-500 font-extrabold text-sm mb-8 uppercase tracking-widest">NUESTRO MENÚ</h3>

        <!-- CONTENEDOR DE PRODUCTOS -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6" id="catalogo-contenedor">
            <!-- Renderizado dinámico por JS -->
        </div>

        <!-- BANNER DE CREAR TU PIZZA -->
        <div class="mt-20 relative p-8 md:p-12 bg-gradient-to-br from-zinc-900 to-black rounded-3xl shadow-2xl border border-zinc-800 text-center max-w-4xl mx-auto overflow-hidden">
            <div class="absolute top-[-50%] left-[-20%] w-96 h-96 bg-red-600/10 rounded-full blur-[100px] pointer-events-none"></div>
            
            <div class="relative z-10 max-w-2xl mx-auto">
                <span class="text-2xl mb-4 inline-block">👨‍🍳🎨</span>
                <h2 class="text-2xl md:text-3xl font-black text-white mb-3 uppercase tracking-tight">¿Deseas algo diferente?</h2>
                <p class="text-zinc-400 mb-8 text-sm md:text-base leading-relaxed">
                    Combina salsa de tomate, extra mozzarella y todos los ingredientes que más te gusten. El límite es tu imaginación.
                </p>
                <a href="personalizar_pizza.jsp" class="inline-block bg-red-600 hover:bg-red-700 text-white px-8 py-4 rounded-xl font-black uppercase tracking-wider text-sm transition-all shadow-[0_0_20px_rgba(220,38,38,0.45)] hover:scale-[1.03]">
                    👉 Personalizar mi pizza ahora
                </a>
            </div>
        </div>
    </section>

    <!-- FOOTER PREMIUM Y MAPA DE GOOGLE -->
    <footer class="bg-black border-t border-zinc-900 pt-16 pb-8 px-4 md:px-8 mt-20 relative z-10">
        <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 text-sm text-zinc-400">
            <!-- Columna 1: Empresa & RUC -->
            <div class="space-y-4">
                <div class="flex items-center gap-2">
                    <span class="text-2xl animate-bounce-short">🍕</span>
                    <span class="font-black text-lg italic tracking-widest uppercase text-white">
                        Mister <span class="text-red-500">Pizza</span>
                    </span>
                </div>
                <p class="leading-relaxed">
                    La mejor pizzería artesanal de la región. Calidad, sabor y rapidez directo a tu mesa en minutos.
                </p>
                <div class="pt-2 text-xs space-y-1 font-semibold">
                    <p class="text-zinc-500">Razón Social: <span class="text-zinc-300">MISTER PIZZA S.A.C.</span></p>
                    <p class="text-zinc-500">RUC: <span class="text-zinc-300">20784918239</span></p>
                </div>
            </div>

            <!-- Columna 2: Enlaces -->
            <div class="space-y-4">
                <h4 class="text-white font-black uppercase tracking-wider text-xs border-l-2 border-red-500 pl-3">Enlaces Rápidos</h4>
                <ul class="space-y-2.5 font-bold">
                    <li><a href="#" class="hover:text-red-500 transition-colors">Inicio</a></li>
                    <li><a href="#menu-seccion" class="hover:text-red-500 transition-colors">Carta / Menú</a></li>
                    <li><a href="personalizar_pizza.jsp" class="hover:text-red-500 transition-colors">Armar Pizza</a></li>
                    <li><a href="seguimiento.jsp" class="hover:text-red-500 transition-colors">Seguimiento</a></li>
                </ul>
            </div>

            <!-- Columna 3: Contacto -->
            <div class="space-y-4">
                <h4 class="text-white font-black uppercase tracking-wider text-xs border-l-2 border-red-500 pl-3">Contacto</h4>
                <ul class="space-y-3">
                    <li class="flex items-start gap-2.5">
                        <span class="text-red-500">📍</span>
                        <span>Av. El Sol 456, Puno, Perú</span>
                    </li>
                    <li class="flex items-start gap-2.5">
                        <span class="text-red-500">📞</span>
                        <span>+51 987 654 321</span>
                    </li>
                    <li class="flex items-start gap-2.5">
                        <span class="text-red-500">⏰</span>
                        <div>
                            <p class="font-bold text-zinc-300">Lun - Dom</p>
                            <p class="text-xs text-zinc-500">11:00 AM - 11:00 PM</p>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Columna 4: Ubicación (Google Maps Embed) -->
            <div class="space-y-4">
                <h4 class="text-white font-black uppercase tracking-wider text-xs border-l-2 border-red-500 pl-3">Nuestra Ubicación</h4>
                <div class="rounded-xl overflow-hidden border border-zinc-800 bg-zinc-950 h-40 shadow-inner group">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3839.8806297316715!2d-70.02998822579178!3d-15.840082724424915!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915d6994cf5e1e9b%3A0x101b088e89547b74!2sPlaza%20Mayor%20de%20Puno!5e0!3m2!1ses!2spe!4v1717960000000!5m2!1ses!2spe" 
                        class="w-full h-full border-0 grayscale invert opacity-75 group-hover:opacity-100 group-hover:grayscale-0 transition-all duration-500" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </div>
        
        <div class="max-w-7xl mx-auto border-t border-zinc-900 mt-12 pt-8 text-center text-xs text-zinc-600 font-bold">
            <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Mister Pizza Web. Todos los derechos reservados.</p>
        </div>
    </footer>

    <!-- BOTÓN FLOTANTE DEL CARRITO -->
    <button id="btnCarrito" onclick="irAlCarrito()" class="hidden fixed bottom-6 left-1/2 -translate-x-1/2 bg-red-600 text-white px-6 md:px-8 py-4 rounded-2xl shadow-[0_0_25px_rgba(220,38,38,0.5)] hover:bg-red-700 transition-all flex items-center gap-3 z-30 w-[90%] md:w-auto justify-center hover:scale-[1.02]">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
        </svg>
        <span class="font-black tracking-wide uppercase text-xs md:text-sm">Ver Pedido (<span id="cantidadTotal">0</span>)</span>
        <span class="bg-black/35 px-3 py-1 rounded-lg font-black text-xs md:text-sm text-red-100 border border-white/5">S/ <span id="precioTotal">0.00</span></span>
    </button>

    <form id="formOcultoCarrito" action="GuardarCarritoServlet" method="POST" style="display: none;">
        <input type="hidden" name="carritoJson" id="inputCarritoJson" />
    </form>

    <!-- SCRIPT DE LÓGICA DE NEGOCIO -->
    <script>
        let carrito = JSON.parse(localStorage.getItem('misterPizzaCarrito')) || [];
        let catalogoPizzas = [];
        let categoriaActual = 'Todos';

        // Carga silenciosa del catálogo
        function cargarPizzasSilenciosamente() {
            fetch('CatalogoServlet?t=' + new Date().getTime())
                .then(response => response.json())
                .then(data => {
                    catalogoPizzas = data;
                    renderizarCatalogo();
                })
                .catch(error => console.error('Error cargando pizzas:', error));
        }

        // Inicialización y polling
        window.onload = function() {
            cargarPizzasSilenciosamente();
            setInterval(cargarPizzasSilenciosamente, 15000);
        };

        // Filtro de categorías
        function filtrarCatalogo(categoria, elementoClickeado) {
            categoriaActual = categoria;
            
            document.getElementById('titulo-categoria').innerText = categoria === 'Todos' ? 'NUESTRO MENÚ' : categoria.toUpperCase();

            // Resetear estilos de todos los botones
            const tabs = document.querySelectorAll('.tab-btn');
            tabs.forEach(tab => {
                tab.className = "tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider text-zinc-400";
            });
            
            // Aplicar estilo activo
            elementoClickeado.className = "tab-btn px-5 py-3 rounded-lg text-red-500 bg-red-600/10 border border-red-500/20 whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider font-extrabold";

            renderizarCatalogo();
        }

        // Renderizado del catálogo
        function renderizarCatalogo() {
            const contenedor = document.getElementById('catalogo-contenedor');
            contenedor.innerHTML = '';

            const pizzasFiltradas = catalogoPizzas.filter(pizza => {
                if (categoriaActual === 'Todos') return true;

                let catAsignada = pizza.categoria; 
                if (!catAsignada || catAsignada === 'null') {
                    const nombre = pizza.nombre.toLowerCase();
                    if (nombre.includes('promo') || nombre.includes('duo') || nombre.includes('combo') || nombre.includes('hut days')) {
                        catAsignada = 'Promociones';
                    } else if (nombre.includes('cola') || nombre.includes('gaseosa') || nombre.includes('agua') || nombre.includes('sprite')) {
                        catAsignada = 'Bebidas';
                    } else if (nombre.includes('hawaiana') || nombre.includes('americana') || nombre.includes('pepperoni') || nombre.includes('mozzarella')) {
                        catAsignada = 'Pizzas Clásicas';
                    } else {
                        catAsignada = 'Especialidades';
                    }
                }
                return catAsignada === categoriaActual;
            });

            if (pizzasFiltradas.length === 0) {
                contenedor.innerHTML = '<div class="col-span-full text-center py-16 text-zinc-500"><div class="text-5xl mb-4">🍽️</div><p class="font-extrabold text-lg">No hay productos en esta categoría por ahora.</p></div>';
                return;
            }

            pizzasFiltradas.forEach(pizza => {
                const item = carrito.find(i => i.id === pizza.id);
                const div = document.createElement('div');
                div.className = "bg-zinc-900/60 backdrop-blur-md rounded-2xl overflow-hidden flex flex-col h-full border border-zinc-800/80 premium-card";

                let botonesHTML = '';
                if (!item) {
                    botonesHTML = '<button onclick="agregarAlCarrito(' + pizza.id + ')" class="w-full bg-red-600 text-white font-extrabold py-3.5 rounded-xl text-xs hover:bg-red-700 transition-colors uppercase tracking-widest shadow-lg">Añadir al Pedido</button>';
                } else {
                    botonesHTML = '<div class="flex items-center justify-between bg-zinc-900 border border-zinc-800 p-1.5 rounded-xl">' +
                                    '<button onclick="cambiarCantidad(' + pizza.id + ', -1)" class="bg-zinc-800 text-zinc-300 rounded-lg w-10 h-10 font-bold flex items-center justify-center hover:bg-zinc-700 hover:text-white transition-colors">-</button>' +
                                    '<span class="font-extrabold text-white text-base">' + item.cantidad + '</span>' +
                                    '<button onclick="cambiarCantidad(' + pizza.id + ', 1)" class="bg-red-600 text-white rounded-lg w-10 h-10 font-bold flex items-center justify-center hover:bg-red-700 transition-colors">+</button>' +
                                  '</div>';
                }
                
                // Formateador de precio
                const precioFormateado = pizza.precio.toFixed(2);
                
                div.innerHTML = 
                    '<div class="relative w-full pt-[70%] bg-zinc-950/40 border-b border-zinc-800/50 overflow-hidden">' +
                        '<img src="' + pizza.imagen_url + '" alt="' + pizza.nombre + '" class="absolute top-0 left-0 w-full h-full object-contain p-4 drop-shadow-[0_8px_16px_rgba(0,0,0,0.5)] zoom-img" />' +
                        '<span class="absolute top-3 right-3 bg-black/60 backdrop-blur-md text-[10px] font-black text-red-400 border border-red-500/20 px-2 py-0.5 rounded-md uppercase tracking-wider">⭐ 4.9</span>' +
                    '</div>' +
                    '<div class="p-5 flex flex-col flex-1">' +
                        '<div class="mb-3">' +
                            '<h3 class="font-extrabold text-white text-lg leading-tight uppercase tracking-wide truncate">' + pizza.nombre + '</h3>' +
                        '</div>' +
                        '<div class="mb-5 flex-1">' +
                            '<p class="text-xs text-zinc-400 line-clamp-2 leading-relaxed font-medium">' + pizza.ingredientes + '</p>' +
                        '</div>' +
                        '<div class="flex items-center justify-between gap-4 mt-auto pt-4 border-t border-zinc-800/30">' +
                            '<div class="flex flex-col">' +
                                '<span class="text-[10px] text-zinc-500 uppercase tracking-widest font-bold">Precio</span>' +
                                '<span class="font-black text-white text-lg">S/ ' + precioFormateado + '</span>' +
                            '</div>' +
                            '<div class="flex-1 max-w-[150px]">' +
                                botonesHTML +
                            '</div>' +
                        '</div>' +
                    '</div>';

                contenedor.appendChild(div);
            });
            actualizarBotonFlotante();
        }

        function guardarCarritoGlobal() {
            localStorage.setItem('misterPizzaCarrito', JSON.stringify(carrito));
        }

        function agregarAlCarrito(id) {
            const pizza = catalogoPizzas.find(p => p.id === id);
            carrito.push({ ...pizza, cantidad: 1 });
            guardarCarritoGlobal();
            renderizarCatalogo();
        }

        function cambiarCantidad(id, cambio) {
            const item = carrito.find(item => item.id === id);
            item.cantidad += cambio;
            if (item.cantidad <= 0) {
                carrito = carrito.filter(item => item.id !== id);
            }
            guardarCarritoGlobal();
            renderizarCatalogo();
        }

        function actualizarBotonFlotante() {
            const btn = document.getElementById('btnCarrito');
            const totalItems = carrito.reduce((sum, item) => sum + item.cantidad, 0);
            const totalPrecio = carrito.reduce((sum, item) => sum + (item.precio * item.cantidad), 0);

            // Actualizar contador del menú superior
            const headerCount = document.getElementById('headerCartCount');
            if (headerCount) {
                headerCount.innerText = totalItems;
            }

            if (totalItems > 0) {
                btn.classList.remove('hidden');
                document.getElementById('cantidadTotal').innerText = totalItems;
                document.getElementById('precioTotal').innerText = totalPrecio.toFixed(2);
            } else {
                btn.classList.add('hidden');
            }
        }

        function irAlCarrito() {
            toggleCartDrawer(true);
        }

        // --- SISTEMA DEL CARRITO DE NAVEGACIÓN SUPERIOR (CART DRAWER) ---
        
        let selectedPaymentMethodValue = 'Yape';

        function toggleCartDrawer(open) {
            const drawer = document.getElementById('cartDrawer');
            const backdrop = document.getElementById('cartDrawerBackdrop');
            if (open) {
                drawer.classList.remove('translate-x-full');
                backdrop.classList.remove('hidden');
                renderDrawerCart();
            } else {
                drawer.classList.add('translate-x-full');
                backdrop.classList.add('hidden');
            }
        }

        function selectPaymentMethod(method) {
            selectedPaymentMethodValue = method;
            const yapeBtn = document.getElementById('btnPayYape');
            const cashBtn = document.getElementById('btnPayCash');
            const yapeForm = document.getElementById('drawerYapeForm');
            
            if (method === 'Yape') {
                yapeBtn.className = "py-3 border border-red-600 bg-red-600/10 text-red-500 rounded-xl text-xs font-black uppercase tracking-wider text-center transition-all";
                cashBtn.className = "py-3 border border-zinc-900 bg-zinc-900/40 text-zinc-500 rounded-xl text-xs font-bold uppercase tracking-wider text-center transition-all";
                yapeForm.classList.remove('hidden');
            } else {
                cashBtn.className = "py-3 border border-red-600 bg-red-600/10 text-red-500 rounded-xl text-xs font-black uppercase tracking-wider text-center transition-all";
                yapeBtn.className = "py-3 border border-zinc-900 bg-zinc-900/40 text-zinc-500 rounded-xl text-xs font-bold uppercase tracking-wider text-center transition-all";
                yapeForm.classList.add('hidden');
            }
        }

        function renderDrawerCart() {
            const container = document.getElementById('drawer-cart-items-container');
            const totalText = document.getElementById('drawerTotalText');
            container.innerHTML = '';
            
            const totalItems = carrito.reduce((sum, item) => sum + item.cantidad, 0);
            const totalPrecio = carrito.reduce((sum, item) => sum + (item.precio * item.cantidad), 0);
            totalText.innerText = totalPrecio.toFixed(2);
            
            if (totalItems === 0) {
                container.innerHTML = 
                    '<div class="flex flex-col items-center justify-center h-64 text-center text-zinc-600">' +
                        '<span class="text-5xl mb-4">🛒</span>' +
                        '<p class="text-sm font-bold uppercase tracking-wider">Tu carrito está vacío</p>' +
                        '<p class="text-xs text-zinc-500 mt-1">Agrega pizzas desde la carta</p>' +
                    '</div>';
                return;
            }
            
            carrito.forEach(item => {
                const itemDiv = document.createElement('div');
                itemDiv.className = "p-4 bg-zinc-900/50 border border-zinc-800/80 rounded-xl flex items-center justify-between gap-4";
                
                itemDiv.innerHTML = 
                    '<div class="flex-1">' +
                        '<h4 class="font-extrabold text-white text-sm uppercase truncate">' + item.nombre + '</h4>' +
                        '<p class="text-[10px] text-zinc-500 line-clamp-1 mt-0.5">' + item.ingredientes + '</p>' +
                        '<span class="text-xs font-extrabold text-red-500 block mt-1.5">S/ ' + (item.precio * item.cantidad).toFixed(2) + '</span>' +
                    '</div>' +
                    '<div class="flex items-center gap-2.5">' +
                        '<button onclick="cambiarCantidadDrawer(' + item.id + ', -1)" class="bg-zinc-800 text-zinc-400 w-7 h-7 rounded-md font-bold flex items-center justify-center hover:bg-zinc-700 transition-colors">-</button>' +
                        '<span class="text-xs font-black text-white w-4 text-center">' + item.cantidad + '</span>' +
                        '<button onclick="cambiarCantidadDrawer(' + item.id + ', 1)" class="bg-red-600 text-white w-7 h-7 rounded-md font-bold flex items-center justify-center hover:bg-red-700 transition-colors">+</button>' +
                    '</div>';
                    
                container.appendChild(itemDiv);
            });
        }

        function cambiarCantidadDrawer(id, cambio) {
            cambiarCantidad(id, cambio);
            renderDrawerCart();
        }

        function procesarPedidoDirecto() {
            const direccion = document.getElementById('drawerDireccion').value.trim();
            if (!direccion) {
                alert("📍 Por favor ingresa una dirección de envío.");
                document.getElementById('drawerDireccion').focus();
                return;
            }

            if (carrito.length === 0) {
                alert("🛒 Agrega al menos un producto al carrito para ordenar.");
                return;
            }

            // Si es Yape, validar datos
            let yapePhoneVal = "969929157";
            let yapeOtpVal = "557454";
            
            if (selectedPaymentMethodValue === 'Yape') {
                const phoneInput = document.getElementById('yapePhone').value.trim();
                const otpInput = document.getElementById('yapeOtp').value.trim();
                
                if (phoneInput.length !== 9 || isNaN(phoneInput)) {
                    alert("📱 Por favor ingresa un número de celular Yape válido (9 dígitos).");
                    document.getElementById('yapePhone').focus();
                    return;
                }
                if (otpInput.length !== 6 || isNaN(otpInput)) {
                    alert("🔑 Por favor ingresa el código de aprobación OTP (6 dígitos).");
                    document.getElementById('yapeOtp').focus();
                    return;
                }
                yapePhoneVal = phoneInput;
                yapeOtpVal = otpInput;
            }

            // Datos dinámicos del usuario
            let nombreCompleto = "<%= usuario.getNombre() %>";
            let partes = nombreCompleto.split(" ");
            let firstName = partes[0] || "Cliente";
            let lastName = partes.slice(1).join(" ") || "Mister Pizza";
            let email = "<%= usuario.getCorreo() %>";
            let userPhone = "<%= usuario.getTelefono() %>" || "999835685";
            if (userPhone === "Sin registro") userPhone = "999835685";

            // Monto total en centavos
            let totalVal = carrito.reduce((sum, item) => sum + (item.precio * item.cantidad), 0);
            let totalCents = Math.round(totalVal * 100).toString();
            let randomOp = Math.floor(1000000 + Math.random() * 9000000).toString();

            // Construir la carga útil JSON (API Yape requerida)
            let yapeRequestJson = {
                "action": "authorize",
                "channel": "ecommerce",
                "merchant_code": "b0deb6f3-e51a-48a7-9268-f1441d46f7bd",
                "merchant_operation_number": randomOp,
                "payment_method": {
                    "method_name": "YAPE",
                    "method_details": {
                        "callback_url": "https://pay-me.com/callback",
                        "phone": {
                            "country_code": "+51",
                            "subscriber": yapePhoneVal
                        },
                        "otp": yapeOtpVal
                    }
                },
                "payment_details": {
                    "amount": totalCents,
                    "currency": "604",
                    "billing": {
                        "first_name": firstName,
                        "last_name": lastName,
                        "email": email,
                        "phone": {
                            "country_code": "+51",
                            "subscriber": userPhone
                        },
                        "location": {
                            "line_1": direccion,
                            "line_2": "",
                            "city": "Puno",
                            "state": "Puno",
                            "country": "Peru"
                        }
                    },
                    "shipping": {
                        "first_name": firstName,
                        "last_name": lastName,
                        "email": email,
                        "phone": {
                            "country_code": "+51",
                            "subscriber": userPhone
                        },
                        "location": {
                            "line_1": direccion,
                            "line_2": "",
                            "city": "Puno",
                            "state": "Puno",
                            "country": "Peru"
                        }
                    },
                    "customer": {
                        "first_name": firstName,
                        "last_name": lastName,
                        "email": email,
                        "phone": {
                            "country_code": "+51",
                            "subscriber": userPhone
                        },
                        "location": {
                            "line_1": direccion,
                            "line_2": "",
                            "city": "Puno",
                            "state": "Puno",
                            "country": "Peru"
                        }
                    },
                    "product_details": carrito.map(item => ({
                        "name": item.nombre,
                        "quantity": item.cantidad.toString(),
                        "price": Math.round(item.precio * 100).toString()
                    }))
                }
            };

            // Mostrar el cargador y volcar el JSON
            const loader = document.getElementById('drawerLoader');
            const pre = document.getElementById('apiPayloadText');
            pre.innerText = JSON.stringify(yapeRequestJson, null, 4);
            loader.classList.remove('hidden');

            // Simular validación remota del API Pay-Me / Yape
            setTimeout(() => {
                // Proceder con guardar el carrito en la sesión por Fetch (AJAX)
                const datosSeguros = carrito.map(item => {
                    return item.nombre + "|" + item.ingredientes + "|" + item.precio + "|" + item.cantidad;
                }).join("||");

                fetch('GuardarCarritoServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                    },
                    body: 'carritoJson=' + encodeURIComponent(datosSeguros)
                })
                .then(res => {
                    // Limpiar el carrito local tras ordenar
                    localStorage.removeItem('misterPizzaCarrito');
                    // Enviar y finalizar pedido en base de datos
                    document.getElementById('directoDireccion').value = direccion;
                    document.getElementById('directoMetodo').value = selectedPaymentMethodValue;
                    document.getElementById('formCheckoutDirecto').submit();
                })
                .catch(err => {
                    alert("Error simulando conexión de red. Inténtalo de nuevo.");
                    loader.classList.add('hidden');
                });
            }, 3500);
        }
    </script>

    <!-- FORMULARIO OCULTO PARA DIRECT CHECKOUT -->
    <form id="formCheckoutDirecto" action="ConfirmarPedidoServlet" method="POST" class="hidden">
        <input type="hidden" name="direccion" id="directoDireccion" />
        <input type="hidden" name="metodo" id="directoMetodo" />
    </form>

    <!-- CART DRAWER OVERLAY -->
    <div id="cartDrawerBackdrop" onclick="toggleCartDrawer(false)" class="hidden fixed inset-0 bg-black/60 z-50 backdrop-blur-sm transition-opacity duration-300"></div>
    <div id="cartDrawer" class="fixed inset-y-0 right-0 z-50 w-full max-w-md bg-zinc-950 border-l border-zinc-900 shadow-2xl translate-x-full transition-transform duration-300 flex flex-col">
        
        <!-- Loader Yape API -->
        <div id="drawerLoader" class="hidden absolute inset-0 bg-black/95 z-50 flex flex-col items-center justify-center p-6 text-center">
            <div class="w-16 h-16 border-4 border-red-600 border-t-transparent rounded-full animate-spin mb-6"></div>
            <h3 class="font-extrabold text-white text-lg mb-2 uppercase tracking-wider">Autorizando Transacción</h3>
            <p class="text-xs text-zinc-500 max-w-xs mb-6">Conectando con la pasarela de pagos Pay-Me & API Yape...</p>
            
            <div class="w-full text-left space-y-3">
                <span class="text-[9px] font-black text-red-500 uppercase tracking-widest block">Petición API Yape (payload):</span>
                <pre id="apiPayloadText" class="bg-zinc-900 border border-zinc-800 text-green-400 p-4 rounded-xl text-[10px] font-mono overflow-auto max-h-56 select-all leading-tight"></pre>
            </div>
        </div>

        <!-- Header -->
        <div class="p-6 border-b border-zinc-900 flex justify-between items-center bg-black">
            <div class="flex items-center gap-2">
                <span class="text-xl">🛒</span>
                <h3 class="font-black text-white uppercase tracking-wider text-base">Mi Pedido</h3>
            </div>
            <button onclick="toggleCartDrawer(false)" class="text-zinc-500 hover:text-white transition-colors text-lg font-bold">✕</button>
        </div>

        <!-- Items List -->
        <div class="flex-1 overflow-y-auto p-6 space-y-4 custom-scrollbar" id="drawer-cart-items-container">
            <!-- Rendered via JS -->
        </div>

        <!-- Footer Drawer -->
        <div class="p-6 border-t border-zinc-900 bg-black space-y-4">
            <!-- Formulario de entrega -->
            <div>
                <label class="block text-[10px] font-black text-zinc-400 uppercase tracking-widest mb-1.5">📍 Dirección de Entrega</label>
                <input type="text" id="drawerDireccion" required class="w-full bg-zinc-950 border border-zinc-900 text-white px-4 py-3 rounded-xl text-xs focus:border-red-600 focus:outline-none transition-colors" placeholder="Ej: Av. El Sol 123, Puno" />
            </div>

            <!-- Método de pago -->
            <div>
                <label class="block text-[10px] font-black text-zinc-400 uppercase tracking-widest mb-1.5">💳 Método de Pago</label>
                <div class="grid grid-cols-2 gap-2">
                    <button type="button" onclick="selectPaymentMethod('Yape')" id="btnPayYape" class="py-3 border border-red-600 bg-red-600/10 text-red-500 rounded-xl text-xs font-black uppercase tracking-wider text-center transition-all">📱 Yape</button>
                    <button type="button" onclick="selectPaymentMethod('Efectivo')" id="btnPayCash" class="py-3 border border-zinc-900 bg-zinc-900/40 text-zinc-500 rounded-xl text-xs font-bold uppercase tracking-wider text-center transition-all">💵 Efectivo</button>
                </div>
            </div>

            <!-- Formulario Yape -->
            <div id="drawerYapeForm" class="bg-zinc-950 border border-zinc-900 p-4 rounded-xl space-y-3">
                <div class="flex items-center justify-between border-b border-zinc-900 pb-2">
                    <span class="text-[10px] font-black text-zinc-400 uppercase tracking-wider">Credenciales de Pago</span>
                    <span class="text-[9px] bg-[#742384] text-white px-2 py-0.5 rounded font-black tracking-widest">YAPE</span>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <div>
                       <label class="block text-[8px] text-zinc-500 font-bold uppercase tracking-wider mb-1">Celular Yape</label>
                       <input type="tel" id="yapePhone" maxlength="9" placeholder="969929157" class="w-full bg-zinc-900 border border-zinc-800 text-white px-3 py-2 rounded-lg text-xs focus:border-red-600 focus:outline-none transition-colors font-mono" />
                    </div>
                    <div>
                       <label class="block text-[8px] text-zinc-500 font-bold uppercase tracking-wider mb-1">Código OTP (Yape)</label>
                       <input type="text" id="yapeOtp" maxlength="6" placeholder="557454" class="w-full bg-zinc-900 border border-zinc-800 text-white px-3 py-2 rounded-lg text-xs focus:border-red-600 focus:outline-none transition-colors font-mono" />
                    </div>
                </div>
                <p class="text-[9px] text-zinc-500 leading-tight">Ingresa el celular asociado a tu cuenta Yape y el código OTP de 6 dígitos que figura en la aplicación.</p>
            </div>

            <!-- Resumen de total y botón de pago -->
            <div class="pt-2 border-t border-zinc-900 flex justify-between items-center">
                <div>
                    <span class="text-[9px] text-zinc-500 uppercase font-bold tracking-widest block">Total Pedido</span>
                    <span class="text-2xl font-black text-white">S/ <span id="drawerTotalText">0.00</span></span>
                </div>
                <button id="btnProcesarOrden" onclick="procesarPedidoDirecto()" class="bg-red-600 hover:bg-red-700 text-white px-6 py-3.5 rounded-xl font-black uppercase tracking-widest text-xs shadow-lg transition-transform hover:scale-[1.02] active:scale-[0.98]">
                    Confirmar Pedido 🚀
                </button>
            </div>
        </div>
    </div>
</body>
</html>