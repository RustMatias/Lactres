{include file="header-login.tpl"}

<section class="section-login">
    <article class="informacion">
        <svg width="175" height="175" fill="none" stroke="#fefefe" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="m3 6-.75-2.5M3 6h19l-3 10H6L3 6Z"></path>
            <path d="M11 19.5a1.5 1.5 0 0 1-3 0"></path>
            <path d="M17 19.5a1.5 1.5 0 0 1-3 0"></path>
          </svg>      
          <div id="street"></div>
      
    </article>
    
   
    <article class="login">
        <div class="presentacion-registro">

            <h1>Regristro</h1>
            <img src="./images/logoazul.png" alt="imagen">
          
        </div>
        
        {if $error != null}
            {$error}
        {/if}
        <form class="form" action="registrer" id="formularioregistro" method='POST'>
            <input type="hidden" name="volver_a" value="{$volver_a}">
            <input name="username" type="text" id="username" class="" placeholder="Nombre de usuario" maxlength="20">
            <small id="usernameError" style="color: red; display: none;">El nombre de usuario no debe tener espacios</small>

            <input name="email" type="text" class="" placeholder="Email">
            <input name="telefono" type="text" class="" placeholder="Telefono">
            <input name="password" type="password" class="" placeholder="Contraseña">
            <input name="rpassword" type="password" class="" placeholder="Repetir Contraseña">

            <div class="form-group">
                <input type="checkbox" id="acepto" name="acepto">
                <label for="acepto">
                    Acepto <a href="terminosycondiciones" target="_blank">términos y condiciones</a>
                </label>
            </div>


            <div class="buttoner">
                <a href="home" class="returnbutton-login">
                    <svg width="46" height="46" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="m6 12 6 6m6.5-6H6h12.5ZM6 12l6-6-6 6Z"></path>
                      </svg>
                </a>
                <button type="submit" class="">Registrar</button>
            </div>
            

        <a href="login{if $volver_a}?V={$volver_a}{/if}">
            Iniciar sesión
        </a>
        </form>
    </article>
</section>



<script>
    const usernameInput = document.getElementById('username');
    const usernameError = document.getElementById('usernameError');

    usernameInput.addEventListener('input', () => {
        if (usernameInput.value.includes(' ')) {
            usernameError.style.display = 'block';
            usernameInput.value = usernameInput.value.replace(/\s+/g, ''); // Elimina los espacios automáticamente
        } else {
            usernameError.style.display = 'none';
        }
    });
</script>