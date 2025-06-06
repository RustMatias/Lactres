<?php
require_once('libs/smarty/libs/Smarty.class.php');

class AdminView{


    //pagina de admin

    function showAdmin($categories, $products, $bannerimages, $shopInfo, $enviosData) {
        $smarty = new Smarty();
        $smarty->assign('bannerimages', $bannerimages);
        $smarty->assign('shopInfo', $shopInfo);
        $smarty->assign('categories', $categories);
        $smarty->assign('enviosData', $enviosData);

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
        $smarty->display('templates/ADMIN_controlPanel.tpl');
    }
    

    //Pagina de error
    function showError($msg){
        $smarty = new Smarty();
        $smarty->assign('msg', $msg);
        $smarty->display('templates/error.tpl');
    }

    function showAdminStock($products, $categorias, $search, $categoriaSelected, $priceOrder, $stockOrder, $currentPage, $totalPages,  $shopInfo) {
        $smarty = new Smarty(); 
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
    
        $smarty->display('templates/ADMIN_Products.tpl');
    }
    
    
    
    

    public function showPedidos($pedidos, $estadoNombres, $search, $currentEstado, $estadisticas, $currentPage, $totalPages) {
        $smarty = new Smarty();
        $smarty->assign('pedidos', $pedidos);
        $smarty->assign('estadoNombres', $estadoNombres);
        $smarty->assign('search', $search);
        $smarty->assign('currentEstado', $currentEstado);
        $smarty->assign('estadisticas', $estadisticas);
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
        $smarty->display('templates/ADMIN_Pedidos.tpl');
    }
    
    

    
    function showStadistics($productoMasVendidos,    $productoMejorValorados,  $categoriaMasVisitada,  $categoriaMasVendida ) {
        $smarty = new Smarty();
        $smarty->assign('productoMasVendidos', $productoMasVendidos);
        $smarty->assign('productoMejorValorados', $productoMejorValorados);
        $smarty->assign('categoriaMasVisitada', $categoriaMasVisitada);
        $smarty->assign('categoriaMasVendida', $categoriaMasVendida);
        
        $smarty->display('templates/ADMIN_Stadistics.tpl');
    }
    
    
    

    function showPedido($pedido, $usuario,  $shopInfo) {
        $smarty = new Smarty();
        $smarty->assign('pedido', $pedido);
        $informacion = json_decode($pedido->informacion, true);
        $smarty->assign('informacion', $informacion);
        $smarty->assign('usuario', $usuario);
        $smarty->assign('shopInfo', $shopInfo);
        $smarty->display('templates/ADMIN_GestionarPedido.tpl');
    }
    

    

    function ShowCypherProducts() {
        $smarty = new Smarty();
        $smarty->display('templates/ADMIN_cypherProducts.tpl');
    }
    
    function showSudoAdmin($pagos, $usuarios, $tiendas, $codigos){
        $smarty = new Smarty();
        $smarty->assign('pagos', $pagos);

        $smarty->assign('usuarios', $usuarios);

        $smarty->assign('tiendas', $tiendas);


        $smarty->assign('codigos', $codigos);

        $smarty->display('templates/ADMIN_sudoAdmin.tpl');
    }

}




