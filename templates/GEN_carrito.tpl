{include file="header-offlog.tpl"}
<style>
   .modal {
   z-index: 1050 !important;
   }

 
.carrito-cart-eliminar{
   background-color: rgb(255, 95, 95);
   border: none;
   border-radius: 50%;
   height: 50px;
   width: 50px;
}
.carrito-cart-gen-container{

   padding: 4rem 1rem;
   display: flex;
   justify-content: center;
   align-items: center;
   flex-direction: column;
   width: 100%;
   overflow: hidden;

}

.carrito-cart-header{
   border-top-left-radius: 1rem;
      border-top-right-radius: 1rem ;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;

   display: flex;
   justify-content: start;
   align-items: center;
   background-color: aqua;
   width: 100%;
   padding: 0.5rem;
}
.carrito-cart-header a{
   margin-left: 1rem;
}
.carrito-cart-content-info{
   padding: 1rem;
   background-color: aliceblue;
    width: 100%;
    border-bottom-left-radius: 1rem;
      border-bottom-right-radius: 1rem ;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;

}





.carrito-cart-container {

  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: space-between;
}


.carrito-cart-productos {
   
  flex: 2;
}

.carrito-cart-title {
  margin-bottom: 10px;
  font-size: 12px;
}

.carrito-cart-producto {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 1rem;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
  padding: 15px;
  margin-bottom: 10px;
  background-color: #fff;
}

.carrito-cart-img,
.carrito-cart-nombre,
.carrito-cart-precio {

  text-align: start;
  font-size: 12px;
}

.carrito-cart-img{
   width: 60px !important;
}

.carrito-cart-resumen {
   border-radius: 1rem;
  flex: 1;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;

  padding: 20px;
  background-color: #fff;
}

.carrito-cart-resumen-title {
  margin-bottom: 20px;
  font-size: 16px;
  font-weight: bold;
}

.carrito-cart-resumen-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.carrito-cart-tooltip {
  font-size: 12px;
  cursor: pointer;
  margin-left: 4px;
  color: gray;
}

.carrito-cart-codigo {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 15px;
}

.carrito-cart-plus {
  font-size: 20px;
  cursor: pointer;
}

.carrito-cart-divider {
  border: none;
  border-top: 2px solid black;
  margin: 20px 0;
}

.carrito-cart-total {
  display: flex;
  justify-content: space-between;
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 20px;
}

.carrito-cart-pagar {
  background-color: black;
  color: white;
  border: none;
  padding: 15px;
  width: 100%;
  font-size: 16px;
  cursor: pointer;
  border-radius: 0.5rem;
  transition: background-color 0.3s ease;
}

.carrito-cart-pagar:hover {
  background-color: #333;
}

.bg-sin-stock{
   background-color: rgb(247, 160, 160);
}

@media (min-width: 768px) {
  .carrito-cart-productos {
    flex: 2 1 60%;
  }

  .carrito-cart-resumen {
    flex: 1 1 35%;
  }
}

</style><!--
<div class="container carrito-transform">
   <div class="carrito-card-container">
      <div class="carrito-svg-container">
         <svg class="carrito-svg-title" width="120" height="120" fill="none" stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="m3 6-.75-2.5M3 6h19l-3 10H6L3 6Z"></path>
            <path d="M11 19.5a1.5 1.5 0 0 1-3 0"></path>
            <path d="M17 19.5a1.5 1.5 0 0 1-3 0"></path>
         </svg>
      </div>
      


       {foreach from=$cartData item=carrito}
      <h2 class="mt-4">Tienda: {$carrito.store_name}</h2>
      {if isset($carrito.items) && $carrito.items|@count > 0}
      <table class="carrito-table">
         <thead class="carrito-thead">
            <tr>
               <th class="carrito-th">Producto</th>
               <th class="carrito-th">Imagen</th>
               <th class="carrito-th">Precio</th>
               <th class="carrito-th">Cantidad</th>
               <th class="carrito-th">Subtotal</th>
               <th class="carrito-th">Acciones</th>
            </tr>
         </thead>
         <tbody class="carrito-tbody">
            {foreach from=$carrito.items item=item}
            <tr class="carrito-tr {if $item.sin_stock} sin-stock {/if}">
               <td class="carrito-td"><a href="{$item.shopname}/product/{$item.id_producto}">{$item.nombre}</a></td>
               <td class="carrito-td">
                  {assign var="imagenesArray" value=","|explode:$item.imagenes}
                  <img src="{$imagenesArray[0]}" alt="{$item.nombre}" width="50">
               </td>
               <td class="carrito-td">${$item.precio|number_format:2}</td>
               <td class="carrito-td">{$item.quantity}</td>
               <td class="carrito-td">${$item.precio * $item.quantity|number_format:2}</td>
               <td class="carrito-td">
                  <form action="eliminarDelCarrito" method="post">
                     <input type="hidden" name="id_producto" value="{$item.id_producto}">
                     <input type="hidden" name="id_carrito" value="{$carrito.id_carrito}">
                     <button type="submit" class="carrito-button-eliminar">Eliminar</button>
                  </form>
               </td>
            </tr>
            {if $item.sin_stock}
            <tr class="sin-stock-message">
               <td colspan="6" class="carrito-td sin-stock-warning">
                  ¡Atención! El producto "{$item.nombre}" tiene más cantidad en el carrito que el stock disponible.
               </td>
            </tr>
            {/if}
            {/foreach}
         </tbody>
         <tfoot class="carrito-tfoot">
            <tr class="carrito-tfoot-tr">
               <td colspan="4" class="carrito-total-label">Costos de Envío</td>
               <td class="carrito-total-value">
                  ${$carrito.costo_envio|number_format:2}
               </td>
               <td class="carrito-total-value"></td>
            </tr>
            <tr class="carrito-tfoot-tr">
               <td colspan="4" class="carrito-total-label">Total</td>
               <td class="carrito-total-value">
                  {assign var="total" value=0}
                  {foreach from=$carrito.items item=item}
                  {assign var="total" value=$total + ($item.precio * $item.quantity)}
                  {/foreach}
                  {assign var="totalFinal" value=$total + $carrito.costo_envio}
                  ${$totalFinal|number_format:2}
               </td>
               <td class="carrito-total-value">
                  <a class="btn btn-success" href="confirmarcarrito/{$carrito.id_carrito}">Realizar Compra</a>
               </td>
            </tr>
         </tfoot>
      </table>
      {else}
      <p>No hay productos en este carrito.</p>
      {/if}
      {/foreach} -->



     

      {if $cartData|@count == 0}
      <p>No hay carritos disponibles.</p>
      {/if}
      <!-- <div class="carrito-button-container">-->
   </div>
    
</div>

{foreach from=$cartData item=carrito}
         <div class="carrito-cart-gen-container">
            <div class="carrito-cart-header " style="background-color: {$carrito.color} ;">
               <img src="{$carrito.logo}" alt="" width="50px">
               
               <a href=" {$carrito.nombre_unico}" style="color: {$carrito.color_texto};"> {$carrito.store_name}</a>
            </div>
          <div class="carrito-cart-content-info ">
               <div class="carrito-cart-container">
                  <div class="carrito-cart-productos">
                  
                     {foreach from=$carrito.items item=item}
                     <div class="carrito-cart-producto">
                         {assign var="imagenesArray" value=","|explode:$item.imagenes}
                        <img src="{$imagenesArray[0]}" alt="{$item.nombre}"  class="carrito-cart-img">
                   
                        <div class="carrito-cart-nombre"><a href="{$item.shopname}/product/{$item.id_producto}">{$item.nombre}</a></div>
                        <div class="carrito-cart-nombre">x{$item.quantity}</div>
                        <div class="carrito-cart-precio">${$item.precio|number_format:2} c/u</div>

                        <div>
                           <form action="eliminarDelCarrito" method="post">
                     <input type="hidden" name="id_producto" value="{$item.id_producto}">
                     <input type="hidden" name="id_carrito" value="{$carrito.id_carrito}">
                     <button type="submit" class="carrito-cart-eliminar"><svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 6h18"></path>
                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                        </svg></button>
                  </form>
                        </div>

                     </div>
                     {if $item.sin_stock}
                     <div class="carrito-cart-producto bg-sin-stock">
                        <small colspan="6" class="">
                           ¡Atención! El producto "{$item.nombre}" tiene más cantidad en el carrito que el stock disponible.
                        </small>
                     </div>
                     {/if}
                     {/foreach}
                  </div>
                  <div class="carrito-cart-resumen">
                     <h3 class="carrito-cart-resumen-title">RESUMEN DEL PEDIDO</h3>
                     <div class="carrito-cart-resumen-item">
                         {assign var="total" value=0}
                           {foreach from=$carrito.items item=item}
                           {assign var="total" value=$total + ($item.precio * $item.quantity)}
                           {/foreach}
                           {assign var="totalFinal" value=$total + $carrito.costo_envio}
                        <span>Subtotal</span>
                        <span>
                          
                                                   
                           {$total|number_format:2:',':' '}</span>
                     </div>
                     <div class="carrito-cart-resumen-item">
                        <span>Envío</span>
                        <span> ${$carrito.costo_envio|number_format:2}</span>
                     </div>

                     <hr class="carrito-cart-divider" />
                     <div class="carrito-cart-total">
                        <strong>Total Estimado</strong>
                        <strong> ${$totalFinal|number_format:2}</strong>
                     </div>
                      <a href="confirmarcarrito/{$carrito.id_carrito}"> <button class="carrito-cart-pagar">Pagar ➤</button></a>
                    
                  </div>
               </div>
            </div>
         </div>

      {/foreach}
{include file="footer.tpl"}