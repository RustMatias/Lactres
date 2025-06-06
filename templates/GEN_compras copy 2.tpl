<!DOCTYPE html>
<html lang="es">
<head>
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-8312971164659380"
     crossorigin="anonymous"></script>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Layout con Pedido</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: #f4f4f4;
    }

    .compras-layout {
      display: grid;
      grid-template-columns: 1fr 2fr 1fr;
      gap: 20px;
      padding: 20px;
    }

    .compras-col {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .compras-left, .compras-right {
      background-color: #e0e0e0;
    }

    @media (max-width: 768px) {
      .compras-layout {
        grid-template-columns: 1fr;
      }

      .compras-left, .compras-right {
        display: none;
      }
    }

    /* Tarjeta del pedido */
    .pedido-container {
      background: #fff;
      width: 100%;
      margin: auto;
      margin-bottom: 1rem;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      overflow: hidden;
    }

    .pedido-header {
      background: #ffe600;
      padding: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .pedido-header img {
      height: 30px;
    }

    .pedido-body {
      padding: 20px;
    }

    .pedido-section {
      margin-bottom: 20px;
    }

    .pedido-section strong {
      display: inline-block;
      width: 130px;
    }

    .pedido-detalles {
      border-top: 1px solid #ccc;
      padding-top: 15px;
    }

    .producto {
      margin-top: 10px;
    }

    .producto p {
      margin: 5px 0;
    }

    .pedido-footer {
      border-top: 1px solid #ccc;
      padding-top: 15px;
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

    @media (max-width: 600px) {
      .pedido-section strong {
        width: 100%;
      }

      .pedido-section {
        display: flex;
        flex-direction: column;
      }

      .pedido-body {
        padding: 16px;
      }
    }

    .compras-center{
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      width: 100%;
    }

  </style>
</head>
<body>

<div class="compras-layout">
  <div class="compras-col compras-left">Columna Izquierda (1/4)</div>

  <div class=" compras-center">
    {foreach from=$compras item=compra}
    <div class="pedido-container">
      <div class="pedido-header">
        <img src="https://http2.mlstatic.com/frontend-assets/ml-web-navigation/ui-navigation/6.4.2/mercadolibre/logo__large_plus.png" alt="Mercado Libre">
      </div>

      <div class="pedido-body">
        <div class="pedido-section">
          <p><strong>Código de Compra:</strong> 21-A320FC67</p>
          <p><strong>Fecha:</strong> 2025-04-24 19:37:12</p>
          <p><strong>Estado Actual:</strong> Preparando Pedido</p>
          <p><strong>Retiro en:</strong> asd</p>
        </div>

        <div class="pedido-section pedido-detalles">
      
          

          {assign var=hayUbicacion value=($compra->contacto && $compra->contacto->ubicacion)}
          {assign var=pasos value=[1,2,3]}
          {if $compra->productos|@count > 0}
            <h4>Detalles de los Productos</h4>
         
              {foreach from=$compra->productos item=producto}


                <div class="producto">
                  <p>  <strong><a href="{$compra->shopName}/product/{$producto.id_producto}">{$producto.nombre}</a></strong></p>
                  <p><strong>Cantidad:</strong>  {$producto.quantity}</p>
                  <p><strong>Subtotal:</strong>  ${$producto.subtotal|default:0|number_format:2}</p>
                </div>
              {/foreach}
         
              <h6>Costo de Envío: ${$compra->costo_envio|default:0|number_format:2}</h6>

              <h6>Total: ${$compra->total|default:0|number_format:2}</h6>
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
            <a href="https://facebook.com/{$compra->contacto->facebook|escape}" class="text-dark" target="_blank">
            <img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook" title="Facebook">
            </p>
          {/if}
            {if isset($compra->contacto->instagram) && $compra->contacto->instagram neq ''}
              <a href="https://instagram.com/{$compra->contacto->instagram|escape}" class="text-dark" target="_blank">
              <img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="Instagram" title="Instagram">
              </a>
          {/if}
          </div>
        </div>
      </div>
    </div>
  {/foreach}
  </div>

  <div class="compras-col compras-right">


</div>
</div>

</body>
</html>
