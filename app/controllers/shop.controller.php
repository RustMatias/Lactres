<?php
include_once 'app/views/shop.view.php';
include_once 'app/models/product.model.php';
include_once 'app/models/category.model.php';
include_once 'app/models/shop.model.php';


class ShopController {

    private $shopview;
    private $shopmodel;
    private $productmodel;
    private $categorymodel;
   // private $view;

    function __construct() {
        $this->shopview = new ShopView();
        $this->shopmodel = new ShopModel();
        $this->productmodel = new ProductModel();
        $this->categorymodel = new CategoryModel();
        session_start();
    }





    function ShowShopMainPage($params = null) {
        $shopName = $params[':UNIQUENAME'];
        if (  !$shopName ) {
            header("Location: " . BASE_URL . 'home'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $id_shop = $this->shopmodel->getIdByShop($shopName);
        if (  !$id_shop ) {
            error_log("ID de la tienda: " . print_r($id_shop, true));
            header("Location: " . BASE_URL . 'home'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        
        $plantilla = $this->shopmodel->getPlantillaById($id_shop);

        // Asegúrate de que el valor de id_shop contiene la plantilla correctamente
        if (empty($plantilla)) {
            // Si no se encuentra el id_plantilla, redirige a home
            header("Location: " . BASE_URL . 'home');
            exit();
        }
        if (!$this->shopmodel->isShopActive($id_shop)) {
            // Si no se encuentra el id_plantilla, redirige a home
            header("Location: " . BASE_URL . 'paginaNoDisponible');
            exit();
        }
        // Obtén el id_plantilla de la respuesta de la base de datos
        $id_plantilla = $plantilla[0]->id_plantilla; // Asumiendo que la función devuelve un array de objetos
        
        switch ($id_plantilla) {
            case 1:
                $this->CM_MainPage($shopName, $id_shop);
                break;
            case 3:
                $this->INI_MainPage($shopName, $id_shop);
                break;
            case 4:
                $this->MID_MainPage($shopName, $id_shop);
                break;
            default:
                // Si no hay coincidencia, redirige a home
               header("Location: " . BASE_URL . 'home');
                exit();
        }
        
    }
    



   Function CM_MainPage($shopName, $id_shop){
         $shopFront = $this->shopmodel->getShopFront($id_shop);
        $bannerimages = $this->shopmodel->getAllBannerImg($id_shop);
        $products = $this->productmodel->getHomeProducts($id_shop);
        $bestproducts = $this->productmodel->getBestRatedProduct($id_shop);
        $categories = $this->categorymodel->GetCategories($id_shop);
        $rankCategories = $this->categorymodel->getRankCategories($id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);
        $this->shopview->ShowShopMainPage($products,$bestproducts, $categories, $rankCategories, $bannerimages,$shopName, $colors, $shopFront);

   }

   Function MID_MainPage($shopName, $id_shop){
        $shopFront = $this->shopmodel->getShopFront($id_shop);
        $bannerimages = $this->shopmodel->getAllBannerImg($id_shop);
        $products = $this->productmodel->getHomeProducts($id_shop);
        $categories = $this->categorymodel->GetCategories($id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);
        $this->shopview->MID_ShowShopMainPage($products,$categories, $bannerimages,$shopName,$colors, $shopFront);
    }





    Function INI_MainPage($shopName, $id_shop){
        $shopFront = $this->shopmodel->getShopFront($id_shop);
        $products = $this->productmodel->INI_getHomeProducts($id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);
        $this->shopview->INI_ShowShopMainPage($products,$shopName,$colors, $shopFront);

   }

   function paginaNoDisponible(){
    $this->shopview->paginaNoDisponible();
   }

}