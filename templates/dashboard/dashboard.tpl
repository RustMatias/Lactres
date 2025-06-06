<!DOCTYPE html>
<html lang="en">
<head>
      <base href="{BASE_URL}">
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>CYSHOPS - Panel de control</title>
      <link rel="shortcut icon" href="./images/logoCyshops.png" />

      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="css/dashboard.css">
      <link rel="stylesheet" href="css/dashboard_profile.css">
      <link rel="stylesheet" href="css/dashboard_connectivities.css">
      {if $page == 'statistics'}
         <link rel="stylesheet" href="css/dashboard_statistics.css">
      {/if}
      {if $page == 'inventory'}
         <link rel="stylesheet" href="css/dashboard_inventory.css">
      {/if}
      {if $page == 'shop'}
         <link rel="stylesheet" href="css/dashboard_shop.css">
      {/if}
      {if $page == 'add_product'}
         <link rel="stylesheet" href="css/dashboard_add_product.css">
      {/if}
      {if $page == 'orders'}
         <link rel="stylesheet" href="css/dashboard_orders.css">
      {/if}
      {if $page == 'manage_orders'}
         <link rel="stylesheet" href="css/dashboard_manage_orders.css">
      {/if}
      {if $page == 'payments'}
         <link rel="stylesheet" href="css/dashboard_payments.css">
      {/if}
      {if $page == 'categories'}
         <link rel="stylesheet" href="css/dashboard_categories.css">
      {/if}
      {if $page == 'add_category'}
         <link rel="stylesheet" href="css/dashboard_add_category.css">
      {/if}
      {if $page == 'brand'}
         <link rel="stylesheet" href="css/dashboard_brand.css">
      {/if}
      {if $page == 'shipments'}
         <link rel="stylesheet" href="css/dashboard_shipments.css">
      {/if}
   </head>
   <body>
      <main>
         <nav class="main-menu">
            <h1>
            <img class="logodk" src="images/LOGO.png" alt="" />
            CYSHOPS</h1>
            <img class="logo" src="images/LOGO.png" alt="" />
           
            <ul>
               <li class="nav-item {if $page == 'profile'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/profile/{$smarty.session.ID_USER}">
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 12a5.25 5.25 0 1 0 0-10.499A5.25 5.25 0 0 0 12 12Zm0 1.5c-3.254 0-9.75 2.01-9.75 6v3h19.5v-3c0-3.99-6.496-6-9.75-6Z"></path>
                     </svg>
                     <span class="nav-text">Perfil</span>
                  </a>
               </li>
               <li class="nav-item {if $page == 'shop'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/shop/{$smarty.session.ID_USER}">
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17.438 7.5v-.563A5.444 5.444 0 0 0 12.136 1.5h-.272a5.444 5.444 0 0 0-5.302 5.438V7.5H2.438a.187.187 0 0 0-.187.188V21.75a.75.75 0 0 0 .75.75h18a.75.75 0 0 0 .75-.75V7.687a.188.188 0 0 0-.188-.187h-4.125Zm-1.875 0H8.436v-.516c0-1.96 1.567-3.588 3.528-3.609a3.566 3.566 0 0 1 3.598 3.563V7.5Z"></path>
                     </svg>
                     <span class="nav-text">Mi tienda</span>
                  </a>
               </li>
               <li class="nav-item {if $page == 'security'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/security/{$smarty.session.ID_USER}">

                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M22.456 5.219a.75.75 0 0 0-.616-.691c-4.033-.723-5.73-1.289-9.371-2.927-.364-.136-.59-.133-.938 0C7.889 3.24 6.192 3.804 2.16 4.528a.75.75 0 0 0-.617.691c-.18 2.864.204 5.531 1.142 7.929a16.352 16.352 0 0 0 3.348 5.27c2.094 2.222 4.416 3.52 5.613 4.012a.937.937 0 0 0 .709 0c1.265-.512 3.5-1.773 5.611-4.014a16.352 16.352 0 0 0 3.348-5.268c.939-2.397 1.323-5.065 1.142-7.929Z"></path>
                     </svg>
                     <span class="nav-text">Seguridad</span>
                  </a>
               </li>
               <li class="nav-item 
            {if $page == 'inventory'}active{/if}{if $page == 'add_product'}active{/if}
            
               ">
                  <b></b>
                  <b></b>
                  <a href="dashboard/inventory/{$smarty.session.ID_USER}"
                  class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}"
                  >

                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12.015 5.918 6.382 9.585l5.633 3.668-5.633 3.669-5.632-3.7 5.633-3.667L.75 5.918 6.383 2.25l5.632 3.668ZM6.352 18.082l5.633-3.668 5.633 3.668-5.633 3.667-5.632-3.668Zm5.663-4.86 5.633-3.668-5.633-3.637 5.602-3.668 5.633 3.668-5.633 3.667 5.633 3.668-5.633 3.669-5.602-3.7Z"></path>
                     </svg>
                     <span class="nav-text">Inventario
                   
                     </span>
                  </a>
               </li>
               <li class="nav-item {if $page == 'orders'}active{/if}{if $page == 'manage_orders'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/orders/{$smarty.session.ID_USER}"
                                    class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}"
                  >
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2.25c-5.376 0-9.75 4.374-9.75 9.75s4.374 9.75 9.75 9.75 9.75-4.374 9.75-9.75S17.376 2.25 12 2.25ZM9 15.727a.75.75 0 0 1-.75.75H7.5a.75.75 0 0 1-.75-.75v-.75a.75.75 0 0 1 .75-.75h.75a.75.75 0 0 1 .75.75v.75Zm0-3.329a.75.75 0 0 1-.75.75H7.5a.75.75 0 0 1-.75-.75v-.75a.75.75 0 0 1 .75-.75h.75a.75.75 0 0 1 .75.75v.75Zm0-3.375a.75.75 0 0 1-.75.75H7.5a.75.75 0 0 1-.75-.75v-.75a.75.75 0 0 1 .75-.75h.75a.75.75 0 0 1 .75.75v.75Zm8.25 7.079H9.969v-1.5h7.281v1.5Zm0-3.329H9.969v-1.5h7.281v1.5Zm0-3.375H9.969v-1.5h7.281v1.5Z"></path>
                     </svg>
                     <span class="nav-text">Pedidos</span>
                  </a>
               </li>
            <li class="nav-item {if $page == 'categories'}active{/if}{if $page == 'add_category'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/categories/{$smarty.session.ID_USER}"
               class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19.5 22.5 12 16.754 4.5 22.5v-21h15v21Z"></path>
                     </svg>
                     <span class="nav-text">Categorias</span>
                  </a>
               </li>
            <li class="nav-item {if $page == 'brand'}active{/if}">
               <b></b>
               <b></b>
               <a href="dashboard/brand/{$smarty.session.ID_USER}"
            class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">
               <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path d="M11.2 0v3.2h1.6V0h-1.6Z"></path>
               <path d="m5.366 5.834-2.4-2.4-1.132 1.132 2.4 2.4 1.132-1.132Z"></path>
               <path d="m19.766 6.966 2.4-2.4-1.132-1.132-2.4 2.4 1.132 1.132Z"></path>
               <path d="M12 4.8a6.334 6.334 0 0 0-6.27 5.439l-.017.112a6.322 6.322 0 0 0 1.263 4.783C7.59 15.927 8 16.684 8 17.442V20a.8.8 0 0 0 .8.8h6.4a.8.8 0 0 0 .8-.8v-2.558c0-.759.41-1.515 1.024-2.308a6.322 6.322 0 0 0 1.263-4.783l-.016-.112A6.335 6.335 0 0 0 12 4.8Z"></path>
               <path d="M0 12.8h3.2v-1.6H0v1.6Z"></path>
               <path d="M20.8 12.8H24v-1.6h-3.2v1.6Z"></path>
               <path d="M9.6 24h4.8v-1.6H9.6V24Z"></path>
             </svg>
                  <span class="nav-text">Marca</span>
               </a>
            </li>
            <li class="nav-item {if $page == 'shipments'}active{/if}">

                  <b></b>
                  <b></b>
                  <a href="dashboard/shipments/{$smarty.session.ID_USER}"
               class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">

                     
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M4.727 6c-.458 0-.897.171-1.221.476A1.578 1.578 0 0 0 3 7.625v8.938h1.727c0 .646.273 1.266.76 1.723a2.676 2.676 0 0 0 1.83.714c.687 0 1.346-.257 1.832-.714a2.367 2.367 0 0 0 .76-1.724h5.18c0 .647.274 1.267.76 1.724a2.676 2.676 0 0 0 1.832.714c.687 0 1.346-.257 1.832-.714a2.366 2.366 0 0 0 .759-1.724H22V12.5l-2.59-3.25h-2.592V6H4.728Zm6.046 1.625 3.454 3.25-3.454 3.25v-2.438H5.59v-1.624h5.182V7.624Zm6.045 2.844h2.16l1.7 2.031h-3.86v-2.031Zm-9.5 4.875c.344 0 .673.128.916.357.243.228.38.538.38.861 0 .324-.137.634-.38.862a1.338 1.338 0 0 1-.916.357c-.343 0-.673-.128-.916-.357a1.183 1.183 0 0 1-.38-.861c0-.324.137-.634.38-.862.243-.229.573-.357.916-.357Zm10.364 0c.343 0 .673.128.916.357.243.228.38.538.38.861 0 .324-.137.634-.38.862a1.338 1.338 0 0 1-.916.357c-.344 0-.673-.128-.916-.357a1.184 1.184 0 0 1-.38-.861c0-.324.137-.634.38-.862.243-.229.572-.357.916-.357Z"></path>
                     </svg>
                     <span class="nav-text">Envios</span>
                  </a>
               </li>
            <li class="nav-item {if $page == 'payments'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/payments/{$smarty.session.ID_USER}"
               class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">
                     <svg  class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M0 4a2.4 2.4 0 0 1 2.4-2.4h12.8A2.4 2.4 0 0 1 17.6 4v.8h4A2.4 2.4 0 0 1 24 7.2V20a2.4 2.4 0 0 1-2.4 2.4H2.4A2.4 2.4 0 0 1 0 20V4Zm14.4 12h4.8v-1.6h-4.8V16Z" clip-rule="evenodd"></path>
                      </svg>
                     <span class="nav-text">Pagos</span>
                  </a>
               </li>
               <li class="nav-item {if $page == 'connectivities'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/connectivities/{$smarty.session.ID_USER}"
               class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 15.748a2.99 2.99 0 0 0-2.162.924l-6.937-3.904a2.993 2.993 0 0 0 0-1.54l6.937-3.903a2.99 2.99 0 1 0-.737-1.307L8.163 9.921a3 3 0 1 0 0 4.154l6.938 3.903A3 3 0 1 0 18 15.748Z"></path>
                     </svg>
                     <span class="nav-text">Conectividades</span>
                  </a>
               </li>
               <li class="nav-item {if $page == 'statistics'}active{/if}">
                  <b></b>
                  <b></b>
                  <a href="dashboard/statistics/{$smarty.session.ID_USER}"
               class="{if !isset($smarty.session.VENDEDOR) || $smarty.session.VENDEDOR != 1}disabled-link{/if}">
                     <svg class="nav-item" width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 23.25H2.25v-9H6v9Z"></path>
                        <path d="M16.5 23.25h-3.75V9.75h3.75v13.5Z"></path>
                        <path d="M21.75 23.25H18V4.5h3.75v18.75Z"></path>
                        <path d="M11.25 23.25H7.5V.75h3.75v22.5Z"></path>
                     </svg>
                     <span class="nav-text">Estadisticas</span>
                  </a>
               </li>
            </ul>
            <hr class="separacion-dashboard">
            <ul class="salir-buton-dashboard">
               <li class="nav-item">
               <b></b>
               <b></b>
               <a href="#" id="logout-button">
               <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24">
                 <path fill-rule="evenodd" d="M12.75.05v14.3h-1.5V.05h1.5Zm7.07 2.887.537.525a11.9 11.9 0 0 1 3.593 8.53c0 6.596-5.348 11.958-11.95 11.958C5.401 23.95.05 18.588.05 11.993c0-3.353 1.397-6.367 3.615-8.532l.537-.524 1.047 1.074-.536.524C2.767 6.434 1.55 9.068 1.55 11.993 1.55 17.76 6.23 22.45 12 22.45c5.772 0 10.45-4.689 10.45-10.457a10.4 10.4 0 0 0-3.143-7.46l-.536-.524 1.05-1.072Z" clip-rule="evenodd"></path>
               </svg>
               <span class="nav-text">Salir</span>
             </a>
               </li>
               </ul>    
               <hr class="separacion-dashboard">
         </nav>
         <section class="content">
         {include file="dashboard/`$page`.tpl"}
         </section>
      </main>
   </body>
   <script type="text/javascript " src="js/user.js"></script>
<script type="text/javascript " src="js/admin.js"></script>
   <script  type="text/javascript " src="js/dashboard.js"></script>
</html>

<!-- Modal de Confirmación -->
<div id="logout-modal" class="logout-modal-overlay">
  <div class="logout-modal-box">
    <h3>¿Deseás salir del sistema?</h3>
    <div class="logout-modal-actions">
    <a href="logout" id="confirm-logout" class="logout-btn-confirm">Sí, salir</a>
    <button id="cancel-logout" class="logout-btn-cancel">Cancelar</button>
    
    </div>
  </div>
</div><script>
const logoutBtn = document.getElementById('logout-button');
const logoutModal = document.getElementById('logout-modal');
const confirmLogout = document.getElementById('confirm-logout');
const cancelLogout = document.getElementById('cancel-logout');

logoutBtn.addEventListener('click', (e) => {
  e.preventDefault();
  logoutModal.style.display = 'flex';
});

cancelLogout.addEventListener('click', () => {
  logoutModal.style.display = 'none';
});

confirmLogout.addEventListener('click', () => {
  window.location.href = 'logout'; // Cambiá a tu URL real de logout
});
</script>
