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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Arma tu Pizza - Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 min-h-screen pb-12 text-zinc-100">

    <header class="bg-black text-white p-4 shadow-2xl sticky top-0 z-50 border-b-4 border-red-600">
        <div class="max-w-6xl mx-auto flex justify-between items-center">
            <a href="catalogo.jsp" class="flex items-center gap-3 hover:text-white text-zinc-400 transition-colors font-bold text-sm">
                <span>⬅️</span> Volver al Catálogo
            </a>
            <div class="font-black text-xl tracking-wider italic uppercase">Mister Pizza</div>
        </div>
    </header>

    <main class="max-w-5xl mx-auto mt-8 px-4 grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-zinc-900 p-6 rounded-2xl shadow-lg border border-zinc-800">
                <h1 class="text-3xl font-black text-white mb-2 uppercase tracking-wide">Crea tu Pizza 🍕</h1>
                <p class="text-zinc-400 mb-8 text-sm">Elige tu base y modifícala a tu gusto exacto.</p>

                <form id="form-personalizar" onsubmit="event.preventDefault(); agregarPizzaAlCarrito();">
                    
                    <section class="mb-10">
                        <h2 class="text-lg font-bold text-white mb-4 flex items-center gap-3 uppercase tracking-widest text-sm">
                            <span class="bg-red-600 text-white w-6 h-6 flex items-center justify-center rounded-sm text-xs font-black">1</span> 
                            Elige tu Pizza Base
                        </h2>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-3" id="contenedor-bases">
                            </div>
                    </section>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-10">
                        <section>
                            <h2 class="text-lg font-bold text-white mb-3 flex items-center gap-3 uppercase tracking-widest text-sm">
                                <span class="bg-red-600 text-white w-6 h-6 flex items-center justify-center rounded-sm text-xs font-black">2</span> 
                                Tamaño
                            </h2>
                            <select name="tamano" id="select-tamano" onchange="calcularTotal()" class="w-full p-4 bg-zinc-950 border border-zinc-800 text-white rounded-md focus:border-red-600 outline-none font-bold transition-colors">
                                <option value="Personal" data-precio="0">Personal (Precio Base)</option>
                                <option value="Mediana" data-precio="10.00">Mediana (+ S/ 10.00)</option>
                                <option value="Familiar" data-precio="20.00">Familiar (+ S/ 20.00)</option>
                            </select>
                        </section>

                        <section>
                            <h2 class="text-lg font-bold text-white mb-3 flex items-center gap-3 uppercase tracking-widest text-sm">
                                <span class="bg-red-600 text-white w-6 h-6 flex items-center justify-center rounded-sm text-xs font-black">3</span> 
                                Masa
                            </h2>
                            <select name="masa" id="select-masa" onchange="calcularTotal()" class="w-full p-4 bg-zinc-950 border border-zinc-800 text-white rounded-md focus:border-red-600 outline-none font-bold transition-colors">
                                <option value="Tradicional" data-precio="0">Tradicional</option>
                                <option value="Delgada" data-precio="0">Masa Delgada</option>
                                <option value="Borde Queso" data-precio="6.00">Borde de Queso (+ S/ 6.00)</option>
                            </select>
                        </section>
                    </div>

                    <section class="mb-10 bg-red-950/20 p-5 rounded-xl border border-red-900/50">
                        <h2 class="text-sm font-bold text-red-500 mb-1 uppercase tracking-widest">¿Deseas quitar algo?</h2>
                        <p class="text-xs text-zinc-400 mb-4">Desmarca lo que no quieras en tu pizza.</p>
                        <div class="grid grid-cols-2 md:grid-cols-3 gap-3" id="contenedor-quitar">
                            </div>
                    </section>

                    <section>
                        <h2 class="text-lg font-bold text-white mb-4 flex items-center gap-3 uppercase tracking-widest text-sm">
                            <span class="bg-red-600 text-white w-6 h-6 flex items-center justify-center rounded-sm text-xs font-black">4</span> 
                            Añadir Extras
                        </h2>
                        <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                            <label class="flex items-center p-3 border border-zinc-800 bg-zinc-950 rounded-md cursor-pointer hover:border-red-600 transition-colors">
                                <input type="checkbox" name="agregados" value="Extra Queso" data-precio="3.50" class="w-5 h-5 accent-red-600" onchange="calcularTotal()" />
                                <div class="ml-3"><span class="text-sm font-bold block text-white">Extra Queso</span><span class="text-xs text-red-500">+ S/ 3.50</span></div>
                            </label>
                            <label class="flex items-center p-3 border border-zinc-800 bg-zinc-950 rounded-md cursor-pointer hover:border-red-600 transition-colors">
                                <input type="checkbox" name="agregados" value="Champiñones" data-precio="3.00" class="w-5 h-5 accent-red-600" onchange="calcularTotal()" />
                                <div class="ml-3"><span class="text-sm font-bold block text-white">Champiñones</span><span class="text-xs text-red-500">+ S/ 3.00</span></div>
                            </label>
                            <label class="flex items-center p-3 border border-zinc-800 bg-zinc-950 rounded-md cursor-pointer hover:border-red-600 transition-colors">
                                <input type="checkbox" name="agregados" value="Tocino" data-precio="4.50" class="w-5 h-5 accent-red-600" onchange="calcularTotal()" />
                                <div class="ml-3"><span class="text-sm font-bold block text-white">Tocino</span><span class="text-xs text-red-500">+ S/ 4.50</span></div>
                            </label>
                            <label class="flex items-center p-3 border border-zinc-800 bg-zinc-950 rounded-md cursor-pointer hover:border-red-600 transition-colors">
                                <input type="checkbox" name="agregados" value="Pepperoni" data-precio="4.00" class="w-5 h-5 accent-red-600" onchange="calcularTotal()" />
                                <div class="ml-3"><span class="text-sm font-bold block text-white">Pepperoni</span><span class="text-xs text-red-500">+ S/ 4.00</span></div>
                            </label>
                        </div>
                    </section>
                </form>
            </div>
        </div>

        <div class="lg:col-span-1">
            <div class="bg-black text-white p-6 rounded-2xl shadow-[0_0_20px_rgba(0,0,0,0.8)] border border-zinc-800 sticky top-24">
                <h3 class="text-sm font-black mb-4 border-b border-zinc-800 pb-4 uppercase tracking-widest text-zinc-400">Resumen del Pedido</h3>
                
                <div class="space-y-3 mb-6 text-sm">
                    <div class="text-red-500 font-black text-xl uppercase tracking-wide" id="resumen-base">Hawaiana</div>
                    <div class="text-white font-bold" id="resumen-tamano-masa">Personal - Tradicional</div>
                    
                    <div class="border-t border-zinc-800 pt-3 text-zinc-500 font-medium italic" id="resumen-sin"></div>
                    <div class="text-red-400 font-bold mt-2" id="resumen-con"></div>
                </div>

                <div class="border-t border-zinc-800 pt-4 mb-6 flex justify-between items-end">
                    <span class="text-sm font-bold uppercase tracking-widest text-zinc-400">Total</span>
                    <span class="text-4xl font-black text-white" id="precio-total-pantalla">S/ 0.00</span>
                </div>

                <button type="button" onclick="agregarPizzaAlCarrito()" class="w-full bg-red-600 hover:bg-red-700 text-white font-black uppercase tracking-widest py-4 rounded-md shadow-[0_0_15px_rgba(220,38,38,0.4)] transition-all">
                    Añadir al Carrito 🛒
                </button>
            </div>
        </div>
    </main>

    <form id="formOcultoCarrito" action="GuardarCarritoServlet" method="POST" style="display: none;">
        <input type="hidden" name="carritoJson" id="inputCarritoJson" />
    </form>

    <script>
        const menuPizzas = {
            "hawaiana": { nombre: "Hawaiana", emoji: "🍍", precio: 18.00, ingredientes: ["Queso Mozzarella", "Salsa de Tomate", "Jamón", "Piña"] },
            "americana": { nombre: "Americana", emoji: "🥓", precio: 16.00, ingredientes: ["Queso Mozzarella", "Salsa de Tomate", "Jamón"] },
            "pepperoni": { nombre: "Pepperoni", emoji: "🍕", precio: 19.00, ingredientes: ["Queso Mozzarella", "Salsa de Tomate", "Pepperoni"] },
            "vegetariana": { nombre: "Vegetariana", emoji: "🫑", precio: 17.00, ingredientes: ["Queso Mozzarella", "Salsa de Tomate", "Champiñones", "Pimientos", "Cebolla"] }
        };

        window.onload = function() {
            const contenedorBases = document.getElementById('contenedor-bases');
            let isFirst = true;

            for (const key in menuPizzas) {
                const pizza = menuPizzas[key];
                const checked = isFirst ? 'checked' : '';
                
                contenedorBases.innerHTML += `
                    <label class="cursor-pointer">
                        <input type="radio" name="base_seleccionada" value="\${key}" class="peer sr-only" \${checked} onchange="cambiarBase()" />
                        <div class="p-3 rounded-md border border-zinc-800 bg-zinc-950 peer-checked:border-red-600 peer-checked:ring-1 peer-checked:ring-red-600 hover:bg-zinc-900 transition-all text-center">
                            <div class="text-3xl mb-1">\${pizza.emoji}</div>
                            <div class="font-bold text-white text-sm">\${pizza.nombre}</div>
                            <div class="text-red-500 font-black text-xs mt-1">S/ \${pizza.precio.toFixed(2)}</div>
                        </div>
                    </label>
                `;
                isFirst = false;
            }
            cambiarBase(); 
        };

        function cambiarBase() {
            const baseSeleccionada = document.querySelector('input[name="base_seleccionada"]:checked').value;
            const pizza = menuPizzas[baseSeleccionada];
            const contenedorQuitar = document.getElementById('contenedor-quitar');
            
            contenedorQuitar.innerHTML = '';
            
            pizza.ingredientes.forEach(ing => {
                contenedorQuitar.innerHTML += `
                    <label class="flex items-center p-3 border border-red-900/30 bg-black rounded-md cursor-pointer hover:border-red-500 transition-colors">
                        <input type="checkbox" name="mantenidos" value="\${ing}" checked class="w-4 h-4 accent-red-600 rounded" onchange="calcularTotal()" />
                        <span class="ml-3 text-xs font-bold text-zinc-300">\${ing}</span>
                    </label>
                `;
            });
            calcularTotal();
        }

        let precioFinal = 0;
        let descripcionFinalTexto = "";
        let nombreFinalTexto = "";

        function calcularTotal() {
            const baseKey = document.querySelector('input[name="base_seleccionada"]:checked').value;
            const pizzaObj = menuPizzas[baseKey];
            let total = pizzaObj.precio;
            
            nombreFinalTexto = "Pizza " + pizzaObj.nombre + " (Custom)";
            document.getElementById('resumen-base').innerText = pizzaObj.nombre;

            const selTamano = document.getElementById('select-tamano');
            const selMasa = document.getElementById('select-masa');
            total += parseFloat(selTamano.options[selTamano.selectedIndex].getAttribute('data-precio'));
            total += parseFloat(selMasa.options[selMasa.selectedIndex].getAttribute('data-precio'));
            
            // CORRECCIÓN: Separamos con guion para no quebrar el Java
            const txtTamanoMasa = selTamano.value + " - " + selMasa.value;
            document.getElementById('resumen-tamano-masa').innerText = txtTamanoMasa;

            const checkboxesMantenidos = document.querySelectorAll('input[name="mantenidos"]');
            let removidos = [];
            let mantenidos = [];
            checkboxesMantenidos.forEach(cb => {
                if (!cb.checked) removidos.push(cb.value);
                else mantenidos.push(cb.value);
            });
            
            let txtSin = removidos.length > 0 ? "SIN: " + removidos.join(", ") : "";
            document.getElementById('resumen-sin').innerText = txtSin;

            const checkboxesExtras = document.querySelectorAll('input[name="agregados"]:checked');
            let agregados = [];
            checkboxesExtras.forEach(cb => {
                agregados.push(cb.value);
                total += parseFloat(cb.getAttribute('data-precio'));
            });

            let txtCon = agregados.length > 0 ? "EXTRAS: " + agregados.join(", ") : "";
            document.getElementById('resumen-con').innerText = txtCon;

            document.getElementById('precio-total-pantalla').innerText = 'S/ ' + total.toFixed(2);
            precioFinal = total;

            let detalles = [txtTamanoMasa];
            if(mantenidos.length > 0) detalles.push(mantenidos.join(", "));
            if(agregados.length > 0) detalles.push("Extras: " + agregados.join(", "));
            if(removidos.length > 0) detalles.push("Sin: " + removidos.join(", "));
            
            // CORRECCIÓN: Unimos todo con guiones
            descripcionFinalTexto = detalles.join(" - ");
        }

        function agregarPizzaAlCarrito() {
            // 1. Recuperamos el carrito que traemos del catálogo (o uno vacío si es el primero)
            let carritoGlobal = JSON.parse(localStorage.getItem('misterPizzaCarrito')) || [];
            
            // 2. Creamos el objeto de la pizza personalizada
            const nuevaPizzaCustom = {
                id: Date.now(), // Usamos la fecha como ID único para que no choque con las del catálogo
                nombre: nombreFinalTexto,
                ingredientes: descripcionFinalTexto,
                precio: precioFinal,
                cantidad: 1
            };

            // 3. Añadimos la pizza personalizada al carrito global y guardamos
            carritoGlobal.push(nuevaPizzaCustom);
            localStorage.setItem('misterPizzaCarrito', JSON.stringify(carritoGlobal));

            // 4. Formateamos todo el carrito unificado para enviarlo a Java
            const datosSeguros = carritoGlobal.map(item => {
                return item.nombre + "|" + item.ingredientes + "|" + item.precio + "|" + item.cantidad;
            }).join("||");
            
            document.getElementById('inputCarritoJson').value = datosSeguros;
            document.getElementById('formOcultoCarrito').submit();
        }
    </script>
</body>
</html>