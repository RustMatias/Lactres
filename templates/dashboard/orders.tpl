<div class="content-stats">
   <div class="activities">
      <h1>Pedidos</h1>

      <body>
        
      













      <div class="dashboard-orders-wrapper">
{*       <div class="dashboard-orders-stats">
        <div class="dashboard-orders-stat-item">
          <small>Realizados: {$estadisticas[1]}</small>
        </div>
        <div class="dashboard-orders-stat-item">
          <small>Confirmados: {$estadisticas[2]}</small>
        </div>
        <div class="dashboard-orders-stat-item">
          <small>Preparados: {$estadisticas[3]}</small>
        </div>
        <div class="dashboard-orders-stat-item">
          <small>Enviados: {$estadisticas[4]}</small>
        </div>
        <div class="dashboard-orders-stat-item">
          <small>Entregados: {$estadisticas[5]}</small>
        </div>
      </div> *}
    
      <div class="dashboard-orders-container">
    
        <form method="GET" action="dashboard/orders/{$smarty.session.ID_USER}" class="dashboard-orders-filters">
          <input type="text" name="search" placeholder="Nombre o código" class="dashboard-orders-input" value="{$search}">
          
          {if $smarty.session.GRUPO == "C"}  
            <select name="estado" class="dashboard-orders-select">
              <option value="">Todos los estados</option>
              {foreach from=$estadoNombres item=estadoValue key=estadoKey}
                <option value="{$estadoKey}" {if $estadoKey == $currentEstado}selected{/if}>{$estadoValue}</option>
              {/foreach}
            </select>
          {/if}
          
          <button type="submit" class="dashboard-orders-button">Filtrar</button>
        </form>
    
        <table class="dashboard-orders-table">
          <thead>
            <tr>
              <th>Código de Compra</th>
              <th>Fecha</th>
              <th>Estado</th>
              <th>Cantidad de Productos</th>
              <th>Monto Total</th>
              <th>Nombre Usuario</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$pedidos item=pedido}
            <tr>
              <td>{$pedido->codigo_compra}</td>
              <td>{$pedido->fecha}</td>
              <td>{$estadoNombres[$pedido->estado]}</td>
              <td>
                {if $pedido->productos}
                  {assign var="productos" value=$pedido->productos|@json_decode:true}
                  {if $productos && $productos|@count > 0}
                    {assign var="cantidadProductos" value=0}
                    {foreach from=$productos item=producto}
                      {assign var="cantidadProductos" value=$cantidadProductos + $producto[1]|@intval}
                    {/foreach}
                    {$cantidadProductos}
                  {else}
                    0
                  {/if}
                {else}
                  0
                {/if}
              </td>
              <td>
                {if isset($pedido->total_monto) && $pedido->total_monto}
                  ${$pedido->total_monto|number_format:2}
                {else}
                  $0.00
                {/if}
              </td>
              <td>{$pedido->usuario}</td>
              <td>
                <a href="dashboard/manage_orders/{$smarty.session.ID_USER}/{$pedido->id_compra}" class="dashboard-orders-manage-btn">Gestionar</a>
              </td>
            </tr>
            {/foreach}
          </tbody>
        </table>
    
        <div class="dashboard-orders-pagination">
          {if $currentPage > 1}
            <a class="dashboard-orders-page-btn" href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$currentPage-1}">Anterior</a>
          {/if}
    
          {section name=page loop=$totalPages}
            <a class="dashboard-orders-page-btn {if $smarty.section.page.index+1 == $currentPage}active{/if}" 
               href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$smarty.section.page.index+1}">
              {$smarty.section.page.index+1}
            </a>
          {/section}
    
          {if $currentPage < $totalPages}
            <a class="dashboard-orders-page-btn" href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$currentPage+1}">Siguiente</a>
          {/if}
        </div>
      </div>
    </div>
    
















      
      </body>
      </html>
   
      </html>
   </div>
</div>