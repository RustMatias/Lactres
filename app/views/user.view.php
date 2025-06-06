<?php
require_once('libs/smarty/libs/Smarty.class.php');

class UserView{

    //Pagina de about
    public function showCompras($compras  ) {
        $smarty = new Smarty();
        $smarty->assign('compras', $compras);

        $smarty->assign('estadoNombres', [
            1 => "Pedido Realizado",
            2 => "Pago Confirmado",
            3 => "Preparando Pedido",
            4 => "Pedido Enviado",
            5 => "Listo para retirar por el local",
            99 => "Pedido Entregado"
        ]);
        
        $smarty->display('templates/GEN_compras.tpl');
    }

    function showCarrito($carritos) {
        $smarty = new Smarty();

        $smarty->assign('cartData', $carritos); // Pasa toda la lista de carritos
        $smarty->display('templates/GEN_carrito.tpl');
    }

    function creartienda($plantillas) {
        $smarty = new Smarty();
        $smarty->assign('plantillas', $plantillas);
        $smarty->display('templates/GEN_creartienda.tpl');
    }
    

    function showProfile($userinfo){
        $smarty = new Smarty();
        
        $smarty->assign('userinfo', $userinfo);

        $smarty->display('templates/GEN_profile.tpl');
    }

    function showConfirmarCarrito($cartData, $shopInfo, $userInfo, $horaActual, $horarioTienda, $costoEnvio,  $publicKey, $id_usuario_vendedor){
        $smarty = new Smarty();
        $smarty->assign('shopInfo', $shopInfo);
        $smarty->assign('userInfo', $userInfo);
        $smarty->assign('costoEnvio', $costoEnvio);
                $smarty->assign('publicKey', $publicKey);
                $smarty->assign('id_usuario_vendedor', $id_usuario_vendedor);


        $smarty->assign('cartData', $cartData);
        $smarty->assign('horaActual', $horaActual);
        $smarty->assign('horarioTienda', $horarioTienda);
        $smarty->display('templates/GEN_confirmarCarrito.tpl');
    }




    function showPagos($pagosInfo, $userId){
        $smarty = new Smarty();
        $smarty->assign('pagosInfo', $pagosInfo);
        $smarty->assign('userId', $userId);

        $smarty->display('templates/GEN_pagos.tpl');
    }

    function showTerminosYCondiciones(){
        $smarty = new Smarty();
        $smarty->display('templates/GEN_terminosycondiciones.tpl');
    }
    
    function showRecuperarContrasena(){
        $smarty = new Smarty();
        $smarty->display('templates/GEN_recuperarcontrasena.tpl');
    }

    function showCambiarContraseña($mail){
        $smarty = new Smarty();
        $smarty->assign('mail', $mail);

        $smarty->display('templates/GEN_cambiarContrasena.tpl');
    }



    function  dashboard( $page , $userinfo){
        $smarty = new Smarty();
        $smarty->assign('page', $page);

        $smarty->assign('userinfo', $userinfo);
       
        $smarty->display('templates/dashboard/dashboard.tpl');
    }
   
    function  dashboard_stats( $page , $productoMasVendidos,    $productoMejorValorados,  $categoriaMasVisitada,  $categoriaMasVendida){
        $smarty = new Smarty();
        $smarty->assign('page', $page);
        $smarty->assign('productoMasVendidos', $productoMasVendidos);
        $smarty->assign('productoMejorValorados', $productoMejorValorados);
        $smarty->assign('categoriaMasVisitada', $categoriaMasVisitada);
        $smarty->assign('categoriaMasVendida', $categoriaMasVendida);

        $smarty->display('templates/dashboard/dashboard.tpl');
    }
    

    function dashboard_inventory($page, $products, $categorias, $search, $categoriaSelected, $priceOrder, $stockOrder, $currentPage, $totalPages,  $shopInfo) {
        $smarty = new Smarty(); 
        $smarty->assign('page', $page);
        $smarty->assign('products', $products);
        $smarty->assign('shopInfo', $shopInfo);
    
        $smarty->assign('categorias', $categorias); // Agrega las categorías
        $smarty->assign('search', $search);
        $smarty->assign('categoriaSelected', $categoriaSelected); 
        $smarty->assign('priceOrder', $priceOrder);
        $smarty->assign('stockOrder', $stockOrder);
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
    
        // Calcular el rango de páginas a mostrar (máximo 5)
        $startPage = max(1, $currentPage - 2); // Muestra 2 páginas antes de la actual
        $endPage = min($totalPages, $currentPage + 2); // Muestra 2 páginas después de la actual
    
        // Asegurar que siempre se muestren 5 páginas como máximo
        if ($endPage - $startPage < 4) {
            if ($startPage == 1) {
                $endPage = min($startPage + 4, $totalPages);
            } elseif ($endPage == $totalPages) {
                $startPage = max($endPage - 4, 1);
            }
        }
    
        $smarty->assign('startPage', $startPage);
        $smarty->assign('endPage', $endPage);
    
        $smarty->display('templates/dashboard/dashboard.tpl');
    }
    
    
    function dashboard_add_product($page, $categories, $shopInfo,  $products) {
        $smarty = new Smarty();
        $smarty->assign('page', $page);
        $smarty->assign('shopInfo', $shopInfo);
        $smarty->assign('categories', $categories);
        $smarty->assign('products', $products);
        $grupo = $_SESSION['GRUPO'] ?? null;
        $totalProductos = count($products);
        // Lógica para definir limitProducto
        $limitProducto = false;
        if ($grupo === 'C') {
            $limitProducto = true;
        } elseif ($grupo === 'I' && $totalProductos < 12) {
            $limitProducto = true;
        } elseif ($grupo === 'M' && $totalProductos < 50) {
            $limitProducto = true;
        }
    
        $smarty->assign('limitProducto', $limitProducto);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }


    
    public function dashboard_orders($page, $pedidos, $estadoNombres, $search, $currentEstado, $estadisticas, $currentPage, $totalPages) {
        $smarty = new Smarty();
        $smarty->assign('page', $page);

        $smarty->assign('pedidos', $pedidos);
        $smarty->assign('estadoNombres', $estadoNombres);
        $smarty->assign('search', $search);
        $smarty->assign('currentEstado', $currentEstado);
        $smarty->assign('estadisticas', $estadisticas);
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }
    


    function dashboard_manage_orders($page, $pedido, $usuario,  $shopInfo) {
        $smarty = new Smarty();
        $smarty->assign('pedido', $pedido);
        $smarty->assign('page', $page);

        $informacion = json_decode($pedido->informacion, true);
        $smarty->assign('informacion', $informacion);
        $smarty->assign('usuario', $usuario);
        $smarty->assign('shopInfo', $shopInfo);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }


    function dashboard_payments($page, $pagosInfo, $userId){
        $smarty = new Smarty();
        $smarty->assign('pagosInfo', $pagosInfo);
        $smarty->assign('userId', $userId);
        $smarty->assign('page', $page);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }



    
    function dashboard_categories($page, $categories, $userId,  $shopInfo){
        $smarty = new Smarty();
        $smarty->assign('categories', $categories);
        $smarty->assign('userId', $userId);
        $smarty->assign('shopInfo', $shopInfo);

        $smarty->assign('page', $page);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }
    function dashboard_add_category($page, $shopInfo){
        $smarty = new Smarty();
        $smarty->assign('shopInfo', $shopInfo);

        $smarty->assign('page', $page);
        $smarty->display('templates/dashboard/dashboard.tpl');
    }


    function dashboard_brand($page,$bannerimages, $shopInfo) {
        $smarty = new Smarty();
        $smarty->assign('page', $page);
        $smarty->assign('bannerimages', $bannerimages);
        $smarty->assign('shopInfo', $shopInfo);
        $grupo = $_SESSION['GRUPO'] ?? null;
        $smarty->display('templates/dashboard/dashboard.tpl');

    }



    function dashboard_shipments($page, $shopInfo, $enviosData) {
            $smarty = new Smarty();
            $smarty->assign('page', $page);
            $smarty->assign('shopInfo', $shopInfo);
            $smarty->assign('enviosData', $enviosData);
            $smarty->display('templates/dashboard/dashboard.tpl');
      
    }
    
}






