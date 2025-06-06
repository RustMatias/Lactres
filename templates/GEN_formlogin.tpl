





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

            <h1>Ingreso</h1>
            <img src="./images/logoazul.png" alt="imagen">
          
        </div>

        <form class="form" action="verify"  id="formularioregistro" method='POST'>
        <input type="hidden" name="volver_a" value="{$volver_a}">
            <input name="user" type="text" class="" placeholder="Nombre de usuario">
            <input name="password" type="password" class="" placeholder="Contraseña">

           

            
             {if $error != null}
                {$error}
            {/if}

            <div class="buttoner">
                <a href="home" class="returnbutton-login">

                    <svg width="46" height="46" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="m6 12 6 6m6.5-6H6h12.5ZM6 12l6-6-6 6Z"></path>
                      </svg>

                </a>

                <button type="submit" class="">Ingresar</button>
            </div>
        <a href="registro{if $volver_a}?V={$volver_a}{/if}">
            Crear una cuenta
        </a>
        
            <a href="recuperarcontrasena" >

                ¿Olvidaste tu contraseña?

            </a>
        </form>
    </article>

    

</section>