{include file="header-admin.tpl"}
<div class="container">
   <div class="profile-vencimiento mt-4 ">
      {assign var="fecha_actual" value=$smarty.now|date_format:"%Y-%m-%d"}
      <strong>
      El vencimiento de tu tienda es el {$pagosInfo.fecha_vencimiento}
      {if $pagosInfo.fecha_vencimiento < $fecha_actual}
      <span class="pagos-vencido"> (VENCIDO) <small>Abone para volver a habilitar la tienda.</small></span>
      {/if}
      </strong>
      <a href="account/{$userId}">
         <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M19 12H5"></path>
            <path d="m12 19-7-7 7-7"></path>
         </svg>
         Volver al perfil
      </a>
   </div>
</div>
<div class="container d-flex mt-4">
   <div class="pagos-container">
      <small>Si hay algun problema con el págo, un administrador se contactara con usted mediante la informacion de su perfil</small>
      <hr>
      <table class="pagos-tabla">
         <thead class="pagos-thead">
            <tr class="pagos-tr">
               <th class="pagos-th">Fecha</th>
               <th class="pagos-th">Monto</th>
               <th class="pagos-th">Estado</th>
            </tr>
         </thead>
         <tbody class="pagos-tbody">
            {foreach from=$pagosInfo.pagos item=pago}
            <tr class="pagos-tr">
               <td class="pagos-td">{$pago.fecha}</td>
               <td class="pagos-td">{$pago.monto}</td>
               <td class="pagos-td">
                  {if $pago.pago == 0}
                  Esperando 
                  <svg width="25" height="25" fill="none" stroke="orange" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M12 2a10 10 0 1 0 0 20 10 10 0 1 0 0-20z"></path>
                     <path d="M12 6v6l4 2"></path>
                  </svg>
                  {elseif $pago.pago == 1}
                  Validado
                  <svg width="25" height="25" fill="none" stroke="green" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M20 6 9 17l-5-5"></path>
                  </svg>
                  {elseif $pago.pago == 2}
                  Reintentar
                  <svg width="25" height="25" fill="none" stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M18 6 6 18"></path>
                     <path d="m6 6 12 12"></path>
                  </svg>
                  {/if}
               </td>
            </tr>
            {/foreach}
         </tbody>
      </table>
   </div>
   <div class="pagos-sidebar">
      <h3>Datos para hacer transferencia</h3>
      <small><strong>Nota:</strong> Recuerde que su comprobante tendra que ser procesado por un administrador en caso de hacer la trasnferenciam manual, podria tardar unos minutos. Recomendamos pagar con antelacion el servicio.</small>
      <hr>
      <small>En la referencia de la trasnferencia escriba lo correspondiente</small>
      <hr>
      <table class="pagos-tabla-sin-bordes">
         <tr>
            <td class="pagos-label">Precio:</td>
            <td class="pagos-value">$ARS {$pagosInfo.precio_plantilla} </td>
         </tr>
         <tr>
            <td class="pagos-label">Alias:</td>
            <td class="pagos-value">cyshops.pagos</td>
         </tr>
         <tr>
            <td class="pagos-label">CBU/CVU:</td>
            <td class="pagos-value">0000003100022408294409</td>
         </tr>
         <tr>
            <td class="pagos-label">Referencia:
            </td>
            <td class="pagos-value"><strong>U{$pagosInfo.id_user}T{$pagosInfo.id_tienda}</strong></td>
         </tr>
      </table>
      {*   <button class="pagos-button">mercado pago</button>
      *}<!-- Button trigger modal -->
      <button class="pagos-button" data-bs-toggle="modal" data-bs-target="#comprobanteModal">Realizar transferencia</button>
      <hr>
      <a href="https://wa.link/08l8x3" target="_blank" rel="noopener noreferrer">
      Si tiene alguna duda, póngase en contacto con nosotros haciendo clic aquí y deje su consulta.
      </a>
      <!-- Modal -->
      <div class="modal fade" id="comprobanteModal" tabindex="-1" aria-labelledby="comprobanteModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="comprobanteModalLabel">Cargar Comprobante</h5>
                  <button type="button" class="btn-close btn" data-bs-dismiss="modal" aria-label="Close">X</button>
               </div>
               <div class="modal-body">
                  <!-- Formulario para cargar el comprobante -->
                  <form action="pagarServicio" method="POST" enctype="multipart/form-data">
                     <input type="hidden" name="monto" id="monto" value="{$pagosInfo.precio_plantilla}">
                     <input type="hidden" name="id_tienda" id="id_tienda" value="{$pagosInfo.id_tienda}">
                     <input type="hidden" name="id_usuario" id="id_usuario" value="{$pagosInfo.id_user}">
                     <table class="pagos-tabla-sin-bordes">
                        <tr>
                           <td class="pagos-label">Precio:</td>
                           <td class="pagos-value">$ {$pagosInfo.precio_plantilla}</td>
                        </tr>
                        <tr>
                           <td class="pagos-label">Alias:</td>
                           <td class="pagos-value">rust.matias.dni</td>
                        </tr>
                        <tr>
                           <td class="pagos-label">CBU:</td>
                           <td class="pagos-value">0140334103620552268803</td>
                        </tr>
                        <tr>
                           <td class="pagos-label">Referencia:
                           </td>
                           <td class="pagos-value"><strong>U{$pagosInfo.id_user}T{$pagosInfo.id_tienda}</strong></td>
                        </tr>
                     </table>
                     <hr>
                     <div class="mb-3">
                        <label for="comprobante" class="form-label">Subir comprobante</label>
                        <input type="file" class="form-control" id="input_image" name="input_image"  required>
                        <hr>
                     </div>
                     <button type="submit" class="btn btn-success">Cargar Comprobante</button>
                  </form>
               </div>
            </div>
         </div>
      </div>
      <!-- Asegúrate de incluir Bootstrap JS y sus dependencias en tu proyecto -->
   </div>
</div>
{include file="adminfooter.tpl"}