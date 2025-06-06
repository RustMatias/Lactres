<style>

</style>

{include file="header-admin.tpl"}







<div class="container-fluid mt-3 ">

{include file="ADMIN_sidenav_mobile.tpl"}







    <div class="row">


    {include file="ADMIN_sidenav.tpl"}


      
        
        
        <div class="col-md-11">
            
            <div class="d-flex flex-wrap align-items-center">
                <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('addproduct')">
                    <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M21.938 2.25H2.063a.563.563 0 0 0-.563.563v2.624c0 .311.252.563.563.563h19.875c.31 0 .562-.252.562-.563V2.813a.562.562 0 0 0-.563-.562Z"></path>
                        <path d="M3 7.5v13.125a1.125 1.125 0 0 0 1.125 1.125h15.75A1.125 1.125 0 0 0 21 20.625V7.5H3Zm9 10.81-4.063-4.06L9 13.187l2.25 2.252V9.75h1.5v5.69l2.253-2.254 1.06 1.061L12 18.311Z"></path>
                    </svg>
                    <small class="btn-text">Añadir Producto</small>
                </button>
                
                <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('editproduct')">
                    <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="m17.069 5.875-12.99 13.02L3 21.004l2.109-1.078 13.02-12.99-1.06-1.061Z"></path>
                        <path d="m19.72 3.22-1.06 1.06 1.06 1.06 1.06-1.06a.75.75 0 0 0 0-1.06v0a.75.75 0 0 0-1.06 0v0Z"></path>
                    </svg>
                    <small class="btn-text">Editar Producto</small>
                </button>
                {if $smarty.session.GRUPO == "C" || $smarty.session.GRUPO == "M" }  
                  <!--   <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('addcategory')">
                        <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="m.754 8.878 1.34 10.963A1.313 1.313 0 0 0 3.399 21h17.204a1.313 1.313 0 0 0 1.305-1.16l1.338-10.962a.561.561 0 0 0-.558-.628H1.313a.563.563 0 0 0-.56.628Z"></path>
                            <path d="M21.75 5.813A1.313 1.313 0 0 0 20.437 4.5h-8.96L9.227 3H3.562A1.313 1.313 0 0 0 2.25 4.313V6.75h19.5v-.938Z"></path>
                        </svg>
                        <small class="btn-text">Añadir Categoría</small>
                    </button> -->
                    <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('addCat')">
                        <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="m.754 8.878 1.34 10.963A1.313 1.313 0 0 0 3.399 21h17.204a1.313 1.313 0 0 0 1.305-1.16l1.338-10.962a.561.561 0 0 0-.558-.628H1.313a.563.563 0 0 0-.56.628Z"></path>
                            <path d="M21.75 5.813A1.313 1.313 0 0 0 20.437 4.5h-8.96L9.227 3H3.562A1.313 1.313 0 0 0 2.25 4.313V6.75h19.5v-.938Z"></path>
                        </svg>
                        <small class="btn-text">Añadir Categoria</small>
                    </button>
                    <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('editcategory')">
                        <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="m17.069 5.875-12.99 13.02L3 21.004l2.109-1.078 13.02-12.99-1.06-1.061Z"></path>
                            <path d="m19.72 3.22-1.06 1.06 1.06 1.06 1.06-1.06a.75.75 0 0 0 0-1.06v0a.75.75 0 0 0-1.06 0v0Z"></path>
                        </svg>
                        <small class="btn-text">Editar Categoría</small>
                    </button>
                
                    <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('banner')">
                        <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <rect width="18" height="18" x="3" y="3" rx="2" ry="2"></rect>
                            <path d="M8.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 1 0 0-3z"></path>
                            <path d="m21 15-5-5L5 21"></path>
                        </svg>
                        <small class="btn-text">Banner</small>
                    </button>
                {/if}
               <!--  <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('logo')">
                    <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <rect width="18" height="18" x="3" y="3" rx="2" ry="2"></rect>
                        <path d="M8.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 1 0 0-3z"></path>
                        <path d="m21 15-5-5L5 21"></path>
                    </svg>
                    <small class="btn-text">Logo</small>
                </button> -->

                <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('logoPage')">
                    <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <rect width="18" height="18" x="3" y="3" rx="2" ry="2"></rect>
                        <path d="M8.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 1 0 0-3z"></path>
                        <path d="m21 15-5-5L5 21"></path>
                    </svg>
                    <small class="btn-text">Logo</small>
                </button>

                <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('enviosPage')">
                <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 1v22"></path>
                    <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                    </svg>
                <small class="btn-text">Precios de envio</small>
            </button>

                <button class="btn btn-admin-up d-flex align-items-center mb-2" onclick="adminsubmenu('contact')">
                <svg width="15" height="15" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M18 2a3 3 0 1 0 0 6 3 3 0 1 0 0-6z"></path>
                <path d="M6 9a3 3 0 1 0 0 6 3 3 0 1 0 0-6z"></path>
                <path d="M18 16a3 3 0 1 0 0 6 3 3 0 1 0 0-6z"></path>
                <path d="m8.59 13.51 6.83 3.98"></path>
                <path d="m15.41 6.51-6.82 3.98"></path>
              </svg>
                <small class="btn-text">Links / Contacto</small>
            </button>
            </div>
            







            {if $limitProducto}
            
            <form action="addproduct" id="addproduct" class="formadmin" method="POST" enctype="multipart/form-data">
                <input name="id_tienda" type="hidden" value="{$shopInfo[0]->id_tienda}">
                <input name="shopName" type="hidden" value="{$shopInfo[0]->nombre_unico}">

                <div class="container">
              
        <h2 class="mb-5 text-center">Nuevo Producto</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="nombre" class="font-weight-bold">Nombre</label>
                    <input class="form-control" name="nombre" type="text" required placeholder="Ingrese el nombre del producto">
                </div>
                <div class="form-group">
                    <label for="descripcion" class="font-weight-bold">Descripción</label>
                    <input class="form-control" name="descripcion" type="text" required placeholder="Describa el producto">
                </div>
                <div class="form-group">
                    <label for="precio" class="font-weight-bold">Precio</label>
                    <input class="form-control" name="precio" type="text" required placeholder="Establezca el precio">
                </div>
            </div>
            <div class="col-md-6">
            {if $smarty.session.GRUPO == "C"}  
                <div class="form-group">
                    <label for="marca" class="font-weight-bold">Marca</label>
                    <input class="form-control" name="marca" type="text" placeholder="Marca del producto">
                </div>
            {/if}
            <div class="form-group">
                <label for="stock" class="font-weight-bold">Stock</label>
            
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <input class="form-control" name="stock" type="number" placeholder="Cantidad disponible" id="stockInput">
                    </div>
            
                    <div class="col-md-6 d-flex align-items-center">
                        <div class="form-check mb-0">
                            <input class="form-check-input" type="checkbox" id="unlimitedStock" name="unlimitedStock" value="1">
                            <label class="form-check-label mt-4" for="unlimitedStock">
                                Sin límite
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            


             
                {if $smarty.session.GRUPO == "C"}  
                <div class="form-group">
                    <label for="fabricante" class="font-weight-bold">Fabricante</label>
                    <input class="form-control" name="fabricante" type="text" placeholder="Nombre del fabricante">
                </div>
            {/if}
            </div>
        </div>
        {if $smarty.session.GRUPO =="C"}  
        <div class="form-group">
            <label for="categoria" class="font-weight-bold">Categoría</label>
            <select name="categoria" id="categoria" class="form-control">
                <option value="0">Sin categoria</option>

                {if $categories|@count > 0}
                    {foreach from=$categories item=category}
                        <option value="{$category->id_categoria}">{$category->nombre}</option>
                    {/foreach}
                {else}
                    <option disabled="disabled">Debe crear una categoría</option>
                {/if}
            </select>
            <small class="form-text text-muted" onclick="adminsubmenu('addCat')">Crear categorías</small>
        </div>
    {/if}


<hr>


                <div class="form-group">
                    <label for="nombre" class="font-weight-bold">Peso</label>
                    <input class="form-control" name="peso" type="text" required placeholder="Ingrese el nombre del producto">
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="alto" class="font-weight-bold">Alto</label>
                        <input class="form-control" name="alto" type="text" required placeholder="Alto (cm)">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="ancho" class="font-weight-bold">Ancho</label>
                        <input class="form-control" name="ancho" type="text" required placeholder="Ancho (cm)">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="largo" class="font-weight-bold">Largo</label>
                        <input class="form-control" name="largo" type="text" required placeholder="Largo (cm)">
                    </div>
                </div>
                
                

                <hr>



    {if $smarty.session.GRUPO == "C"}  
        <div class="form-group">
            <label for="input_image" class="font-weight-bold">Imágenes del Producto</label>
            <input type="file" class="form-control-file" id="input_image" name="input_image[]" multiple accept="image/*" max="5" required>
            <small class="form-text text-muted">Máximo 5 imágenes</small>
            <div id="image-preview" class="mt-3"></div> <!-- Contenedor para la vista previa de las imágenes -->
        </div>
    {else}
        <div class="form-group">
            <label for="input_image" class="font-weight-bold">Imagen del Producto</label>
            <input type="file" class="form-control-file" id="input_image" name="input_image" accept="image/*" max="1" required>
            <small class="form-text text-muted">Solo se permite 1 imagen</small>
            <div id="image-preview" class="mt-3"></div>
        </div>
    {/if}
    
    <button type="submit" class="btn btn-secondary btn-block">Agrega
    
</form>
{else}
<div class="alert alert-warning" role="alert" id="addproduct">
    🚨 Superaste el límite de creación de productos 🚨
    {if $smarty.session.GRUPO == "I"}  
    ( 12 productos )
    {elseif $smarty.session.GRUPO == "M"}  
    ( 50 productos )
    {/if}
</div>


{/if}

          <script>

            document.addEventListener('DOMContentLoaded', function () {
                const inputImage = document.getElementById('input_image');
                const previewContainer = document.getElementById('image-preview');

                // Función para actualizar la vista previa de las imágenes
                function updateImagePreview(files) {
                    previewContainer.innerHTML = ''; // Limpiar vista previa anterior

                    for (let i = 0; i < files.length; i++) {
                        const file = files[i];
                        const reader = new FileReader();

                        reader.onload = function(e) {
                            const imgElement = document.createElement('img');
                            imgElement.src = e.target.result;
                            imgElement.style.maxWidth = '150px'; // Ajustar tamaño si es necesario
                            imgElement.style.marginRight = '10px'; // Espacio entre imágenes

                            previewContainer.appendChild(imgElement);
                        };

                        reader.readAsDataURL(file);
                    }
                }

                // Evento para manejar la selección de archivos
                inputImage.addEventListener('change', function() {
                    const files = inputImage.files;
                    if (files.length > 0) {
                        updateImagePreview(files);
                    }
                });
            });

          </script>
            
    
    
    
    
    
    
    
    
    
    
    



            <form action="addcategory" id="addcategory" class="formadmin hideform" method="POST" enctype="multipart/form-data">
                <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">

                <div class="container">
                    <h2 class="mb-5 text-center">Nueva Categoría</h2>
                    <div class="form-group">
                        <label for="nombre" class="font-weight-bold">Nombre de la categoría</label>
                        <input class="form-control" name="nombre" type="text" required placeholder="Ingrese el nombre de la categoría">
                    </div>
                    <div class="form-group">
                        <label for="descripcion" class="font-weight-bold">Descripción</label>
                        <input class="form-control" name="descripcion" type="text" required placeholder="Describa la categoría">
                    </div>
                    <div class="form-group">
                        <label for="input_image" class="font-weight-bold">Imagen de la Categoría</label>
                        <input type="file" class="form-control-file" id="input_image" name="input_image">
                    </div>
                </div>
            </form>
           
 

        <div id="logo" class="formadmin hideform">
            <label for="logo">Logo actual</label>
            <img src="{$shopInfo[0]->logo}" alt="logo" class="img-logo-cntrol-panel">
            <form action="updateLogo" id="updateLogo" class="formadmin" method="POST" enctype="multipart/form-data">
                <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">
   
                <div class="form-group">
                        <label for="input_image" class="font-weight-bold">Nuevo logo</label>
                        <input type="file" class="form-control-file" id="input_image" name="input_image">
                    </div>
                    <button id="delete-buton" type="submit" class="btn btn-secondary btn-block" style="display: none;">Actualizar Logo</button>
                    </form>
        </div>

        <div id="logoPage" class="formadmin hideform">
            <label for="logo">Logo actual</label>
            <img src="{$shopInfo[0]->logo}" alt="logo" class="img-logo-cntrol-panel">
            <form action="updateLogo" id="updateLogo" class="formadmin" method="POST" enctype="multipart/form-data">
                <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">
   
                <div class="form-group">
                        <label for="input_image" class="font-weight-bold">Nuevo logo</label>
                        <input type="file" class="form-control-file" id="input_image" name="input_image">
                    </div>
                    <button type="submit" class="btn btn-secondary btn-block">Actualizar Logo</button>
            </form>
        </div>
    
    

















        {assign var="enviosData" value=$enviosData}
{assign var="precioFijoActivado" value=$enviosData.precioFijoActivado}
{assign var="precioEnvio" value=$enviosData.precioEnvio}
{assign var="costosEnvio" value=$enviosData.costosEnvio}

<div id="enviosPage" class="formadmin hideform">
    <h2 class="mb-5 text-center">Precios de envíos</h2>
    {if $shopInfo[0]->nombre_unico neq null}
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            Hemos detectado que ya tiene una ubicación configurada en su perfil. Para evitar conflictos en los cálculos de envío, recomendamos no modificar este apartado. Si decide hacerlo, le sugerimos seleccionar la opción "precio fijo" y establecer el valor en 0.
        </div>
        {/if}
    <hr>
    <div class="form-group">
        <div class="form-check d-flex align-items-center gap-2 mb-3">
            <input class="form-check-input mt-0" type="checkbox" id="precios-envios-togglePrecioEnvio" style="flex-shrink: 0;" {if $precioFijoActivado}checked{/if}>
            <label class="form-check-label fw-bold mb-0" for="precios-envios-togglePrecioEnvio">
                ¿Desea poner un precio fijo en los envíos?
            </label>
        </div>
        <div id="precios-envios-precioEnvioContainer" class="mt-4" style="{if $precioFijoActivado}display:block;{else}display:none;{/if}">
            <label for="precios-envios-precio_envio" class="fw-bold mb-2">Precio fijo de envío</label>
            <input class="form-control" id="precios-envios-precio_envio" name="precio_envio" type="text" placeholder="Ingrese el precio fijo" value="{$precioEnvio}">
        </div>
    </div>
    <small>Al tener habilitada esta opción TODOS tus pedidos tendrán este valor, para usar la tabla de costos desactiva esta opción</small>
    <hr>

    <script>
        document.getElementById('precios-envios-togglePrecioEnvio').addEventListener('change', function () {
            const container = document.getElementById('precios-envios-precioEnvioContainer');
            container.style.display = this.checked ? 'block' : 'none';
        });
    </script>

    <div class="mt-5">
        <h2 class="mb-4">Tabla de Costos de Envío</h2>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th scope="col">Rango de Peso (kg)</th>
                    <th scope="col">Costo de Envío (ARS)</th>
                    <th scope="col">Opciones</th>
                </tr>
            </thead>
            <tbody id="precios-envios-tabla-envio">
                {if $costosEnvio|@count > 0}
                    {foreach from=$costosEnvio item=envio key=idx}
                        <tr>
                            <td>
                                <span>{$envio.rangoPesoMin} - </span>
                                <input type="number" class="form-control d-inline w-auto" value="{$envio.rangoPesoMax}" min="{$envio.rangoPesoMin}" id="precios-envios-peso-min-{$idx+1}">
                            </td>
                            <td>
                                <input type="number" class="form-control" value="{$envio.costoEnvio}" id="precios-envios-costo-{$idx+1}">
                            </td>
                            <td>
                                <button class="btn btn-sm btn-danger" onclick="eliminarFila(this)">Eliminar</button>
                            </td>
                        </tr>
                    {/foreach}
                {else}
                    <!-- Fila inicial por defecto -->
                    <tr>
                        <td>
                            <span>1 - </span>
                            <input type="number" class="form-control d-inline w-auto" value="5" min="1" id="precios-envios-peso-min-1">
                        </td>
                        <td>
                            <input type="number" class="form-control" value="500" id="precios-envios-costo-1">
                        </td>
                        <td>
                            <button class="btn btn-sm btn-danger" onclick="eliminarFila(this)">Eliminar</button>
                        </td>
                    </tr>
                {/if}
            </tbody>
        </table>

        <button class="btn btn-primary" onclick="agregarFila()">Agregar fila</button>
    </div>
    <hr>
    <button id="precios-envios-GuardarLista" class="btn btn-secondary btn-block mt-4">Guardar Lista</button>

    <script>
        function eliminarFila(btn) {
            const fila = btn.closest('tr');
            fila.remove();
        }

        function agregarFila() {
            const tabla = document.getElementById('precios-envios-tabla-envio');
            const filas = tabla.getElementsByTagName('tr');
            const ultimaFila = filas[filas.length - 1];
            const ultimoInputMax = ultimaFila.querySelector('td input[type="number"]');
            const ultimoMax = parseInt(ultimoInputMax.value);

            const nuevoMin = ultimoMax + 1;
            const nuevoMax = nuevoMin + 4;

            // Crear nueva fila
            const nuevaFila = document.createElement('tr');

            // Columna rango
            const tdRango = document.createElement('td');
            const spanMin = document.createElement('span');
            spanMin.textContent = nuevoMin + ' - ';
            const inputMax = document.createElement('input');
            inputMax.type = 'number';
            inputMax.className = 'form-control d-inline w-auto';
            inputMax.value = nuevoMax;
            inputMax.min = nuevoMin;
            tdRango.appendChild(spanMin);
            tdRango.appendChild(inputMax);

            // Columna precio
            const tdPrecio = document.createElement('td');
            const inputPrecio = document.createElement('input');
            inputPrecio.type = 'number';
            inputPrecio.className = 'form-control';
            inputPrecio.value = 0;
            tdPrecio.appendChild(inputPrecio);

            // Columna opciones
            const tdOpciones = document.createElement('td');
            const btnEliminar = document.createElement('button');
            btnEliminar.className = 'btn btn-sm btn-danger';
            btnEliminar.textContent = 'Eliminar';
            btnEliminar.onclick = function () {
                eliminarFila(btnEliminar);
            };
            tdOpciones.appendChild(btnEliminar);

            // Agregar columnas a la fila
            nuevaFila.appendChild(tdRango);
            nuevaFila.appendChild(tdPrecio);
            nuevaFila.appendChild(tdOpciones);

            // Agregar fila a la tabla
            tabla.appendChild(nuevaFila);
        }

        // Evento para el botón de guardar lista
        document.querySelector('#precios-envios-GuardarLista').addEventListener('click', function (e) {
        e.preventDefault();

        const precioFijoActivado = document.getElementById('precios-envios-togglePrecioEnvio').checked;
        const precioEnvio = document.getElementById('precios-envios-precio_envio').value;
        const idTienda = document.getElementById('id_tienda').value;

        const tablaEnvio = document.getElementById('precios-envios-tabla-envio');
        const filas = tablaEnvio.getElementsByTagName('tr');
        const costosEnvio = [];

        for (let i = 0; i < filas.length; i++) {
            const celdas = filas[i].getElementsByTagName('td');

            const rangoMin = celdas[0].querySelector('span')?.textContent.replace(' - ', '') ?? '';
            const rangoMax = celdas[0].querySelector('input[type="number"]')?.value ?? '';
            const costoEnvio = celdas[1].querySelector('input')?.value ?? '';

            const rangoPeso = rangoMin + ' - ' + rangoMax;

            costosEnvio.push({
                rangoPeso: rangoPeso,
                costoEnvio: costoEnvio
            });
        }

        const datos = {
            id_tienda: idTienda,
            precioFijoActivado: precioFijoActivado,
            precioEnvio: precioEnvio,
            costosEnvio: costosEnvio
        };

        fetch('api/guardarlistaenvios', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(datos)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
            } else {
                alert("Error: " + data.message);
                console.error(data.error);
            }
        })
        .catch(error => {
            console.error('Error en la solicitud:', error);
            alert('Error al comunicarse con el servidor.');
        });
    });
</script>
</div>

        
































        <div id="addCat" class="formadmin hideform">
      
            <form action="addcategory"  method="POST" enctype="multipart/form-data">
                <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">

                <div class="container">
                    <h2 class="mb-5 text-center">Nueva Categoría</h2>
                    <div class="form-group">
                        <label for="nombre" class="font-weight-bold">Nombre de la categoría</label>
                        <input class="form-control" name="nombre" type="text" required placeholder="Ingrese el nombre de la categoría">
                    </div>
                    <div class="form-group">
                        <label for="descripcion" class="font-weight-bold">Descripción</label>
                        <input class="form-control" name="descripcion" type="text" required placeholder="Describa la categoría">
                    </div>
                    <div class="form-group">
                        <label for="input_image" class="font-weight-bold">Imagen de la Categoría</label>
                        <input type="file" class="form-control-file" id="input_image" name="input_image">
                    </div>
                    <button type="submit" class="btn btn-secondary btn-block">Agregar Categoría</button>
                </div>
            </form>
        </div>
    
    
    
    
    
            <form id="editcategory" class="formadmin hideform" onsubmit="return false;">
                <input hidden name="id_tienda" id="id_tienda_ec" value="{$shopInfo[0]->id_tienda}">
                <input hidden name="shopName" id="shopName_ec" value="{$shopInfo[0]->nombre_unico}">

                <div class="container">
                    <h2 class="mb-5 text-center">Editar Categoría</h2>
                    <div class="form-group">
                        <label for="admin-category-input" class="font-weight-bold">Buscar Categoría</label>
                        <input class="form-control" name="admin-category-input" id="admin-category-input" type="text" placeholder="Ingrese nombre de la categoría">
                    </div>
                    <button type="button" class="btn btn-secondary btn-block" onclick="getCategories()">Buscar</button>
                    <div id="productsresultcat" class="category-home-list mt-4 mb-0"></div>
                </div>
            </form> 
            
    
    
            
            {assign var="contactData" value=$shopInfo[0]->medios_de_contacto|json_decode:true}
            <form id="contact" class="formadmin hideform" action="updateContactInformation" method="POST">
                <input name="id_tienda" id="id_tienda" type="hidden" value="{$shopInfo[0]->id_tienda}">
            
                <div class="container">
                    <h2 class="mb-5 text-center">Contacto para tus clientes</h2>
                    <span class="mb-2">Esta es la información que tus clientes podrán saber sobre usted.</span>
            
                    <div class="form-group">
                        <label for="contact-phone" class="font-weight-bold">Teléfono</label>
                        <input class="form-control" name="contact-phone" id="contact-phone" type="text" placeholder="Ingrese su número de teléfono"
                            value="{$contactData.telefono|default:''}">
                    </div>
            
                    <div class="form-group">
                        <label for="contact-email" class="font-weight-bold">Correo Electrónico</label>
                        <input class="form-control" name="contact-email" id="contact-email" type="email" placeholder="Ingrese su correo electrónico"
                            value="{$contactData.email|default:''}">
                    </div>
            
                    <div class="form-group">
                        <label for="contact-facebook" class="font-weight-bold">Facebook</label>
                        <input class="form-control" name="contact-facebook" id="contact-facebook" type="text" placeholder="Link o nombre de usuario de Facebook"
                            value="{$contactData.facebook|default:''}">
                    </div>
            
                    <div class="form-group">
                        <label for="contact-instagram" class="font-weight-bold">Instagram</label>
                        <input class="form-control" name="contact-instagram" id="contact-instagram" type="text" placeholder="Link o usuario de Instagram"
                            value="{$contactData.instagram|default:''}">
                    </div>
            
                    <div class="form-group">
                        <label for="contact-whatsapp" class="font-weight-bold">WhatsApp</label>
                        <input class="form-control" name="contact-whatsapp" id="contact-whatsapp" type="text" placeholder="Número o link de WhatsApp"
                            value="{$contactData.whatsapp|default:''}">
                    </div>
            
                    <button type="submit" class="btn btn-secondary btn-block">Guardar información</button>
                </div>
            </form>
            
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('contact');
                
                    form.addEventListener('submit', function (e) {
                        e.preventDefault(); // Evita envío normal
                
                        const data = new FormData(form);
                
                        fetch('api/updateContactInformation', {
                            method: 'POST',
                            body: data
                        })
                        .then(res => res.json())
                        .then(response => {
                            if (response.status === 'ok') {
                                alert('Información de contacto guardada correctamente.');
                            } else {
                                alert('Hubo un error al guardar los datos.');
                            }
                        })
                        .catch(error => {
                            console.error('Error en la solicitud:', error);
                            alert('Ocurrió un error inesperado.');
                        });
                    });
                });
                </script>
                
    
    
    
            <form id="editproduct" class="formadmin hideform" onsubmit="return false;">
                <input  name="id_tienda" id="id_tienda" type="hidden" value="{$shopInfo[0]->id_tienda}">
                <input  name="shopNameEP" id="shopNameEP" type="hidden" value="{$shopInfo[0]->nombre_unico}">

                <div class="container ">
                    <h2 class="mb-5 text-center">Editar Producto</h2>
                    <div class="form-group">
                        <label for="admin-product-input" class="font-weight-bold">Buscar Producto</label>
                        <input class="form-control" name="admin-product-input" id="admin-product-input" type="text" placeholder="Ingrese el nombre del producto">
                    </div>
                    <button type="button" class="btn btn-secondary btn-block" onclick="getProducts()">Buscar</button>
                    <div id="productsresult" class="mt-4 mb-0"></div>
                    <div id="pagination"></div>
                </div>
            </form>
            
    
    
            <table id="stockcontrol" class="table table-hover hideform">
                <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Marca</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Fabricante</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$products item=producto}
                    <tr onclick="window.location.href='product/{$producto->id_producto}'" style="cursor:pointer;">
                        <td><img src="{$producto->imagenes}" alt="Imagen del producto" style="width:100px; height:100px;"></td>
                        <td>{$producto->nombre}</td>
                        <td>{$producto->marca}</td>
                        <td>{$producto->descripcion|truncate:50:"...":true}</td>
                        <td>${$producto->precio}</td>
                        <td>{$producto->stock}</td>
                        <td>{$producto->fabricante}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
    
    
            <div id="banner" class="formadmin hideform">
                <div class="container ">
                    <h2 class="mb-5 text-center">Control de imágenes para el banner</h2>
                    <div class="banner-row">
                        {foreach from=$bannerimages item=imagen}
                        <div class="banner-col" id="banner-col-{$imagen->id_imagen}">
                            <div class="banner-card">
                                <img src="{$imagen->imagen}" class="banner-card-img" alt="Imagen">
                                <div class="banner-card-body">
                                    <h5 class="banner-card-title">{$imagen->texto1}</h5>
                                    <p class="banner-card-text">{$imagen->texto2}</p>
                                    <div class="banner-card-actions">
                                        <!-- Eliminar -->
                                        <button data-bs-toggle="modal" data-bs-target="#deleteModal{$imagen->id_imagen}">
                                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M3 6h18"></path>
                                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                            </svg>
                                        </button>

                                    </div>
                                </div>
                            </div>
                        </div>
            
                        <!-- Modal para eliminar -->
                        <div class="modal fade" id="deleteModal{$imagen->id_imagen}" tabindex="-1" aria-labelledby="deleteModalLabel{$imagen->id_imagen}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        ¿Estás seguro de que quieres eliminar esta imagen?
                                    </div>
                                    <div class="modal-footer">
                                        <form action="deletebanner" method="POST" class="d-flex justify-content-between w-100">
                                            <input type="hidden" name="imagen_id" value="{$imagen->id}">
                                            <button type="button" class="btn btn-secondary mr-2" style="width: fit-content;" data-bs-dismiss="modal">Cancelar</button>
                                            <button type="button" class="btn btn-danger ml-2" style="width: fit-content;" data-bs-dismiss="modal" data-imagen-id="{$imagen->id_imagen}" onclick="deleteBanner(this)">Eliminar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/foreach}
                        <!-- Card to add a new image -->
                        <div class="banner-col">
                            <div class="banner-card">
                                <form action="addbanner" method="POST" enctype="multipart/form-data">
                                    <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">

                                    <div class="banner-card-body">
                                        <div class="banner-form-group">
                                            <label for="input_image">Nueva imagen:</label>
                                            <small>Resolucion recomendada: 1500px x 300px</small>
                                            <input type="file" id="input_image" name="input_image">
                                        </div>
                                        <div class="banner-form-group">
                                            <label for="texto1">Texto 1:</label>
                                            <input type="text" id="texto1" name="texto1">
                                        </div>
                                        <div class="banner-form-group">
                                            <label for="texto2">Texto 2:</label>
                                            <input type="text" id="texto2" name="texto2">
                                        </div>
                                        <button type="submit" class="banner-submit-button">Agregar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            
            
            
    
    
        </div>
    </div>
    
</div>

{include file="adminfooter.tpl"}
