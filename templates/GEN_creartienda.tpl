<style>
 a,
        a:hover,
        a:focus,
        a:active {
            text-decoration: none;
            outline: none;
        }
        
        a,
        a:active,
        a:focus {
            color: #333;
            text-decoration: none;
            transition-timing-function: ease-in-out;
            -ms-transition-timing-function: ease-in-out;
            -moz-transition-timing-function: ease-in-out;
            -webkit-transition-timing-function: ease-in-out;
            -o-transition-timing-function: ease-in-out;
            transition-duration: .2s;
            -ms-transition-duration: .2s;
            -moz-transition-duration: .2s;
            -webkit-transition-duration: .2s;
            -o-transition-duration: .2s;
        }
        
        ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        img {
    max-width: 100%;
    height: auto;
}
/*--blog----*/

.sec-title{
  position:relative;
  margin-bottom:70px;
}

.sec-title .title{
  position: relative;
  display: block;
  font-size: 16px;
  line-height: 1em;
  color: #ff8a01;
  font-weight: 500;
  background: rgb(247,0,104);
  background: -moz-linear-gradient(to left, rgba(247,0,104,1) 0%, rgba(68,16,102,1) 25%, rgba(247,0,104,1) 75%, rgba(68,16,102,1) 100%);
  background: -webkit-linear-gradient(to left, rgba(247,0,104,1) 0%,rgba(68,16,102,1) 25%,rgba(247,0,104,1) 75%,rgba(68,16,102,1) 100%);
  background: linear-gradient(to left, rgba(247,0,104) 0%,rgba(68,16,102,1) 25%,rgba(247,0,104,1) 75%,rgba(68,16,102,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#F70068', endColorstr='#441066',GradientType=1 );
  color: transparent;
  -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  text-transform: uppercase;
  letter-spacing: 5px;
  margin-bottom: 15px;
}

.sec-title h2{
  position:relative;
  display: inline-block;
  font-size:48px;
  line-height:1.2em;
  color:#1e1f36;
  font-weight:700;
}

.sec-title .text{
  position: relative;
  font-size: 16px;
  line-height: 28px;
  color: #888888;
  margin-top: 30px;
}

.sec-title.light h2,
.sec-title.light .title{
  color: #ffffff;
  -webkit-text-fill-color:inherit; 
}
.pricing-section {
    position: relative;
    padding:  0 80px;
    overflow: hidden;
}
.pricing-section .outer-box{
  max-width: 1100px;
  margin: 0 auto;
}


.pricing-section .row{
  margin: 0 -30px;
}

.pricing-block{
  position: relative;
  padding: 0 30px;
  margin-bottom: 40px;
border-radius: 1rem;
}

.pricing-block .inner-box{
      
    border-radius: 1rem;
  position: relative;
  background-color: #ffffff;
  box-shadow: 0 20px 40px rgba(0,0,0,0.08);
  padding: 0 0 30px;
  max-width: 370px;
  margin: 0 auto;
  border-bottom: 20px solid #40cbb4;
}

.icon-box{
        border-radius: 1rem;

}

.pricing-block .icon-box{
  position: relative;
  padding: 50px 30px 0;
  background-color: #40cbb4;
  text-align: center;

}

.pricing-block .icon-box:before{
  position: absolute;
  left: 0;
  bottom: 0;
  height: 75px;
  width: 100%;
  border-radius: 50% 50% 0 0;
  background-color: #ffffff;
  content: "";
}




.pricing-block .icon-box .icon-outer{
  position: relative;
  height: 150px;
  width: 150px;
  background-color: #ffffff;
  border-radius: 50%;
  margin: 0 auto;
  padding: 10px;
  
}



.pricing-block .icon-box i{
  position: relative;
  display: block;
  height: 130px;
  width: 130px;
  line-height: 120px;
  border: 5px solid #40cbb4;
  border-radius: 50%;
  font-size: 50px;
  color: #40cbb4;
  -webkit-transition:all 600ms ease;
  -ms-transition:all 600ms ease;
  -o-transition:all 600ms ease;
  -moz-transition:all 600ms ease;
  transition:all 600ms ease;
}

.pricing-block .inner-box:hover .icon-box i{
  transform:rotate(360deg);
}

.pricing-block .price-box{
  position: relative;
  text-align: center;
  padding: 10px 20px;
}

.pricing-block .title{
  position: relative;
  display: block;
  font-size: 24px;
  line-height: 1.2em;
  color: #222222;
  font-weight: 600;
}

.pricing-block .price{
  display: block;
  font-size: 14px;
  color: #222222;
  font-weight: 700;
  color: #40cbb4;
}


.pricing-block .features{
  position: relative;

  margin: 0 auto 20px;
}

.pricing-block .features li{
  position: relative;
  display: block;
  font-size: 14px;
  line-height: 30px;
  color: #848484;
  font-weight: 500;
  padding: 5px 0;
  padding-left: 30px;
  border-bottom: 1px dashed #dddddd;
}
.pricing-block .features li:before {
    position: absolute;
    left: 0;
    top: 50%;
    font-size: 16px;
    color: #2bd40f;
    -moz-osx-font-smoothing: grayscale;
    -webkit-font-smoothing: antialiased;
    display: inline-block;
    font-style: normal;
    font-variant: normal;
    text-rendering: auto;
    line-height: 1;
    content: "\f058";
    font-family: "Font Awesome 5 Free";
    margin-top: -8px;
}
.pricing-block .features li.false:before{
  color: #e1137b;
  content: "\f057";
}

.pricing-block .features li a{
  color: #848484;
}

.pricing-block .features li:last-child{
  border-bottom: 0;
}

.pricing-block .btn-box{
  position: relative;
  text-align: center;
}

.pricing-block .btn-box a{
  position: relative;
  display: inline-block;
  font-size: 14px;
  line-height: 25px;
  color: #ffffff;
  font-weight: 500;
  padding: 8px 30px;
  background-color: #40cbb4;
  border-radius: 10px;
  border-top:2px solid transparent;
  border-bottom:2px solid transparent;
  -webkit-transition: all 400ms ease;
  -moz-transition: all 400ms ease;
  -ms-transition: all 400ms ease;
  -o-transition: all 400ms ease;
  transition: all 300ms ease;
}

.pricing-block .btn-box a:hover{
  color: #ffffff;
}

.pricing-block .inner-box:hover .btn-box a{
  color:#40cbb4;
  background:none;
  border-radius:0px;
  border-color:#40cbb4;
}

.pricing-block:nth-child(2) .icon-box i,
.pricing-block:nth-child(2) .inner-box{
  border-color: #1d95d2;
}

.pricing-block:nth-child(2) .btn-box a,
.pricing-block:nth-child(2) .icon-box{
  background-color: #1d95d2;
}

.pricing-block:nth-child(2) .inner-box:hover .btn-box a{
  color:#1d95d2;
  background:none;
  border-radius:0px;
  border-color:#1d95d2;
}

.pricing-block:nth-child(2) .icon-box i,
.pricing-block:nth-child(2) .price{
  color: #1d95d2;
}

.pricing-block:nth-child(3) .icon-box i,
.pricing-block:nth-child(3) .inner-box{
  border-color: #ffc20b;
}

.pricing-block:nth-child(3) .btn-box a,
.pricing-block:nth-child(3) .icon-box{
  background-color: #ffc20b;
}

.pricing-block:nth-child(3) .icon-box i,
.pricing-block:nth-child(3) .price{
  color: #ffc20b;
}

.pricing-block:nth-child(3) .inner-box:hover .btn-box a{
  color:#ffc20b;
  background:none;
  border-radius:0px;
  border-color:#ffc20b;
}
.features li {
    position: relative;
    padding-left: 25px;
    margin-bottom: 8px;
    list-style: none;
}

.features li::before {
    position: absolute;
    left: 0;
    top: 0;
    font-weight: bold;
    font-size: 16px;
}

.features li.true::before {
    content: "✔";
    color: green;
}

.features li.false::before {
    content: "✖" !important;
    color: red;
}

.expo-tienda{
    background-color: gray  ;
    padding: 0.5rem;
    width: min-content;
white-space: nowrap;
border-radius: 0.5rem;
margin-bottom: 0.5rem;
color: white;
text-decoration: none;
}
.expo-tienda:hover{
    
color: white;
text-decoration: none;
background-color: rgb(159, 159, 159);
}

@media (max-width: 768px) {
  .pricing-section {
    padding: 0 !important;
  }
}
</style>
{include file="header-offlog.tpl"}

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">   

<div class="container"> 


<div class="crear-tienda-instrucciones mt-4">
    <img src="images/crear-tienda1.png" alt=""> <!--1200 X 69PX-->
</div>
<section class="pricing-section">
    <div class="container">

        <div class="outer-box">
            <div class="row">
                <!-- Plan Inicial -->
                <div class="pricing-block col-lg-4 col-md-6 col-sm-12 wow fadeInUp">
                    <div class="inner-box">
                        <div class="icon-box">
                            <div class="icon-outer">
                            <svg width="100" height="100" fill="none" stroke="#40cbb4" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.143 10.857h4.571l-6.857 10.286v-7.997l-4.571-.003 6.857-10.286v8Z"></path>
                            </svg></div>
                        </div>
                        <div class="price-box">
                            <div class="title">Inicial</div>
                            <h4 class="price">Ideal para emprendedores pequeños</h4>
                        </div>
                        <ul class="features">
                            <li class="true">Hasta 12 productos</li>
                            <li class="true">Administración de pedidos básica</li>
                            <li class="true">Todo en una página + buscador</li>
                            <li class="true">Gestión de inventario básica</li>
                            <li class="false">Estadísticas avanzadas</li>
                            <li class="false">Soporte por chat</li>
                            <li class="true">Subdominio gratuito</li>
                            <li class="false">Comentarios en productos</li>
                            <li class="false">Avisos por mail</li>
                            <li class="true">Logo (nivel marca)</li>
                            <li class="false">Conexión con sistema de facturación</li>
                             <li class="true">Conexión con Mercado Pago</li>
                        </ul>
                     
                    </div>
                </div>

                <!-- Plan Medio -->
                <div class="pricing-block col-lg-4 col-md-6 col-sm-12 wow fadeInUp" data-wow-delay="400ms">
                    <div class="inner-box">
                        <div class="icon-box">
                            <div class="icon-outer">
                            <svg width="100" height="100" fill="none" stroke="#1d95d2" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="m13.134 4.648 5.714 3.265A2.286 2.286 0 0 1 20 9.898v5.347c0 .82-.44 1.578-1.152 1.985l-5.714 3.265a2.286 2.286 0 0 1-2.268 0L5.152 17.23A2.286 2.286 0 0 1 4 15.245V9.898c0-.82.44-1.578 1.152-1.985l5.714-3.265a2.286 2.286 0 0 1 2.268 0Z" clip-rule="evenodd"></path>
                            <path d="M16 10.857 8 6.286"></path>
                            <path d="m4.571 9.143 6.345 3.416a2.283 2.283 0 0 0 2.168 0l6.345-3.416"></path>
                            <path d="M12 13.143v7.428"></path>
                            </svg>
                            </div>
                        </div>
                        <div class="price-box">
                            <div class="title">Medio</div>
                            <h4 class="price">Especial para tiendas con experiencia</h4> <!-- Reemplazá Y por el precio -->
                        </div>
                        <ul class="features">
                            <li class="true">Hasta 50 productos</li>
                            <li class="true">Administración de pedidos básica</li>
                            <li class="true">Búsqueda, páginas independientes, categorías</li>
                            <li class="true">Gestión de inventario completa</li>
                            <li class="false">Estadísticas avanzadas</li>
                            <li class="true">Soporte por chat</li>
                            <li class="true">Subdominio gratuito</li>
                            <li class="false">Comentarios en productos</li>
                            <li class="true">Alertas básicas por mail</li>
                            <li class="true">Logo y Banner</li>
                            <li class="true">Conexión con Cypher Gestión</li>
                            <li class="true">Conexión con Mercado Pago</li>
                        </ul>
                       
                    </div>
                </div>

                <!-- Plan Completo -->
                <div class="pricing-block col-lg-4 col-md-6 col-sm-12 wow fadeInUp" data-wow-delay="800ms">
                    <div class="inner-box">
                        <div class="icon-box">
                            <div class="icon-outer">
                            <svg width="100" height="100" fill="none" stroke="#ffc20b" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="m17.714 4.571 3.429 4.572L12 20.57 2.857 9.143 6.296 4.57h11.418Z" clip-rule="evenodd"></path>
                            <path d="M2.857 9.143h18.286"></path>
                            <path d="M8.571 9.143 12 20.57"></path>
                            <path d="M15.429 9.143 12 20.57"></path>
                            <path d="m6.296 4.571 2.275 4.572L12 4.57l3.429 4.572 2.285-4.572"></path>
                            </svg>
                            </div>
                        </div>
                        <div class="price-box">
                            <div class="title">Completo</div>
                            <h4 class="price">E-commerce / Grandes tiendas / Distribuidoras </h4> <!-- Reemplazá Y por el precio -->
                        </div>
                        <ul class="features">
                            <li class="true">Productos ilimitados</li>
                            <li class="true">Administración completa con filtros</li>
                            <li class="true">Búsqueda, páginas independientes, categorías</li>
                            <li class="true">Gestión de inventario completa</li>
                            <li class="true">Estadísticas avanzadas</li>
                            <li class="true">Soporte por chat</li>
                            <li class="true">Subdominio gratuito</li>
                            <li class="true">Comentarios y calificaciones</li>
                            <li class="true">Avisos por mail personalizados</li>
                            <li class="true">Logo y Banner</li>
                            <li class="true">Conexión con Cypher Gestión</li>
                             <li class="true">Conexión con Mercado Pago</li>
                        </ul>
                      
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

    

<div class="crear-tienda-instrucciones mt-4">
    <img src="images/crear-tienda2.png" alt=""> <!--1200 X 69PX-->
</div>


<ul class="nav nav-tabs mt-1" id="myTab" role="tablist">
    <li class="nav-item mr-1" role="presentation">
        <a class="nav-link active bg-inicial" id="inicial-tab" data-bs-toggle="tab" href="#inicial" role="tab" aria-controls="inicial" aria-selected="true">Inicial</a>
    </li>
    <li class="nav-item  mr-1" role="presentation">
        <a class="nav-link  bg-medio" id="medio-tab" data-bs-toggle="tab" href="#medio" role="tab" aria-controls="medio" aria-selected="false">Medio</a>
    </li>
    <li class="nav-item  mr-1" role="presentation">
        <a class="nav-link bg-completo" id="completa-tab" data-bs-toggle="tab" href="#completo" role="tab" aria-controls="completo" aria-selected="false">Completa</a>
    </li>
</ul>

<div class="tab-content crear-tienda-page-tab-content" id="crearTiendaTabContent">
    <div class="tab-pane fade show active bg-inicial p-4" id="inicial" role="tabpanel" aria-labelledby="inicial-tab">
        <div class="crear-tienda-page-plantilla-list">
            {foreach from=$plantillas item=plantilla}
                {if $plantilla.seleccionable == 1 && $plantilla.grupo == 'I'}
                    <div class="crear-tienda-page-card">
                        <img src="{$plantilla.imagen}" alt="{$plantilla.nombre}" class="crear-tienda-page-card-img">
                        <div class="crear-tienda-page-card-info">
                            <h5 class="crear-tienda-page-card-title">{$plantilla.nombre}</h5>
                            {assign var="precio_original" value=($plantilla.precio * 1.1)|number_format:2:'.':''}

                            <p class="crear-tienda-page-card-price">
                                <span style="text-decoration: line-through; color: #888; font-size: 14px;">
                                    ${$precio_original}
                                </span>
                                <span style="font-weight: bold; margin-left: 8px;">
                                    ${$plantilla.precio}
                                </span>
                                / mes
                                <span style="background-color: #28a745; color: #fff; padding: 5px 10px; border-radius: 5px; font-size: 14px; font-weight: bold; display: inline-block;">
                                    + 2 meses de prueba
                                </span>
                            </p>






                            </p>
                            <p class="crear-tienda-page-card-description">{$plantilla.descripcion}</p>
<a href="https://cyshops.com/ejemploTiendaInicial" class="expo-tienda" target="_blank">Ver Tienda de ejemplo</a>

                            <button 
                                class="crear-tienda-page-card-accion-button"
                                data-img="{$plantilla.imagen}"
                                data-title="{$plantilla.nombre}"
                                data-price="{$plantilla.precio}"
                                data-id="{$plantilla.id_tipo_plantilla}"
                                data-description="{$plantilla.descripcion}"
                                onclick="seleccionarTienda(this)"
                            >
                                Seleccionar tienda
                            </button>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>
    </div>

    <div class="tab-pane fade bg-medio p-4" id="medio" role="tabpanel" aria-labelledby="medio-tab">
        <div class="crear-tienda-page-plantilla-list">
            {foreach from=$plantillas item=plantilla}
                {if $plantilla.seleccionable == 1 && $plantilla.grupo == 'M'}
                    <div class="crear-tienda-page-card">
                        <img src="{$plantilla.imagen}" alt="{$plantilla.nombre}" class="crear-tienda-page-card-img">
                        <div class="crear-tienda-page-card-info">
                            <h5 class="crear-tienda-page-card-title">{$plantilla.nombre}</h5>
{assign var="precio_original" value=($plantilla.precio * 1.1)|number_format:2:'.':''}

                            <p class="crear-tienda-page-card-price">
                                <span style="text-decoration: line-through; color: #888; font-size: 14px;">
                                    ${$precio_original}
                                </span>
                                <span style="font-weight: bold; margin-left: 8px;">
                                    ${$plantilla.precio}
                                </span>
                                / mes
                                <span style="background-color: #28a745; color: #fff; padding: 5px 10px; border-radius: 5px; font-size: 14px; font-weight: bold; display: inline-block;">
                                    + 2 meses de prueba
                                </span>
                            </p>






                            </p> 
                            <p class="crear-tienda-page-card-description">{$plantilla.descripcion}</p>
                           <a href="https://cyshops.com/ejemploTiendaMedio" class="expo-tienda" target="_blank">Ver Tienda de ejemplo</a>

                            <button 
                                class="crear-tienda-page-card-accion-button"
                                data-img="{$plantilla.imagen}"
                                data-title="{$plantilla.nombre}"
                                data-price="{$plantilla.precio}"
                                data-id="{$plantilla.id_tipo_plantilla}"
                                data-description="{$plantilla.descripcion}"
                                onclick="seleccionarTienda(this)"
                            >
                                Seleccionar tienda
                            </button>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>
    </div>

    <div class="tab-pane fade bg-completo p-4" id="completo" role="tabpanel" aria-labelledby="completo-tab">
        <div class="crear-tienda-page-plantilla-list">
            {foreach from=$plantillas item=plantilla}
                {if $plantilla.seleccionable == 1 && $plantilla.grupo == 'C'}
                    <div class="crear-tienda-page-card">
                        <img src="{$plantilla.imagen}" alt="{$plantilla.nombre}" class="crear-tienda-page-card-img">
                        <div class="crear-tienda-page-card-info">
                            <h5 class="crear-tienda-page-card-title">{$plantilla.nombre}</h5>
{assign var="precio_original" value=($plantilla.precio * 1.1)|number_format:2:'.':''}

                            <p class="crear-tienda-page-card-price">
                                <span style="text-decoration: line-through; color: #888; font-size: 14px;">
                                    ${$precio_original}
                                </span>
                                <span style="font-weight: bold; margin-left: 8px;">
                                    ${$plantilla.precio}
                                </span>
                                / mes
                                <span style="background-color: #28a745; color: #fff; padding: 5px 10px; border-radius: 5px; font-size: 14px; font-weight: bold; display: inline-block;">
                                    + 2 meses de prueba
                                </span>
                            </p>






                            </p>
                            <p class="crear-tienda-page-card-description">{$plantilla.descripcion}</p>
                            <a href="https://cyshops.com/ejemploTiendaComp" class="expo-tienda" target="_blank">Ver Tienda de ejemplo</a>

                            <button 
                            class="crear-tienda-page-card-accion-button"
                            data-img="{$plantilla.imagen}"
                            data-title="{$plantilla.nombre}"
                            data-price="{$plantilla.precio}"
                            data-id="{$plantilla.id_tipo_plantilla}"
                            data-description="{$plantilla.descripcion}"
                            data-id_user="{if isset($smarty.session.ID_USER)}{$smarty.session.ID_USER}{else}0{/if}"
                            onclick="seleccionarTienda(this)"
                        >
                        
                                Seleccionar tienda
                            </button>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>
    </div>
</div>


{if isset($smarty.session.VENDEDOR) && $smarty.session.VENDEDOR == 1}
<div class="mensaje-tiempo">
    <div class="mensaje-contenido">
        <h3>USTED YA TIENE SU TIENDA</h3>
    </div>
</div>
{else}
    <div class="card mt-4" id="tiendaSeleccionada" style="display: none;">
        
        <div class="card-header crear-tienda-seleccionados-contenedor">
            <h5 id="seleccion-titulo" class="crear-tienda-seleccionados-titulo"></h5>
            <img id="seleccion-imagen" src="" alt="" class="crear-tienda-seleccionados-imagen img-fluid" style="max-width: 200px;">
            <p id="seleccion-precio" class="crear-tienda-seleccionados-precio"></p>
            <p id="seleccion-descripcion" class="crear-tienda-seleccionados-descripcion"></p>
        </div>
        
            <div class="card-body">

           <div class="mb-3">
                <label for="shopName" class="form-label">Nombre de la tienda</label>
                <input type="text" class="form-control" id="shopName" name="shopName" required placeholder="Nombre de la tienda">
                <small>Por favor coloque aqui el nombre de su local, este nombre puede ser el que usted desee, es el que aparecera como nombre de su tienda</small>
            </div>
                
                <div class="mb-3">
                    <label for="shopName" class="form-label">Dominio</label>
                    <input type="text" class="form-control" id="shopUniqueName" name="shopUniqueName" required oninput="this.value = this.value.replace(/\s/g, '')" placeholder="Dominio"> 
                   <small>
                        Este será el nombre único que identifica a su tienda en internet. 
                        Puede usar el mismo nombre que escribió arriba, pero sin espacios ni símbolos especiales. 
                        Por ejemplo, si su tienda se llama <strong>Zapatería El Sol</strong>, puede escribir <strong>zapateriaelsol</strong> aquí. 
                        Así, la dirección de su tienda será algo como: <strong>www.cyshops.com/zapateriaelsol</strong><br>
                        Este nombre debe ser único, es decir, no puede estar siendo usado por otra tienda. 
                        Si al escribirlo aparece un mensaje en rojo debajo, significa que debe elegir otro nombre.
                    </small>

                    <p class="text-danger " id="error_modal_existente"></p>
                </div>
                <hr>

                {* <div class="mb-3">
                    <label for="shopName" class="form-label">CBU / CVU</label>
                    <input type="text" class="form-control" id="CBU" name="CBU" required>
                    <small>Ingrese CBU o CVU como opcion para que tus compradores puedan realizar una trasnferencia</small>

                </div>
                <div class="mb-3">
                    <label for="shopName" class="form-label">Alias</label>
                    <input type="text" class="form-control" id="alias" name="alias" required>
                    <small>Ingrese alias como opcion para que tus compradores puedan realizar una trasnferencia</small>

                </div> *}
                


                    <input type="hidden" class="form-control" id="shopTemplate" name="shopTemplate" value="" required>
                    <input type="hidden" class="form-control" id="id_user" name="id_user" value="{$smarty.session.ID_USER}" required>

                    <div class="mb-3 pl-4">
                        <input type="checkbox" id="hasCode" name="hasCode" class="form-check-input" onclick="toggleInput()">
                        <label for="hasCode" class="form-check-label">¿Usted tiene un código?</label>
                    </div>
                    
                    <div class="mb-3 " id="inputContainer" style="display: none;">
                        <label for="codigo" class="form-label" id="shopLabel">Código:</label>
                        <input type="text" class="form-control" id="codigo" name="codigo" required>
                    </div>
                    
                    <script>
                        function toggleInput() {
                            const checkbox = document.getElementById('hasCode');
                            const inputContainer = document.getElementById('inputContainer');
                            
                            // Mostrar u ocultar el input según el estado del checkbox
                            if (checkbox.checked) {
                                inputContainer.style.display = 'block';
                            } else {
                                inputContainer.style.display = 'none';
                            }
                        }
                    </script>
            


                    <button onclick="validarTienda()" class="btn btn-success">Crear tienda</button>
            </div>

            {/if}
        </div>
</div>




<script type="text/javascript " src="js/user.js"></script>
<script type="text/javascript " src="js/admin.js"></script>
{include file="footer.tpl"}
