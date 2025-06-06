<div class="content-stats">
<div class="activities">
   <h1>Agregar producto o servicio </h1>
   <body>
   {if $limitProducto}
    <form action="addproduct" id="addproduct" class="form-producto" method="POST" enctype="multipart/form-data">
      <input name="id_tienda" type="hidden" value="{$shopInfo[0]->id_tienda}">
      <input name="shopName" type="hidden" value="{$shopInfo[0]->nombre_unico}">
    
      <div class="form-grid">
        <div class="form-col">
          <label>Nombre</label>
          <input name="nombre" type="text" required placeholder="Ingrese el nombre del producto">
    
          <label>Descripción</label>
          <input name="descripcion" type="text" required placeholder="Describa el producto">
    
          <label>Precio</label>
          <input name="precio" type="text" required placeholder="Establezca el precio">
        </div>
    
        <div class="form-col">
          {if $smarty.session.GRUPO == "C"}
          <label>Marca</label>
          <input name="marca" type="text" placeholder="Marca del producto">
          {/if}
    
          <label>Stock</label>
          <div class="form-stock">
            <input name="stock" type="number" placeholder="Cantidad disponible" id="stockInput">
            <label class="checkbox-container">
              <input type="checkbox" id="unlimitedStock" name="unlimitedStock" value="1">
              <span>Sin límite</span>
            </label>
          </div>
    
          {if $smarty.session.GRUPO == "C"}
          <label>Fabricante</label>
          <input name="fabricante" type="text" placeholder="Nombre del fabricante">
          {/if}
        </div>
      </div>
    
      {if $smarty.session.GRUPO =="C"}
      <label>Categoría</label>
      <select name="categoria" id="categoria">
        <option value="0">Sin categoria</option>
        {if $categories|@count > 0}
          {foreach from=$categories item=category}
            <option value="{$category->id_categoria}">{$category->nombre}</option>
          {/foreach}
        {else}
          <option disabled="disabled">Debe crear una categoría</option>
        {/if}
      </select>
      <a href="dashboard/add_category/{$smarty.session.ID_USER}" class="form-hint">Crear categorías</a>
      {/if}
    
      <hr>
    
      <label>Peso</label>
      <input name="peso" type="text" required placeholder="Peso del producto">
    
      <div class="form-dimensiones">
        <div>
          <label>Alto</label>
          <input name="alto" type="text" required placeholder="Alto (cm)">
        </div>
        <div>
          <label>Ancho</label>
          <input name="ancho" type="text" required placeholder="Ancho (cm)">
        </div>
        <div>
          <label>Largo</label>
          <input name="largo" type="text" required placeholder="Largo (cm)">
        </div>
      </div>
    
      <hr>
    
      {if $smarty.session.GRUPO == "C"}
      <label>Imágenes del Producto</label>
      <input type="file" id="input_image" name="input_image[]" multiple accept="image/*" required>
      <small class="form-hint">Máximo 5 imágenes</small>
      {else}
      <label>Imagen del Producto</label>
      <input type="file" id="input_image" name="input_image" accept="image/*" required>
      <small class="form-hint">Solo se permite 1 imagen</small>
      {/if}
    
      <div id="image-preview" class="preview-imagenes"></div>
    
      <button type="submit" class="btn-enviar">Agregar producto</button>
    </form>
    {else}
    <div class="form-limite">
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
   </body>
   </html>
   </html>
   </div>
</div>