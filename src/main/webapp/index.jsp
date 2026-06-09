<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mister Pizza - Sabor Artesanal y Caliente</title>
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
        html {
            scroll-behavior: smooth;
        }
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(1deg); }
            50% { transform: translateY(-12px) rotate(-1deg); }
        }
        .animate-float {
            animation: float 6s ease-in-out infinite;
        }
        .glass-nav {
            background: rgba(0, 0, 0, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }
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

    <!-- HEADER DE INICIO DE SESIÓN / REGISTRO PÚBLICO -->
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
            
            <!-- Enlaces centrales -->
            <nav class="hidden md:flex items-center gap-8 text-sm font-bold tracking-wide text-zinc-400">
                <a href="#" class="hover:text-red-500 transition-colors uppercase">Inicio</a>
                <a href="#menu-publico" class="hover:text-red-500 transition-colors uppercase">Carta / Menú</a>
                <a href="login_cliente.jsp" class="hover:text-red-500 transition-colors uppercase flex items-center gap-1.5">
                    <span class="text-xs">✨</span> Personalizar
                </a>
                <a href="login_personal.jsp" class="hover:text-red-500 transition-colors uppercase">
                    Personal
                </a>
            </nav>

            <!-- Acciones -->
            <div class="flex items-center gap-3">
                <a href="login_cliente.jsp" class="text-xs font-bold text-zinc-400 hover:text-white transition-colors uppercase tracking-widest px-3 py-2 hidden sm:inline-block">
                    Inicia Sesión
                </a>
                <a href="registro_cliente.jsp" class="bg-red-600 hover:bg-red-700 text-white px-5 py-2.5 rounded-lg text-xs font-black transition-all uppercase tracking-widest shadow-[0_0_15px_rgba(220,38,38,0.3)]">
                    Crea tu Cuenta
                </a>
            </div>
        </div>
    </header>

    <!-- BANNER HERO -->
    <section class="relative pt-32 pb-20 px-4 md:px-8 overflow-hidden">
        <div class="absolute top-[20%] left-[-10%] w-96 h-96 bg-red-600/15 rounded-full blur-[120px] z-0 pointer-events-none"></div>
        <div class="absolute bottom-[10%] right-[-10%] w-96 h-96 bg-orange-600/10 rounded-full blur-[120px] z-0 pointer-events-none"></div>

        <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-12 items-center relative z-10">
            <!-- Textos -->
            <div class="lg:col-span-7 text-center lg:text-left space-y-6">
                <div class="inline-flex items-center gap-2 bg-red-500/10 border border-red-500/20 px-4 py-1.5 rounded-full text-red-500 text-xs font-black uppercase tracking-widest">
                    <span>🍕</span> ¡Pizzas artesanales de verdad!
                </div>
                <h1 class="text-4xl sm:text-6xl font-black text-white leading-tight uppercase tracking-tight">
                    Tu Pizza Favorita,<br>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-red-600 to-orange-500 italic drop-shadow-[0_0_15px_rgba(220,38,38,0.3)]">Lista en Minutos.</span>
                </h1>
                <p class="text-zinc-400 text-base sm:text-lg max-w-xl mx-auto lg:mx-0 font-medium leading-relaxed">
                    Navega por nuestra carta, selecciona los productos que más se te antojen y ordénalos al instante. ¡El verdadero sabor italiano directo a tu mesa!
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start pt-2">
                    <a href="#menu-publico" class="bg-red-600 hover:bg-red-700 text-white px-8 py-4 rounded-xl font-black uppercase tracking-wider text-sm transition-all shadow-[0_0_25px_rgba(220,38,38,0.4)] hover:scale-[1.03] text-center">
                        Ver Catálogo en Vivo 🍽️
                    </a>
                    <a href="registro_cliente.jsp" class="bg-zinc-900 border border-zinc-800 hover:bg-zinc-800 text-zinc-300 hover:text-white px-8 py-4 rounded-xl font-black uppercase tracking-wider text-sm transition-all text-center">
                        Crear Cuenta Ahora
                    </a>
                </div>
            </div>

            <!-- Imagen -->
            <div class="lg:col-span-5 flex justify-center items-center">
                <div class="relative w-72 sm:w-96 h-72 sm:h-96 animate-float">
                    <div class="absolute inset-0 bg-red-600/20 rounded-full blur-[40px] pointer-events-none"></div>
                    <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=600&q=80" 
                         alt="Pizza Especial" 
                         class="w-full h-full object-cover rounded-full border-4 border-zinc-900 shadow-2xl" />
                </div>
            </div>
        </div>
    </section>

    <!-- CARACTERÍSTICAS -->
    <section class="py-12 px-4 md:px-8 bg-black/40 border-y border-zinc-900">
        <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 text-center md:text-left">
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">🛵</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Reparto Caliente</h4>
                    <p class="text-zinc-400 text-sm mt-1">Nuestros repartidores llevan tu pedido en bolsas térmicas de alta tecnología.</p>
                </div>
            </div>
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">🌿</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Ingredientes Orgánicos</h4>
                    <p class="text-zinc-400 text-sm mt-1">Albahaca fresca, salsa natural y quesos de origen local certificado.</p>
                </div>
            </div>
            <div class="flex flex-col md:flex-row items-center md:items-start gap-4 p-4">
                <span class="text-4xl text-red-500 bg-red-500/10 p-3.5 rounded-xl border border-red-500/10">🔥</span>
                <div>
                    <h4 class="font-extrabold text-white text-lg uppercase tracking-wider">Horno de Piedra</h4>
                    <p class="text-zinc-400 text-sm mt-1">Horneado tradicional sobre base refractaria para ese borde inflado y ahumado.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- MENÚ PÚBLICO -->
    <section id="menu-publico" class="py-20 px-4 md:px-8 max-w-7xl mx-auto scroll-mt-24">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-12 gap-6">
            <div>
                <span class="text-red-500 text-xs font-black uppercase tracking-widest block mb-2">Conoce nuestra propuesta</span>
                <h2 class="text-3xl md:text-4xl font-black text-white uppercase tracking-tight">Catálogo de Productos</h2>
            </div>
            
            <!-- Filtro de Categorías -->
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

        <!-- Grilla de productos -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6" id="catalogo-contenedor">
            <!-- Renderizado dinámico -->
        </div>
    </section>

    <!-- BANNER PIZZA PERSONALIZADA -->
    <section class="pb-20 px-4 md:px-8 max-w-7xl mx-auto">
        <div class="relative p-8 md:p-12 bg-gradient-to-br from-zinc-900 to-black rounded-3xl border border-zinc-800 text-center max-w-4xl mx-auto overflow-hidden">
            <div class="absolute top-[-50%] left-[-20%] w-96 h-96 bg-red-600/10 rounded-full blur-[100px] pointer-events-none"></div>
            
            <div class="relative z-10 max-w-xl mx-auto">
                <span class="text-3xl mb-4 inline-block">🍕🎨</span>
                <h3 class="text-xl md:text-2xl font-black text-white mb-2 uppercase tracking-wide">Crea una pizza a tu medida</h3>
                <p class="text-zinc-400 mb-6 text-sm">
                    Inicia sesión o regístrate para acceder al configurador interactivo, donde podrás seleccionar la masa, salsa e ingredientes a tu gusto.
                </p>
                <a href="login_cliente.jsp" class="inline-block bg-red-600 hover:bg-red-700 text-white px-6 py-3.5 rounded-xl font-black uppercase tracking-wider text-xs transition-all shadow-[0_0_15px_rgba(220,38,38,0.4)]">
                    Iniciar Sesión para armar
                </a>
            </div>
        </div>
    </section>

    <footer class="bg-black border-t border-zinc-900 py-8 text-center text-zinc-500 text-xs mt-10">
        <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Mister Pizza Web. Todos los derechos reservados.</p>
    </footer>

    <!-- BOTÓN FLOTANTE DEL CARRITO (QUE REDIRIGE A LOGIN PARA CONFIRMAR) -->
    <button id="btnCarrito" onclick="irAlCarrito()" class="hidden fixed bottom-6 left-1/2 -translate-x-1/2 bg-red-600 text-white px-6 md:px-8 py-4 rounded-2xl shadow-[0_0_25px_rgba(220,38,38,0.5)] hover:bg-red-700 transition-all flex items-center gap-3 z-30 w-[90%] md:w-auto justify-center hover:scale-[1.02]">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
        </svg>
        <span class="font-black tracking-wide uppercase text-xs md:text-sm">Iniciar Sesión para ordenar (<span id="cantidadTotal">0</span>)</span>
        <span class="bg-black/35 px-3 py-1 rounded-lg font-black text-xs md:text-sm text-red-100 border border-white/5">S/ <span id="precioTotal">0.00</span></span>
    </button>

    <!-- JAVASCRIPT DE CATÁLOGO Y CARRITO PÚBLICO -->
    <script>
        let carrito = JSON.parse(localStorage.getItem('misterPizzaCarrito')) || [];
        let catalogoPizzas = [];
        let categoriaActual = 'Todos';

        function cargarPizzasPublico() {
            fetch('CatalogoServlet?t=' + new Date().getTime())
                .then(response => response.json())
                .then(data => {
                    catalogoPizzas = data;
                    renderizarCatalogo();
                })
                .catch(error => console.error('Error cargando pizzas:', error));
        }

        window.onload = function() {
            cargarPizzasPublico();
            setInterval(cargarPizzasPublico, 15000);
        };

        function filtrarCatalogo(categoria, elementoClickeado) {
            categoriaActual = categoria;
            document.getElementById('titulo-categoria').innerText = categoria === 'Todos' ? 'NUESTRO MENÚ' : categoria.toUpperCase();

            const tabs = document.querySelectorAll('.tab-btn');
            tabs.forEach(tab => {
                tab.className = "tab-btn px-5 py-3 rounded-lg hover:text-white border border-transparent whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider text-zinc-400";
            });
            
            elementoClickeado.className = "tab-btn px-5 py-3 rounded-lg text-red-500 bg-red-600/10 border border-red-500/20 whitespace-nowrap cursor-pointer transition-all uppercase tracking-wider font-extrabold";

            renderizarCatalogo();
        }

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
                
                div.innerHTML = 
                    '<div class="relative w-full pt-[70%] bg-zinc-950/40 border-b border-zinc-800/50 overflow-hidden">' +
                        '<img src="' + pizza.imagen_url + '" alt="' + pizza.nombre + '" class="absolute top-0 left-0 w-full h-full object-contain p-4 drop-shadow-[0_8px_16px_rgba(0,0,0,0.5)] zoom-img" />' +
                        '<span class="absolute top-3 right-3 bg-black/60 backdrop-blur-md text-[10px] font-black text-red-400 border border-red-500/20 px-2 py-0.5 rounded-md uppercase tracking-wider">⭐ 4.8</span>' +
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
                                '<span class="font-black text-white text-lg">S/ ' + pizza.precio.toFixed(2) + '</span>' +
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

            if (totalItems > 0) {
                btn.classList.remove('hidden');
                document.getElementById('cantidadTotal').innerText = totalItems;
                document.getElementById('precioTotal').innerText = totalPrecio.toFixed(2);
            } else {
                btn.classList.add('hidden');
            }
        }

        function irAlCarrito() {
            // Como no está logueado, lo mandamos al login para completar la orden
            alert("🔑 Para continuar con tu orden, por favor inicia sesión o regístrate. Tus productos seleccionados se guardarán en tu sesión.");
            window.location.href = "login_cliente.jsp";
        }
    </script>
</body>
</html>