{include file="CM_header.tpl"}
{include file="GEN_carrousel.tpl"}
{assign var="color_fondo" value=$colors[0]->color}
{assign var="color_texto" value=$colors[0]->color_texto}


<style>
.cm_mainpage_rank_cat-button {
    font-size: 1rem;
    padding: 10px 15px;
    border: 2px solid {$color_fondo};
    background-color: transparent;
    color: {$color_fondo};
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
  }
  
  .cm_mainpage_rank_cat-button:hover {
   text-decoration: none;
    background-color: {$color_fondo};
    color: #fff;
  }


  .cm_mainpage_ver_todos_productos{
  font-weight: bold;
  width: 100%;
  border: 3px solid {$color_fondo};
  border-radius: 0.5rem;
  padding: 0.5rem;
  color: {$color_fondo};
  transition: 0.2s;
}

.cm_mainpage_ver_todos_productos:hover{
  width: 100%;
  background-color: {$color_fondo};
  border: 3px solid {$color_fondo};
  border-radius: 0.5rem;
  padding: 0.5rem;
  color: #ffffff;
  text-decoration: none;
}


</style>

<div class="container">

   <div class="cm_mainpage_rank_cat-container">
    {foreach from=$rankCategories item=category} 
        <div class="cm_mainpage_rank_cat-card">
            <div class="cm_mainpage_rank_cat-content">
                <h2 class="cm_mainpage_rank_cat-title">{$category->nombre}</h2>
                <p class="cm_mainpage_rank_cat-description">{$category->descripcion}</p>
                <a href="{$shopName}/category/{$category->id_categoria}" class="cm_mainpage_rank_cat-button">Ver productos</a>
            </div>

            {if !empty($category->imagen)}
                <img src="{$category->imagen}" alt="{$category->nombre}" class="cm_mainpage_rank_cat-image"/>
            {/if}
        </div>
    {/foreach}
</div>




   <section class="cm_mainpage_relatedp-related-products">

      <div class="cm_mainpage_relatedp-back-related-productos"  style="background-color: {$color_fondo};"> </div>
      <div class="cm_mainpage_relatedp_header">
         <h2>Descubrí nuestros mejores productos</h2>
         <a href="{$shopName}/products">Ver todos</a>
      </div>
      <div class="cm_mainpage_relatedp-related-products-container">
         {foreach from=$bestproducts item=product}
            <a href="{$shopName}/product/{$product->id_producto}" class="cm_mainpage_relatedp-related-product shadow">
               {assign var="imagenesArray" value=","|explode:$product->imagenes}
               <img src="{$imagenesArray[0]|default:'banner.jpg'}" 
                    alt="{$product->nombre|escape:'html'}">
                              <div class="cm_mainpage_relatedp-related-products-info">
                     <p>${$product->precio|number_format:2}</p>
                     <small>{$product->nombre|escape:'html'}</small>
                     {assign var="rating" value=($product->valoracion_promedio*10)|ceil/10}
                     <span>
                        {$rating}
                        {foreach from=[1,2,3,4,5] item="star"}
                           {if $star <= $rating}
                                 <span class="">★</span>
                           {else}
                                 <span class="star-nofilled">★</span>
                           {/if}
                        {/foreach}
                     </span>
               </div>
            </a>
         {/foreach}

     
      </div>
   </section>
   <section class="cm_mainpage_products_list-products">
      <div class="cm_mainpage_products_list_header">
         <h2>Podria interesarte</h2>
      </div>
      <div class="cm_mainpage_products_list-grid">
         {foreach from=$products item=product}
         <div class="cm_mainpage_products_list-card shadow">
            <a href="{$shopName}/product/{$product->id_producto}" class="cm_mainpage_products_list-link">
               {assign var="imagenesArray" value=","|explode:$product->imagenes}
               <img src="{$imagenesArray[0]|default:'banner.jpg'}" 
                   alt="{$product->nombre|escape:'html'}" 
                   class="cm_mainpage_products_list-image">
               <div class="cm_mainpage_products_list-info">
                  <p class="cm_mainpage_products_list-price">
                     ${$product->precio|number_format:2}
                  </p>
                  <small class="cm_mainpage_products_list-name">
                  {$product->nombre|escape:'html'}
                  </small>
                  <span>{$product->descripcion}</span>
               </div>
            </a>
         </div>
         {/foreach}
      </div>
   </section>
   <a href="{$shopName}/products" class="cm_mainpage_ver_todos_productos">Ver todos los productos</a>

</div>
{include file="GEN_contactFooter.tpl"}
{include file="footer.tpl"}