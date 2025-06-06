{assign var="fecha_actual" value=$smarty.now|date_format:"%Y-%m-%d"}
<div class="left-content">
   <div class="activities">
      <h1>Configuración de tu tienda</h1>
      {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
      {if isset($userinfo.tienda.fecha_vencimiento) && $userinfo.tienda.fecha_vencimiento > $fecha_actual}
      <div id="configuraciones">
         <div class="dashobard-shop-conf-card">
            <label for="colorPicker">Selecciona un color para tu tienda:</label>
            <div>
               <input type="color" id="colorPicker" name="color" value="{$userinfo.tienda.color}" class="profile-colorpicker-input">
            </div>
            <label for="colorPicker">Selecciona un color para el texto</label>
            {assign var="isChecked" value=($userinfo.tienda.color_texto == '#000000') ? 'checked' : ''}
            <div class="profile-toggle">
               <input type="checkbox" id="toggle" class="profile-toggle-input" {$isChecked}>
               <label for="toggle" class="profile-toggle-label">
               <span class="profile-toggle-text profile-toggle-white">Blanco</span>
               <span class="profile-toggle-text profile-toggle-black">Negro</span>
               </label>
            </div>
            <button class="dashboard-shop-button" onclick="guardarColor('{$userinfo.tienda.nombre_unico}')">
            Guardar Colores
            </button>
         </div>
         <div class="dashobard-shop-conf-card">
            <label for="">Horario en el que tus clientes pueden realizar sus compras:</label>
            <div class="profile-conf-time-range">
               <input type="time" class="profile-conf-time-input" name="hora_desde" id="hora_desde" value="{$userinfo.tienda.horario.desde|default:''}">
               <span>a</span>
               <input type="time" class="profile-conf-time-input" name="hora_hasta" id="hora_hasta" value="{$userinfo.tienda.horario.hasta|default:''}">
            </div>
            <label class="profile-conf-checkbox">
            <input type="checkbox" name="sin_horario" id="sin_horario" {if !$userinfo.tienda.horario}checked{/if}>
            <span>Sin horario</span>
            </label>
            <button class="dashboard-shop-button" onclick="guardarHorarios('{$userinfo.tienda.nombre_unico}', event)">
            Guardar Horario
            </button>
            <br>
         </div>
         <script>
            document.addEventListener("DOMContentLoaded", function () {
                const sinHorarioCheckbox = document.getElementById("sin_horario");
                const horaDesde = document.getElementById("hora_desde");
                const horaHasta = document.getElementById("hora_hasta");
            
                function toggleHorario() {
                    if (sinHorarioCheckbox.checked) {
                        horaDesde.value = "";
                        horaHasta.value = "";
                        horaDesde.disabled = true;
                        horaHasta.disabled = true;
                    } else {
                        horaDesde.disabled = false;
                        horaHasta.disabled = false;
                    }
                }
            
                sinHorarioCheckbox.addEventListener("change", toggleHorario);
            
                // Ejecutar al cargar para aplicar el estado correcto
                toggleHorario();
            });
         </script>
         {assign var="ubicacionGuardada" value=$userinfo.tienda.ubicacion}
         {if $ubicacionGuardada}
         {assign var="toggleChecked" value="checked"}
         {assign var="ubicacionTexto" value=$ubicacionGuardada}
         {else}
         {assign var="toggleChecked" value=""}
         {assign var="ubicacionTexto" value=""}
         {/if}
         <div class="dashobard-shop-conf-card">
            <label for="">¿Tus clientes retiran el pedido en tu local?</label>
            <div class="profile-toggle">
               <input type="checkbox" id="toggleSiNo" class="profile-toffle-input" {$toggleChecked}>
               <label for="toggleSiNo" class="profile-toffle-label">
               <span class="profile-toffle-text profile-toffle-si">No</span>
               <span class="profile-toffle-text profile-toffle-no">Si</span>
               </label>
            </div>
            <div class="" id="ubicacionInputContainer">
               <span>Coloque la dirección de su local</span>
               <input type="text" id="ubicacionTienda" value="{$ubicacionTexto}" class="dashboard-profile-info-input">
            </div>
            <button class="dashboard-shop-button" onclick="guardarUbicacion('{$userinfo.tienda.nombre_unico}', event)">
            Guardar ubicación
            </button>
         </div>
         <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toggle = document.getElementById('toggleSiNo');
                const ubicacionContainer = document.getElementById('ubicacionInputContainer');
            
                // Mostrar u ocultar al cargar
                ubicacionContainer.style.display = toggle.checked ? 'block' : 'none';
            
                // Mostrar/ocultar al cambiar
                toggle.addEventListener('change', () => {
                    ubicacionContainer.style.display = toggle.checked ? 'block' : 'none';
                });
            });
         </script>
      </div>
   </div>
   {/if}{/if}
</div>
</div>























<div class="right-content">
   {if isset($smarty.session.VENDEDOR) && $smarty.session.VENDEDOR == 1}
   {if !isset($userinfo.tienda.fecha_vencimiento)}
   <div class="profile-created-shop-info">
      <span class="pagos-vencido"> (Realice el primer pago)</span>
      <span class="pagos-vencido">PARA HABILITAR SU TIENDA DEBE ABONAR EL MES.</span>
   </div>
  <a class="dashboard-btn-eliminar-tienda" href="dashboard/payments/{$userinfo.usuario.id}">
         Ir a pagos 
         <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
            <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
            <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
         </svg>
      </a>

   </button>
   <!-- Botón para abrir el modal -->
 <button type="button" class="dashboard-btn-eliminar-tienda" id="modal-eliminar-tienda-open">
         Eliminar tienda
         <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24">
            <path d="M3 6h18"></path>
            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            <path d="M10 11v6"></path>
            <path d="M14 11v6"></path>
         </svg>
      </button>
   {else}
   {if  $userinfo.tienda.fecha_vencimiento < $fecha_actual}
   <div class="profile-created-shop-info">
      <div class="profile-created-shop-info">
         <span class="pagos-vencido"> (VENCIDO)</span>
         <span class="pagos-vencido">Su tienda esta vencida, por abone la mensualidad para volver a habilidarla</span>
      </div>
      <a class="dashboard-btn-eliminar-tienda" href="dashboard/payments/{$userinfo.usuario.id}">
         Ir a pagos 
         <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
            <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
            <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
         </svg>
      </a>
     
     
      <button type="button" class="dashboard-btn-eliminar-tienda" id="modal-eliminar-tienda-open">
         Eliminar tienda
         <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24">
            <path d="M3 6h18"></path>
            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            <path d="M10 11v6"></path>
            <path d="M14 11v6"></path>
         </svg>
      </button>
   </div>
  
   {else}
   <div class="profile-created-shop-info">
      <div class="profile-shop-view-tab">
         <div class="profile-shop-view-tab-icon">
            <img src="{$userinfo.tienda.logo}" alt="Icono">
         </div>
         <span class="profile-shop-view-tab-title">{$userinfo.tienda.nombre_simple}</span>
      </div>
      <button class="profile-tienda-button-link">
         <a href="{$userinfo.tienda.nombre_unico}">
            ir a mi tienda
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path d="m3 3 7.07 16.97 2.51-7.39 7.39-2.51L3 3z"></path>
               <path d="m13 13 6 6"></path>
            </svg>
         </a>
      </button>
      <button onclick="copiarEnlace()" class="dashboard-shop-button">
      Copiar enlace a mi tienda
      </button>
      <span id="mensajeCopiado" style="color: green; display: none; margin-left: 10px;">¡Enlace copiado!</span>
      <script>
         function copiarEnlace() {
            const enlace = "www.cyshops.com/{$userinfo.tienda.nombre_unico}"; // Aquí pones tu enlace dinámico
            const tempInput = document.createElement("input");
            document.body.appendChild(tempInput);
            tempInput.value = enlace;
            tempInput.select();
            document.execCommand("copy");
            document.body.removeChild(tempInput);
         
            // Mostrar el mensaje de "Enlace copiado"
            const mensaje = document.getElementById("mensajeCopiado");
            mensaje.style.display = "inline";
            
            // Ocultar el mensaje después de 2 segundos
            setTimeout(() => mensaje.style.display = "none", 2000);
         }
      </script>
      </button>
      <!-- Botón para abrir el modal -->
      <button type="button" class="dashboard-btn-eliminar-tienda" id="modal-eliminar-tienda-open">
         Eliminar tienda
         <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24">
            <path d="M3 6h18"></path>
            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            <path d="M10 11v6"></path>
            <path d="M14 11v6"></path>
         </svg>
      </button>




      <div class="profile-personal-info-section">
      <hr>
  <h3>Datos para tus compradores.</h3>
  <small>Completar estos datos para que tus clientes puedan enviarte dinero.</small>
<div class="profile-mini-alert warning">
  ⚠️ Si usted quiere que sus clientes puedan usar la transferencia como método de pago, por favor complete este campo.  
  Si desea que usen tarjetas, por favor conecte su Mercado Pago en <strong>Conectividades</strong>.
  Si desea usar ambas formas de cobro, complete estos campos y conecte Mercado Pago.
</div>

<div class="profile-mini-alert info">
  ℹ️ Si usted quiere evitar la transferencia como método de pago, deje estos campos vacíos.
</div>
  <div class="profile-control-info">
    <span>Alias</span>
    <input type="text" id="aliasTienda" value="{$userinfo.tienda.alias}">
  </div>

  <div class="profile-control-info">
    <span>Cbu / Cvu</span>
    <input type="text" id="cbuTienda" value="{$userinfo.tienda.cbu}">
  </div>

  <hr>

  <button onclick="saveShopInfo()" class="profile-personal-info-save-button" id="save-info-profile-1">
    Guardar
  </button>
</div>

<script>
  const aliasInput = document.getElementById('aliasTienda');
  const cbuInput = document.getElementById('cbuTienda');
  const saveButton = document.getElementById('save-info-profile-1');

  const initialAlias = aliasInput.value;
  const initialCbu = cbuInput.value;

  function checkChanges() {
    if (aliasInput.value !== initialAlias || cbuInput.value !== initialCbu) {
      saveButton.style.display = 'inline-block';
    } else {
      saveButton.style.display = 'none';
    }
  }

  aliasInput.addEventListener('input', checkChanges);
  cbuInput.addEventListener('input', checkChanges);
</script>

     
   </div>
   {/if}
   {/if}
   {else}
   <!-- Mostrar el enlace para crear la tienda si no existe -->
   <a href="creartienda" class="profile-create-shop-button" {* data-bs-toggle="modal" data-bs-target="#createShopModal" *}>
   Crear tienda 
   <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <path d="M12 12v6m-6-6h6-6Zm12 0h-6 6Zm-6 0V6v6Z"></path>
   </svg>
   </a>
   {/if}
</div>
<div class="custom-modal" id="confirmModal" style="display:none;">
   <div class="custom-modal-backdrop" id="modalBackdrop" style="position:fixed; top:0; left:0; width:100%; height:100%; background:#00000099;"></div>
   <div class="custom-modal-content" style="position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); background:white; padding:1.5rem; border-radius:8px; z-index:1001;">
      <div class="custom-modal-header">
         <h5>Confirmación de Eliminación</h5>
      </div>
      <div class="custom-modal-body">
         <p>¿Está seguro de que desea eliminar esta tienda? Por favor, escriba la palabra <strong>"Borrar"</strong> para confirmar.</p>
         <input type="hidden" id="id_tienda" value="{$userinfo.tienda.id_tienda}">
         <input type="text" id="confirmationText" placeholder="Escriba 'Borrar'" class="dashboard-profile-info-input">
         <div id="error-message" style="color:red; margin-top:0.5rem; display:none;">Debe escribir "borrar" para continuar.</div>
      </div>
      <div class="custom-modal-footer" style="margin-top:1rem; display:flex; justify-content:end; gap:0.5rem;">
         <button type="button" id="cancelButton">Cancelar</button>
         <button type="button" id="confirmButton" disabled>Eliminar</button>
      </div>
   </div>
</div>
<script>
   document.getElementById('modal-eliminar-tienda-open').addEventListener('click', function () {
      document.getElementById('confirmModal').style.display = 'block';
   });
   
   document.getElementById('cancelButton').addEventListener('click', function () {
      document.getElementById('confirmModal').style.display = 'none';
   });
   
   document.getElementById('modalBackdrop').addEventListener('click', function () {
      document.getElementById('confirmModal').style.display = 'none';
   });
   
   
   // Cuando se escribe en el campo de texto
   document.getElementById("confirmationText").addEventListener("input", function() {
          const inputText = this.value.toLowerCase().trim();
          const confirmButton = document.getElementById("confirmButton");
          const errorMessage = document.getElementById("error-message");
      
          // Verificar si el texto escrito es 'borrar'
          if (inputText === "borrar") {
              confirmButton.disabled = false;  // Habilitar el botón de eliminación
              errorMessage.style.display = "none";  // Ocultar mensaje de error
          } else {
              confirmButton.disabled = true;  // Deshabilitar el botón de eliminación
              errorMessage.style.display = "block";  // Mostrar mensaje de error
          }
      });
   document.getElementById("confirmButton").addEventListener("click", function() {
         // Obtener el id_tienda desde el input
          const idTienda = document.getElementById("id_tienda").value;
                        
          // Hacer una petición fetch para eliminar la imagen del producto
          fetch('api/eliminarTienda', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/json', // Especifica el tipo de contenido
              },
              body: JSON.stringify({
                  id_tienda: idTienda // Enviar el id_tienda en el cuerpo de la solicitud
              })
          })
          .then(response => response.json())  // Convertir la respuesta en formato JSON
          .then(data => {
              if (data.success) {
                  location.reload();
              } else {
                  alert("Hubo un error al eliminar la tienda, intente en unos minutos");
              }
          })
          .catch(error => {
              console.error('Error:', error);
              alert('Error al realizar la solicitud.');
          });
      
      });
</script>