<div class="content-stats">
   <div class="activities">
      <h1>Información del Pedido</h1>

      <body>
        
      




      <div class="dashboard-manage-order-container">

      <input type="hidden" id="id_compra" value="{$pedido->id_compra}">
    
      <table class="dashboard-manage-order-table">
        <tr>
          <th>Código de Compra</th>
          <td>{$pedido->codigo_compra}</td>
        </tr>
        <tr>
          <th>Fecha</th>
          <td>{$pedido->fecha}</td>
        </tr>
        <tr>
          <th>Cantidad Total de Productos</th>
          <td>{$pedido->cantidad}</td>
        </tr>
        <tr>
          {if $pedido->borrado == 1}
          <td colspan="2" class="dashboard-manage-order-warning">Pedido Borrado</td>
          {else}
          <th>Estado</th>
          <td>
            <div class="dashboard-manage-order-field">
              <label for="estado">Asignar Estado:</label>
              <select id="estado" name="estado" onchange="changestatus()">
                <option value="1" {if $pedido->estado == 1}selected{/if}>Pendiente</option>
                <option value="2" {if $pedido->estado == 2}selected{/if}>Pago confirmado</option>
                <option value="3" {if $pedido->estado == 3}selected{/if}>Preparando pedido</option>
                {if empty($shopInfo[0]->ubicacion)}
                <option value="4" {if $pedido->estado == 4}selected{/if}>Pedido enviado</option>
                {else}
                <option value="5" {if $pedido->estado ==5}selected{/if}>Pedido finalizado, listo para retirar.</option>
                {/if}
                <option value="99" {if $pedido->estado == 99}selected{/if}>Pedido entregado</option>
              </select>
            </div>
          </td>
          {/if}
        </tr>
      </table>
    
      <h3 class="dashboard-manage-order-title">Detalles de los Productos</h3>
      <table class="dashboard-manage-order-table">
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Cantidad</th>
          <th>Precio Unitario</th>
          <th>Subtotal</th>
        </tr>
      </thead>
      <tbody>
        {assign var="total" value=0}
        {foreach from=$pedido->productos item=producto}
          {assign var="subtotal" value=$producto.subtotal}
          <tr>
            <td>{$producto.nombre}</td>
            <td>{$producto.cantidad}</td>
            <td>${$producto.precio|number_format:2}</td>
            <td>${$subtotal|number_format:2}</td>
          </tr>
          {assign var="total" value=$total + $subtotal}
        {/foreach}
        
        <tr>
          <td colspan="3" class="gp-total-label">Costos de envío</td>
          <td class="gp-total-value">${$pedido->costo_envio|number_format:2}</td>
        </tr>
    
        {assign var="total" value=$total + $pedido->costo_envio}
        <tr>
          <td colspan="3" class="dashboard-manage-order-total-label">Total</td>
          <td class="dashboard-manage-order-total-value">${$total|number_format:2}</td>
        </tr>
      </tbody>
    </table>
    
    
      <h3 class="dashboard-manage-order-title">Información del Usuario</h3>
      <table class="dashboard-manage-order-table">
  {if isset($usuario->usuario) && $usuario->usuario neq ''}
  <tr><th>Nombre Usuario</th><td>{$usuario->usuario}</td></tr>
  {/if}

  {if isset($usuario->email) && $usuario->email neq ''}
  <tr><th>Email del usuario</th><td>{$usuario->email}</td></tr>
  {/if}

  {if isset($usuario->telefono) && $usuario->telefono neq ''}
  <tr><th>Teléfono</th><td>{$usuario->telefono}</td></tr>
  {/if}

  {if isset($informacion.nombre) && $informacion.nombre neq ''}
  <tr><th>Nombre</th><td>{$informacion.nombre}</td></tr>
  {/if}

  {if isset($informacion.email) && $informacion.email neq ''}
  <tr><th>Email de contacto</th><td>{$informacion.email}</td></tr>
  {/if}

  {if isset($informacion.telefono) && $informacion.telefono neq ''}
  <tr><th>Teléfono</th><td>{$informacion.telefono}</td></tr>
  {/if}

  {if isset($informacion.codigo_postal) && $informacion.codigo_postal neq ''}
  <tr><th>Código Postal</th><td>{$informacion.codigo_postal}</td></tr>
  {/if}

  {if isset($informacion.direccion) && $informacion.direccion neq ''}
  <tr><th>Dirección</th><td>{$informacion.direccion}</td></tr>
  {/if}

  {if isset($informacion.ciudad) && $informacion.ciudad neq ''}
  <tr><th>Ciudad</th><td>{$informacion.ciudad}</td></tr>
  {/if}

  {if isset($informacion.pais) && $informacion.pais neq ''}
  <tr><th>País</th><td>{$informacion.pais}</td></tr>
  {/if}

  {if isset($informacion.comprobante.path) && $informacion.comprobante.path neq ''}
  <tr>
    <th>Comprobante</th>
    <td>
      <a href="{$informacion.comprobante.path}" class="dashboard-manage-order-btn" download>Descargar Comprobante</a>
    </td>
  </tr>
  {/if}
</table>

    
      {if $pedido->borrado == 0}
      <div class="dashboard-manage-order-actions">
        <button class="dashboard-manage-order-btn dashboard-manage-order-danger" onclick="openModal()">Eliminar Pedido</button>
      </div>
      {/if}
    
      <!-- Modal -->
      <div id="finalizarPedidoModal" class="dashboard-manage-order-modal">
        <div class="dashboard-manage-order-modal-content">
          <span class="dashboard-manage-order-close" onclick="closeModal()">&times;</span>
          <p>¿Estás seguro que deseas eliminar este pedido?</p>
          <form method="POST" action="admin/deletepedido">
            <input type="hidden" name="id_compra" value="{$pedido->id_compra}">
            <button type="submit" class="dashboard-manage-order-btn dashboard-manage-order-danger">Confirmar Eliminación</button>
          </form>
        </div>
      </div>
    </div>
    






      
      </body>
      </html>
   
      </html>
   </div>
</div>


<script>
  function openModal() {
    document.getElementById("finalizarPedidoModal").style.display = "block";
  }

  function closeModal() {
    document.getElementById("finalizarPedidoModal").style.display = "none";
  }

  window.onclick = function(event) {
    const modal = document.getElementById("finalizarPedidoModal");
    if (event.target == modal) {
      closeModal();
    }
  }
</script>
