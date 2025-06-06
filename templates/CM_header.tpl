{assign var="color_texto" value=$colors[0]->color_texto|default:'#ffffff'}
{assign var="color_fondo" value=$colors[0]->color|default:'#303198'}
<!DOCTYPE html>
<html lang="en">
   <!--Incluimos el head, ya que se repite en todas las paginas. -->
   <head>
      <base href="{BASE_URL}">
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>{$shopFront[0]->nombre_simple}</title>
      <link rel="stylesheet" href="css/css.css">
      <link rel="stylesheet" href="css/CM_productDetail.css">
      <link rel="stylesheet" href="css/CM_mainpage.css">
      <link rel="stylesheet" href="css/CM_category.css">
      <link rel="shortcut icon" href="{$shopFront[0]->logo}" />
      <link rel="stylesheet" href="css/productDetail.css">
      <link rel="stylesheet" href="css/productCard.css">
      <link rel="stylesheet" href="css/asideMenu.css">
      <link rel="stylesheet" href="css/categoryHomeList.css">
      <link rel="stylesheet" href="css/carrouselHome.css">
      <link rel="stylesheet" href="css/CM_header.css">
  
      <link rel="stylesheet" href="css/footer.css">
      <link rel="stylesheet" href="css/home.css">
      <link rel="stylesheet" href="css/profile.css">
      <link rel="stylesheet" href="css/editProduct.css">
      <link rel="stylesheet" href="css/admin.css">
      <link rel="stylesheet" href="css/carrito.css">
      <link rel="stylesheet" href="css/adminStadistics.css">
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
   </head>
   <!-- Meta Pixel Code -->

<!-- End Meta Pixel Code -->
   <style>
      .cm_mainpage_colortexto-db {
      color: {$color_texto};
      }
      .cm_mainpage_colortexto-db svg {
      stroke: {$color_texto};
      }
      .cm_mainpage_colortexto-db:hover > svg {
      {if $color_texto == '#ffffff'}
      stroke: #f0f0f0; /* Blanco tenue */
      {elseif $color_texto == '#000000'}
      stroke: #333333; /* Negro tenue */
      {else}
      stroke: darken({$color_texto}, 10%); /* Si no es blanco ni negro, oscurecer un 10% */
      {/if}
      }
      .cm_mainpage_colortexto-db:hover {
      {if $color_texto == '#ffffff'}
      color: #f0f0f0; /* Blanco tenue */
      {elseif $color_texto == '#000000'}
      color: #333333; /* Negro tenue */
      {else}
      color: darken({$color_texto}, 10%); /* Si no es blanco ni negro, oscurecer un 10% */
      {/if}
      }

       header {

         background-color: {$color_fondo};

      }

        .cm-header-mobile-menu {
       background-color: {$color_fondo};
   
  
    }

     .cm-header-mobile-menu *{
       color: {$color_texto} !important;
  
    }

      header *{
         
       color: {$color_texto} !important;

      }



      
    .cm-header-custom-dropdown .cm-header-dropdown-menu {
  background-color: {$color_fondo};
  filter: brightness(115%);
  box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15) !important;
}

.cm-header-custom-dropdown .cm-header-dropdown-menu  a:hover {
      background-color: {$color_fondo};
      filter: brightness(90%);
      font-weight: bold;
      
    }


       .cm-header-profile-menu {
   background-color: {$color_fondo};
  filter: brightness(115%);
  box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15) !important;
 

    }

        .cm-header-profile-menu a:hover {
      background-color: {$color_fondo};
      filter: brightness(90%);
      font-weight: bold;
    }
   </style>

   <body>


<header>
  <div class="cm-header-hamburger" onclick="toggleMobileMenu()">
    <div></div>
    <div></div>
    <div></div>
  </div>

  <div class="cm-header-search-group">
  <form action="{$shopName}/search"  method="POST">
    <input type="text" name="search" placeholder="Buscar en {$shopFront[0]->nombre_simple}">
     </form>
    <div class="cm-header-custom-dropdown" onclick="toggleDropdown(this)">
      <button class="cm-header-quitar-movile cm-header-dropdown-toggle-dk">Categorías</button>
      <div class="cm-header-dropdown-menu">
       {foreach from=$categories item=category}
      <a href="{$shopName}/category/{$category->id_categoria}" class="dropdown-item">
                           {$category->nombre}
      </a>
      {/foreach}
      </div>
    </div>
  </div>

  <div class="cm-header-nav-links">
    
     {if isset($smarty.session.USER_NAME)}  
      <a href="{$shopName}/products">Todos los productos <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M6.45.05h11.1V4a2.35 2.35 0 0 1-2.35 2.35H8.8A2.35 2.35 0 0 1 6.45 4V.05Zm1.5 1.5V4c0 .47.38.85.85.85h6.4c.47 0 .85-.38.85-.85V1.55h-8.1Zm-6.3.1H6.4v1.5H3.15V21.6c0 .47.38.85.85.85h16c.47 0 .85-.38.85-.85V3.15H17.6v-1.5h4.75V21.6A2.35 2.35 0 0 1 20 23.95H4a2.35 2.35 0 0 1-2.35-2.35V1.65Z" clip-rule="evenodd"></path>
</svg></a>
    <a href="miscompras">Compras <svg width="20" height="20" fill="currentColor"  viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M12 1.55A4.05 4.05 0 0 0 7.95 5.6v.8h-1.5v-.8a5.55 5.55 0 1 1 11.1 0v.8h-1.5v-.8A4.05 4.05 0 0 0 12 1.55Zm-6.568 8a.85.85 0 0 0-.845.756l-1.244 11.2a.85.85 0 0 0 .845.944h15.624a.85.85 0 0 0 .845-.944l-1.244-11.2a.85.85 0 0 0-.845-.756H5.432Zm-2.336.59a2.35 2.35 0 0 1 2.336-2.09h13.136c1.197 0 2.203.9 2.336 2.09l1.244 11.2a2.35 2.35 0 0 1-2.336 2.61H4.188a2.35 2.35 0 0 1-2.336-2.61l1.244-11.2Z" clip-rule="evenodd"></path>
            </svg></a>


    <a href="carrito">Carrito <svg width="20" height="20" fill="currentColor" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="m.082 1.015 1.436-.43.8 2.665H20a3.95 3.95 0 0 1 3.95 3.95v10.35H5.042L.082 1.015ZM2.768 4.75l3.39 11.3H22.45V7.2A2.45 2.45 0 0 0 20 4.75H2.768Zm6.032 16a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Zm-2.35.85a2.35 2.35 0 1 1 4.7 0 2.35 2.35 0 0 1-4.7 0Zm11.2 0a2.35 2.35 0 1 1 4.7 0 2.35 2.35 0 0 1-4.7 0Zm2.35-.85a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Z" clip-rule="evenodd"></path>
            </svg></a>

    <div class="cm-header-profile" id="profileDropdown">
      <button onclick="toggleProfile()">{$smarty.session.USER_NAME} <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path fill-rule="evenodd" d="M12 1.55a4.048 4.048 0 0 0-4.05 4.047A4.048 4.048 0 0 0 12 9.644a4.048 4.048 0 0 0 4.05-4.047A4.048 4.048 0 0 0 12 1.55ZM6.45 5.597A5.548 5.548 0 0 1 12 .05a5.548 5.548 0 1 1 0 11.094 5.548 5.548 0 0 1-5.55-5.547ZM8.8 15.94a4.05 4.05 0 0 0-4.05 4.049v2.445h14.5V19.99a4.05 4.05 0 0 0-4.05-4.05H8.8Zm-5.55 4.05a5.55 5.55 0 0 1 5.55-5.55h6.4a5.55 5.55 0 0 1 5.55 5.55v3.946H3.25V19.99Z" clip-rule="evenodd"></path>
                  </svg></button>
      <div class="cm-header-profile-menu">
        <a href="dashboard/profile/{$smarty.session.ID_USER}">Panel de control</a>
        <a href="logout">Salir</a>
      </div>
    </div>
    {else}
 <a  href="login?V={$shopName}">Iniciar sesión <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M.05 12C.05 5.4 5.4.05 12 .05S23.95 5.4 23.95 12 18.6 23.95 12 23.95.05 18.6.05 12ZM12 1.55C6.229 1.55 1.55 6.23 1.55 12c0 5.771 4.679 10.45 10.45 10.45 5.771 0 10.45-4.679 10.45-10.45 0-5.771-4.679-10.45-10.45-10.45Zm1.6 6.19L17.86 12l-4.26 4.26-1.06-1.06 2.45-2.45H6.4v-1.5h8.59L12.54 8.8l1.06-1.06Z" clip-rule="evenodd"></path>
            </svg></a>
   <a href="registro?V={$shopName}">Crear tienda  <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M22.4 1.55H1.6V.05h20.8v1.5ZM1.665 3.853A.75.75 0 0 1 2.4 3.25h19.2a.75.75 0 0 1 .735.603l1.6 8a.75.75 0 0 1-.735.897h-.85v9.7H24v1.5H0v-1.5h1.65v-9.7H.8a.75.75 0 0 1-.735-.897l1.6-8ZM3.15 12.75v9.7h17.7v-9.7h-1.7v4.8H4.85v-4.8h-1.7Zm3.2 0v3.3h11.3v-3.3H6.35Zm-3.335-8-1.3 6.5h20.57l-1.3-6.5H3.015Z" clip-rule="evenodd"></path>
            </svg></a>
   {/if}
  </div>
</header>

<nav id="mobileMenu" class="cm-header-mobile-menu">
  <div class="cm-header-custom-dropdown cm-header-dropdown-movile" onclick="toggleDropdown(this)">
    <button class="cm-header-dropdown-toggle"><svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M.05 4A2.35 2.35 0 0 1 2.4 1.65h3.2A2.35 2.35 0 0 1 7.95 4v3.2A2.35 2.35 0 0 1 5.6 9.55H2.4A2.35 2.35 0 0 1 .05 7.2V4Zm2.35-.85a.85.85 0 0 0-.85.85v3.2c0 .47.38.85.85.85h3.2c.47 0 .85-.38.85-.85V4a.85.85 0 0 0-.85-.85H2.4ZM24 6.35H11.2v-1.5H24v1.5ZM.05 16.8a2.35 2.35 0 0 1 2.35-2.35h3.2a2.35 2.35 0 0 1 2.35 2.35V20a2.35 2.35 0 0 1-2.35 2.35H2.4A2.35 2.35 0 0 1 .05 20v-3.2Zm2.35-.85a.85.85 0 0 0-.85.85V20c0 .47.38.85.85.85h3.2c.47 0 .85-.38.85-.85v-3.2a.85.85 0 0 0-.85-.85H2.4Zm21.6 3.2H11.2v-1.5H24v1.5Z" clip-rule="evenodd"></path>
</svg> Todas las categorías</button>
    <div class="cm-header-dropdown-menu">
      {foreach from=$categories item=category}
      <a href="{$shopName}/category/{$category->id_categoria}" class="dropdown-item">
                           {$category->nombre}
      </a>
      {/foreach}
    </div>
  </div>


  {if isset($smarty.session.USER_NAME)}  
        <a href="{$shopName}/products"><svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M11.705.11a.75.75 0 0 1 .59 0l11.2 4.797a.75.75 0 0 1 .455.69V18.4a.75.75 0 0 1-.455.69l-11.2 4.8a.75.75 0 0 1-.59 0l-11.2-4.8a.75.75 0 0 1-.455-.69V5.597c0-.3.179-.571.455-.69l11.2-4.796Zm-.455 10.78-9.7-4.152v11.168l9.7 4.158V10.889Zm1.5 11.174 9.7-4.157V6.735l-9.7 4.16v11.168Zm8.545-16.466L12 1.616l-9.295 3.98L12 9.579l9.295-3.981Z" clip-rule="evenodd"></path>
</svg>Todos los productos</a>
  <a href="miscompras">
            <svg width="20" height="20" fill="currentColor"  viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M12 1.55A4.05 4.05 0 0 0 7.95 5.6v.8h-1.5v-.8a5.55 5.55 0 1 1 11.1 0v.8h-1.5v-.8A4.05 4.05 0 0 0 12 1.55Zm-6.568 8a.85.85 0 0 0-.845.756l-1.244 11.2a.85.85 0 0 0 .845.944h15.624a.85.85 0 0 0 .845-.944l-1.244-11.2a.85.85 0 0 0-.845-.756H5.432Zm-2.336.59a2.35 2.35 0 0 1 2.336-2.09h13.136c1.197 0 2.203.9 2.336 2.09l1.244 11.2a2.35 2.35 0 0 1-2.336 2.61H4.188a2.35 2.35 0 0 1-2.336-2.61l1.244-11.2Z" clip-rule="evenodd"></path>
            </svg>
            Compras
         </a>
         <a href="carrito">
            <svg width="20" height="20" fill="currentColor" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="m.082 1.015 1.436-.43.8 2.665H20a3.95 3.95 0 0 1 3.95 3.95v10.35H5.042L.082 1.015ZM2.768 4.75l3.39 11.3H22.45V7.2A2.45 2.45 0 0 0 20 4.75H2.768Zm6.032 16a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Zm-2.35.85a2.35 2.35 0 1 1 4.7 0 2.35 2.35 0 0 1-4.7 0Zm11.2 0a2.35 2.35 0 1 1 4.7 0 2.35 2.35 0 0 1-4.7 0Zm2.35-.85a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Z" clip-rule="evenodd"></path>
            </svg>
            Carrito
         </a>
  <a href="dashboard/profile/{$smarty.session.ID_USER}">
  <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M8.774.655A.75.75 0 0 1 9.51.05h4.978a.75.75 0 0 1 .736.604l.138.694v.004l.444 2.161c.639.28 1.23.628 1.777 1.024l2.198-.735.016-.006.691-.214a.75.75 0 0 1 .87.339l.358.614 1.772 2.964.36.617a.75.75 0 0 1-.155.944l-.533.464-1.665 1.417c.053.32.103.68.103 1.052 0 .371-.05.732-.103 1.052l1.671 1.422.527.459a.75.75 0 0 1 .155.943l-.364.624-1.768 2.958-.357.615a.75.75 0 0 1-.872.338l-.691-.215-.015-.005-2.198-.735a9.571 9.571 0 0 1-1.777 1.023l-.443 2.161-.001.005-.139.694a.75.75 0 0 1-.735.604H9.51a.75.75 0 0 1-.736-.606l-.136-.692-.001-.006-.445-2.16a9.567 9.567 0 0 1-1.776-1.023l-2.199.735-.014.005-.691.215a.75.75 0 0 1-.873-.34l-.356-.614L.51 16.485l-.359-.617a.75.75 0 0 1 .155-.941l.533-.466 1.665-1.417a6.444 6.444 0 0 1-.104-1.051c0-.37.051-.733.104-1.052L.831 9.518l-.525-.46a.75.75 0 0 1-.155-.94l.364-.626 1.768-2.957.356-.613a.75.75 0 0 1 .871-.34l.691.214.016.006 2.199.735a9.57 9.57 0 0 1 1.776-1.024l.446-2.162.136-.696Zm1.353.895-.02.1-.526 2.557a.75.75 0 0 1-.467.55c-.762.29-1.46.705-2.1 1.206a.75.75 0 0 1-.7.121L3.75 5.227l-.112-.035-.064.109-1.768 2.957-.046.078.056.05 1.986 1.69c.2.17.297.432.254.69l-.045.271c-.06.357-.11.644-.11.956 0 .311.05.599.11.955l.045.27a.75.75 0 0 1-.254.692L1.815 15.6l-.056.05.046.078 1.774 2.966.058.1.111-.035 2.566-.858a.75.75 0 0 1 .7.121c.64.501 1.338.916 2.1 1.207a.75.75 0 0 1 .467.55l.528 2.563.018.094h3.746l.019-.096v-.004l.525-2.557a.75.75 0 0 1 .467-.55 8.084 8.084 0 0 0 2.1-1.207.75.75 0 0 1 .7-.12l2.566.857.113.035.064-.109 1.767-2.958.046-.078-.056-.048-1.987-1.69a.75.75 0 0 1-.254-.695l.04-.234c.064-.37.115-.669.115-.99 0-.32-.051-.619-.115-.988a45.3 45.3 0 0 1-.04-.235.75.75 0 0 1 .254-.694l1.987-1.69.056-.049-.046-.078-1.771-2.964-.06-.103-.114.036-2.565.857a.75.75 0 0 1-.7-.12 8.082 8.082 0 0 0-2.1-1.208.75.75 0 0 1-.467-.55l-.525-2.56-.02-.096h-3.745ZM12 9.545a2.45 2.45 0 0 0-2.45 2.448 2.45 2.45 0 0 0 4.9 0A2.45 2.45 0 0 0 12 9.545Zm-3.95 2.448a3.95 3.95 0 0 1 7.9 0 3.95 3.95 0 0 1-7.9 0Z" clip-rule="evenodd"></path>
            </svg>Panel de control</a>
  <a href="logout"><svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M1.65 1.65H12.8v1.5H3.15v17.7h9.65v1.5H1.65V1.65Zm15.68 5.02 5.31 5.31-5.289 5.729-1.102-1.018 3.638-3.941H6.4v-1.5h13.39l-3.52-3.52 1.06-1.06Z" clip-rule="evenodd"></path>
            </svg>Salir</a>
   {else}
 <a  href="login?V={$shopName}">   <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M.05 12C.05 5.4 5.4.05 12 .05S23.95 5.4 23.95 12 18.6 23.95 12 23.95.05 18.6.05 12ZM12 1.55C6.229 1.55 1.55 6.23 1.55 12c0 5.771 4.679 10.45 10.45 10.45 5.771 0 10.45-4.679 10.45-10.45 0-5.771-4.679-10.45-10.45-10.45Zm1.6 6.19L17.86 12l-4.26 4.26-1.06-1.06 2.45-2.45H6.4v-1.5h8.59L12.54 8.8l1.06-1.06Z" clip-rule="evenodd"></path>
            </svg>Iniciar sesión</a>
   <a href="registro?V={$shopName}">
    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path fill-rule="evenodd" d="M22.4 1.55H1.6V.05h20.8v1.5ZM1.665 3.853A.75.75 0 0 1 2.4 3.25h19.2a.75.75 0 0 1 .735.603l1.6 8a.75.75 0 0 1-.735.897h-.85v9.7H24v1.5H0v-1.5h1.65v-9.7H.8a.75.75 0 0 1-.735-.897l1.6-8ZM3.15 12.75v9.7h17.7v-9.7h-1.7v4.8H4.85v-4.8h-1.7Zm3.2 0v3.3h11.3v-3.3H6.35Zm-3.335-8-1.3 6.5h20.57l-1.3-6.5H3.015Z" clip-rule="evenodd"></path>
            </svg>
   Crear tienda</a>
   {/if}
</nav>




<script>
  function toggleProfile() {
    document.getElementById("profileDropdown").classList.toggle("open");
  }

  function toggleProfileMobile() {
    document.getElementById("mobileProfileDropdown").classList.toggle("open");
  }

  function toggleMobileMenu() {
    document.getElementById("mobileMenu").classList.toggle("open");
  }

  function toggleDropdown(el) {
    document.querySelectorAll('.custom-dropdown').forEach(d => {
      if (d !== el) d.classList.remove('open');
    });
    el.classList.toggle('open');
  }

  function selectCategory(btn) {
    const dropdown = btn.closest('.custom-dropdown');
    const toggle = dropdown.querySelector('.dropdown-toggle');
    toggle.textContent = btn.textContent ;
    dropdown.classList.remove('open');
  }

  document.addEventListener("click", function (e) {
    if (!e.target.closest(".profile")) {
      document.querySelectorAll(".profile").forEach(p => p.classList.remove("open"));
    }

    if (!e.target.closest(".custom-dropdown")) {
      document.querySelectorAll(".custom-dropdown").forEach(d => d.classList.remove("open"));
    }
  });
</script>