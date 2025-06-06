{if $bannerimages|@count > 0}
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <!-- Indicadores dinámicos -->
  <ol class="carousel-indicators">
    {foreach from=$bannerimages item=imagen key=key}
      <li data-target="#carouselExampleIndicators" data-slide-to="{$key}" class="{if $key == 0}active{/if}"></li>
    {/foreach}
  </ol>

  <!-- Imágenes del carrusel -->
  <div class="carousel-inner">
    {foreach from=$bannerimages item=imagen key=key}
      <div class="carousel-item carrousel-products {if $key == 0}active{/if}">
        <img class="coverimg" src="{$imagen->imagen}" alt="{$imagen->texto1}">
        <div class="carousel-caption d-none d-md-block">
          <h5>{$imagen->texto1}</h5>
          <p>{$imagen->texto2}</p>
        </div>
      </div>
    {/foreach}
  </div>

  <!-- Controles -->
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
{/if}
