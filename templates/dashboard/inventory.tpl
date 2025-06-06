<div class="content-stats">
   <div class="activities">
      <div class="dashboard-inventory-header">
         <h1>Productos y servicios</h1>
         <a href="dashboard/add_product/{$smarty.session.ID_USER}">
            <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M0 12C0 5.373 5.373 0 12 0s12 5.373 12 12-5.373 12-12 12S0 18.627 0 12Zm11.2 5.6v-4.8H6.4v-1.6h4.8V6.4h1.6v4.8h4.8v1.6h-4.8v4.8h-1.6Z" clip-rule="evenodd"></path>
             </svg>
            Agregar producto</a>
      </div>
     
      <body>
<!-- FORMULARIO -->
<form method="get" action="dashboard/inventory/{$smarty.session.ID_USER}" class="dashboard-inventory-form">
  <div class="dashboard-inventory-form-group">
    <label for="search" class="dashboard-inventory-form-label">Buscar productos</label>
    <input type="text" name="search" id="search" class="dashboard-inventory-form-input" value="{$search|default:''}">
  </div>

  {if $smarty.session.GRUPO == "C"}
    <div class="dashboard-inventory-form-group">
      <label for="categoria" class="dashboard-inventory-form-label">Categoría</label>
      <select name="categoria" id="categoria" class="dashboard-inventory-form-select">
        <option value="">Todas las categorías</option>
        {foreach from=$categorias item=categoria}
          <option value="{$categoria->id_categoria}" {if $categoria->id_categoria == $categoriaSelected}selected{/if}>
            {$categoria->nombre}
          </option>
        {/foreach}
      </select>
    </div>

    <div class="dashboard-inventory-form-group">
      <label for="priceOrder" class="dashboard-inventory-form-label">Ordenar por precio</label>
      <select name="priceOrder" id="priceOrder" class="dashboard-inventory-form-select">
        <option value="">Seleccionar</option>
        <option value="asc" {if $priceOrder == 'asc'}selected{/if}>Menor precio</option>
        <option value="desc" {if $priceOrder == 'desc'}selected{/if}>Mayor precio</option>
      </select>
    </div>

    <div class="dashboard-inventory-form-group">
      <label for="stockOrder" class="dashboard-inventory-form-label">Ordenar por stock</label>
      <select name="stockOrder" id="stockOrder" class="dashboard-inventory-form-select">
        <option value="">Seleccionar</option>
        <option value="asc" {if $stockOrder == 'asc'}selected{/if}>Menor stock</option>
        <option value="desc" {if $stockOrder == 'desc'}selected{/if}>Mayor stock</option>
      </select>
    </div>
  {/if}

  <button type="submit" class="dashboard-inventory-form-button">Filtrar</button>
</form>

<!-- TABLA -->
<table class="dashboard-inventory-table">
  <thead>
    <tr>
      <th>Imagen</th>
      <th>Nombre</th>
      <th>Marca</th>
      <th>Descripción</th>
      <th>Precio</th>
      <th>Stock</th>
      <th>Fabricante</th>
      <th>Acciones</th>
    </tr>
  </thead>
  <tbody>
    {foreach from=$products item=producto}
      {assign var="imagenesArray" value=","|explode:$producto->imagenes}
      <tr id="row-producto-{$producto->id_producto}">
        <td><img src="{$imagenesArray[0]}" alt="Imagen del producto" class="dashboard-inventory-thumbnail"></td>
        <td>{$producto->nombre}</td>
        <td>{$producto->marca}</td>
        <td>{$producto->descripcion|truncate:50:"...":true}</td>
        <td>${$producto->precio}</td>
        <td>{$producto->stock}</td>
        <td>{$producto->fabricante}</td>
        <td>
          <a class="dashboard-inventory-action-button" href="{$shopInfo[0]->nombre_unico}/edit/{$producto->id_producto}">Editar</a>
          <button class="dashboard-inventory-action-button" data-modal-target="modal-{$producto->id_producto}">Borrar</button>
        </td>
      </tr>

      <!-- MODAL -->
      <div class="dashboard-inventory-modal-overlay" id="modal-{$producto->id_producto}">
        <div class="dashboard-inventory-modal-content">
          <div class="dashboard-inventory-modal-header">Confirmar Eliminación</div>
          <div class="dashboard-inventory-modal-body">
            ¿Estás seguro de que deseas eliminar el producto <strong>{$producto->nombre}</strong>?
          </div>
          <div class="dashboard-inventory-modal-footer">
            <button class="dashboard-inventory-btn-cancel">Cancelar</button>
            <a class="dashboard-inventory-btn-delete" href="deleteproduct/{$producto->id_producto}">Eliminar</a>
          </div>
        </div>
      </div>
    {/foreach}
  </tbody>
</table>

<!-- PAGINACIÓN -->
<nav aria-label="Page navigation" class="dashboard-inventory-pagination">
  <ul class="pagination">
    {if $currentPage > 1}
      <li class="page-item">
        <a class="page-link" href="dashboard/inventory/{$smarty.session.ID_USER}?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$currentPage-1}">Anterior</a>
      </li>
    {/if}

    {if $startPage > 1}
      <li class="page-item">
        <a class="page-link" href="dashboard/inventory/{$smarty.session.ID_USER}?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page=1">1</a>
      </li>
      {if $startPage > 2}
        <li class="page-item disabled"><span class="page-link">...</span></li>
      {/if}
    {/if}

    {section name=page start=$startPage loop=$endPage+1}
      <li class="page-item {if $currentPage == $smarty.section.page.index}active{/if}">
        <a class="page-link" href="dashboard/inventory/{$smarty.session.ID_USER}?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$smarty.section.page.index}">{$smarty.section.page.index}</a>
      </li>
    {/section}

    {if $endPage < $totalPages}
      {if $endPage < $totalPages - 1}
        <li class="page-item disabled"><span class="page-link">...</span></li>
      {/if}
      <li class="page-item">
        <a class="page-link" href="dashboard/inventory/{$smarty.session.ID_USER}?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$totalPages}">{$totalPages}</a>
      </li>
    {/if}

    {if $currentPage < $totalPages}
      <li class="page-item">
        <a class="page-link" href="dashboard/inventory/{$smarty.session.ID_USER}?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$currentPage+1}">Siguiente</a>
      </li>
    {/if}
  </ul>
</nav>

<!-- SCRIPT MODAL -->
<script>
  document.querySelectorAll('.dashboard-inventory-action-button[data-modal-target]').forEach(button => {
    button.addEventListener('click', () => {
      const modalId = button.dataset.modalTarget;
      document.getElementById(modalId).classList.add('active');
    });
  });

  document.querySelectorAll('.dashboard-inventory-btn-cancel').forEach(button => {
    button.addEventListener('click', () => {
      button.closest('.dashboard-inventory-modal-overlay').classList.remove('active');
    });
  });
</script>

      </body>
      </html>


