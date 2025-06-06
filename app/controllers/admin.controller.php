<?php
include_once 'app/helpers/user.helper.php';
include_once 'app/views/admin.view.php';
include_once 'app/models/user.model.php';
include_once 'app/models/shop.model.php';
include_once 'app/models/user.model.php';
include_once 'app/models/product.model.php';
include_once 'app/models/category.model.php';
include_once 'app/models/admin.model.php';


class AdminController {
    private $userhelper;
    private $modeluser;
    private $view;
    private $modelproduct;
    private $shopmodel;
    private $usermodel;
    
    private $modeladmin;
    private $categorymodel;
  

    function __construct() {
        $this->userhelper = new UserHelper();
        $this->view = new AdminView();
        $this->modeluser = new UserModel();
        $this->shopmodel = new ShopModel();
        $this->usermodel = new UserModel();

        
        $this->modelproduct = new ProductModel();
        $this->modeladmin = new AdminModel();
        $this->categorymodel = new CategoryModel();
        $this->userhelper->checkAdminlogin();
    }

    function showError($msg){
       
    }
    function showAdmin($params = null) {
        if (isset($_SESSION['ID_USER'])) {
            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
            
            // Obtener datos de envíos
            $enviosData = json_decode($shopInfo[0]->lista_envios, true);
            if (!$enviosData) {
                $enviosData = [
                    "precioFijoActivado" => false,
                    "precioEnvio" => "",
                    "costosEnvio" => []
                ];
            }
    
            // Procesar el campo rangoPeso dividiéndolo en min y max
            foreach ($enviosData['costosEnvio'] as &$envio) {
                $rangoPeso = explode(' - ', $envio['rangoPeso']);
                $envio['rangoPesoMin'] = trim($rangoPeso[0]);
                $envio['rangoPesoMax'] = trim($rangoPeso[1]);
            }
    
            // Obtener otros datos necesarios
            $bannerimages = $this->modeladmin->getAllShopBanners($shopInfo);
            $products = $this->modelproduct->getAllShopProducts($shopInfo[0]->id_tienda);
            $categories = $this->categorymodel->GetCategories($shopInfo[0]->id_tienda);
    
            // Pasar los datos al template
            $this->view->showAdmin($categories, $products, $bannerimages, $shopInfo, $enviosData);
        } else {
            $this->showError('No tienes acceso a esta sección');
        }
    }
    

    function showAdminStock() {
        if (1==1) {
            // Obtener filtros
            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
            $nombreUnico = $shopInfo[0]->nombre_unico;
            $idTienda = $shopInfo[0]->id_tienda;
            $search = $_GET['search'] ?? '';
            $categoria = $_GET['categoria'] ?? '';
            $priceOrder = $_GET['priceOrder'] ?? '';
            $stockOrder = $_GET['stockOrder'] ?? '';
            
            // Obtener página actual
            $currentPage = $_GET['page'] ?? 1;
            $productsPerPage = 10; // número de productos por página
            $offset = ($currentPage - 1) * $productsPerPage;
    
            // Obtener productos filtrados desde el modelo con paginación
            $products = $this->modelproduct->getFilteredProducts($search, $categoria, $priceOrder, $stockOrder, $offset, $productsPerPage, $idTienda);
            $totalProducts = $this->modelproduct->countFilteredProducts($search, $categoria, $idTienda);
            $totalPages = ceil($totalProducts / $productsPerPage);
    
            // Obtener categorías desde el modelo
            $categorias = $this->categorymodel->GetCategories($idTienda);
            
            // Enviar datos a la vista
            // Asignamos la categoría seleccionada si está definida, o una cadena vacía si no.
            $categoriaSelected = $_GET['categoria'] ?? ''; // Asigna la categoría seleccionada o cadena vacía si no existe

            // Definir rango de páginas para mostrar
            $range = 2;
            $startPage = max(1, $currentPage - $range);
            $endPage = min($totalPages, $currentPage + $range);

            $this->view->showAdminStock(
                $products, 
                $categorias, 
                $search, 
                $categoriaSelected, 
                $priceOrder, 
                $stockOrder, 
                $currentPage, 
                $totalPages, 
                $shopInfo,
                $startPage, 
                $endPage
            );

        } else {
            $this->showError('No tienes acceso a esta sección');
        }
    }
    
    
    
    

    public function showPedidos() {
        // Obtener los parámetros de filtrado
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $idTienda = $shopInfo[0]->id_tienda;

        $search = isset($_GET['search']) ? trim($_GET['search']) : '';
        $estado = isset($_GET['estado']) ? trim($_GET['estado']) : '';
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10; // Número de pedidos por página
        $offset = ($page - 1) * $limit;
        
        // Obtener todos los pedidos con filtros aplicados
        $pedidos = $this->modeluser->getPedidos($search, $estado, $limit, $offset, $idTienda);
        
        // Contar los pedidos totales para la paginación
        $totalPedidos = $this->modeluser->countPedidos($search, $estado, $idTienda);
        $totalPages = ceil($totalPedidos / $limit);
        
        // Contar los pedidos por estado
        $estadisticas = [
            1 => 0,
            2 => 0,
            3 => 0,
            4 => 0,
            5 => 0
        ];
        
        $pedidosStats = $this->modeluser->getAllPedidos();

        foreach ($pedidosStats as $pedido) {
            $estadoB = $pedido->estado;
            if (isset($estadisticas[$estadoB])) {
                $estadisticas[$estadoB]++;
            }
        }
    
        // Definir nombres de estados
        $estadoNombres = [
            1 => "Pedido Realizado, en espera de un administrador para confirmar",
            2 => "Pago Confirmado",
            3 => "Preparando Pedido",
            4 => "Pedido Enviado",
            5 => "Listo para retirar por el local",
            99 => "Pedido Entregado"
        ];
        
        
        // Pasar datos a la vista
        $this->view->showPedidos($pedidos, $estadoNombres, $search, $estado, $estadisticas, $page, $totalPages);
    }
    
    
    
    
    
    

    function showGestionarPedido($params) {
        $idPedido = $params[':ID'];
        $pedido = $this->modeluser->getPedidoById($idPedido);
    
        if ($pedido) {
            // Obtener detalles de los productos
            $productos = json_decode($pedido->productos, true);
            $productIds = array_column($productos, 0); // Obtener solo los IDs de productos
            $productosDetalles = $this->modelproduct->getProductDetails($productIds);
    
            // Crear un mapa de productos con sus detalles
            $productosMap = [];
            foreach ($productosDetalles as $producto) {
                $productosMap[$producto->id_producto] = $producto;
            }
    
            // Añadir detalles de cada producto al pedido
            $detailedProductos = [];
            $totalCantidad = 0;
            foreach ($productos as $producto) {
                $id = $producto[0];
                $quantity = $producto[1];
                if (isset($productosMap[$id])) {
                    $productoDetalle = $productosMap[$id];
                    $detailedProductos[] = [
                        'id_producto' => $productoDetalle->id_producto,
                        'nombre' => $productoDetalle->nombre,
                        'cantidad' => $quantity,
                        'precio' => $productoDetalle->precio,
                        'subtotal' => $productoDetalle->precio * $quantity
                    ];
                    $totalCantidad += $quantity;
                }
            }
    
            $pedido->productos = $detailedProductos;
            $pedido->cantidad = $totalCantidad;
    
            // Obtener detalles del usuario
            $idUsuario = $pedido->id_usuario;
            $usuario = $this->modeluser->getUserById($idUsuario);
            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);

            $this->view->showPedido($pedido, $usuario,  $shopInfo);
        } else {
            // Manejo de error: Pedido no encontrado
            $this->view->showError("Pedido no encontrado");
        }
    }
    
    
    function addBanner(){
        if (1 == 1) {
            $texto1 = $_POST['texto1'];
            $texto2 = $_POST['texto2'];
            $id_tienda = $_POST['id_tienda'];

        

            // verifico campos obligatoriosw
            if($_FILES['input_image']['type'] == "image/jpg" || $_FILES['input_image']['type'] == "image/jpeg" || $_FILES['input_image']['type'] == "image/png" ){
                $imagename= $this->uniqueSaveName($_FILES['input_image']['name'],$_FILES['input_image']['tmp_name']);
                $this->modeladmin->addBanner(
                    $id_tienda,
                    $texto1,
                    $texto2,
                    $imagename // Pasa el path completo, no solo el nombre
                );
            }  

   
                header("Location: " . BASE_URL . "dashboard/brand/". $_SESSION['ID_USER']);
        } else {
                header("Location: " . BASE_URL . "dashboard/brand/". $_SESSION['ID_USER']);
        }
    }


    function updateLogo(){
        if (1 == 1) {  // Check if user is authorized, replace with actual condition
            $id_tienda = $_POST['id_tienda'];
        
            if ($_FILES['input_image']['type'] == "image/jpg" || $_FILES['input_image']['type'] == "image/jpeg" || $_FILES['input_image']['type'] == "image/png") {
                $imagename = $this->uniqueSaveName($_FILES['input_image']['name'], $_FILES['input_image']['tmp_name']);
                // Assuming the function `uniqueSaveName()` saves the image and returns its name or path.
                $this->modeladmin->updateLogo($id_tienda, $imagename);
                header("Location: " . BASE_URL . "dashboard/brand/". $_SESSION['ID_USER']);
            } else {
                header("Location: " . BASE_URL . "dashboard/brand/". $_SESSION['ID_USER']);
            }
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



    function showStadistics(){
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $idTienda = $shopInfo[0]->id_tienda;
        $productoMasVendidos = $this->modelproduct->productoMasVendidos($idTienda);
        $productoMejorValorados =$this->modelproduct->productoMejorValorados($idTienda);
        $categoriaMasVisitada = $this->categorymodel->categoriaMasVisitada($idTienda);
        $categoriaMasVendida = $this->categorymodel->categoriaMasVendida($idTienda);

 

        $this->view->showStadistics( $productoMasVendidos,    $productoMejorValorados,  $categoriaMasVisitada,  $categoriaMasVendida );

    }


    function ShowCypherProducts(){
        $this->view->ShowCypherProducts();

    }
   

    function phpinfo(){
       phpinfo();

    }



    function showSudoAdmin(){

        $pagos = $this->modeladmin->getPagos();
        $usuarios = $this->usermodel->getUsuarios();
        $tiendas = $this->shopmodel->getTiendas();
        $codigos = $this->modeladmin->getCodigos();

        $this->view->showSudoAdmin($pagos, $usuarios, $tiendas, $codigos);
    }



    function agregarCodigoCreacionTienda(){

        $codigo = $_POST['codigo'];
        $id_plantilla = $_POST['id_plantilla'];
        $pagos = $this->modeladmin->addCodigo(  $codigo,   $id_plantilla);
        $this->showSudoAdmin();
    }



    function deleteCategory($params) {
        $idCat = $params[':ID'];
        $this->categorymodel->deleteCategorySafeMode($idCat);
        header("Location: " . BASE_URL . "dashboard/categories/". $_SESSION['ID_USER']);
   }
    
    
}