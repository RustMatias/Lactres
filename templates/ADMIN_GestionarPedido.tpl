{include file="header-admin.tpl"}
<div class="container-fluid mt-3 ">
{include file="ADMIN_sidenav_mobile.tpl"}
<div class="row">
   {include file="ADMIN_sidenav.tpl"}
   <div class="col-md-11">
      <div class="gp-container">
         <h2 class="gp-section-title">Información del Pedido</h2>
         <table class="gp-table">
            <!--                     <tr>
               <th>ID Compra</th>
               <td id="id_compra">{$pedido->id_compra}</td>
               </tr> -->
            <input type="hidden" id="id_compra" value="{$pedido->id_compra}">
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
               <td colspan="2" style="color: red; font-weight: bold;">Pedido Borrado</td>
               {else}
               <th>Estado</th>
               <td>
                  <div class="gp-form-group">
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
         <h2 class="gp-section-title">Detalles de los Productos</h2>
         <table class="gp-table tableinfoproducts-gestionarpedido">
            <thead>
               <tr>
                  <!--     <th>ID Producto</th> -->
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
                  <!--             <td>{$producto.id_producto}</td> -->
                  <td>{$producto.nombre}</td>
                  <td>{$producto.cantidad}</td>
                  <td>${$producto.precio|number_format:2}</td>
                  <td>${$subtotal|number_format:2}</td>
               </tr>
               {assign var="total" value=$total + $subtotal}
               {/foreach}
               <tr>
                  <td colspan="3" class="gp-total-label">Costos de envio</td>
                  <td class="gp-total-value">{$pedido->precio_envio}</td>
               </tr>
               <tr>
                  <td colspan="3" class="gp-total-label">Totall</td>
                  <td class="gp-total-value">${$total|number_format:2}</td>
               </tr>
            </tbody>
         </table>
         <h2 class="gp-section-title">Información del Usuario</h2>
         <table class="gp-table">
            <tr>
               <th>Nombre Usuario</th>
               <td>{$usuario->usuario}</td>
            </tr>
            <tr>
               <th>Email del usuario</th>
               <td>{$usuario->email}</td>
            </tr>
            <tr>
               <th>Teléfono</th>
               <td>{$usuario->telefono}</td>
            </tr>
            <tr>
               <th>Nombre</th>
               <td>{$informacion.nombre}</td>
            </tr>
            <tr>
               <th>Email de contacto</th>
               <td>{$informacion.email}</td>
            </tr>
            <tr>
               <th>Teléfono</th>
               <td>{$informacion.telefono}</td>
            </tr>
            <tr>
               <th>Código Postal</th>
               <td>{$informacion.codigo_postal}</td>
            </tr>
            <tr>
               <th>Dirección</th>
               <td>{$informacion.direccion}</td>
            </tr>
            <tr>
               <th>Ciudad</th>
               <td>{$informacion.ciudad}</td>
            </tr>
            <tr>
               <th>País</th>
               <td>{$informacion.pais}</td>
            </tr>
            <tr>
               <th>Comprobante</th>
               {$informacion.comprobante.tmp_name}
               <td>
                  {if isset($informacion.comprobante.path)}
                  <a href="{$informacion.comprobante.path}" class="btn btn-primary" download>
                  Descargar Comprobante
                  </a>
                  {else}
                  No hay comprobante disponible.
                  {/if}
               </td>
            </tr>
         </table>
         <div class="gp-form-group">
            {if $pedido->borrado == 0}
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#finalizarPedidoModal">
            Eliminar Pedido
            </button>               
            {/if}
         </div>
      </div>
   </div>
</div>
<div class="modal fade" id="finalizarPedidoModal" tabindex="-1" aria-labelledby="finalizarPedidoModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="finalizarPedidoModalLabel">Confirmar eliminacion del Pedido</h5>
         </div>
         <div class="modal-body">
            ¿Estás seguro de que deseas finalizar este pedido? Esta acción no se puede deshacer.
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-success" onclick="finalizarPedido()">Finalizar Pedido</button>
         </div>
      </div>
   </div>
</div>
{include file="adminfooter.tpl"}