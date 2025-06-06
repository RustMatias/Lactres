<?php
require_once('libs/smarty/libs/Smarty.class.php');

class ProductView{

    function showHome(){
        $smarty = new Smarty();


        $smarty->display('templates/GEN_home.tpl');
    }


    function showEmprendedores(){
        $smarty = new Smarty();


        $smarty->display('templates/GEN_emprendedores.tpl');
    }



    
    function showProductDetail($products, $imagenes,$relatedProducts, $comments, $valoracionProducto, $categories,$shopName, $colors,  $shopFront ){
        $smarty = new Smarty();
        $smarty->assign('product', $products);
        $smarty->assign('imagenes', $imagenes);

        $smarty->assign('relatedProducts', $relatedProducts);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('comments', $comments);
        $smarty->assign('valoracionProducto', $valoracionProducto);
        $smarty->assign('categories', $categories);
        $smarty->assign('shopName', $shopName);
        $smarty->display('templates/CM_productDetail.tpl');
    }
    
    function editProduct($products, $shopName,   $categories){
        $smarty = new Smarty();
        $smarty->assign('product', $products);

        $smarty->assign('categories', $categories);

        $smarty->assign('shopName', $shopName);

        $smarty->display('templates/GEN_editProduct.tpl');
    }

    function showAllProducts($products, $categories, $shopName, $colors,  $shopFront  ){
        $smarty = new Smarty();
        $smarty->assign('products', $products);
        $smarty->assign('shopName', $shopName);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('categories', $categories);

        $smarty->display('templates/CM_allproducts.tpl');
    }

    function MID_showAllProducts($products, $categories, $shopName, $colors,  $shopFront  ){
        $smarty = new Smarty();
        $smarty->assign('products', $products);
        $smarty->assign('shopName', $shopName);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('categories', $categories);

        $smarty->display('templates/MID_allproducts.tpl');
    }

    function CM_searchResult($products, $categories, $search, $shopName, $colors,  $shopFront){
        $smarty = new Smarty();
        $smarty->assign('search', $search);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);
        $smarty->assign('products', $products);
        $smarty->assign('shopName', $shopName);
        $smarty->assign('categories', $categories);
        $smarty->display('templates/CM_search.tpl');
    }

    function INI_searchResult($products,  $search, $shopName, $colors,  $shopFront){
        $smarty = new Smarty();
        $smarty->assign('search', $search);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('products', $products);
        $smarty->assign('shopName', $shopName);

        $smarty->display('templates/INI_search.tpl');
    }

    function MID_searchResult($products, $categories, $search, $shopName, $colors,  $shopFront){
        $smarty = new Smarty();
        $smarty->assign('search', $search);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);
        $smarty->assign('categories', $categories);

        $smarty->assign('products', $products);
        $smarty->assign('shopName', $shopName);

        $smarty->display('templates/MID_search.tpl');
    }
}


