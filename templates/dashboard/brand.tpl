<div class="content-stats">
   <div class="activities">
      <h1>Marca</h1>
      <body>
      {if $smarty.session.GRUPO == "C" || $smarty.session.GRUPO == "M" }  

        <div id="banner" class="dashboard-brand-banner-container">
            <h2 class="dashboard-brand-banner-title">Control de imágenes para el banner</h2>
            
            <div class="dashboard-brand-banner-row">
                {foreach from=$bannerimages item=imagen}
                <div class="dashboard-brand-banner-col" id="banner-col-{$imagen->id_imagen}">
                <div class="dashboard-brand-banner-card">
                    <img src="{$imagen->imagen}" class="dashboard-brand-banner-img" alt="Imagen del banner">
                    <div class="dashboard-brand-banner-body">
                    <h5 class="dashboard-brand-banner-heading">{$imagen->texto1}</h5>
                    <p class="dashboard-brand-banner-text">{$imagen->texto2}</p>
                    <button class="dashboard-brand-banner-delete" onclick="openDeleteModal('{$imagen->id_imagen}')">🗑 Eliminar</button>
                    </div>
                </div>
                </div>

                <!-- Modal eliminar -->
                <div class="dashboard-brand-banner-modal" id="deleteModal{$imagen->id_imagen}">
                <div class="dashboard-brand-banner-modal-content">
                    <p class="dashboard-brand-banner-modal-message">¿Estás seguro de que quieres eliminar esta imagen?</p>
                    <div class="dashboard-brand-banner-modal-buttons">
                    <button onclick="closeDeleteModal('{$imagen->id_imagen}')" class="dashboard-brand-banner-modal-cancel">Cancelar</button>
                    

                    <form action="deletebanner" method="POST" class="d-flex justify-content-between w-100">
                        <button type="button"class="dashboard-brand-banner-modal-confirm"  data-bs-dismiss="modal" data-imagen-id="{$imagen->id_imagen}" onclick="deleteBanner(this)">Eliminar</button>
                    </form>
                    </div>
                </div>
                </div>
                {/foreach}

                <!-- Agregar nueva imagen -->
                <div class="dashboard-brand-banner-col">
                <div class="dashboard-brand-banner-card">
                    <form action="addbanner" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="id_tienda" value="{$shopInfo[0]->id_tienda}">

                    <div class="dashboard-brand-banner-body">
                        <label class="dashboard-brand-banner-label">Nueva imagen
                        <small>Resolución recomendada: 1500x300</small>
                        <input type="file" name="input_image" class="dashboard-brand-banner-input">
                        </label>

                        <label class="dashboard-brand-banner-label">Texto 1
                        <input type="text" name="texto1" class="dashboard-brand-banner-input">
                        </label>

                        <label class="dashboard-brand-banner-label">Texto 2
                        <input type="text" name="texto2" class="dashboard-brand-banner-input">
                        </label>

                        <button type="submit" class="dashboard-brand-banner-add">Agregar</button>
                    </div>
                    </form>
                </div>
                </div>
            </div>
            </div>
      {/if}





      {* logo *}
      <div id="logoPage" class="logo-container">
      <div class="logo-current-section">
        <h2 class="dashboard-contact-title">Logo actual</h2>

        <img src="{$shopInfo[0]->logo}" alt="logo" class="logo-image">
      </div>
    
      <form action="updateLogo" id="updateLogo" method="POST" enctype="multipart/form-data" class="logo-form">
        <input type="hidden" name="id_tienda" value="{$shopInfo[0]->id_tienda}">
    
        <div class="logo-form-group">
          <label for="input_image" class="logo-label">Nuevo logo</label>
          <input type="file" id="input_image" name="input_image" class="logo-input">
        </div>
    
        <button type="submit" class="logo-submit-button">Actualizar Logo</button>
      </form>
    </div>
    

{* CONTACT *}

{assign var="contactData" value=$shopInfo[0]->medios_de_contacto|json_decode:true}
<form id="contact" class="dashboard-contact-form hideform" action="updateContactInformation" method="POST">
  <input name="id_tienda" id="id_tienda" type="hidden" value="{$shopInfo[0]->id_tienda}">

  <div class="dashboard-contact-container">
    <h2 class="dashboard-contact-title">Contacto para tus clientes</h2>
    <span class="dashboard-contact-description">
      Esta es la información que tus clientes podrán saber sobre usted.
    </span>

    <div class="dashboard-contact-group">
      <label for="contact-phone" class="dashboard-contact-label">Teléfono</label>
      <input class="dashboard-contact-input" name="contact-phone" id="contact-phone" type="text"
        placeholder="Ingrese su número de teléfono" value="{$contactData.telefono|default:''}">
    </div>

    <div class="dashboard-contact-group">
      <label for="contact-email" class="dashboard-contact-label">Correo Electrónico</label>
      <input class="dashboard-contact-input" name="contact-email" id="contact-email" type="email"
        placeholder="Ingrese su correo electrónico" value="{$contactData.email|default:''}">
    </div>

    <div class="dashboard-contact-group">
      <label for="contact-facebook" class="dashboard-contact-label">Facebook</label>
      <input class="dashboard-contact-input" name="contact-facebook" id="contact-facebook" type="text"
        placeholder="Link o nombre de usuario de Facebook" value="{$contactData.facebook|default:''}">
    </div>

    <div class="dashboard-contact-group">
      <label for="contact-instagram" class="dashboard-contact-label">Instagram</label>
      <input class="dashboard-contact-input" name="contact-instagram" id="contact-instagram" type="text"
        placeholder="Link o usuario de Instagram" value="{$contactData.instagram|default:''}">
    </div>

    <div class="dashboard-contact-group">
      <label for="contact-whatsapp" class="dashboard-contact-label">WhatsApp</label>
      <input class="dashboard-contact-input" name="contact-whatsapp" id="contact-whatsapp" type="text"
        placeholder="Número o link de WhatsApp" value="{$contactData.whatsapp|default:''}">
    </div>

    <button type="submit" class="dashboard-contact-submit-button">Guardar información</button>
  </div>
</form>
<script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('contact');
                
                    form.addEventListener('submit', function (e) {
                        e.preventDefault(); // Evita envío normal
                
                        const data = new FormData(form);
                
                        fetch('api/updateContactInformation', {
                            method: 'POST',
                            body: data
                        })
                        .then(res => res.json())
                        .then(response => {
                            if (response.status === 'ok') {
                                alert('Información de contacto guardada correctamente.');
                            } else {
                                alert('Hubo un error al guardar los datos.');
                            }
                        })
                        .catch(error => {
                            console.error('Error en la solicitud:', error);
                            alert('Ocurrió un error inesperado.');
                        });
                    });
                });
                </script>







      </body>
      </html>

      </html>
   </div>
</div>

<script>
function openDeleteModal(id) {
  const modal = document.getElementById('deleteModal' + id);
  if (modal) modal.style.display = 'flex';
}

function closeDeleteModal(id) {
  const modal = document.getElementById('deleteModal' + id);
  if (modal) modal.style.display = 'none';
}

// Cierra el modal haciendo clic fuera
window.addEventListener('click', function(e) {
  const modals = document.querySelectorAll('.dashboard-brand-banner-modal');
  modals.forEach(modal => {
    if (e.target === modal) modal.style.display = 'none';
  });
});
</script>
