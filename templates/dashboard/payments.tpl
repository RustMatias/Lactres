<div class="left-content">
   <div class="activities">
      <h1>Tus págos</h1>
      <style>
         #form-checkout {
 
         padding: 0.5rem;
         border-radius: 12px;
         max-width: 420px;
         width: 100%;
         display: flex;
         flex-direction: column;
         gap: 1rem;
         }
         #form-checkout .container,
         #form-checkout input,
         #form-checkout select {
         height: 42px;
         padding: 0 12px;
         border: 1px solid #ccc;
         border-radius: 6px;
         font-size: 14px;
         outline: none;
  
         transition: border-color 0.2s;
         }
         #form-checkout .container:focus-within,
         #form-checkout input:focus,
         #form-checkout select:focus {
         border-color: #007bff;
         }
         #form-checkout__submit {
         height: 45px;
         background-color: #007bff;
         color: #fff;
         font-weight: 600;
         font-size: 16px;
         border: none;
         border-radius: 6px;
         cursor: pointer;
         transition: background-color 0.2s;
         }
         #form-checkout__submit:hover {
         background-color: #0056b3;
         }
         .progress-bar {
         width: 100%;
          height: 8px;
  

         }
        
      </style>
      
     
      <div class="activity-container">
         <div class="dashboard-payments-container">
            <div class="dashboard-payments-expiration">
               {assign var="fecha_actual" value=$smarty.now|date_format:"%Y-%m-%d"}
               <strong>
               El vencimiento de tu tienda es el {$pagosInfo.fecha_vencimiento}
               {if $pagosInfo.fecha_vencimiento < $fecha_actual}
               <span class="dashboard-payments-expired">
               (VENCIDO)
               <small>Abone para volver a habilitar la tienda.</small>
               </span>
               {/if}
               </strong>
            </div>
            <div class="dashboard-payments-box">
               <small class="dashboard-payments-note">
               Si hay algún problema con el pago, un administrador se contactará con usted mediante la información de su perfil.
               </small>
               <hr class="dashboard-payments-separator">
               <table class="dashboard-payments-table">
                  <thead>
                     <tr>
                        <th>Fecha</th>
                        <th>Monto</th>
                        <th>Estado</th>
                     </tr>
                  </thead>
                  <tbody>
                     {foreach from=$pagosInfo.pagos item=pago}
                     <tr>
                        <td>{$pago.fecha}</td>
                        <td>{$pago.monto}</td>
                        <td class="dashboard-payments-status">
                           {if $pago.pago == 0}
                           Esperando
                           <svg width="25" height="25" fill="none" stroke="orange" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path d="M12 2a10 10 0 1 0 0 20 10 10 0 1 0 0-20z"></path>
                              <path d="M12 6v6l4 2"></path>
                           </svg>
                           {elseif $pago.pago == 1}
                           Validado
                           <svg width="25" height="25" fill="none" stroke="green" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path d="M20 6 9 17l-5-5"></path>
                           </svg>
                           {elseif $pago.pago == 2}
                           Reintentar
                           <svg width="25" height="25" fill="none" stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path d="M18 6 6 18"></path>
                              <path d="m6 6 12 12"></path>
                           </svg>
                           {/if}
                        </td>
                     </tr>
                     {/foreach}
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="right-content">

<div>
<form id="form-checkout">
  <h3>Abonar</h3>
         
         <div id="form-checkout__cardNumber" class="container"></div>
       
         <div id="form-checkout__expirationDate" class="container"></div>
       
         <div id="form-checkout__securityCode" class="container"></div>
         <input type="text" id="form-checkout__cardholderName" />
         <select id="form-checkout__issuer"></select>
         <select id="form-checkout__installments"></select>
         <select id="form-checkout__identificationType"></select>
         <input type="text" id="form-checkout__identificationNumber" />
         <input type="email" id="form-checkout__cardholderEmail" />
         <button type="submit" id="form-checkout__submit">Pagar</button>
         <progress value="0" class="progress-bar">Cargando...</progress>
         <input type="hidden" id="monto" value="{$pagosInfo.precio_plantilla}">
        <input type="hidden" id="id_tienda" value="{$pagosInfo.id_tienda}">
        <input type="hidden" id="id_usuario" value="{$pagosInfo.id_user}">
  </form>
</div>



  {*  <div class="algo">
      <div class="dashboard-payments-transfer-box">
         <h3 class="dashboard-payments-title">Datos de transferencia</h3>
         <hr class="dashboard-payments-separator">
         <small class="dashboard-payments-note">
         <strong>Nota:</strong> Recuerde que su comprobante tendrá que ser procesado por un administrador en caso de hacer la transferencia manual. Podría tardar unos minutos. Recomendamos pagar con antelación el servicio.
         </small>
         <small class="dashboard-payments-subnote">
         En la referencia de la transferencia escriba lo correspondiente.
         </small>
         <hr class="dashboard-payments-separator">
         <table class="dashboard-payments-transfer-table">
            <tr>
               <td class="dashboard-payments-label">Precio:</td>
               <td class="dashboard-payments-value">$ARS {$pagosInfo.precio_plantilla}</td>
            </tr>
            <tr>
               <td class="dashboard-payments-label">Alias:</td>
               <td class="dashboard-payments-value">cyshops.pagos</td>
            </tr>
            <tr>
               <td class="dashboard-payments-label">CBU/CVU:</td>
               <td class="dashboard-payments-value">0000003100022408294409</td>
            </tr>
            <tr>
               <td class="dashboard-payments-label">Referencia:</td>
               <td class="dashboard-payments-value"><strong>U{$pagosInfo.id_user}T{$pagosInfo.id_tienda}</strong></td>
            </tr>
         </table>
         <div>
            <button class="dashboard-payments-button" onclick="openComprobanteModal()">Realizar transferencia</button>
            <hr class="dashboard-payments-separator">
            <a class="dashboard-payments-link" href="https://wa.link/08l8x3" target="_blank" rel="noopener noreferrer">
            Si tiene alguna duda, póngase en contacto con nosotros haciendo clic aquí y deje su consulta.
            </a>
         </div>
      </div>
   </div> *}
   <!-- Modal personalizado -->
   <div class="dashboard-payments-modal" id="comprobanteModal">
      <div class="dashboard-payments-modal-content">
         <div class="dashboard-payments-modal-header">
            <h5 class="dashboard-payments-modal-title">Cargar Comprobante</h5>
            <button class="dashboard-payments-modal-close" onclick="closeComprobanteModal()">×</button>
         </div>
         <div class="dashboard-payments-modal-body">
            <form action="pagarServicio" method="POST" enctype="multipart/form-data">
               
               <table class="dashboard-payments-transfer-table">
                  <tr>
                     <td class="dashboard-payments-label">Precio:</td>
                     <td class="dashboard-payments-value">$ {$pagosInfo.precio_plantilla}</td>
                  </tr>
                  <tr>
                     <td class="dashboard-payments-label">Alias:</td>
                     <td class="dashboard-payments-value">rust.matias.dni</td>
                  </tr>
                  <tr>
                     <td class="dashboard-payments-label">CBU:</td>
                     <td class="dashboard-payments-value">0140334103620552268803</td>
                  </tr>
                  <tr>
                     <td class="dashboard-payments-label">Referencia:</td>
                     <td class="dashboard-payments-value"><strong>U{$pagosInfo.id_user}T{$pagosInfo.id_tienda}</strong></td>
                  </tr>
               </table>
               <hr class="dashboard-payments-separator">
               <label for="input_image" class="dashboard-payments-upload-label">Subir comprobante</label>
               <input type="file" id="input_image" name="input_image" class="dashboard-payments-upload-input" required>
               <hr class="dashboard-payments-separator">
               <button type="submit" class="dashboard-payments-button-submit">Cargar Comprobante</button>
            </form>
         </div>
      </div>
   </div>
</div>
<script>
   function openComprobanteModal() {
     document.getElementById('comprobanteModal').style.display = 'flex';
   }
   
   function closeComprobanteModal() {
     document.getElementById('comprobanteModal').style.display = 'none';
   }
   
   // Cierra el modal al hacer clic fuera del contenido
   window.addEventListener('click', function(event) {
     const modal = document.getElementById('comprobanteModal');
     if (event.target === modal) {
       closeComprobanteModal();
     }
   });
</script>
 <script src="https://sdk.mercadopago.com/js/v2"></script>
      <script>

      const mp = new MercadoPago("APP_USR-51dbcd5b-55d8-4a5d-8267-372c8e45ebad");


  const cardForm = mp.cardForm({
     amount: "{$pagosInfo.precio_plantilla}",
     iframe: true,
     form: {
         id: "form-checkout",
         cardNumber: {
             id: "form-checkout__cardNumber",
             placeholder: "Numero de tarjeta",
         },
         expirationDate: {
             id: "form-checkout__expirationDate",
             placeholder: "MM/YY",
         },
         securityCode: {
             id: "form-checkout__securityCode",
             placeholder: "Código de seguridad",
         },
         cardholderName: {
             id: "form-checkout__cardholderName",
             placeholder: "Titular de la tarjeta",
         },
         issuer: {
             id: "form-checkout__issuer",
             placeholder: "Banco emisor",
         },
         installments: {
             id: "form-checkout__installments",
             placeholder: "Cuotas",
         },
         identificationType: {
             id: "form-checkout__identificationType",
             placeholder: "Tipo de documento",
         },
         identificationNumber: {
             id: "form-checkout__identificationNumber",
             placeholder: "Número del documento",
         },
         cardholderEmail: {
             id: "form-checkout__cardholderEmail",
             placeholder: "E-mail",
         },
     },
     callbacks: {
         onFormMounted: error => {
             if (error) return console.warn("Form Mounted handling error: ", error);
             console.log("Form mounted");
         },
         onSubmit: event => {
             event.preventDefault();

             const {
                 paymentMethodId: payment_method_id,
                 issuerId: issuer_id,
                 cardholderEmail: email,
                 amount,
                 token,
                 installments,
                 identificationNumber,
                 identificationType,
             } = cardForm.getCardFormData();

             console.log(amount);
             fetch("api/process_payment", {
                     method: "POST",
                     headers: {
                         "Content-Type": "application/json",
                     },
                     body: JSON.stringify({
                         token,
                         issuer_id,
                         payment_method_id,
                         transaction_amount: Number(amount),
                         installments: Number(installments),
                         description: "Abono mensaual CYSHOPS",
                         payer: {
                             email,
                             identification: {
                                 type: identificationType,
                                 number: identificationNumber,
                             },
                         },
                     }),
                 })
                 .then(response => response.json())
                 .then(data => {
                     if (data.success) {
                       
                         if (data.status == "approved") {
                 

                             id_tienda = document.getElementById('id_tienda').value
                             fetch("api/pagarServicio", {
                                     method: "POST",
                                     headers: {
                                         "Content-Type": "application/json",
                                     },
                                     body: JSON.stringify({
                                         amount,
                                         id_tienda,

                                     }),
                                 })
                                 .then(res => res.json())
                                 .then(resp => {
                                     if (resp.success) {
                                         alert("Servicio pagado correctamente.");
                                         location.reload();
                                     } else {
                                         alert("El pago fue aprobado, pero ocurrió un error al registrar el servicio.");
                                     }
                                 })
                                 .catch(err => {
                                     console.error("Error en api/pagarServicio:", err);
                                     alert("Error al procesar el servicio.");
                                 });

                         } else {
                             alert("Ha ocurrido un error, por favor compruebe su cuenta de mercado pago o intente nuevamente");
                         } //in_progres

                     } else {
                         alert("Error: " + data.message + ", Intente nuevamente en unos minutos");
                     }
                 })
                 .catch(error => {
                     console.error("Error al procesar el pago:", error);
                     alert("Ocurrió un error inesperado");
                 });
         },
         onFetching: (resource) => {
             console.log("Fetching resource: ", resource);

             // Animate progress bar
             const progressBar = document.querySelector(".progress-bar");
             progressBar.removeAttribute("value");


             return () => {
                 progressBar.setAttribute("value", "0");
             };
         }
     },
 });

  </script>