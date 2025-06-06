<div class="content-stats">
   <div class="activities">
      <h1>Agregar neuva categoria</h1>
      <body>
      <form action="addcategory" id="addcategory" class="dashboard-add-category-form hideform" method="POST" enctype="multipart/form-data">
      <input hidden name="id_tienda" value="{$shopInfo[0]->id_tienda}">
    
      <div class="dashboard-add-category-container">
    
        <div class="dashboard-add-category-group">
          <label for="nombre" class="dashboard-add-category-label">Nombre de la categoría</label>
          <input name="nombre" type="text" required placeholder="Ingrese el nombre de la categoría" class="dashboard-add-category-input">
        </div>
    
        <div class="dashboard-add-category-group">
          <label for="descripcion" class="dashboard-add-category-label">Descripción</label>
          <input name="descripcion" type="text" required placeholder="Describa la categoría" class="dashboard-add-category-input">
        </div>
    
        <div class="dashboard-add-category-group">
          <label for="input_image" class="dashboard-add-category-label">Imagen de la Categoría</label>
          <input type="file" id="input_image" name="input_image" class="dashboard-add-category-file">
        </div>
      </div>
      <button type="submit" class="btn-enviar">Agregar Categoría</button>

    </form>
    
      </body>
      </html>
 
      </html>
   </div>
</div>