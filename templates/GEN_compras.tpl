{include file="header-offlog.tpl"}

<style>
  .progress-bar-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;
  }

  .progress-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    width: 20%;
    text-align: center;
  }

  .progress-step .step-circle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 2px solid #ddd;
    background-color: #fff;
    position: relative;
    z-index: 2;
    margin-bottom: 0.5rem;
  }

  .progress-step .step-circle.filled {
    background-color: #28a745;
    border-color: #28a745;
  }

  .tick-icon {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: #fff;
  }

  .progress-step .step-label {
    margin-top: 5px;
    font-size: 12px;
    white-space: normal;
    line-height: 1.2;
  }

  .progress-step.completed .step-circle {
    border-color: #28a745;
  }

  .progress-bar-container::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    height: 2px;
    background-color: #ddd;
    z-index: 1;
  }

  .progress-step.completed + .progress-step::before {
    background-color: #28a745;
  }

  @media (max-width: 767px) {
    .progress-bar-container {
      display: none;
    }

    .progress-step {
      width: 100%;
      text-align: center;
    }

    .progress-step .step-label {
      display: block;
    }

    .progress-step:not(.current) {
      display: none;
    }
  }

  .ticket-bottom-shape {
  padding-bottom: 4rem;
  clip-path: polygon(
    0 0, 100% 0, 100% 95%,
    98% 100%, 96% 95%, 94% 100%, 92% 95%, 90% 100%,
    88% 95%, 86% 100%, 84% 95%, 82% 100%, 80% 95%, 78% 100%, 76% 95%, 74% 100%,
    72% 95%, 70% 100%, 68% 95%, 66% 100%, 64% 95%, 62% 100%, 60% 95%, 58% 100%,
    56% 95%, 54% 100%, 52% 95%, 50% 100%, 48% 95%, 46% 100%, 44% 95%, 42% 100%,
    40% 95%, 38% 100%, 36% 95%, 34% 100%, 32% 95%, 30% 100%, 28% 95%, 26% 100%,
    24% 95%, 22% 100%, 20% 95%, 18% 100%, 16% 95%, 14% 100%, 12% 95%, 10% 100%,
    8% 95%, 6% 100%, 4% 95%, 2% 100%, 0 95%
  );
}

@media (max-width: 600px) {
  .ticket-bottom-shape {
    clip-path: polygon(
      0 0, 100% 0, 100% 95%,
      96% 100%, 92% 95%, 88% 100%, 84% 95%, 80% 100%,
      76% 95%, 72% 100%, 68% 95%, 64% 100%, 60% 95%, 56% 100%, 52% 95%, 48% 100%,
      44% 95%, 40% 100%, 36% 95%, 32% 100%, 28% 95%, 24% 100%, 20% 95%, 16% 100%,
      12% 95%, 8% 100%, 4% 95%, 0 100%
    );
  }
}


.miscompras-card{
  background-color: #fff;
  box-shadow: 0px 10px 40px -3px rgba(0,0,0,.5);
  margin-bottom: 5rem;
  }


.miscompras-card-header{
  padding: 1.25rem;
 
  display: flex;
  justify-content: space-between;
  align-items: center;

}

.miscompras-card-header img{
  margin-right: 1rem;
 width: 50px;
}

.miscompras-card-header h5, .miscompras-card-header a{
 margin: 0px;
}
.social-icons {
      margin-top: 10px;
      display: flex;
      justify-content: center;
      gap: 12px;
    }

    .social-icons img {
      width: 32px;
      height: 32px;
      cursor: pointer;
    }

    .pedido-footer{
      padding: 1.25rem;
    }


    .pd-alert {
  padding: 12px 16px;
  border-radius: 6px;
  font-size: 14px;
  margin-bottom: 16px;
  border: 1px solid transparent;
}

.pd-alert-warning {
  background-color: #fff3cd;
  color: #856404;
  border-color: #ffeeba;
}

.ticket-table-container {

  max-width: 100%;
  margin: auto;
  font-family: Arial, sans-serif;
  background-color: transparent;
}

.ticket-responsive {
  overflow-x: auto;
}

.ticket-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 320px;
}

.ticket-table th, .ticket-table td {
  padding: 12px;
  text-align: left;
  border: 1px dashed #c7c7c78c; /* Bordes punteados */
  background-color: transparent;
}

.ticket-table thead {
  background-color: transparent;
}

.ticket-table a {
  color: #007bff;
  text-decoration: none;
}

.ticket-table a:hover {
  text-decoration: underline;
}

.envio-row td, .total-row td {
  font-weight: bold;
  background-color: transparent;
}

@media (max-width: 600px) {
  .ticket-table th, .ticket-table td {
    padding: 8px;
    font-size: 14px;
  }
}



</style>

<body>
  <div class="container mt-5">
    <div class="row">
      {if $compras|@count == 0}
        <h2 class="text-center">No tienes pedidos</h2>
      {else}
        {foreach from=$compras item=compra}
          <div class="col-md-12 mb-4 ">
            <div class="miscompras-card ticket-bottom-shape">
             <div class="miscompras-card-header" style="background-color: {$compra->color}; color: {$compra->color_texto};">
              <div>
                <img src="  {$compra->logoTienda}" alt="">
                <a href="{$compra->shopName}" style=" color: {$compra->color_texto};">{$compra->nombreTienda}</a>
            
              </div>
              <div>
                <small class="card-title">Cód. C. <strong>{$compra->codigo_compra}</strong></small>

              </div>
              
             
             </div>

              <div class="card-body">


                {* Barra de progreso dinámica *}
                <!-- NO TOCAR -->
                <div class="progress-bar-container mb-3">
                  {assign var=hayUbicacion value=($compra->contacto && $compra->contacto->ubicacion)}
                  {assign var=pasos value=[1,2,3]}
                  {foreach from=$pasos item=i}
                    <div class="progress-step {if $compra->estado >= $i}completed{/if} {if $compra->estado == $i}current{/if}">
                      <div class="step-circle {if $compra->estado >= $i}filled{/if}">
                        {if $compra->estado >= $i}
                          <svg class="tick-icon" width="12" height="12" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20 6 9 17l-5-5"></path>
                          </svg>
                        {/if}
                      </div>
                      <div class="step-label">{$estadoNombres[$i]}</div>
                    </div>
                  {/foreach}

                  {if !$hayUbicacion}
                    <div class="progress-step {if $compra->estado >= 4}completed{/if} {if $compra->estado == 4}current{/if}">
                      <div class="step-circle {if $compra->estado >= 4}filled{/if}">
                        {if $compra->estado >= 4}
                          <svg class="tick-icon" width="12" height="12" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20 6 9 17l-5-5"></path>
                          </svg>
                        {/if}
                      </div>
                      <div class="step-label">{$estadoNombres[4]}</div>
                    </div>
                  {/if}

                  {if $hayUbicacion}
                    <div class="progress-step {if $compra->estado >= 5}completed{/if} {if $compra->estado == 5}current{/if}">
                      <div class="step-circle {if $compra->estado >= 5}filled{/if}">
                        {if $compra->estado >= 5}
                          <svg class="tick-icon" width="12" height="12" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20 6 9 17l-5-5"></path>
                          </svg>
                        {/if}
                      </div>
                      <div class="step-label">{$estadoNombres[5]}</div>
                    </div>
                  {/if}

                  <div class="progress-step {if $compra->estado >= 99}completed{/if} {if $compra->estado == 99}current{/if}">
                    <div class="step-circle {if $compra->estado >= 99}filled{/if}">
                      {if $compra->estado >= 99}
                        <svg class="tick-icon" width="12" height="12" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                          <path d="M20 6 9 17l-5-5"></path>
                        </svg>
                      {/if}
                    </div>
                    <div class="step-label">{$estadoNombres[99]}</div>
                  </div>
                </div>
                
                {if $compra->contacto && $compra->contacto->ubicacion}
                <div class="pd-alert pd-alert-warning">
                  Este pedido se debe retirar en la siguiente dirección: 
                  <strong>{$compra->contacto->ubicacion}</strong>
                </div>
              {/if}



                <p class="card-text">Fecha: {$compra->fecha}</p>
                <p class="card-text">Estado Actual: {$estadoNombres[$compra->estado]}</p>

              

                

                {if $compra->productos|@count > 0}
                  <div class="ticket-table-container">
                    <h2>Detalle de Compra</h2>
                  
                    <div class="ticket-responsive">
                      <table class="ticket-table">
                        <thead>
                          <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                          </tr>
                        </thead>
                        <tbody>
                          {foreach from=$compra->productos item=producto}
                          <tr>
                            <td><a href="{$compra->shopName}/product/{$producto.id_producto}">{$producto.nombre}</a></td>
                            <td>{$producto.quantity}</td>
                            <td>$ {$producto.subtotal|default:0|number_format:2}</td>
                          </tr>
                          {/foreach}
                          <tr class="envio-row">
                            <td colspan="2">Costo de Envío</td>
                            <td>$ {$compra->costo_envio|default:0|number_format:2}</td>
                          </tr>
                          <tr class="total-row">
                            <td colspan="2"><strong>Total</strong></td>
                            <td><strong>$ {$compra->total|default:0|number_format:2}</strong></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  {/if}
                  
              </div>

              <div class="pedido-section pedido-footer">
                {if isset($compra->contacto->email) && $compra->contacto->email neq ''}
                  <p><strong>Email:</strong> rustmatiasdev@gmail.com</p>
                {/if}
                  {if isset($compra->contacto->telefono) && $compra->contacto->telefono neq ''}
                  <p><strong>Teléfono:</strong> 213123444</p>
                {/if}
                
                  <div class="social-icons">
                  {if isset($compra->contacto->whatsapp) && $compra->contacto->whatsapp neq ''}
                  <a href="https://wa.me/{$compra->contacto->whatsapp|escape}" class="text-dark" target="_blank">
                    <img src="https://cdn-icons-png.flaticon.com/512/733/733585.png" alt="WhatsApp" title="WhatsApp">
                    </a>
                  {/if}
                  {if isset($compra->contacto->facebook) && $compra->contacto->facebook neq ''}
                    <a href="{$compra->contacto->facebook|escape}" class="text-dark" target="_blank">
                    <img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook" title="Facebook">
                    </p>
                  {/if}
                    {if isset($compra->contacto->instagram) && $compra->contacto->instagram neq ''}
                      <a href="{$compra->contacto->instagram|escape}" class="text-dark" target="_blank">
                      <img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="Instagram" title="Instagram">
                      </a>
                  {/if}
                  </div>
                </div>
            </div>
            
          </div>
          
        {/foreach}
      {/if}
    </div>
  </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

{include file="footer.tpl"}