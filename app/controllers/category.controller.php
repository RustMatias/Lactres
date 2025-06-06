<?php
include_once 'app/helpers/user.helper.php';
include_once 'app/models/product.model.php';
include_once 'app/models/shop.model.php';

include_once 'app/models/category.model.php';
include_once 'app/views/product.view.php';
include_once 'app/views/category.view.php';

class CategoryController {
    private $userhelper;
    private $categoryModel;
    private $productView;
    private $productModel;
    private $shopmodel;


    function __construct() {
        $this->userhelper = new UserHelper();
        $this->categoryModel = new CategoryModel();
        $this->productView = new ProductView();
        $this->categoryView = new CategoryView();
        $this->productModel = new ProductModel();
        $this->shopmodel = new ShopModel();

    }

    function addCategory() {
        if (1 == 1) {
            $nombre = $_POST['nombre'];
            $descripcion = $_POST['descripcion'];
            $id_tienda = $_POST['id_tienda'];


            if($_FILES['input_image']['type'] == "image/jpg" || $_FILES['input_image']['type'] == "image/jpeg" || $_FILES['input_image']['type'] == "image/png" ){
                $imagename= $this->uniqueSaveName($_FILES['input_image']['name'],$_FILES['input_image']['tmp_name']);
                $this->categoryModel->addCategory(
                    $id_tienda,
                    $nombre,
                    $descripcion,
                    $imagename // Pasa el path completo, no solo el nombre
                );
            }else{
                $this->categoryModel->addCategory(
                    $id_tienda,
                    $nombre,
                    $descripcion,
                    '' // Pasa el path completo, no solo el nombre
                );

            }
            // redirigimos al listado
           header("Location: " . BASE_URL . "dashboard/categories/".$_SESSION['ID_USER']);
        } else {
            $this->showError('No tienes acceso a esta seccion');
        }
    }

    function editCategory() {
        if (1 == 1) {
            $nombre = $_POST['nombre'];
            $descripcion = $_POST['descripcion'];
            $id = $_POST['id_categoria'];
    
            // Obtener la imagen actual de la base de datos
            $categoria = $this->categoryModel->getCategory($id);
            $imagenActual = $categoria->imagen;
    
            // Comprobar si se subió una nueva imagen
            if (!empty($_FILES['nueva_imagen']['name']) && 
                ($_FILES['nueva_imagen']['type'] == "image/jpg" || 
                 $_FILES['nueva_imagen']['type'] == "image/jpeg" || 
                 $_FILES['nueva_imagen']['type'] == "image/png")) {
    
                // Guardar la nueva imagen con un nombre único
                $imagename = $this->uniqueSaveName($_FILES['nueva_imagen']['name'], $_FILES['nueva_imagen']['tmp_name']);
            } else {
                // Si no se subió una nueva imagen, usar la imagen actual
                $imagename = $imagenActual;
            }
    
            // Llamar al modelo para actualizar la categoría
            $this->categoryModel->editCategory($id, $nombre, $descripcion, $imagename);
    
            // Redirigir al administrador
           header("Location: " . BASE_URL . "admin");
        } else {
            $this->showError('No tienes acceso a esta sección');
        }
    }
    
    
    function uniqueSaveName($realName, $tempName) {
        
        $filePath = "img_storage/" . uniqid("", true) . "." 
            . strtolower(pathinfo($realName, PATHINFO_EXTENSION));

        move_uploaded_file($tempName, $filePath);

        return $filePath;
    }

    function showCategory($params = null) {
        $idCat = $params[':ID'];
        $shopName = $params[':UNIQUENAME'];
        if (  !$shopName ) {
            header("Location: " . BASE_URL . 'home'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $id_shop = $this->shopmodel->getIdByShop($shopName);
        if (  !$id_shop ) {
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
        
        // Obtén el id_plantilla de la respuesta de la base de datos
        $id_plantilla = $plantilla[0]->id_plantilla; // Asumiendo que la función devuelve un array de objetos
        
        switch ($id_plantilla) {
            case 1:
                $this->CM_category($shopName, $id_shop, $idCat);
                break;
            case 4:
                $this->MID_category($shopName, $id_shop, $idCat);
                break;
            default:
                // Si no hay coincidencia, redirige a home
                header("Location: " . BASE_URL . 'home');
                exit();
        }
         }
    
    function CM_category($shopName, $id_shop, $idCat){
        //logo y nombre
        $shopFront = $this->shopmodel->getShopFront($id_shop);

        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $productsPerPage = 12; // Puedes cambiar esto al número de productos que quieras por página

        $this->categoryModel->actRankCategory($idCat);
        $categories = $this->categoryModel->GetCategories($id_shop);
        $productosByCat = $this->productModel->getProductByCategoryPaginated($idCat, $page, $productsPerPage, $id_shop);
        $totalProducts = $this->productModel->getTotalProductsByCategory($idCat, $id_shop);
        $totalPages = ceil($totalProducts / $productsPerPage);

        $category = $this->categoryModel->getCategory($idCat);
        $colors = $this->shopmodel->getShopColors($id_shop);

        // Pasa currentPage y totalPages a la vista
        $this->categoryView->showCategory($productosByCat, $category, $categories,  $page, $totalPages,   $shopName, $colors, $shopFront);

    }
    
    function MID_category($shopName, $id_shop, $idCat){
                 //logo y nombre
         $shopFront = $this->shopmodel->getShopFront($id_shop);

         $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
         $productsPerPage = 12; // Puedes cambiar esto al número de productos que quieras por página
     
         $this->categoryModel->actRankCategory($idCat);
         $categories = $this->categoryModel->GetCategories($id_shop);
         $productosByCat = $this->productModel->getProductByCategoryPaginated($idCat, $page, $productsPerPage, $id_shop);
         $totalProducts = $this->productModel->getTotalProductsByCategory($idCat, $id_shop);
         $totalPages = ceil($totalProducts / $productsPerPage);
     
         $category = $this->categoryModel->getCategory($idCat);
         $colors = $this->shopmodel->getShopColors($id_shop);
 
         // Pasa currentPage y totalPages a la vista
         $this->categoryView->MID_showCategory($productosByCat, $category, $categories,  $page, $totalPages,   $shopName, $colors, $shopFront);
    
    }

    function showBrand($params = null) {
        $brand = $params[':Q'];
        $currentPage = isset($_GET['page']) ? intval($_GET['page']) : 1;
        $itemsPerPage = 12; // Número de productos por página
    
        // Obtener el total de productos para esta marca
        $totalProducts = $this->productModel->getTotalProductsByBrand($brand);
        $totalPages = ceil($totalProducts / $itemsPerPage);
    
        // Asegurarse de que la página actual esté dentro del rango válido
        $currentPage = max(1, min($currentPage, $totalPages));
        $offset = ($currentPage - 1) * $itemsPerPage;
    
        // Obtener los productos para la página actual
        $productosByBrand = $this->productModel->getProductByBrand($brand, $itemsPerPage, $offset);
        $brands = $this->productModel->getBrands();
    
        $this->categoryView->showBrand($productosByBrand, $brand, $brands, $currentPage, $totalPages);
    }
    
    
    
    function showEditCategory($params = null){
        $id_categoria = $params[':ID'];
        $shopName = $params[':UNIQUENAME'];
        if (  !$shopName ) {
            header("Location: " . BASE_URL . 'home'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $id_shop = $this->shopmodel->getIdByShop($shopName);
        if (  !$id_shop ) {
            header("Location: " . BASE_URL . 'home'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }

        $categoryInfo = $this->categoryModel->getCategory($id_categoria);
       

        $this->categoryView->showEditCategory( $categoryInfo );
    }



    
}