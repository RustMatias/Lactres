{include file="INI_header.tpl"}
{assign var="color_fondo" value=$colors[0]->color}
{assign var="color_texto" value=$colors[0]->color_texto}
<style>
   body{
   background-color: {$color_fondo} !important;
   min-height: 100vh;
   }
   .ini_mainpage_producto {
   position: relative;
   text-align: center;
   color: {$color_texto};
   }
   .ini_mainpage_producto a{
   text-decoration: underline;
   color: {$color_texto};
   }


   .ini_mainpage_modal-add-to-cart {
   display: block;
   background-color: {$color_fondo} !important;
   color: {$color_texto};
   padding: 10px;
   text-align: center;
   font-size: 1rem;
   width: 100%;
   border: none;
   cursor: pointer;
   margin: 10px 10px;
   }

   .ini_mainpage_main H2{
      margin-top: 2rem;
      color: {$color_texto};
}

.ini_mainpage_colortexto-db{
     text-align: center;
    color: {$color_texto};
}
.ini_mainpage_colortexto-db:hover{
    color: {$color_texto};
}
</style>











<body >
   <main class="ini_mainpage_main">
   <h2 class="ini_mainpage_colortexto-db">{$shopFront[0]->nombre_simple}</h2>

   <a class="ini_mainpage_colortexto-db" href="home">#MiTiendaCyShops</a>

      <div class="ini_mainpage_productos">
         {foreach from=$products item=product}
         {assign var="imagenesArray" value=","|explode:$product->imagenes}
         <div class="ini_mainpage_producto">
            <img src="{$imagenesArray[0]|default:'banner.jpg'}" 
               alt="{$product->nombre|escape:'html'}"
               data-title="{$product->nombre|escape:'html'}"
               data-id="{$product->id_producto}"
               data-stock="{$product->stock|escape:'html'}"
               data-price="{$product->precio|number_format:2}"
               data-sin_limite="{$product->sin_limite}"
               data-description="{$product->descripcion|escape:'html'}">
            <p class="ini-mainpage-name-product">{$product->nombre|escape:'html'}</p>
            <p class="ini-mainpage-price-product">${$product->precio|number_format:2}</p>
         </div>
         {/foreach}
      </div>
   </main>


   <!-- MODAL - OCULTO POR DEFECTO -->
   <div id="productModal" class="ini_mainpage_modal" style="display: none;">
   <span class="ini_mainpage_modal-close ini_mainpage_modal-close-mobile">&times;</span>

    <div class="ini_mainpage_modal-content">
        <span class="ini_mainpage_modal-close">&times;</span>
        
        <div class="ini_mainpage_modal-product-container">
            <div class="ini_mainpage_modal-product-image">
                <img id="modal-image" src="" alt="Producto">
            </div>

            <div class="ini_mainpage_modal-product-details">
                <h2 id="modal-title" class="ini_mainpage_modal-product-title"></h2>
                <hr>
                <p id="modal-price" class="ini_mainpage_modal-product-price"></p>
                  <hr>
                    <input type="hidden" name="id_shop" id="id_shop" value="{$shopName}">
                
                  <form  class="ini_mainpage_modal_agrupacion_botones" id="form-addtocarrito-ini" method="POST">

                     <div class="ini_mainpage_modal-quantity-selector">

                        <button class="ini_mainpage_modal-btn">−</button>
                        <input  id="quantity" name="quantity" min="1"  value="1" type="number" class="ini_mainpage_modal-quantity-input">
                        <button class="ini_mainpage_modal-btn">+</button>
                     </div>
                       

                    <button type="submit" id="ini_mainpage_addToCart" class="ini_mainpage_modal-add-to-cart">Agregar al carrito</button>
                    </form>
              
                    
                <hr>
                <ul class="ini_mainpage_modal-product-description">
                    <li id="modal-description"></li>
                </ul>
            </div>
        </div>
    </div>
</div>


 
</div>
  














<script>
document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("productModal");
    var modalImage = document.getElementById("modal-image");
    var modalTitle = document.getElementById("modal-title");
    var modalPrice = document.getElementById("modal-price");
    var modalDescription = document.getElementById("modal-description");
    var closeModal = document.querySelector(".ini_mainpage_modal-close");
    var quantityInput = document.querySelector(".ini_mainpage_modal-quantity-input");
    var decreaseBtn = document.querySelector(".ini_mainpage_modal-btn:first-child");
    var increaseBtn = document.querySelector(".ini_mainpage_modal-btn:last-child");
    var addToCartButton = document.getElementById("ini_mainpage_addToCart");
    var form = document.getElementById("form-addtocarrito-ini");
    var  id_shop = document.getElementById("id_shop").value;
    var SIN_LIMITE = 0 //VAMOS A USAR ESTRA VARIALBE para otras funciones que neceitan saber si el producto puede o no cargarse sin limite
  

    function openModal(image, title, price, description, id, stock, sin_limite) {
    stock = parseInt(stock, 10); // Convertir stock a número
    sin_limite = parseInt(sin_limite, 10); // Asegurar que es número

    console.log("Stock:", stock, "Sin límite:", sin_limite);

    modalImage.src = image;
    modalTitle.textContent = title;
    modalPrice.textContent = "$" + price;
    modalDescription.textContent = description;
    modal.style.display = "flex";
    form.action = "addToCarrito/" + id + "/" + id_shop;
    SIN_LIMITE = sin_limite
    if (sin_limite === 1) {
        quantityInput.value = 1;
        quantityInput.removeAttribute("max"); // Sin límite de cantidad
        quantityInput.disabled = false;
        addToCartButton.disabled = false;
        addToCartButton.innerText = "Agregar al carrito";
    } else {
        quantityInput.value = stock > 0 ? 1 : 0;
        quantityInput.max = stock;
        quantityInput.disabled = stock === 0;

        if (stock < 1 && stock != null) {
            addToCartButton.disabled = true;
            addToCartButton.innerText = "Sin stock";
        } else {
            addToCartButton.disabled = false;
            addToCartButton.innerText = "Agregar al carrito";
        }
    }
}


    document.querySelectorAll(".ini_mainpage_producto img").forEach(function(img) {
        img.addEventListener("click", function() {
            var title = this.getAttribute("data-title");
            var price = this.getAttribute("data-price");
            var stock = this.getAttribute("data-stock");
            var sin_limite = this.getAttribute("data-sin_limite");

            var id = this.getAttribute("data-id");
            var description = this.getAttribute("data-description");
            openModal(this.src, title, price, description, id, stock, sin_limite);
        });
    });

    closeModal.addEventListener("click", function() {
        modal.style.display = "none";
    });

    window.addEventListener("click", function(e) {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });

    decreaseBtn.addEventListener("click", function(event) {
    event.preventDefault(); // Evita que el formulario se envíe
    var quantity = parseInt(quantityInput.value);
    if (quantity > 1) {
        quantityInput.value = quantity - 1;
    }
});

increaseBtn.addEventListener("click", function(event) {
    event.preventDefault(); 
    var quantity = parseInt(quantityInput.value);

    if (SIN_LIMITE === 1 || isNaN(SIN_LIMITE)) {
        quantityInput.value = quantity + 1;
    } else {
        var maxStock = parseInt(quantityInput.getAttribute("max"), 10);
        if (quantity < maxStock) {
            quantityInput.value = quantity + 1;
        }
    }
});





});
</script>

</body>
</html>

{include file="GEN_contactFooter.tpl"}