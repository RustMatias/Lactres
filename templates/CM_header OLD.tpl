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
      <link rel="stylesheet" href="css/header-offlog.css">
      <link rel="stylesheet" href="css/footer.css">
      <link rel="stylesheet" href="css/home.css">
      <link rel="stylesheet" href="css/profile.css">
      <link rel="stylesheet" href="css/editProduct.css">
      <link rel="stylesheet" href="css/admin.css">
      <link rel="stylesheet" href="css/carrito.css">
      <link rel="stylesheet" href="css/adminStadistics.css">
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
   </head>
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
   </style>
   <body class="">
      <header class="sticky-top">
         {assign var="color_fondo" value=$colors[0]->color}
         <nav class="navbar navbar-expand-lg header-class" style="background-color: {$color_fondo};">
            <div class="container">
               <div class="cm-header-search-mobile">
                  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                     <svg width="20" height="20" fill="none" stroke="#fefefe" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M8 6h13"></path>
                        <path d="M8 12h13"></path>
                        <path d="M8 18h13"></path>
                        <path d="M3 6h.01"></path>
                        <path d="M3 12h.01"></path>
                        <path d="M3 18h.01"></path>
                     </svg>
                  </button>
                  <div class="search-container-mobile">
                     <form action="{$shopName}/search"  method="POST">
                        <input type="text" name="search" class="search-input" placeholder="Buscar en {$shopFront[0]->nombre_simple}">
                        <svg 
                           class="search-icon"
                           width="26" height="26" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                           <path d="M16.97 14.332a7.8 7.8 0 1 0-1.676 1.678h-.001c.036.048.074.094.117.138l4.62 4.62a1.2 1.2 0 0 0 1.698-1.697l-4.62-4.62a1.201 1.201 0 0 0-.138-.12v.001Zm.31-4.612a6.6 6.6 0 1 1-13.2 0 6.6 6.6 0 0 1 13.2 0Z"></path>
                        </svg>
                     </form>
                  </div>
               </div>
               <div class="collapse navbar-collapse" id="navbarNavDropdown">
                  <ul class="navbar-nav mr-auto d-flex w-100 headerpage">
                     <li class="nav-item ml-0">
                        <div class="search-container">
                           <form action="{$shopName}/search"  method="POST">
                              <input type="text" name="search" class="search-input" placeholder="Buscar en {$shopFront[0]->nombre_simple}">
                              <svg 
                                 class="search-icon"
                                 width="26" height="26" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                 <path d="M16.97 14.332a7.8 7.8 0 1 0-1.676 1.678h-.001c.036.048.074.094.117.138l4.62 4.62a1.2 1.2 0 0 0 1.698-1.697l-4.62-4.62a1.201 1.201 0 0 0-.138-.12v.001Zm.31-4.612a6.6 6.6 0 1 1-13.2 0 6.6 6.6 0 0 1 13.2 0Z"></path>
                              </svg>
                           </form>
                        </div>
                     </li>
                     <!--Adm options-->
                     <li class="nav-item cm-header-ml-auto hover-header carrito">
                        <a class="nav-link cm_mainpage_colortexto-db " href="miscompras">
                           Mis compras
                           <svg width="20" height="20" fill="none"  stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path d="m20.59 13.41-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
                              <path d="M7 7h.01"></path>
                           </svg>
                        </a>
                     </li>
                     <li class="nav-item  hover-header carrito">
                        <a class="nav-link cm_mainpage_colortexto-db " href="carrito">
                           Carrito
                           <svg width="20" height="20" fill="none" class=""  stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path d="M9 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                              <path d="M20 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                              <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                           </svg>
                        </a>
                     </li>
                     <!--Session options-->
                     {if isset($smarty.session.USER_NAME)}        
                     <li class="nav-item dropdown">
                        <a 
                           class="nav-link dropdown-toggle cm_mainpage_colortexto-db hover-header" 
                           href="#" 
                           id="userDropdown" 
                           role="button" 
                           data-bs-toggle="dropdown" 
                           aria-expanded="false"
                           >
                        {$smarty.session.USER_NAME}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                          
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
                                 <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path d="m19 12-3-3m-4 3h7-7Zm7 0-3 3 3-3Z"></path>
                                    <path d="M19 6V5a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-1"></path>
                                 </svg>
                              </a>
                           </li>
                        </ul>
                     </li>
                     {/if}
                  </ul>
               </div>
            </div>
         </nav>
         <nav class="navbar navbar-expand-lg header-class p-0 pb-1 " style="background-color: {$color_fondo};">
            <div class="container d-flex justify-content-between align-items-center ">
               <div>
                  {if isset($shopName)}
                  <small class="nav-item dropdown">
                     <a 
                        class="dropdown-toggle cm_mainpage_colortexto-db" 
                        href="#" 
                        id="userDropdown" 
                        role="button" 
                        data-bs-toggle="dropdown" 
                        aria-expanded="false"
                        >
                     Todas las Categorías
                     </a>
                     <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                        {foreach from=$categories item=category}
                        <li>
                           <a href="{$shopName}/category/{$category->id_categoria}" class="dropdown-item">
                           {$category->nombre}
                           </a>
                        </li>
                        {/foreach}
                     </ul>
                  </small>
                  {/if}
                  <a href="{$shopName}/products" class="ml-4 cm_mainpage_colortexto-db">
                  <small>
                  Todos nuestros productos
                  </small>
                  </a>
               </div>
               <!-- Links de registro e inicio de sesión -->
               <div class="cm-inicio-container-oflog">
                  {if !isset($smarty.session.USER_NAME)}   
                  <a class="pr-5 cm_mainpage_colortexto-db" href="registro?V={$shopName}">
                     <small>  Crear cuenta</small>
                     <svg width="16" height="16" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                        <path d="m10 17 5-5-5-5"></path>
                        <path d="M15 12H3"></path>
                     </svg>
                  </a>
                  <a class="cm_mainpage_colortexto-db" href="login?V={$shopName}">
                     <small>Ingresar</small>
                     <svg width="16" height="16" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                        <path d="m10 17 5-5-5-5"></path>
                        <path d="M15 12H3"></path>
                     </svg>
                  </a>
                  {/if}
                  <a class="ml-5 cm_mainpage_colortexto-db" href="home">#MiTiendaCyShops</a>
               </div>
            </div>
         </nav>
      </header>