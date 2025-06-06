<?php
require_once('libs/smarty/libs/Smarty.class.php');

class ShopView{

    function ShowShopMainPage($products, $bestproducts,$categories, $rankCategories, $bannerimages, $shopName,$colors, $shopFront){
        $smarty = new Smarty();
        $smarty->assign('bannerimages', $bannerimages);
        $smarty->assign('products', $products);
        $smarty->assign('bestproducts', $bestproducts);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('shopName', $shopName);

        $smarty->assign('categories', $categories);
        $smarty->assign('rankCategories', $rankCategories);
        $smarty->display('templates/CM_mainPage.tpl');
    }
    

    function MID_ShowShopMainPage($products, $categories,  $bannerimages, $shopName,$colors, $shopFront){
        $smarty = new Smarty();
        $smarty->assign('bannerimages', $bannerimages);
        $smarty->assign('products', $products);
        $smarty->assign('colors', $colors);
        $smarty->assign('shopFront', $shopFront);

        $smarty->assign('shopName', $shopName);

        $smarty->assign('categories', $categories);
        $smarty->display('templates/MID_mainPage.tpl');
    }

    function INI_ShowShopMainPage($products, $shopName,$colors, $shopFront){
        $smarty = new Smarty();

        $smarty->assign('products', $products);
        $smarty->assign('shopFront', $shopFront);
       
        $smarty->assign('colors', $colors);

        $smarty->assign('shopName', $shopName);

        $smarty->display('templates/INI_mainPage.tpl');
    }


    function paginaNoDisponible(){
        $smarty = new Smarty();
        $smarty->display('templates/GEN_paginaNoDisponible.tpl');
    }



}




