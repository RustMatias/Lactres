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
      <link rel="stylesheet" href="css/INI_mainpage.css">
      <link rel="stylesheet" href="css/INI_header.css">
      <link rel="stylesheet" href="css/CM_category.css">
      <link rel="shortcut icon" href="{$shopFront[0]->logo}" />
      <link rel="stylesheet" href="css/productDetail.css">
      <link rel="stylesheet" href="css/productCard.css">
      <link rel="stylesheet" href="css/asideMenu.css">
      <link rel="stylesheet" href="css/categoryHomeList.css">
      <link rel="stylesheet" href="css/carrouselHome.css">
    {*   <link rel="stylesheet" href="css/CM_header.css"> *}
   {*    <link rel="stylesheet" href="css/header-offlog.css"> *}
      <link rel="stylesheet" href="css/footer.css">
      <link rel="stylesheet" href="css/home.css">
      <link rel="stylesheet" href="css/profile.css">
      <link rel="stylesheet" href="css/editProduct.css">
      <link rel="stylesheet" href="css/admin.css">
      <link rel="stylesheet" href="css/carrito.css">
      <link rel="stylesheet" href="css/adminStadistics.css">
      <link rel="shortcut icon" href="./images/logopng.png" />
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
   </head>
   <!-- Meta Pixel Code -->

<!-- End Meta Pixel Code -->
   <style>
      .ini_mainpage_header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 20px;
      background-color:  {$color_fondo};
      position: relative;
      color: {$color_texto};
      }
      .ini_mainpage_search-input {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid white;
      background: {$color_fondo};
      color: {$color_texto};
      border-radius: 5px;
      outline: none;
      box-sizing: border-box;
      }
      .ini_mainpage_search-button svg{
      stroke: {$color_texto};;
      }
      .dropdown-emp {
      color: {$color_texto} !important;
      stroke: {$color_texto};;
      }
      .cm_mainpage_colortexto-db {
      color: {$color_texto};
      }
      .cm_mainpage_colortexto-db:hover {
      color: {$color_texto};
      font-weight: bold;
      }
   </style>
   <header class="ini_mainpage_header">
      <div class="ini_mainpage_header-left">
         <button id="search-icon" class="ini_mainpage_search-button">
            <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
               <path d="M11 3a8 8 0 1 0 0 16 8 8 0 1 0 0-16z"></path>
               <path d="m21 21-4.35-4.35"></path>
            </svg>
         </button>
         <div class="ini-mobile-backout"></div>
         <form id="search-form-emp" action="{$shopName}/search" method="POST">
            <input type="text" name="search" class="ini_mainpage_search-input" placeholder="Buscar en {$shopFront[0]->nombre_simple}">
         </form>
      </div>
      <div class="ini_mainpage_header-center">
         <img src="{$shopFront[0]->logo}" alt="Logo de {$shopFront[0]->nombre_simple}" class="ini_mainpage_logo">
      </div>
      <div class="ini_mainpage_header-right">
         <ul>
            {if isset($smarty.session.USER_NAME)}        
            <li class="nav-item dropdown ">
               <a 
                  class="nav-link dropdown-toggle cm_mainpage_colortexto-db hover-header" 
                  href="#" 
                  id="userDropdown" 
                  role="button" 
                  data-bs-toggle="dropdown" 
                  aria-expanded="false"
                  >
                  <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                     <path d="M12 3a4 4 0 1 0 0 8 4 4 0 1 0 0-8z"></path>
                  </svg>
             
               </a>
               <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                 
                  <li>
                     <a class="dropdown-item d-flex align-items-center" href="miscompras">
                        <span class="mr-2">Mis compras</span>
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                           <path d="M3 6h18"></path>
                           <path d="M16 10a4 4 0 0 1-8 0"></path>
                        </svg>
                     </a>
                  </li>
                  <li>
                     <a class="dropdown-item d-flex align-items-center" href="carrito">
                        <span class="mr-2">Carrito</span>
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="M9 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                           <path d="M20 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                           <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                     </a>
                  </li>
                  <li>
                  <a class="dropdown-item  d-flex align-items-center" href="dashboard/profile/{$smarty.session.ID_USER}">
                     <span class="mr-2">Panel de control</span>
                     <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <rect width="20" height="14" x="2" y="3" rx="2" ry="2"></rect>
                        <path d="M8 21h8"></path>
                        <path d="M12 17v4"></path>
                     </svg>
                  </a>
               </li>
                  {if isset($smarty.session.ADMIN) && $smarty.session.ADMIN == 1}
                  <li>
                     <a class="dropdown-item  d-flex align-items-center" href="sudoAdmin">
                        <span class="mr-2">Admin</span>
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <rect width="20" height="14" x="2" y="3" rx="2" ry="2"></rect>
                           <path d="M8 21h8"></path>
                           <path d="M12 17v4"></path>
                        </svg>
                     </a>
                  </li>
                  {/if}
                  <li>
                     <a class="dropdown-item text-danger d-flex align-items-center" href="logout">
                        <span class="mr-2">Salir</span>
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="m19 12-3-3m-4 3h7-7Zm7 0-3 3 3-3Z"></path>
                           <path d="M19 6V5a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-1"></path>
                        </svg>
                     </a>
                  </li>
               </ul>
            </li>
            {else}
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle dropdown-emp" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <svg width="30" height="30" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                     <path d="M12 3a4 4 0 1 0 0 8 4 4 0 1 0 0-8z"></path>
                  </svg>
               </a>
               <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                  <li>
                     <a class="dropdown-item" href="registro?V={$shopName}">
                        Crear cuenta
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                           <path d="m10 17 5-5-5-5"></path>
                           <path d="M15 12H3"></path>
                        </svg>
                     </a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="login?V={$shopName}">
                        Ingresar
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                           <path d="m10 17 5-5-5-5"></path>
                           <path d="M15 12H3"></path>
                        </svg>
                     </a>
                  </li>
               </ul>
            </li>
            {/if}
         </ul>
      </div>
   </header>
   <script>
      document.addEventListener("DOMContentLoaded", () => {
         const searchIcon = document.getElementById("search-icon");
         const searchForm = document.getElementById("search-form-emp");
         const blackout = document.querySelector(".ini-mobile-backout");
      
         searchIcon.addEventListener("click", () => {
            searchIcon.style.display = "none";
            searchForm.classList.add("active");
            blackout.classList.add("active");
      
            // Focalizar el campo de búsqueda
            searchForm.querySelector("input").focus();
         });
      
         // Cierra el formulario al hacer clic fuera de él
         document.addEventListener("click", (e) => {
            if (!searchForm.contains(e.target) && !searchIcon.contains(e.target)) {
               searchForm.classList.remove("active");
               blackout.classList.remove("active");
               searchIcon.style.display = "inline-block";
            }
         });
      });
   </script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>