<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Catálogo Mister Pizza</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col md:flex-row">

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
                <a href="admin_productos.jsp" class="flex items-center gap-3 px-4 py-3 bg-red-600 text-white rounded-md font-bold transition-colors shadow-[0_0_10px_rgba(220,38,38,0.3)] whitespace-nowrap">
                    📦 Gestionar Catálogo
                </a>
                <a href="GestionUsuariosServlet" class="flex items-center gap-3 px-4 py-3 text-zinc-400 hover:bg-zinc-900 hover:text-white rounded-md font-medium transition-colors whitespace-nowrap">
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

    <main class="flex-1 p-6 md:p-8 overflow-x-hidden">
        <header class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 border-b border-zinc-800 pb-6 gap-4">
            <div>
                <h1 class="text-3xl font-black text-white uppercase tracking-wide">Catálogo de Productos</h1>
                <p class="text-zinc-400 text-sm mt-1">Añade, edita o elimina el menú disponible para los clientes.</p>
            </div>
            <button onclick="abrirFormularioNuevo()" class="bg-red-600 hover:bg-red-700 text-white px-6 py-3 rounded-md font-black uppercase tracking-widest transition-colors shadow-[0_0_15px_rgba(220,38,38,0.4)] whitespace-nowrap">
                + Nuevo Producto
            </button>
        </header>

        <div id="formNuevoProducto" class="hidden bg-zinc-900 p-6 md:p-8 rounded-xl shadow-lg border border-zinc-800 mb-8 transition-all">
            <h2 id="tituloFormulario" class="text-xl font-black text-white mb-6 uppercase tracking-wide">Agregar Nuevo Producto</h2>
            
            <!-- EL FORMULARIO AHORA ES SIMPLE SIN EL ENCTYPE MULTIPART -->
            <form action="GestorProductosServlet" method="POST" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                <input type="hidden" name="id_producto" id="input_id" />

                <div>
                    <label class="block text-xs font-bold text-zinc-400 uppercase tracking-widest mb-2">Nombre del Producto</label>
                    <input type="text" name="nombre" id="input_nombre" required class="w-full bg-zinc-950 border border-zinc-800 text-white px-4 py-3 rounded-md focus:border-red-600 focus:outline-none transition-colors" />
                </div>
                
                <div>
                    <label class="block text-xs font-bold text-zinc-400 uppercase tracking-widest mb-2">Precio (S/)</label>
                    <input type="number" step="0.01" name="precio" id="input_precio" required class="w-full bg-zinc-950 border border-zinc-800 text-white px-4 py-3 rounded-md focus:border-red-600 focus:outline-none transition-colors" />
                </div>

                <div class="md:col-span-2">
                    <label class="block text-xs font-bold text-zinc-400 uppercase tracking-widest mb-2">Categoría (Pestaña del Menú)</label>
                    <select name="categoria" id="input_categoria" required class="w-full bg-zinc-950 border border-zinc-800 text-white px-4 py-3 rounded-md focus:border-red-600 focus:outline-none transition-colors font-bold">
                        <option value="Promociones">🔥 Promociones</option>
                        <option value="Pizzas Clásicas">Pizzas Clásicas</option>
                        <option value="Especialidades">Especialidades</option>
                        <option value="Bebidas">Bebidas</option>
                    </select>
                </div>

                <div class="md:col-span-2">
                    <label class="block text-xs font-bold text-zinc-400 uppercase tracking-widest mb-2">Ingredientes / Descripción</label>
                    <input type="text" name="ingredientes" id="input_ingredientes" required placeholder="Ej: Salsa de tomate, queso..." class="w-full bg-zinc-950 border border-zinc-800 text-white px-4 py-3 rounded-md focus:border-red-600 focus:outline-none transition-colors" />
                </div>
                
                <div class="md:col-span-2 bg-black p-4 rounded-md border border-zinc-800">
                    <label class="block text-xs font-bold text-red-500 uppercase tracking-widest mb-3">Enlace (URL) de la Imagen del Producto</label>
                    <!-- ÚNICO INPUT PARA LA IMAGEN (SOLO TEXTO) -->
                    <input type="url" name="imagen_producto" id="input_imagen_producto" placeholder="Ej: https://i.imgur.com/mifoto.jpg" required class="w-full bg-zinc-950 border border-zinc-800 text-white px-4 py-3 rounded-md focus:border-red-600 focus:outline-none transition-colors" />
                    <p class="text-zinc-500 text-xs mt-2">Puedes subir imágenes gratis en <a href="https://postimages.org/" target="_blank" class="text-red-500 underline">postimages.org</a> y pegar aquí el enlace directo.</p>
                </div>
                
                <div class="md:col-span-2 flex justify-end gap-4 mt-4 border-t border-zinc-800 pt-6">
                    <button type="button" onclick="cerrarFormulario()" class="px-6 py-3 text-zinc-400 hover:text-white hover:bg-zinc-800 rounded-md transition-colors font-bold uppercase tracking-widest text-sm">Cancelar</button>
                    <button type="submit" id="btn_guardar" class="bg-red-600 hover:bg-red-700 text-white px-8 py-3 rounded-md font-black uppercase tracking-widest transition-colors shadow-[0_0_15px_rgba(220,38,38,0.4)]">Guardar Producto</button>
                </div>
            </form>
        </div>

        <div class="bg-zinc-900 rounded-xl shadow-lg border border-zinc-800 overflow-x-auto custom-scrollbar">
            <table class="w-full text-left border-collapse min-w-[800px]">
                <thead>
                    <tr class="bg-black border-b-2 border-zinc-800 text-zinc-400 text-xs uppercase tracking-widest">
                        <th class="p-4 font-bold">Imagen</th>
                        <th class="p-4 font-bold">Nombre</th>
                        <th class="p-4 font-bold">Categoría</th>
                        <th class="p-4 font-bold">Descripción</th>
                        <th class="p-4 font-bold text-center">Precio</th>
                        <th class="p-4 font-bold text-center">Acciones</th> 
                    </tr>
                </thead>
                <tbody id="tabla-productos-body" class="divide-y divide-zinc-800 text-sm text-zinc-300">
                    </tbody>
            </table>
        </div>
    </main>

    <script>
        const formDiv = document.getElementById('formNuevoProducto');

        function abrirFormularioNuevo() {
            document.getElementById('input_id').value = '';
            document.getElementById('input_nombre').value = '';
            document.getElementById('input_precio').value = '';
            document.getElementById('input_ingredientes').value = '';
            document.getElementById('input_categoria').value = 'Pizzas Clásicas'; // Valor por defecto
            
            // Limpiar campo de imagen
            document.getElementById('input_imagen_producto').value = '';
            
            document.getElementById('tituloFormulario').innerText = 'AGREGAR NUEVO PRODUCTO';
            document.getElementById('btn_guardar').innerText = 'GUARDAR PRODUCTO';
            formDiv.classList.remove('hidden');
        }

        // AHORA RECIBE LA URL DE LA IMAGEN COMO PARÁMETRO
        function prepararEdicion(id, nombre, precio, ingredientes, categoria, imagen_url) {
            document.getElementById('input_id').value = id;
            document.getElementById('input_nombre').value = nombre;
            document.getElementById('input_precio').value = precio;
            document.getElementById('input_ingredientes').value = ingredientes;
            
            document.getElementById('input_categoria').value = categoria && categoria !== 'null' ? categoria : 'Pizzas Clásicas';
            
            // Llenar el campo de la imagen para que el gerente vea qué enlace tiene
            document.getElementById('input_imagen_producto').value = imagen_url;
            
            document.getElementById('tituloFormulario').innerText = 'EDITAR PRODUCTO (ID: ' + id + ')';
            document.getElementById('btn_guardar').innerText = 'ACTUALIZAR PRODUCTO';
            
            formDiv.classList.remove('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' }); 
        }

        function cerrarFormulario() {
            formDiv.classList.add('hidden');
        }

        function confirmarEliminacion(id, nombre) {
            if (confirm("⚠️ ¿Estás seguro de que deseas eliminar: " + nombre + "? Esta acción no se puede deshacer.")) {
                window.location.href = "EliminarProductoServlet?id=" + id;
            }
        }

        window.onload = function() {
            fetch('CatalogoServlet')
                .then(response => response.json())
                .then(data => {
                    const tbody = document.getElementById('tabla-productos-body');
                    tbody.innerHTML = '';
                    
                    data.forEach(prod => {
                        const tr = document.createElement('tr');
                        tr.className = "hover:bg-zinc-800/50 transition-colors";
                        
                        const catMostrada = prod.categoria ? prod.categoria : 'Pizzas Clásicas';
                        
                        tr.innerHTML = `
                            <td class="p-4">
                                <img src="\${prod.imagen_url}" class="w-14 h-14 rounded-md object-cover border border-zinc-700 bg-black" />
                            </td>
                            <td class="p-4 font-black text-white">\${prod.nombre}</td>
                            <td class="p-4 font-bold text-red-500 text-xs uppercase tracking-widest">\${catMostrada}</td>
                            <td class="p-4 text-xs text-zinc-400 max-w-xs truncate">\${prod.ingredientes}</td>
                            <td class="p-4 font-black text-white text-center">S/ \${prod.precio.toFixed(2)}</td>
                            <td class="p-4 text-center whitespace-nowrap">
                                <!-- AQUÍ SE ENVÍA LA URL AL BOTÓN DE EDITAR -->
                                <button onclick="prepararEdicion(\${prod.id}, '\${prod.nombre}', \${prod.precio}, '\${prod.ingredientes}', '\${prod.categoria}', '\${prod.imagen_url}')" class="bg-zinc-800 hover:bg-zinc-700 text-white px-3 py-2 rounded-md transition-colors font-bold text-xs uppercase tracking-widest mr-2 border border-zinc-700">✏️ Editar</button>
                                <button onclick="confirmarEliminacion(\${prod.id}, '\${prod.nombre}')" class="bg-red-900/30 hover:bg-red-600 text-red-500 hover:text-white px-3 py-2 rounded-md transition-colors font-bold text-xs uppercase tracking-widest border border-red-900/50">🗑️ Borrar</button>
                            </td>
                        `;
                        tbody.appendChild(tr);
                    });
                })
                .catch(error => console.error('Error cargando el catálogo:', error));
        };
    </script>
</body>
</html>
