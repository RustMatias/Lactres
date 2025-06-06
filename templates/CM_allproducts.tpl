{include file="CM_header.tpl"}
{assign var="color_fondo" value=$colors[0]->color}
{assign var="color_texto" value=$colors[0]->color_texto}

<style>
   .cm_categorypage-miniheader {
    padding: 0.5rem;
    height: 58px;
    background-color: {$color_fondo};
    color: {$color_texto};
   display: flex;
   justify-content: space-between;
   align-items: center;
    border-radius: 5px;
  }

  
</style>



<div class="container mt-3 ">
  <div class="cm_categorypage-miniheader">
    <div class="cm_categorypage-categorypointer">
      
    
      <small id="current-location" class="cm_categorypage-current">Listado de todos nuestros productos</small>
    
    </div>
   
    <a href="{$shopName}" class="cm_categorypage-link">
      
      
      <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path d="m6 12 6 6m6.5-6H6h12.5ZM6 12l6-6-6 6Z"></path>
      </svg>
      
      Volver</a>
  </div>
 
</div>





<div class="container">



  <section class="cm_mainpage_products_list-products">

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
                {assign var="rating" value=$product->rating}
                <div class="cm_mainpage_products_list-rating">
                  <span>{$product->descripcion}</span>
               </div>
             </div>
          </a>
       </div>
       {/foreach}
    </div>
 </section>
 


</div>






{include file="GEN_contactFooter.tpl"}

{include file="footer.tpl"}