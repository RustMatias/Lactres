<div class="content-stats">
   <div class="activities">
      <div class="dashboard-inventory-header">
         <h1>Categorias</h1>
         <a href="dashboard/add_category/{$smarty.session.ID_USER}">
            <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M0 12C0 5.373 5.373 0 12 0s12 5.373 12 12-5.373 12-12 12S0 18.627 0 12Zm11.2 5.6v-4.8H6.4v-1.6h4.8V6.4h1.6v4.8h4.8v1.6h-4.8v4.8h-1.6Z" clip-rule="evenodd"></path>
             </svg>
            Agregar categoria</a>
      </div>
     
      <body>

      <table class="categories-table">
  <thead>
    <tr>
      <th>Nombre</th>
      <th>Descripción</th>
      <th>Imagen</th>
      <th>Acciones</th>
    </tr>
  </thead>
  <tbody>
  {foreach from=$categories item=category}
    <tr>
      <td data-label="Nombre">{$category->nombre|escape}</td>
      <td data-label="Descripción">{$category->descripcion|escape}</td>
      <td data-label="Imagen">
        <img src="{$category->imagen|escape}" alt="{$category->nombre|escape}" class="category-img" />
      </td>
      <td data-label="Acciones">
        <a href="{$shopInfo[0]->nombre_unico}/editcategory/{$category->id_categoria}" class="btn-editar">Editar</a>
        <a href="#" class="btn-eliminar" data-id="{$category->id_categoria}">Eliminar</a>

        <!-- Modal -->
        <div id="modal-confirm-delete" class="modal-delete-overlay">
          <div class="modal-delete-content">
            <h3>¿Estás seguro que deseas eliminar esta categoría?</h3>
            <div class="modal-delete-actions">
              <button id="confirm-delete-btn" class="btn-confirm">Sí, eliminar</button>
              <button id="cancel-delete-btn" class="btn-cancel">Cancelar</button>
            </div>
          </div>
        </div>
      </td>
    </tr>
  {/foreach}
</tbody>

</table>

    

      

      </body>
      </html>


      <script>
      let categoryToDeleteId = null;
    
      document.querySelectorAll('.btn-eliminar').forEach(btn => {
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          categoryToDeleteId = this.getAttribute('data-id');
          document.getElementById('modal-confirm-delete').style.display = 'flex';
        });
      });
    
      document.getElementById('cancel-delete-btn').addEventListener('click', function () {
        categoryToDeleteId = null;
        document.getElementById('modal-confirm-delete').style.display = 'none';
      });
    
      document.getElementById('confirm-delete-btn').addEventListener('click', function () {
        if (categoryToDeleteId) {
          window.location.href = 'deleteCategory/' + categoryToDeleteId;
        }
      });
    </script>
    