{include file="CM_header.tpl"}
{assign var="color_fondo" value=$colors[0]->color}
{assign var="color_texto" value=$colors[0]->color_texto}



<style>

.CM_producto_detail-back-related-productos {
    padding: 0rem 1rem;
    width: 100%;
    height: 300px;
    position: absolute;
    left: 0px;
    background-color: {$color_fondo};
    z-index: 9;
}


.CM_producto_detail-custom-add-to-cart-btn {
    background-color: {$color_fondo}; /* Azul para el botón activo */
    color:  {$color_texto};
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: 0.2s;
    
}

.CM_producto_detail-custom-add-to-cart-btn:hover {
   transform: scale(1.04);
}

.CM_producto_detail-new-comment-pd{
    font-size: 14px;
    background-color: {$color_fondo};
    color:  {$color_texto};
    border-radius: 1rem;
    border: none;
}

.CM_producto_detail-new-comment-pd:hover{
   transform: scale(1.04);

}


</style>

<body class="">
<div class="container">
   <main class="CM_producto_detail-product-page">
      <div class="CM_producto_detail-product-images">
         <div class="CM_producto_detail-main-image">
             {if isset($imagenes[0])}
                 <img src="{$imagenes[0]}" alt="Vista principal">
             {/if}
         </div>
         <div class="CM_producto_detail-thumbnail-images">
             {if isset($imagenes[1])}
                 <img src="{$imagenes[1]}" alt="Vista 1">
             {/if}
             {if isset($imagenes[2])}
                 <img src="{$imagenes[2]}" alt="Vista 2">
             {/if}
             {if isset($imagenes[3])}
                 <img src="{$imagenes[3]}" alt="Vista 3">
             {/if}
             {if isset($imagenes[4])}
                 <img src="{$imagenes[4]}" alt="Vista 4">
             {/if}
         </div>
     </div>
     <script>
      document.addEventListener('DOMContentLoaded', function () {
          // Seleccionar la imagen principal
          const mainImage = document.querySelector('.CM_producto_detail-main-image img');
          // Seleccionar todas las imágenes miniatura
          const thumbnails = document.querySelectorAll('.CM_producto_detail-thumbnail-images img');
  
          // Agregar evento de clic a cada miniatura
          thumbnails.forEach(thumbnail => {
              thumbnail.addEventListener('click', function () {
                  // Guardar la imagen principal en una variable temporal
                  let tempSrc = mainImage.src;
                  
                  // Intercambiar la imagen principal con la miniatura clickeada
                  mainImage.src = this.src;
                  this.src = tempSrc;
              });
          });
      });
  </script>
  
      <div class="CM_producto_detail-product-details">
         <h1>{$product->nombre}</h1>
         <div class="CM_producto_detail-product-rating">
            <span>
               {$valoracionProducto|number_format:1} 
               {assign var="roundedRating" value=ceil($valoracionProducto)}
               {foreach from=[1,2,3,4,5] item="star"}
               {if $star <= $roundedRating}
               <icon class="CM_producto_detail-star-filled">★</icon>
               {else}
               <icon class="CM_producto_detail-star-nofilled">★</icon>
               {/if}
               {/foreach}
            </span>
            <span>{$product->vendidos} vendidos</span>
         </div>
         <hr>
         <div class="CM_producto_detail-product-price">
            <p class="CM_producto_detail-discounted-price">${$product->precio}</p>
         </div>
         <hr>
         <div class="CM_producto_detail-purchase-options">

             {if $product->stock > 0 ||  $product->sin_limite == 1 }
            <p>Stock disponible</p>
             {/if}

         </div>
         <hr>

         <form action="addToCarrito/{$product->id_producto}/{$shopName}" method="POST">
            <div>
               <label for="quantity" class="CM_producto_detail-custom-quantity-label">Cantidad:</label>
               <input type="number" id="quantity" name="quantity" min="1"  value="1" class="CM_producto_detail-custom-quantity-input" oninput="validateQuantity(this)">
            </div>
            <hr>
            <div>
               {if $product->stock > 0 ||  $product->sin_limite == 1 }
               <button type="submit" class="CM_producto_detail-custom-add-to-cart-btn mt-2">Añadir al carrito</button>
               {else}
               <button type="button" class="CM_producto_detail-custom-out-of-stock-btn mt-2" disabled>No hay stock disponible</button>
               {/if}
            </div>
         </form>
      </div>
   </main>
   {if $relatedProducts|@count > 0}
   <section class="CM_producto_detail-related-products">
      <div class="CM_producto_detail-back-related-productos"></div>
      <div class="CM_producto_detail-related-products-container">
         {foreach from=$relatedProducts item=product}
         <a href="{$shopName}/product/{$product->id_producto}" class="CM_producto_detail-related-product shadow">
                {assign var="imagenesArray" value=","|explode:$product->imagenes}
                <img src="{$imagenesArray[0]|default:'banner.jpg'}" 
                    alt="{$product->nombre|escape:'html'}">
                            <div class="CM_producto_detail-related-products-info">
               <p>${$product->precio|number_format:2}</p>
               <small>{$product->nombre|escape:'html'}</small>
               {assign var="rating" value=$product->valoracion_promedio}
               <span>
               {$product->valoracion_promedio}
               {foreach from=[1,2,3,4,5] item="star"}
               {if $star <= $rating}
               <span class="CM_producto_detail-star-filled">★</span>
               {else}
               <span class="CM_producto_detail-star-nofilled">★</span>
               {/if}
               {/foreach}
               </span>
            </div>
         </a>
         {/foreach}
      </div>
   </section>
   {/if}
   <!-- Sección de descripción del producto -->
   <section class="CM_producto_detail-product-description">
      <h2>Descripción</h2>
      <p> {$product->descripcion}</p>
   </section>
   <!-- Sección de características del producto -->
   <section class="CM_producto_detail-product-specs">
   <h2>Características del producto</h2>
   <ul>
      <li>Fabricante: {$product->fabricante}</li>
      <li>Marca: {$product->marca}</li>
      <li>Peso: {$product->peso} kg</li>
      {assign var=dimensiones value=$product->dimensiones|json_decode:true}
      <li>Alto: {$dimensiones.alto} cm</li>
      <li>Ancho: {$dimensiones.ancho} cm</li>
      <li>Largo: {$dimensiones.largo} cm</li>
   </ul>
</section>
   <section class="CM_producto_detail-product-comments">
      <div class="CM_producto_detail-pd-comments-header">
         <hr>

         {if (isset($smarty.session.USER_NAME))}
         <button id="toggle-comment-form" class="CM_producto_detail-new-comment-pd">Hacer comentario</button>
         {/if}
      </div>
      <div action="" class="CM_producto_detail-pd-new-comment" style="display: none;">
         <div class="CM_producto_detail-pd-rating-container d-flex align-items-center">
            <div class="CM_producto_detail-pd-rating">
               <input type="radio" id="star5" name="valoracion" value="5" />
               <label for="star5" title="5 estrellas">★</label>
               <input type="radio" id="star4" name="valoracion" value="4" />
               <label for="star4" title="4 estrellas">★</label>
               <input type="radio" id="star3" name="valoracion" value="3" />
               <label for="star3" title="3 estrellas">★</label>
               <input type="radio" id="star2" name="valoracion" value="2" />
               <label for="star2" title="2 estrellas">★</label>
               <input type="radio" id="star1" name="valoracion" value="1" />
               <label for="star1" title="1 estrella">★</label>
            </div>
            <span class="CM_producto_detail-pd-error-message ml-4" style="display: none; color: red;">Seleccione valoración</span>
         </div>
         <textarea name="comentario" id="comentario" placeholder="Escribe tu comentario"></textarea>
         <!-- Valores ocultos para el ID de usuario y nombre de usuario -->
         <input type="hidden" id="userId" value="{$smarty.session.ID_USER}">
         <input type="hidden" id="userName" value=" {$smarty.session.USER_NAME}">
         <button type="button" id="toggle-comment-form" onclick="addComment()">Enviar</button>
      </div>
      <ul id="comments-list" class="CM_producto_detail-comments-list">
         {foreach from=$comments item=comment}
           {if $comment->comentario|strlen > 0}
             <li class="CM_producto_detail-comment-item">
               <div class="CM_producto_detail-comment">
                 <span class="CM_producto_detail-comment-user">{$comment->usuario}</span>
                 <span>
                   {assign var="rating" value=$comment->valoracion}
                   {foreach from=[1,2,3,4,5] item="star"}
                     {if $star <= $rating}
                       <span class="CM_producto_detail-star-filled">★</span>
                     {else}
                       <span class="CM_producto_detail-star-nofilled">★</span>
                     {/if}
                   {/foreach}
                 </span>
                 <small class="CM_producto_detail-comment-text">{$comment->comentario}</small>
               </div>
             </li>
           {/if}
         {/foreach}
       </ul>
       
       
   </section>
</div>
</body>




<script>
   function validateQuantity(input) {
       var maxStock = parseInt(input.getAttribute('max'), 10);
       var value = parseInt(input.value, 10);
   
       if (value > maxStock) {
           input.value = maxStock;
       } else if (value < 1) {
           input.value = 1;
       }
   }
   
   document.querySelector('.CM_producto_detail-pd-rating').addEventListener('click', function(e) {
       if (e.target.tagName === 'LABEL') {
           const valor = e.target.previousElementSibling.value;
           document.querySelector('input[name="valoracion"][value="' + valor + '"]').checked = true;
       }
   })
   
   document.addEventListener('DOMContentLoaded', function () {
   const toggleButton = document.getElementById('toggle-comment-form');
   console.log(toggleButton)
   const commentForm = document.querySelector('.CM_producto_detail-pd-new-comment');
   const submitButton = commentForm.querySelector('button[type="button"]'); // Cambiar el tipo de botón a "button" ya que no se envía como un formulario
   const ratingInputs = document.querySelectorAll('input[name="valoracion"]');
   const errorMessage = document.querySelector('.CM_producto_detail-pd-error-message');
   const comentarioTextarea = document.getElementById('comentario');
   
   // Mostrar/ocultar el formulario
   toggleButton.addEventListener('click', function () {
       if (commentForm.style.display === 'none') {
           commentForm.style.display = 'flex';
           toggleButton.textContent = 'Anular comentario';
       } else {
           commentForm.style.display = 'none';
           toggleButton.textContent = 'Hacer comentario';
       }
   });
   
   // Manejar el clic en el botón de enviar
   submitButton.addEventListener('click', function () {
       let selected = false;
       ratingInputs.forEach(input => {
           if (input.checked) {
               selected = true;
           }
       });
   
       if (!selected) {
           errorMessage.style.display = 'block'; // Mostrar el mensaje de error si no se selecciona una estrella
       } else {
           errorMessage.style.display = 'none'; // Ocultar el mensaje de error si se seleccionó una estrella
           
           // Ocultar el formulario
           commentForm.style.display = 'none';
           toggleButton.textContent = 'Hacer comentario';
           
           // Limpiar los campos del formulario
           ratingInputs.forEach(input => input.checked = false);
           comentarioTextarea.value = '';
       }
   });
   
   // Opcional: Si el formulario es un formulario real (con <form>), podrías manejar la validación aquí
   });
   
   
   
   
   ;
</script>
{include file="GEN_contactFooter.tpl"}

{include file="footer.tpl"}