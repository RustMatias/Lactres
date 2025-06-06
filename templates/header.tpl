<!DOCTYPE html>
<html lang="en">
<!--Incluimos el head, ya que se repite en todas las paginas. -->
<head>
    <base href="{BASE_URL}">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cyshops</title>
    <link rel="stylesheet" href="css/css.css">
    <link rel="stylesheet" href="css/productDetail.css">
    <link rel="stylesheet" href="css/productCard.css">
    <link rel="stylesheet" href="css/asideMenu.css">
    <link rel="stylesheet" href="css/categoryHomeList.css">
    <link rel="stylesheet" href="css/carrouselHome.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/editProduct.css">
        <link rel="stylesheet" href="css/CM_mainpage.css">

    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/carrito.css">
    <link rel="stylesheet" href="css/adminStadistics.css">
    <link rel="shortcut icon" href="./images/logopng.png" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>

<body class="">
<header class="sticky-top">
  
    <nav class="navbar navbar-expand-lg navbar-light header-class">
        <a class="navbar-brand " href="home">
            <img class="logopng-header" src="./images/LOGO.png" alt="Buffa-img">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav mr-auto d-flex w-100 headerpage">
                <li class="nav-item active hover-header">
                    <a class="nav-link text-dark" href="home">Inicio <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item hover-header">
                    <a class="nav-link text-dark" href="about">Sobre Nostros</a>
                </li>

                <li class="nav-item">
                    <div class="search-container">
                        <form action="search"  method="POST">

                            <input type="text" name="search" class="search-input" placeholder="Search...">
                       

                            <svg 
                            class="search-icon"
                            width="26" height="26" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M16.97 14.332a7.8 7.8 0 1 0-1.676 1.678h-.001c.036.048.074.094.117.138l4.62 4.62a1.2 1.2 0 0 0 1.698-1.697l-4.62-4.62a1.201 1.201 0 0 0-.138-.12v.001Zm.31-4.612a6.6 6.6 0 1 1-13.2 0 6.6 6.6 0 0 1 13.2 0Z"></path>
                            </svg>
                        </form>
                    </div>
                </li>


                <!--Adm options-->
                {if (isset($smarty.session.USER_NAME)) && ($smarty.session.PERMISOS == 1)}
                    <li class="nav-item ml-auto hover-header carrito">
                        <a class="nav-link text-dark carrito" href="admin">Panel de control
                        
                        <svg width="20" height="20" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <rect width="20" height="14" x="2" y="3" rx="2" ry="2"></rect>
                            <path d="M8 21h8"></path>
                            <path d="M12 17v4"></path>
                            </svg>
                        </a>
                    </li>
                {/if}
                {if (isset($smarty.session.USER_NAME)) && ($smarty.session.PERMISOS == 0)}
                    <li class="nav-item ml-auto hover-header carrito">
                        <a class="nav-link text-dark " href="miscompras">Mis compras
                            <svg width="20" height="20" fill="none"  stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="m20.59 13.41-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
                                <path d="M7 7h.01"></path>
                              </svg>
                        </a>
                    </li>
                    <li class="nav-item  hover-header carrito">
                        <a class="nav-link text-dark " href="carrito">
                            Carrito
                            <svg width="20" height="20" fill="none" class=""  stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                                <path d="M20 20a1 1 0 1 0 0 2 1 1 0 1 0 0-2z"></path>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                              </svg>
                        </a>
                    </li>
                {/if}
              
                <!--Session options-->
                {if isset($smarty.session.USER_NAME)}        
                            
                    <li class="nav-item carrito">
                        <a class="nav-link text-dark logout-header hover-header " href="logout">
                            Salir de {$smarty.session.USER_NAME} 
                            <svg width="20" height="20" fill="none"  stroke-linecap="round" stroke-linejoin="round"  viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                <path d="m16 17 5-5-5-5"></path>
                                <path d="M21 12H9"></path>
                              </svg>
                           
                        </a>
                    </li>

                {else}
                <li class="nav-item ml-auto hover-header" >
                    <a class="nav-link text-dark" href="registro">Registrarse <i class="fa-solid fa-right-to-bracket"></i></a>
                </li>
                <li class="nav-item  hover-header" >
                    <a class="nav-link text-dark" href="login">Ingresar <i class="fa-solid fa-right-to-bracket"></i></a>
                </li>
                   
                {/if}
            </ul>
        </div>
    </nav>
</header>