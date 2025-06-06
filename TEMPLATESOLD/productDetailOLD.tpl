{include file="header.tpl"}
{if (isset($smarty.session.USER_NAME)) && ($smarty.session.PERMISOS == 1)}
    <a class="edit-button-detail" href="edit/{$product->id_producto}">Editar
        <svg width="26" height="26"  viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M18.067 2.182a.625.625 0 0 0-.884 0l-2.058 2.059 4.634 4.634 2.058-2.058a.623.623 0 0 0 0-.885l-3.75-3.75Zm.808 7.576L14.24 5.125 6.116 13.25h.259a.625.625 0 0 1 .625.624v.625h.625a.625.625 0 0 1 .625.625v.625h.625a.625.625 0 0 1 .625.626V17h.625a.625.625 0 0 1 .625.625v.258l8.125-8.125ZM9.54 19.093a.625.625 0 0 1-.04-.218v-.625h-.625a.625.625 0 0 1-.625-.625V17h-.625A.625.625 0 0 1 7 16.375v-.626h-.625a.625.625 0 0 1-.625-.625V14.5h-.625a.624.624 0 0 1-.219-.04l-.224.223a.625.625 0 0 0-.137.21l-2.5 6.25a.625.625 0 0 0 .812.813l6.25-2.5a.625.625 0 0 0 .21-.138l.223-.223Z"></path>
          </svg>

    </a>
{/if}
<div class="product-detail-container">
    <div id="tree">
        <small id="current-location">Productos</small>
        <small>
          <svg width="15" height="15" fill="none" stroke="gray" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path d="m9 18 6-6-6-6"></path>
          </svg>
        </small>
        <small id="current-location">{$product->nombre}</small>
      </div>
    
        
</div>

<div class="product-detail-container">
    <div class="product-detail-images">
        <img src="{$product->imagenes}" alt="{$product->imagenes}">
        <!-- Agrega más imágenes según sea necesario -->
    </div>
  
    <div class="product-detail-details">

        <h2 class="product-detail-title">{$product->nombre}

            
        </h2>
        <small>vende <span>Buffa</span> </small>

        <div class="product--detail-price">u$s {$product->precio}</div>

        <div class="more-detail-info">
            <svg width="46" height="46" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M2.4 6.597a1.8 1.8 0 0 1 1.8-1.8H15a1.8 1.8 0 0 1 1.8 1.8v1.8h1.224a1.8 1.8 0 0 1 1.404.675l1.777 2.22a1.8 1.8 0 0 1 .395 1.126v2.579a1.8 1.8 0 0 1-1.8 1.8h-.6a2.4 2.4 0 0 1-4.8 0h-6a2.4 2.4 0 1 1-4.797-.102A1.8 1.8 0 0 1 2.4 14.997v-8.4Zm1.553 8.947a2.399 2.399 0 0 1 4.126.053h6.643c.211-.365.514-.667.878-.878V6.597a.6.6 0 0 0-.6-.6H4.2a.6.6 0 0 0-.6.6v8.4a.6.6 0 0 0 .353.547ZM16.8 14.397a2.4 2.4 0 0 1 2.079 1.2h.921a.6.6 0 0 0 .6-.6v-2.58a.6.6 0 0 0-.132-.374l-1.776-2.22a.6.6 0 0 0-.468-.226H16.8v4.8ZM6 15.597a1.2 1.2 0 1 0 0 2.4 1.2 1.2 0 0 0 0-2.4Zm10.8 0a1.2 1.2 0 1 0 0 2.4 1.2 1.2 0 0 0 0-2.4Z"></path>
            </svg>
              Cuadrar entrega con vendedor
        </div>
   
        <table>
            <tr>
                <td>Fabricante:</td>
                <td>{$product->fabricante}</td>
            </tr>
            <tr>
                <td>Marca:</td>
                <td>{$product->marca}</td>
            </tr>
            <tr>
               <form action="addToCarrito/{$product->id_producto}" method='POST'>
                    <td>
                        <label for="quantity">Cantidad:</label>
                        <input type="number" id="quantity" name="quantity" min="1" max="{$product->stock}" value="1" class="pd-input-quantity">
                    </td>
                    <td>
                        {if $product->stock > 0}
                            <button type="submit" class="pd-btn-add-to-cart">Añadir al carrito</button>
                        {else}
                            <button type="button" class="pd-btn-out-of-stock" disabled>No hay stock disponible</button>
                        {/if}
                    </td>
                </form>

            </tr>
            

        </table>

       
        <!-- Agrega más detalles según tus necesidades -->
    </div>


</div>
<div class="product-detail-container descripcion-detail-detalle">
    <h3>Descripcion</h3>
    <p class="product-detail-description">
        {$product->descripcion}
    </p>
</div>
{include file="footer.tpl"}