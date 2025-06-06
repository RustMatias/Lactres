<?php
require_once('libs/smarty/libs/Smarty.class.php');

class CategoryView{

    function showCategory($products, $category,      $categories ,$currentPage, $totalPages,   $shopName, $colors, $shopFront) {
        $smarty = new Smarty();
        $smarty->assign('products', $products);
        $smarty->assign('category', $category);
        $smarty->assign('categories',$categories);
        $smarty->assign('shopFront',$shopFront);
     
  
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
        $smarty->assign('shopName', $shopName);
        $smarty->assign('colors', $colors);

        $smarty->display('templates/CM_category.tpl');
    }

    function MID_showCategory($products, $category,      $categories ,$currentPage, $totalPages,   $shopName, $colors, $shopFront) {
        $smarty = new Smarty();
        $smarty->assign('products', $products);
        $smarty->assign('category', $category);
        $smarty->assign('categories',$categories);
        $smarty->assign('shopFront',$shopFront);
     
  
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
        $smarty->assign('shopName', $shopName);
        $smarty->assign('colors', $colors);

        $smarty->display('templates/MID_category.tpl');
    }

    function showBrand($products, $name, $brands, $currentPage, $totalPages) {
        $smarty = new Smarty();
        $smarty->assign('products', $products);
        $smarty->assign('name', $name);
        $smarty->assign('brands', $brands);
        $smarty->assign('currentPage', $currentPage);
        $smarty->assign('totalPages', $totalPages);
        $smarty->display('templates/brand.tpl');
    }
    

    function showEditCategory($categoryInfo ){
        $smarty = new Smarty();
        $smarty->assign('categoryInfo', $categoryInfo);
        $smarty->display('templates/CM_editCategory.tpl');
    }

    
}




