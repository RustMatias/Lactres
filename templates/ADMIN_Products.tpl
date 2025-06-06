{include file="header-admin.tpl"}
<div class="container-fluid mt-3 ">
{include file="ADMIN_sidenav_mobile.tpl"}
<div class="row">
{include file="ADMIN_sidenav.tpl"}
<div class="col-md-11">
   <div class="gp-container">
      <form method="get" action="admin/stock" class="form-as-form">
         <div class="form-as-group">
            <label for="search" class="form-as-label">Buscar productos</label>
            <input type="text" name="search" id="search" class="form-as-input" value="{$search|default:''}">
         </div>
         {if $smarty.session.GRUPO == "C"}  
         <div class="form-as-group">
            <label for="categoria" class="form-as-label">Categoría</label>
            <select name="categoria" id="categoria" class="form-as-select">
               <option value="">Todas las categorías</option>
               {foreach from=$categorias item=categoria}
               <option value="{$categoria->id_categoria}" {if $categoria->id_categoria == $categoriaSelected}selected{/if}>
                  {$categoria->nombre}
               </option>
               {/foreach}
            </select>
         </div>
         <div class="form-as-group">
            <label for="priceOrder" class="form-as-label">Ordenar por precio</label>
            <select name="priceOrder" id="priceOrder" class="form-as-select">
               <option value="">Seleccionar</option>
               <option value="asc" {if $priceOrder == 'asc'}selected{/if}>Menor precio</option>
               <option value="desc" {if $priceOrder == 'desc'}selected{/if}>Mayor precio</option>
            </select>
         </div>
         <div class="form-as-group">
            <label for="stockOrder" class="form-as-label">Ordenar por stock</label>
            <select name="stockOrder" id="stockOrder" class="form-as-select">
               <option value="">Seleccionar</option>
               <option value="asc" {if $stockOrder == 'asc'}selected{/if}>Menor stock</option>
               <option value="desc" {if $stockOrder == 'desc'}selected{/if}>Mayor stock</option>
            </select>
         </div>
         {/if}  
         <button type="submit" class="form-as-button">Filtrar</button>
      </form>
      <table class="table table-hover admin_table_pedidos">
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
         <tbody class="astock-tbody">
            {foreach from=$products item=producto}
            <tr id="row-producto-{$producto->id_producto}">
               {assign var="imagenesArray" value=","|explode:$producto->imagenes}
               <td><img src="{$imagenesArray[0]}" alt="Imagen del producto" style=""></td>
               <td>{$producto->nombre}</td>
               <td>{$producto->marca}</td>
               <td>{$producto->descripcion|truncate:50:"...":true}</td>
               <td>${$producto->precio}</td>
               <td>{$producto->stock}</td>
               <td>{$producto->fabricante}</td>
               <td>
                  <a class="as-action-button" href="{$shopInfo[0]->nombre_unico}/edit/{$producto->id_producto}">
                  Editar
                  </a>
                  <button class="as-action-button" data-bs-toggle="modal" data-bs-target="#deleteModal{$producto->id_producto}">
                  Borrar
                  </button>
               </td>
            </tr>
            <div class="modal fade" id="deleteModal{$producto->id_producto}" tabindex="-1" aria-labelledby="deleteModalLabel{$producto->id_producto}" aria-hidden="true">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel{$producto->id_producto}">Confirmar Eliminación</h5>
                     </div>
                     <div class="modal-body">
                        ¿Estás seguro de que deseas eliminar el producto <strong>{$producto->nombre}</strong>?
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="deleteproduct/{$producto->id_producto}">Eliminar</a>
                     </div>
                  </div>
               </div>
            </div>
            {/foreach}
         </tbody>
      </table>
      <!-- Paginación -->
      <nav aria-label="Page navigation">
         <ul class="pagination">
            {if $currentPage > 1}
            <li class="page-item">
               <a class="page-link" href="admin/stock?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$currentPage-1}">Anterior</a>
            </li>
            {/if}
            {* Botón para la primera página si está fuera del rango *}
            {if $startPage > 1}
            <li class="page-item">
               <a class="page-link" href="admin/stock?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page=1">1</a>
            </li>
            {if $startPage > 2}
            <li class="page-item disabled"><span class="page-link">...</span></li>
            {/if}
            {/if}
            {* Mostrar rango de páginas *}
            {section name=page start=$startPage loop=$endPage+1}
            <li class="page-item {if $currentPage == $smarty.section.page.index}active{/if}">
               <a class="page-link" href="admin/stock?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$smarty.section.page.index}">{$smarty.section.page.index}</a>
            </li>
            {/section}
            {* Botón para la última página si está fuera del rango *}
            {if $endPage < $totalPages}
            {if $endPage < $totalPages - 1}
            <li class="page-item disabled"><span class="page-link">...</span></li>
            {/if}
            <li class="page-item">
               <a class="page-link" href="admin/stock?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$totalPages}">{$totalPages}</a>
            </li>
            {/if}
            {if $currentPage < $totalPages}
            <li class="page-item">
               <a class="page-link" href="admin/stock?search={$search}&categoria={$categoriaSelected}&priceOrder={$priceOrder}&stockOrder={$stockOrder}&page={$currentPage+1}">Siguiente</a>
            </li>
            {/if}
         </ul>
      </nav>
   </div>
</div>
</script>
<script type="text/javascript " src="js/admin.js"></script>
{include file="adminfooter.tpl"}