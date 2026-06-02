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
    <title>Catálogo - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="min-h-screen bg-zinc-950 text-zinc-100 pb-24">

    <div class="bg-black text-white p-4 md:p-6 sticky top-0 z-20 flex justify-between items-center border-b-4 border-red-600 shadow-2xl">
        <div class="flex items-center gap-3">
            <span class="text-3xl">🍕</span>
            <div>
                <h1 class="text-xl md:text-2xl font-black italic tracking-wider uppercase">Mister Pizza</h1>
                <p class="text-xs text-zinc-400">Hola, <span class="text-red-400"><%= usuario.getNombre() %></span></p>
            </div>
        </div>
        
        <div class="flex items-center gap-2 md:gap-4">
            <a href="seguimiento.jsp" class="bg-zinc-800 hover:bg-zinc-700 text-white px-3 py-2 md:px-4 md:py-2 rounded-full text-xs font-bold transition-colors border border-zinc-700 flex items-center gap-2">
                <span>🛵</span> <span class="hidden md:inline">Ver Pedido</span>
            </a>
            <a href="LogoutServlet" class="text-xs md:text-sm text-zinc-400 hover:text-red-500 transition-colors uppercase font-bold tracking-widest">Salir</a>
        </div>
    </div>

    <div class="bg-zinc-900 border-b border-zinc-800 sticky top-[76px] md:top-[88px] z-10 shadow-md">
        <ul class="flex overflow-x-auto no-scrollbar text-sm font-bold text-zinc-400 px-4 md:px-8 py-3 gap-6 md:gap-8">
            <li onclick="filtrarCatalogo('Todos', this)" class="tab-btn text-red-500 border-b-2 border-red-500 pb-1 whitespace-nowrap cursor-pointer transition-all">Ver todo</li>
            <li onclick="filtrarCatalogo('Promociones', this)" class="tab-btn hover:text-white border-b-2 border-transparent pb-1 whitespace-nowrap cursor-pointer transition-all">🔥 Promociones</li>
            <li onclick="filtrarCatalogo('Pizzas Clásicas', this)" class="tab-btn hover:text-white border-b-2 border-transparent pb-1 whitespace-nowrap cursor-pointer transition-all">Pizzas Clásicas</li>
            <li onclick="filtrarCatalogo('Especialidades', this)" class="tab-btn hover:text-white border-b-2 border-transparent pb-1 whitespace-nowrap cursor-pointer transition-all">Especialidades</li>
            <li onclick="filtrarCatalogo('Bebidas', this)" class="tab-btn hover:text-white border-b-2 border-transparent pb-1 whitespace-nowrap cursor-pointer transition-all">Bebidas</li>
        </ul>
    </div>

    <div class="p-4 md:p-8 max-w-7xl mx-auto">
        <h2 id="titulo-categoria" class="text-zinc-300 font-black text-xl md:text-2xl mb-6 uppercase tracking-wide">Nuestro Menú</h2>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6" id="catalogo-contenedor">
            </div>

        <div class="mt-16 p-8 bg-zinc-900 rounded-xl shadow-2xl border border-zinc-800 text-center max-w-2xl mx-auto pizza-card">
            <h2 class="text-2xl font-black text-white mb-2 uppercase tracking-wide">¿No encuentras lo que buscas?</h2>
            <p class="text-zinc-400 mb-6 text-sm">Arma tu propia pizza desde cero con tus ingredientes favoritos.</p>
            <a href="personalizar_pizza.jsp" class="inline-block bg-red-600 text-white px-8 py-3 rounded-md font-black hover:bg-red-700 transition-colors shadow-[0_0_15px_rgba(220,38,38,0.4)] uppercase tracking-wider">
                + Crear mi Pizza
            </a>
        </div>
    </div>

    <button id="btnCarrito" onclick="irAlCarrito()" class="hidden fixed bottom-6 left-1/2 -translate-x-1/2 bg-red-600 text-white px-6 md:px-8 py-3 md:py-4 rounded-full shadow-[0_0_20px_rgba(220,38,38,0.4)] hover:bg-red-700 transition-all flex items-center gap-3 z-30 w-[90%] md:w-auto justify-center">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
        <span class="font-bold">Ver mi Pedido (<span id="cantidadTotal">0</span>)</span>
        <span class="bg-black/30 px-3 py-1 rounded-md font-black">S/ <span id="precioTotal">0.00</span></span>
    </button>

    <form id="formOcultoCarrito" action="GuardarCarritoServlet" method="POST" style="display: none;">
        <input type="hidden" name="carritoJson" id="inputCarritoJson" />
    </form>

    <script>
        let carrito = JSON.parse(localStorage.getItem('misterPizzaCarrito')) || [];
        let catalogoPizzas = [];
        let categoriaActual = 'Todos';

        // 1. Carga silenciosa con prevención de caché
        function cargarPizzasSilenciosamente() {
            fetch('CatalogoServlet?t=' + new Date().getTime())
                .then(response => response.json())
                .then(data => {
                    catalogoPizzas = data;
                    renderizarCatalogo();
                })
                .catch(error => console.error('Error cargando pizzas:', error));
        }

        // 2. Inicialización y ejecución cada 15 segundos
        window.onload = function() {
            cargarPizzasSilenciosamente();
            setInterval(cargarPizzasSilenciosamente, 15000);
        };

        function filtrarCatalogo(categoria, elementoClickeado) {
            categoriaActual = categoria;
            
            document.getElementById('titulo-categoria').innerText = categoria === 'Todos' ? 'NUESTRO MENÚ' : categoria.toUpperCase();

            const tabs = document.querySelectorAll('.tab-btn');
            tabs.forEach(tab => {
                tab.classList.remove('text-red-500', 'border-red-500');
                tab.classList.add('hover:text-white', 'border-transparent', 'text-zinc-400');
            });
            
            elementoClickeado.classList.remove('hover:text-white', 'border-transparent', 'text-zinc-400');
            elementoClickeado.classList.add('text-red-500', 'border-red-500');

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
                contenedor.innerHTML = '<div class="col-span-full text-center py-12 text-zinc-500"><div class="text-5xl mb-4">🍽️</div><p class="font-bold text-lg">No hay productos en esta categoría por ahora.</p></div>';
                return;
            }

            pizzasFiltradas.forEach(pizza => {
                const item = carrito.find(i => i.id === pizza.id);
                const div = document.createElement('div');
                div.className = "bg-zinc-900 rounded-xl overflow-hidden flex flex-col h-full border border-zinc-800 pizza-card";

                let botonesHTML = '';
                if (!item) {
                    botonesHTML = '<button onclick="agregarAlCarrito(' + pizza.id + ')" class="w-full bg-red-600 text-white font-black py-4 text-sm hover:bg-red-700 transition-colors uppercase tracking-wider shadow-inner">Añadir al Pedido</button>';
                } else {
                    botonesHTML = '<div class="flex items-center justify-between bg-zinc-800 p-2">' +
                                    '<button onclick="cambiarCantidad(' + pizza.id + ', -1)" class="bg-zinc-700 text-white rounded-md w-12 h-10 font-bold flex items-center justify-center hover:bg-zinc-600 transition-colors">-</button>' +
                                    '<span class="font-black text-white text-lg">' + item.cantidad + '</span>' +
                                    '<button onclick="cambiarCantidad(' + pizza.id + ', 1)" class="bg-red-600 text-white rounded-md w-12 h-10 font-bold flex items-center justify-center hover:bg-red-700 transition-colors">+</button>' +
                                  '</div>';
                }
                
                div.innerHTML = 
                    '<div class="relative w-full pt-[75%] bg-zinc-950 border-b border-zinc-800">' +
                        '<img src="' + pizza.imagen_url + '" alt="' + pizza.nombre + '" class="absolute top-0 left-0 w-full h-full object-contain p-4 drop-shadow-2xl" />' +
                    '</div>' +
                    '<div class="p-5 flex flex-col flex-1">' +
                        '<div class="flex justify-between items-start mb-2 gap-2">' +
                            '<h3 class="font-black text-white text-lg leading-tight uppercase tracking-wide">' + pizza.nombre + '</h3>' +
                            '<span class="font-black text-red-500 text-lg whitespace-nowrap">S/ ' + pizza.precio.toFixed(2) + '</span>' +
                        '</div>' +
                        '<div class="mb-5 flex-1">' +
                            '<p class="text-xs text-zinc-400 line-clamp-3 leading-relaxed">' + pizza.ingredientes + '</p>' +
                        '</div>' +
                        '<div class="mt-auto">' +
                            botonesHTML +
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
            const datosSeguros = carrito.map(item => {
                return item.nombre + "|" + item.ingredientes + "|" + item.precio + "|" + item.cantidad;
            }).join("||");

            document.getElementById('inputCarritoJson').value = datosSeguros;
            document.getElementById('formOcultoCarrito').submit();
        }
    </script>
</body>
</html>