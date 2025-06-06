{include file="header-admin.tpl"}
<div class="container mt-3 mb-3">
   <div class="general-edit-product-container">
      <form action="editproduct" method="POST" enctype="multipart/form-data">
         <input hidden name="id" id="producto_id"value="{$product->id_producto}" type="text">
         <input hidden name="shopName" value="{$shopName}" type="text">           
         <div class="general-edit-product-content">
            <!-- Sección de imágenes a la izquierda -->
           <!-- Sección de imágenes a la izquierda -->
            <div class="general-edit-product-images">
            {assign var="imagenes" value=","|explode:$product->imagenes}

            {foreach from=$imagenes item=imagen key=index}
                {if $imagen neq ""}
                    <div class="general-edit-product-image-container" onmouseover="showDeleteButton({$index})" onmouseout="hideDeleteButton({$index})">
                        <img class="general-edit-product-img" src="{$imagen}" alt="Imagen del producto">
                        <button type="button" class="general-edit-product-delete-button" id="delete-btn-{$index}" 
                                onclick="confirmarEliminarImagen({$index}, event)">
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 6h18"></path>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                <path d="M10 11v6"></path>
                                <path d="M14 11v6"></path>
                            </svg>
                        </button>
                    </div>
                {/if}
            {/foreach}

            <!-- AQUÍ INSERTA EL NUEVO BLOQUE -->
            <!-- BLOQUE PARA SUBIR IMÁGENES -->
            {if $smarty.session.GRUPO == "C"}
               <input type="file" id="input_image" name="input_image[]" multiple accept="image/*">
               <small class="form-text text-muted">Puedes subir hasta 5 imágenes.</small>
            {else}
               <input type="file" id="input_image" name="input_image" accept="image/*">
               <small class="form-text text-muted">Solo puedes subir una imagen.</small>
            {/if}

            </div>

            <!-- Sección de detalles a la derecha -->
            <div class="general-edit-product-details">
               <h2 class="general-edit-product-title">
                  <textarea class="general-edit-product-textarea" name="nombre" id="nombre">{$product->nombre}</textarea>
               </h2>
               <div class="general-edit-product-price">
                  Precio<input class="general-edit-product-input" name="precio" value="{$product->precio}" type="text">
               </div>
               {if $smarty.session.GRUPO =="C"}  
               <table class="general-edit-product-table">
                  <tr>
                     <td>Fabricante:</td>
                     <td><input class="general-edit-product-input" name="fabricante" value="{$product->fabricante}" type="text"></td>
                  </tr>
                  <tr>
                     <td>Marca:</td>
                     <td><input class="general-edit-product-input" name="marca" value="{$product->marca}" type="text"></td>
                  </tr>
                  

                  <tr>
                     <td>Categoría:</td>
                     <td>
                        <select class="general-edit-product-input" name="categoria">
                           {foreach from=$categories item=cat}
                           <option value="{$cat->id_categoria}" {if $cat->id_categoria == $product->id_categoria}selected{/if}>
                              {$cat->nombre}
                           </option>
                           {/foreach}
                        </select>
                     </td>
                     {/if}
                  </tr>

                  <tr>
                  <td>Stock:</td>
                  <td>
                     <input class="general-edit-product-input" name="stock" value="{$product->stock}" type="text" id="stockInput">
                     <label>
                        <input type="checkbox" id="unlimitedStock" name="unlimitedStock" value="1" onchange="toggleStock()" 
                           {if $product->sin_limite == 1} checked {/if}>
                        Sin límite
                     </label>
                  </td>
               </tr>
               
               <tr>
                  <td>Peso (kg):</td>
                  <td><input class="general-edit-product-input" name="peso" value="{$product->peso}" type="text"></td>
               </tr>
               {assign var="dims" value=$product->dimensiones|json_decode:true}
               <tr>
                  <td>Alto (cm):</td>
                  <td><input class="general-edit-product-input" name="alto" value="{$dims.alto}" type="text"></td>
               </tr>
               <tr>
                  <td>Ancho (cm):</td>
                  <td><input class="general-edit-product-input" name="ancho" value="{$dims.ancho}" type="text"></td>
               </tr>
               <tr>
                  <td>Largo (cm):</td>
                  <td><input class="general-edit-product-input" name="largo" value="{$dims.largo}" type="text"></td>
               </tr>

               
               <script>
                  function toggleStock() {
                  const stockInput = document.getElementById('stockInput');
                  const unlimitedStock = document.getElementById('unlimitedStock');

                  if (unlimitedStock.checked) {
                     stockInput.value = 'Sin límite';
                     stockInput.disabled = true;
                  } else {
                     if (stockInput.value === 'Sin límite') {
                        stockInput.value = "{$product->stock}"; // Restaura el valor original
                     }
                     stockInput.disabled = false;
                  }
               }

               document.addEventListener("DOMContentLoaded", function() {
                  toggleStock();
               });

               </script>
               
               </table>
               <div class="general-edit-product-description">
                  <h3>Descripción</h3>
                  <textarea class="general-edit-product-textarea" name="descripcion" id="descripcion">{$product->descripcion}</textarea>
               </div>
               <button class="general-edit-product-button">
                  Finalizar y guardar
                  <svg width="26" height="26" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M17.203 6.684a.88.88 0 0 1 1.256 0 .907.907 0 0 1 .012 1.26l-7.095 8.388a.878.878 0 0 1-1.278.024L5.78 11.98a.908.908 0 0 1 .288-1.468.88.88 0 0 1 .969.196l3.662 3.711 6.48-7.71a.306.306 0 0 1 .024-.026Z"></path>
                  </svg>
               </button>
            </div>
         </div>
      </form>
   </div>
</div>
<!-- Modal de Confirmación -->
<div id="general-edit-product-modal" class="general-edit-product-modal">
   <div class="general-edit-product-modal-content">
      <p>¿Estás seguro de que quieres eliminar esta imagen?</p>
      <small>Se regargara la pagina, recomandamos guardar sus cambios antes de realizar esta accion</small>
      <button class="general-edit-product-modal-btn general-edit-product-modal-confirm" onclick="eliminarImagenProducto()">Sí, eliminar</button>
      <button class="general-edit-product-modal-btn general-edit-product-modal-cancel" onclick="cerrarModal()">Cancelar</button>
   </div>
</div>
<script>
   function confirmarEliminarImagen(index, event) {
       event.preventDefault(); // Evita el envío del formulario
       imagenIndexAEliminar = index;
       document.getElementById('general-edit-product-modal').style.display = 'flex'; // Mostrar modal centrado
   }
   
   
   
   function cerrarModal() {
       location.window.reload()
       document.getElementById('general-edit-product-modal').style.display = 'none';
   }
   
   function showDeleteButton(index) {
       document.getElementById('delete-btn-' + index).style.display = 'block';
   }
   
   function hideDeleteButton(index) {
       document.getElementById('delete-btn-' + index).style.display = 'none';
   }
   
   window.onload = function() {
       
       document.getElementById('general-edit-product-modal').style.display = 'none';
   }
   
   
   
   
   
   //PARA IMAGENES NUEVAS
   
   // Obtener el contenedor de previsualizaciones
   const inputImageElement = document.getElementById('input_image');
   const imagePreviewsContainer = document.getElementById('image-previews');
   
   // Aquí se guardarán las imágenes cargadas actualmente
   let loadedImages = []; // Esto debería contener las imágenes que ya están cargadas
   
   // Función para manejar la previsualización y el límite de imágenes
   inputImageElement.addEventListener('change', function(event) {
       const files = event.target.files;
   
       // Verificar el número de imágenes ya cargadas
       const totalImages = loadedImages.length + files.length;
       if (totalImages > 5) {
           alert('No puedes cargar más de 5 imágenes.');
           return;
       }
   
       // Limpiar las previsualizaciones anteriores
       imagePreviewsContainer.innerHTML = '';
   
       // Mostrar las previsualizaciones de las nuevas imágenes
       for (let i = 0; i < files.length; i++) {
           const file = files[i];
           
           // Crear un elemento de previsualización
           const previewContainer = document.createElement('div');
           previewContainer.classList.add('image-preview');
           
           const imgElement = document.createElement('img');
           imgElement.classList.add('preview-image');
           imgElement.src = URL.createObjectURL(file);
           previewContainer.appendChild(imgElement);
   
           imagePreviewsContainer.appendChild(previewContainer);
       }
   });
   
   // Esto actualizaría las imágenes cargadas visualmente, por ejemplo, cuando se carga una imagen
   function actualizarImagenesCargadas(imagenes) {
       loadedImages = imagenes;
       // Aquí podrías agregar código para mostrar las imágenes cargadas, por ejemplo, en la misma sección de previsualización
       imagePreviewsContainer.innerHTML = ''; // Limpiar el contenedor antes de agregar las previsualizaciones
   
       imagenes.forEach(imagen => {
           const previewContainer = document.createElement('div');
           previewContainer.classList.add('image-preview');
           
           const imgElement = document.createElement('img');
           imgElement.classList.add('preview-image');
           imgElement.src = imagen; // El src de la imagen cargada
           previewContainer.appendChild(imgElement);
   
           imagePreviewsContainer.appendChild(previewContainer);
       });
   }
   
</script>
<script src="./js/admin.js"></script>
{include file="adminfooter.tpl"}