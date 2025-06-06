<?php
include_once 'app/views/shared.view.php';
include_once 'app/views/user.view.php';
include_once 'app/models/shop.model.php';
include_once 'app/models/user.model.php';
include_once 'app/helpers/user.helper.php';
include_once 'app/helpers/mercado.pago.helper.php';
include_once 'app/helpers/user.mailer.php';
include_once 'app/models/product.model.php';
include_once 'app/models/category.model.php';
include_once 'app/models/admin.model.php';

class UserController {
    private $modelproduct;
    private $model;
    private $adminModel;
    private $mphelper;
    private $view;
    private $userview;
    private $shopmodel;
    private $userMailer;
    private $categorymodel;
    private $userHelper;

    public function __construct() {
        $this->adminModel = new AdminModel();
        $this->model = new UserModel();
        $this->shopmodel = new ShopModel();
        $this->mphelper = new MercadoPagoHelper();
        $this->modelproduct = new ProductModel();
        $this->view = new SharedView();
        $this->userview = new UserView();
        $this->userHelper = new UserHelper();
        $this->userMailer = new UserMailer();
        $this->categorymodel = new CategoryModel();
    }

    function showLogin($error = null) {
        $volver_a = isset($_GET['V']) ? $_GET['V'] : null;
        $this->view->showLogin($error, $volver_a);
    }
    

    function showRegistro($error = null) {
        $volver_a = isset($_GET['V']) ? $_GET['V'] : null;
        $this->view->showRegistro($error, $volver_a);
    }
    


    function creartienda(){
        $plantillas = $this->model->getPlantillas();
        
        $this->userview->creartienda($plantillas);
    }

    public function loginUser() {
        $username = $_POST['user'];
        $password = $_POST['password'];
        $volver_a = (!empty($_POST['volver_a'])) ? $_POST['volver_a'] : null;
        if (empty($username) || empty($password)) {
            $this->view->showLogin('Faltan datos obligatorios');
            die();
        }
    
        // Obtengo el usuario de la base de datos
        $user = $this->model->getUser($username);
    
        // Verifico que el usuario exista y que la contraseña sea correcta
        if ($user && !empty($user->pass) && password_verify($password, $user->pass)) {
            // Inicio sesión
            $this->userHelper->login($user);
           // Redirijo según el valor de $volver_a
            if ($volver_a !== null) {
                header("Location: " . BASE_URL . $volver_a);
            } else {
                header("Location: " . BASE_URL . 'dashboard/profile/' . $user->id);
            }

            die();
        } else {
            $this->view->showLogin("Usuario y contraseña inválidos");
        }
    }
    
    function registrer() {
        //funcion para registrar
        // aunque aun no la estamos utilizando
        $username = $_POST['username'];
        $password = $_POST['password'];
        $spassword = $_POST['rpassword'];
        $email = $_POST['email'];
        $telefono = $_POST['telefono'];
        $volver_a = (!empty($_POST['volver_a'])) ? $_POST['volver_a'] : null;
        $terminosycondiciones = isset($_POST['acepto']) ? $_POST['acepto'] : null;
        if (empty($username) || empty($password) || empty($spassword) | empty($email) | empty($telefono)) {
            // $this->view->showRegistro("Faltan datos obligatorios");
            $this->view->showRegistro('Faltan datos obligatorios.');
            return;
        }
        if ($password != $spassword){
            $this->view->showRegistro('Las contraseñas no son iguales.');
            return;
        }   

        if ($terminosycondiciones !== 'on') {
            $this->view->showRegistro('Es necesario aceptar términos y condiciones.'); 
            return;
        }



        //busco si existe el usuario
        $userrepeat = $this->model->getUser($username);
        
       
        //busco si existe el email
        $emailrepeat = $this->model->getEmail($email);

        if ($userrepeat && $userrepeat->id > 0) {
            $this->view->showRegistro('Ya existe un usuario con ese nombre.');
            return;
       
    
        }else if($emailrepeat){  
            $this->view->showRegistro('Ya existe un usuario con ese email.');
            return;
          
        }else{//si no existe ninguno de los 2, registro y logeo la cuenta:
            echo('entra mal');
            $passhash = password_hash($password,PASSWORD_DEFAULT);
            $this->model->insert($username,$passhash,$email,$telefono);
            $user = $this->model->getUser($username);
            $this->userHelper->login($user);
            $this->userMailer->nuevoRegistroAdmin($username, $password, $email, $telefono );
           

            if ($volver_a !== null) {
                header("Location: " . BASE_URL . $volver_a);
            } else {
                header("Location: " . "dashboard/profile/" . $_SESSION['ID_USER']); 
            }
        }
    }

    function logout() {
        $this->userHelper->logout();
    }

    function showAbout(){
        //Pagina de about, llama al view para visualizarse.
        $this->view->showAbout();
    }


    public function showCompras() {
        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $compras = $this->model->getCompras();
       
        // Calcular el total para cada compra
        foreach ($compras as $compra) {
            $compra->contacto =  $this->model->getContactByShopId($compra->id_tienda);

            
        
            // Reasignar estado 4 y 5 según ubicación
            if ($compra->estado == 4 || $compra->estado == 5) {
                if ($compra->contacto && $compra->contacto->ubicacion) {
                    $compra->estado = 5; // Listo para retirar
                } else {
                    $compra->estado = 4; // Enviado
                }
            }
        }


        $this->userview->showCompras($compras);
    }
    


    public function ShowCarrito() {
        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . 'login'); 
            exit();
        }
        $idUser = $_SESSION['ID_USER'];
        $cartData = $this->model->getCarritosWithProductDetails($idUser);

        $this->userview->showCarrito($cartData); // Pasa el array completo
        
    }
    
    
    

    public function showProfile($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->showProfile($info);
    }





    function confirmarCarrito($params = null) {
        $id_carrito = $params[':ID'];
        $infoCarrito = $this->model->getCarritoInfo($id_carrito);

        $id_usuario = $infoCarrito['id_usuario'];

        $shopInfo = $this->shopmodel->getShopInfoById($id_usuario);
        $id_usuario_vendedor = $shopInfo[0]->id_usuario;
        
        if (!isset($infoCarrito)) {
            header("Location: " . BASE_URL . 'carrito'); 
            exit(); 
        }


        $publicKey = null;
        $userInfo = $this->model->getUserById($id_usuario_vendedor);
        if (!empty($userInfo->mp_credentials)) {
        $credenciales = json_decode($userInfo->mp_credentials, true); // Lo pasamos a array asociativo

        if (isset($credenciales['public_key'])) {
            $publicKey = $credenciales['public_key'];
        }
}
        // Decodificar el horario de la tienda
        $horarioTienda = !empty($shopInfo[0]->horario) ? json_decode($shopInfo[0]->horario, true) : null;
        
        // Obtener la hora actual en formato "HH:MM"
        $horaActual = date('H:i');
    
        // Calcular el costo de envío
        $costoEnvio = $this->model->calcularCostoEnvio($infoCarrito['id_tienda'], $infoCarrito['items']);
    
        // Pasar la información al template
        $this->userview->showConfirmarCarrito($infoCarrito, $shopInfo, $userInfo, $horaActual, $horarioTienda, $costoEnvio,  $publicKey, $id_usuario_vendedor);
    }
    
    



    function showPagos($params = null){

        $id_user = $params[':ID_USER'];
 
        $pagosInfo = $this->model->getPagos($id_user);
        $precio = $pagosInfo['precio_plantilla'];
      
      
        $this->userview->showPagos( $pagosInfo,  $id_user);

    }



    function pagarServicio(){
     

            $monto = $_POST['monto'];
            $id_tienda = $_POST['id_tienda'];
            $id_usuario = $_POST['id_usuario'];


            // verifico campos obligatoriosw
            if ($_FILES['input_image']['type'] == "image/jpg" || $_FILES['input_image']['type'] == "image/jpeg" || $_FILES['input_image']['type'] == "image/png" || $_FILES['input_image']['type'] == "application/pdf") {
                $imagename = $this->uniqueSaveName($_FILES['input_image']['name'], $_FILES['input_image']['tmp_name']);
                $this->model->pagarServicio(
                    $monto,
                    $id_tienda,
                    $imagename // Pasa el path completo, no solo el nombre
                );
               header("Location: " . BASE_URL . 'dashboard/payments/' . $id_usuario);
            }
            


    }


    function uniqueSaveName($realName, $tempName) {
        
        $filePath = "img_storage/" . uniqid("", true) . "." 
            . strtolower(pathinfo($realName, PATHINFO_EXTENSION));

        move_uploaded_file($tempName, $filePath);

        return $filePath;
    }





    
    function showTerminosYCondiciones(){
        $this->userview->showTerminosYCondiciones();
    }


    function recuperarContrasena(){
        $this->userview->showRecuperarContrasena();
    }
    public function cambiarContraseña() {
        // Obtener los datos enviados por POST
        $mail = isset($_POST['mail']) ? $_POST['mail'] : null;
        $codigo = isset($_POST['codigo']) ? $_POST['codigo'] : null;
    
        // Verificar si se han recibido los datos
        if ($mail && $codigo) {
            // Puedes trabajar con estos valores (por ejemplo, mostrar una vista con estos datos)
            $this->userview->showCambiarContraseña($mail);
        } else {
            // En caso de que no se haya enviado el correo o código, muestra un error o realiza alguna acción
            echo "Faltan parámetros.";
        }
    }
    
    public function cambiarContrasenaAccion() {
        // Recuperamos los datos del formulario
        $mail = $_POST['mail'];
        $password = $_POST['password'];
        $passwordRepeat = $_POST['password-repeat'];
       
        
        // Validación de las contraseñas
        if ($password !== $passwordRepeat) {
           
            // Si las contraseñas no coinciden, devolvemos un error
            return;
        }
    
        // Validamos que la contraseña sea suficientemente segura (puedes personalizar esta validación)
        if (strlen($password) < 6) {
        
            return;
        }
    
        // Encriptar la contraseña
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
       
        $result = $this->model->actualizarContraseña($mail, $hashedPassword);
     
        // Verificamos si la actualización fue exitosa
        if ($result) {
            // Si fue exitosa, mostramos un mensaje de éxito
            $this->view->showLogin('Escriba su nueva contraseña');

        }
    }
    


    
    public function dashboard_profile($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->dashboard( "profile" ,$info);
    }

    public function dashboard_security($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->dashboard( "security" ,$info);
    }


    public function dashboard_connectivities($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->dashboard( "connectivities" ,$info);
    }


    public function dashboard_connectivities2way($id_user){
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->dashboard( "connectivities" ,$info);
    }

    
    public function dashboard_statistics($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $idTienda = $shopInfo[0]->id_tienda;
        $productoMasVendidos = $this->modelproduct->productoMasVendidos($idTienda);
        $productoMejorValorados =$this->modelproduct->productoMejorValorados($idTienda);
        $categoriaMasVisitada = $this->categorymodel->categoriaMasVisitada($idTienda);
        $categoriaMasVendida = $this->categorymodel->categoriaMasVendida($idTienda);

        $this->userview->dashboard_stats("statistics" , $productoMasVendidos,    $productoMejorValorados,  $categoriaMasVisitada,  $categoriaMasVendida );

    }


    public function dashboard_shop($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $info = $this->model->getProfileInfo($id_user);
        // Decodificar el horario si existe, o establecerlo como null
        if (!empty($info['tienda']['horario'])) {
            $info['tienda']['horario'] = json_decode($info['tienda']['horario'], true);
        } else {
            $info['tienda']['horario'] = null;
        }

        $this->userview->dashboard( "shop" ,$info);
    }





    function dashboard_inventory($params = null) {
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
       
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

            $this->userview->dashboard_inventory(
                "inventory",
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

         
    }



    function dashboard_add_product($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        
            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
           

            $products = $this->modelproduct->getAllShopProducts($shopInfo[0]->id_tienda);
            $categories = $this->categorymodel->GetCategories($shopInfo[0]->id_tienda);
    
            // Pasar los datos al template
            $this->userview->dashboard_add_product("add_product", $categories, $shopInfo,  $products );



    }


    function  dashboard_orders($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
          // Obtener los parámetros de filtrado
          $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
          $idTienda = $shopInfo[0]->id_tienda;
  
          $search = isset($_GET['search']) ? trim($_GET['search']) : '';
          $estado = isset($_GET['estado']) ? trim($_GET['estado']) : '';
          $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
          $limit = 10; // Número de pedidos por página
          $offset = ($page - 1) * $limit;
          
          // Obtener todos los pedidos con filtros aplicados
          $pedidos = $this->model->getPedidos($search, $estado, $limit, $offset, $idTienda);
          
          // Contar los pedidos totales para la paginación
          $totalPedidos = $this->model->countPedidos($search, $estado, $idTienda);
          $totalPages = ceil($totalPedidos / $limit);
          
          // Contar los pedidos por estado
          $estadisticas = [
              1 => 0,
              2 => 0,
              3 => 0,
              4 => 0,
              5 => 0
          ];
          
          $pedidosStats = $this->model->getAllPedidos();
  
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
          $this->userview->dashboard_orders("orders", $pedidos, $estadoNombres, $search, $estado, $estadisticas, $page, $totalPages);
    }
   



    function dashboard_manage_orders($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }

        $idPedido = $params[':ID'];
        $pedido = $this->model->getPedidoById($idPedido);
    
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
            $usuario = $this->model->getUserById($idUsuario);
            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);

            $this->userview->dashboard_manage_orders("manage_orders", $pedido, $usuario,  $shopInfo);
        } else {
            // Manejo de error: Pedido no encontrado
            $this->view->showError("Pedido no encontrado");
        }
    }






    function dashboard_payments($params = null){

        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
 
        $pagosInfo = $this->model->getPagos($id_user);
        $precio = $pagosInfo['precio_plantilla'];
      
      
        $this->userview->dashboard_payments("payments", $pagosInfo,  $id_user);

    }



    function dashboard_categories($params = null){

        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
 
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $idTienda = $shopInfo[0]->id_tienda;
        $categorias = $this->categorymodel->GetCategories($idTienda);
        $this->userview->dashboard_categories("categories", $categorias,  $id_user,  $shopInfo);

    }



    function dashboard_add_category($params = null){

        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);

        $this->userview->dashboard_add_category("add_category", $shopInfo);




    }



    function dashboard_brand($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $bannerimages = $this->adminModel->getAllShopBanners($shopInfo);
        // Pasar los datos al template
        $this->userview->dashboard_brand("brand", $bannerimages, $shopInfo);
    }



    function dashboard_shipments($params = null){
        $id_user = $params[':ID_USER'];
        $idUserSession = $_SESSION['ID_USER'];
        if (  $id_user != $idUserSession) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
    
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

        // Pasar los datos al template
        $this->userview->dashboard_shipments("shipments", $shopInfo, $enviosData);
    
    }



    function mpOauth() {
        if (!isset($_GET['code'])) {
            echo "No se recibió ningún código de autorización.";
            return;
        }

        $code = $_GET['code'];

        $clientId = '3590053151031368'; // Tu APP_ID
        $clientSecret = 'WKuUqBPpQY5dtRjqSm2zCflJnaZexcg1'; // Reemplazalo por tu secret real
        $redirectUri = 'https://www.cyshops.com/mp/oauth'; // Exactamente igual al que configuraste
        $state = uniqid(); // Un identificador único, por ejemplo para guardar quién autorizó

        $data = [
            'client_id' => $clientId,
            'client_secret' => $clientSecret,
            'grant_type' => 'authorization_code',
            'code' => $code,
            'redirect_uri' => $redirectUri,
            'state' => $state
        ];

        $ch = curl_init('https://api.mercadopago.com/oauth/token');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'accept: application/json',
            'content-type: application/x-www-form-urlencoded'
        ]);

        $response = curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpcode === 200) {
            $responseData = json_decode($response, true);
            $this->model->save_mp_credentials($responseData ,$_SESSION['ID_USER']);
            $this->dashboard_connectivities2way($_SESSION['ID_USER']);

            // Acá podés guardar el access_token, user_id, refresh_token, etc. en tu base de datos.
        } else {
            echo "Error al obtener el token. Código HTTP: $httpcode<br>";
            echo "Respuesta: $response";
        }
    }

 
}