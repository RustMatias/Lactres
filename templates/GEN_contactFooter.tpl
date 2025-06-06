{assign var="contacto" value=$shopFront[0]->medios_de_contacto|@json_decode}

<footer class="footer bg-white mt-5 text-dark py-5">
    <div class="container">
        <div class="row">
            <!-- Título del Footer -->
            <div class="col-12 text-center mb-4">
                <h4 class="mb-3">Contacto</h4>
                <hr>
                <p class="lead">Si tienes alguna pregunta o inquietud, no dudes en contactarnos.</p>
            </div>
        </div>

        <div class="row">
            <!-- Columna de Información de Contacto (Móvil a Desktop) -->
            <div class="col-12 col-md-6 mb-3 text-center">
                {if !empty($contacto->email)}
                    <p><strong>Email:</strong> <a href="mailto:{$contacto->email|escape}" class="text-dark">{$contacto->email|escape}</a></p>
                {/if}

                {if !empty($contacto->telefono)}
                    <p><strong>Teléfono:</strong> <a href="tel:{$contacto->telefono|escape}" class="text-dark">{$contacto->telefono|escape}</a></p>
                {/if}
            </div>

            <!-- Columna de Redes Sociales (Móvil a Desktop) -->
            <div class="col-12 col-md-6 mb-3 text-center">
                {if !empty($contacto->whatsapp)}
                    <p><a href="https://wa.me/{$contacto->whatsapp|escape}" class="text-dark" target="_blank">
                    
                    
                    <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
</svg>WhatsApp
                    </a></p>
                {/if}

                {if !empty($contacto->facebook)}
                    <p><a href="https://facebook.com/{$contacto->facebook|escape}" class="text-dark" target="_blank">
                    <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
</svg>Facebook
                    </a></p>
                {/if}

                {if !empty($contacto->instagram)}
                    <p><a href="{$contacto->instagram|escape}" class="text-dark" target="_blank">
                
                    <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <rect width="20" height="20" x="2" y="2" rx="5" ry="5"></rect>
  <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
  <path d="M17.5 6.5h.01"></path>
</svg>    Instagram
                    </a></p>
                {/if}
            </div>


        </div>

    </div>
</footer>
