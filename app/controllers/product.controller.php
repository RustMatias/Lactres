<?php
include_once 'app/helpers/user.helper.php';
include_once 'app/models/product.model.php';
include_once 'app/models/category.model.php';
include_once 'app/models/admin.model.php';
include_once 'app/models/shop.model.php';
include_once 'app/models/user.model.php';
include_once 'app/helpers/user.mailer.php';
include_once 'app/models/comment.model.php';
include_once 'app/views/product.view.php';

class ProductController {
    private $userhelper;
    private $usermodel;
    private $userMailer;
    private $shopmodel;
    private $productModel;
    private $categoryModel;
    private $commentsmodel;
    private $productView;
    private $modeladmin;
    function __construct() {
        $this->userhelper = new UserHelper();
        $this->usermodel = new UserModel();
        $this->userMailer = new UserMailer();
        $this->shopmodel = new ShopModel();
        $this->productModel = new ProductModel();
        $this->categoryModel = new CategoryModel();
        $this->commentsmodel = new commentModel();
        $this->productView = new ProductView();
        $this->modeladmin = new AdminModel();
    }


    function showHome(){

        $this->productView->showHome();

    }


    function showEmprendedores(){
        $this->productView->showEmprendedores();

    }
    function addProduct() {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $nombre = $_POST['nombre'];
            $id_tienda = $_POST['id_tienda'];
            $shopName = $_POST['shopName'];
            $descripcion = $_POST['descripcion'];
            $precio = $_POST['precio'];
            $stock = empty($_POST['stock']) ? 0 : $_POST['stock'];
          
            $peso = $_POST['peso'];
            $unlimitedStock = isset($_POST['unlimitedStock']) ? $_POST['unlimitedStock'] : 0;
            $dimensiones = [
                'alto' => isset($_POST['alto']) ? $_POST['alto'] : 0,
                'ancho' => isset($_POST['ancho']) ? $_POST['ancho'] : 0,
                'largo' => isset($_POST['largo']) ? $_POST['largo'] : 0
            ];
            $dimensiones = json_encode($dimensiones, JSON_PRETTY_PRINT);


            $fabricante = !empty($_POST['fabricante']) ? $_POST['fabricante'] : '';
            $marca = !empty($_POST['marca']) ? $_POST['marca'] : '';
            $categoria = !empty($_POST['categoria']) ? $_POST['categoria'] : 0;
    
            $imagenesGuardadas = [];
    
            // Verificar si se está subiendo una imagen o varias
            if ($_SESSION['GRUPO'] == "C") {
                // Para grupo "C", permitir múltiples imágenes
                if (!empty($_FILES['input_image']['name'][0])) {
                    $totalArchivos = count($_FILES['input_image']['name']);
    
                    for ($i = 0; $i < $totalArchivos; $i++) {
                        $nombreArchivo = $_FILES['input_image']['name'][$i];
                        $tipoArchivo = $_FILES['input_image']['type'][$i];
                        $rutaTemporal = $_FILES['input_image']['tmp_name'][$i];
    
                        // Validar tipo de archivo
                        if ($tipoArchivo == "image/jpg" || $tipoArchivo == "image/jpeg" || $tipoArchivo == "image/png") {
                            // Guardar imagen con nombre único
                            $nombreUnico = $this->uniqueSaveName($nombreArchivo, $rutaTemporal);
                            $imagenesGuardadas[] = $nombreUnico;
                        }
                    }
                }
            } else {
                // Para grupo "I", solo permitir una imagen
                if (!empty($_FILES['input_image']['name'])) {
                    $nombreArchivo = $_FILES['input_image']['name'];
                    $tipoArchivo = $_FILES['input_image']['type'];
                    $rutaTemporal = $_FILES['input_image']['tmp_name'];
    
                    // Validar tipo de archivo
                    if ($tipoArchivo == "image/jpg" || $tipoArchivo == "image/jpeg" || $tipoArchivo == "image/png") {
                        // Guardar imagen con nombre único
                        $nombreUnico = $this->uniqueSaveName($nombreArchivo, $rutaTemporal);
                        $imagenesGuardadas[] = $nombreUnico;
                    }
                }
            }
    
            // Si no se subieron imágenes, usar "images/noimage.png"
            $imagenesString = !empty($imagenesGuardadas) ? implode(',', $imagenesGuardadas) : "images/noimage.png";
    
            // Insertar en la base de datos
            $id = $this->productModel->addProduct(
                $id_tienda,
                $nombre,
                $marca,
                $descripcion,
                $stock,
                $precio,
                $fabricante,
                $categoria,
                $peso,
                $dimensiones,
                $unlimitedStock,
                $imagenesString, // Guardar la lista de imágenes o la imagen por defecto
            );
    
            // Redireccionar al producto creado
          header("Location: " . BASE_URL . "/dashboard/inventory/". $_SESSION['ID_USER']);
            exit;
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
       
    function uniqueSaveNamePayments($realName, $tempName) {
        
        $filePath = "img_payments/" . uniqid("", true) . "." 
            . strtolower(pathinfo($realName, PATHINFO_EXTENSION));

        move_uploaded_file($tempName, $filePath);

        return $filePath;
    }
    

    function showProduct($params = null){
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

        $idProducto = $params[':ID'];
    //logo y nombre
    $shopFront = $this->shopmodel->getShopFront($id_shop);



        // Funcion para mostrar la skin en detalle.
        $producto = $this->productModel->getProductById($idProducto, $id_shop);
        $imagenes = explode(',', $producto->imagenes);

        $relatedProducts =$this->productModel->getRelatedProduct($idProducto, $id_shop);

        $commentsData = $this->commentsmodel->getComments($idProducto);

        $categories = $this->categoryModel->GetCategories($id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);

        // Obtener los comentarios y el promedio
        $comments = $commentsData['comments'];
        $valoracionProducto = $commentsData['promedio'];
     
        $this->productView->showProductDetail($producto,        $imagenes, $relatedProducts, $comments, $valoracionProducto, $categories,  $shopName, $colors,  $shopFront );
    }

    //All
    function showProducts($params = null){
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
                $this->CM_allProducts($shopName, $id_shop);
                break;
 
            case 4:
                $this->MID_allProducts($shopName, $id_shop);
                break;
            default:
                // Si no hay coincidencia, redirige a home
                 header("Location: " . BASE_URL . 'home');
                exit();
        }
          }



    function CM_allProducts($shopName, $id_shop){
    //logo y nombre
        $shopFront = $this->shopmodel->getShopFront($id_shop);


        // Funcion para mostrar la skin en detalle.
        $products = $this->productModel->getAllShopProducts($id_shop);
        $categories = $this->categoryModel->GetCategories( $id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);

        $this->productView->showAllProducts($products, $categories, $shopName,$colors,  $shopFront  );

    }


    function MID_allProducts($shopName, $id_shop){
           //logo y nombre
        $shopFront = $this->shopmodel->getShopFront($id_shop);
        // Funcion para mostrar la skin en detalle.
        $products = $this->productModel->getAllShopProducts($id_shop);
        $categories = $this->categoryModel->GetCategories( $id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);

        $this->productView->MID_showAllProducts($products, $categories, $shopName,$colors,  $shopFront  );
    
    }

    function showEditProduct($params = null){
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
        $userlogin = $this->userhelper->checkUserLogin();
        $idProducto = $params[':ID'];
        // Funcion para mostrar la skin en detalle.
        $producto = $this->productModel->getProductById($idProducto, $id_shop);
        $categories = $this->categoryModel->GetCategories($id_shop);

        $this->productView->editProduct($producto, $shopName,   $categories);
    }

    function editProduct() {
        if (1 == 1) { // Validar permisos
            $id = $_POST['id'];
            $shopName = $_POST['shopName'];
    
            $nombre = $_POST['nombre'];
            $descripcion = $_POST['descripcion'];
            $precio = $_POST['precio'];
            $stock = isset($_POST['stock']) && trim($_POST['stock']) !== '' ? $_POST['stock'] : 0;
            $unlimitedStock = isset($_POST['unlimitedStock']) ? $_POST['unlimitedStock'] : 0;
        
            $peso = $_POST['peso'];
            $dimensiones = [
                'alto' => isset($_POST['alto']) ? $_POST['alto'] : 0,
                'ancho' => isset($_POST['ancho']) ? $_POST['ancho'] : 0,
                'largo' => isset($_POST['largo']) ? $_POST['largo'] : 0
            ];
            $fabricante = !empty($_POST['fabricante']) ? $_POST['fabricante'] : '';
            $marca = !empty($_POST['marca']) ? $_POST['marca'] : '';
            $categoria = !empty($_POST['categoria']) ? $_POST['categoria'] : 0;
    
            // ✅ Obtener las imágenes actuales del producto
            $imagenesExistentes = $this->productModel->getProductImages($id);
            if (!is_array($imagenesExistentes)) {
                $imagenesExistentes = [];
            }
    
            // 🛠️ Debug: Verificar archivos recibidos
           /*  var_dump($_FILES['input_image']); */ 
    
            if ($_SESSION['GRUPO'] == "I" || $_SESSION['GRUPO'] == "M")  {
               /*  echo "Procesando una sola imagen...<br>"; */
    
                if (isset($_FILES['input_image']) && !empty($_FILES['input_image']['name'])) {
                    $tipoArchivo = $_FILES['input_image']['type'];
    
                    // Validar tipo de archivo
                    if (in_array($tipoArchivo, ['image/jpg', 'image/jpeg', 'image/png'])) {
                        // Guardar la nueva imagen
                        $imagenNueva = $this->uniqueSaveName($_FILES['input_image']['name'], $_FILES['input_image']['tmp_name']);
                      /*   var_dump($imagenNueva);  */// 🛠️ Verificar si se genera el nombre correctamente
                        
                        if ($imagenNueva) {
                            $imagenesFinales = $imagenNueva;
                        }
                    } else {
                       /*  echo "Imagen inválida: " . $_FILES['input_image']['name']; */
                        return;
                    }
                } else {
                    $imagenesFinales = isset($imagenesExistentes[0]) ? $imagenesExistentes[0] : '';
                }
            } 
            else {
                /* echo "Procesando múltiples imágenes...<br>"; */
    
                if (
                    isset($_FILES['input_image']) &&
                    is_array($_FILES['input_image']['name']) &&
                    !empty($_FILES['input_image']['name'][0])
                ) {
                    
                    $totalArchivos = count($_FILES['input_image']['name']);
                   /*  echo "Total de archivos recibidos: $totalArchivos<br>"; */
    
                    for ($i = 0; $i < $totalArchivos; $i++) {
                        $tipoArchivo = $_FILES['input_image']['type'][$i];
    
                        // Validar tipo de archivo
                        if (in_array($tipoArchivo, ['image/jpg', 'image/jpeg', 'image/png'])) {
                            // Guardar la nueva imagen
                            $imagenNueva = $this->uniqueSaveName($_FILES['input_image']['name'][$i], $_FILES['input_image']['tmp_name'][$i]);
                            /* var_dump($imagenNueva); */ // 🛠️ Verificar si se genera el nombre correctamente
                            
                            if ($imagenNueva) {
                                $imagenesExistentes[] = $imagenNueva;
                            }
                        } else {
                            echo "Imagen inválida: " . $_FILES['input_image']['name'][$i];
                            return;
                        }
                    }
                }
    
                // ✅ Limitar a un máximo de 5 imágenes
                $todasLasImagenes = array_filter($imagenesExistentes);
                $todasLasImagenes = array_slice($todasLasImagenes, 0, 5);
    
                // Convertir el array de imágenes en una cadena separada por comas
                $imagenesFinales = implode(',', $todasLasImagenes);
            }
    
            // ✅ Actualizar el producto en la base de datos
            $resultado = $this->productModel->editProduct(
                $id,
                $nombre,
                $marca,
                $descripcion,
                $precio,
                $fabricante,
                $categoria,
                $imagenesFinales,
                $stock,
                $unlimitedStock,
             
                $peso,
                $dimensiones

            );
    
            //var_dump($resultado); // 🛠️ Verificar si la actualización fue exitosa
    
            // ✅ Redireccionar según el grupo de usuario
            if ($_SESSION['GRUPO'] == "C") {
                header("Location: " . BASE_URL . $shopName . "/product/" . $id);
            } else {
               header("Location: " . BASE_URL . "dashboard/inventory/". $_SESSION['ID_USER']);
            }
            exit;
        } else {
            $this->showError('No tienes acceso a esta sección');
        }
    }
    
    
    
    
    


    function search($params = null){

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
        
        // Obtén el id_plantilla de la respuesta de la base de datos
        $id_plantilla = $plantilla[0]->id_plantilla; // Asumiendo que la función devuelve un array de objetos
        
        switch ($id_plantilla) {
            case 1:
                $this->CM_search($shopName, $id_shop);
                break;
            case 3:
                $this->INI_search($shopName, $id_shop);
                break;
            case 4:
                $this->MID_search($shopName, $id_shop);
                break;
            default:
                // Si no hay coincidencia, redirige a home
                 header("Location: " . BASE_URL . 'home');
                exit();
        }
    }



    function CM_search($shopName, $id_shop ){
        $search = $_POST['search'];
        // Funcion para mostrar la skin en detalle.

        $shopFront = $this->shopmodel->getShopFront($id_shop);

        $products = $this->productModel->search($search, $id_shop);
        $categories = $this->categoryModel->GetCategories($id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);

        $this->productView->CM_searchResult($products, $categories, $search, $shopName, $colors , $shopFront  );
    }

    function INI_search($shopName, $id_shop){
        $search = $_POST['search'];
        // Funcion para mostrar la skin en detalle.
          //logo y nombre
          $shopFront = $this->shopmodel->getShopFront($id_shop);
        $products = $this->productModel->search($search, $id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);

        $this->productView->INI_searchResult($products,  $search, $shopName, $colors,  $shopFront );
  
    }
    function MID_search($shopName, $id_shop){
        $search = $_POST['search'];
        // Funcion para mostrar la skin en detalle.
          //logo y nombre
          $shopFront = $this->shopmodel->getShopFront($id_shop);
        $products = $this->productModel->search($search, $id_shop);
        $colors = $this->shopmodel->getShopColors($id_shop);
        $categories = $this->categoryModel->GetCategories($id_shop);

        $this->productView->MID_searchResult($products, $categories, $search, $shopName, $colors,  $shopFront );
  
    }

    public function comprarCarrito() {
        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        if (isset($_POST['id_carrito'])) {
            $idUser = $_SESSION['ID_USER'];
       
            $id_carrito = $_POST['id_carrito']; // Nombre completo del comprador
            $nombre = $_POST['nombre']; // Nombre completo del comprador
            $email = $_POST['email']; // Correo electrónico del comprador
            $telefono = $_POST['telefono']; // Teléfono
            $direccion        = $_POST['direccion']       ?? null;
            $pais             = $_POST['pais']            ?? null;
            $ciudad           = $_POST['ciudad']          ?? null;
            $codigo_postal    = $_POST['codigo_postal']   ?? null;
            $comprobante = $_FILES['comprobante']; // Comprobante de pago (archivo subido)
            $instrucciones = $_POST['instrucciones'];
            $documento = $_POST['documento'];
            $razon_social = isset($_POST['razon_social']) ? $_POST['razon_social'] : null;
            $cuit = isset($_POST['cuit']) ? $_POST['cuit'] : null;
            $condicion_iva = isset($_POST['condicion_iva']) && $_POST['condicion_iva'] !== "" ? $_POST['condicion_iva'] : 5;


            $userdata = [
                "nombre" => $nombre,
                "email" => $email,
                "direccion" => $direccion,
                "telefono" => $telefono,
                "pais" => $pais,
                "ciudad" => $ciudad,
                "codigo_postal" => $codigo_postal,
                "documento" => $documento,
                "razon_social" => $razon_social,
                "condicion_iva" => $condicion_iva,
                "cuit" => $cuit,
            ];

      
            $randomString = bin2hex(random_bytes(5)); // Cadena aleatoria de 10 caracteres
            $randomString = strtoupper($randomString);
            $codigo = $idUser . '-' . $randomString;



            //ver si tiene linkeado a cypher
           /*  $productosCypher  *///ir al carrito y buscar de todos los productos los que tengan un id_cypher y diferenciarlos con los que no tienen
            if(  $this->usermodel->isShopConected($idUser)){
                $this->realizarPedidoCypher($id_carrito,$idUser, $userdata,  $codigo);
            }
         
       
            $imagenGuardada = null;
            if (!empty($_FILES['comprobante']['name'])) {
          

                $nombreArchivo = $_FILES['comprobante']['name'];
                $tipoArchivo = $_FILES['comprobante']['type'];
                $rutaTemporal = $_FILES['comprobante']['tmp_name'];

                // Validar tipo de archivo
                if ($tipoArchivo == "image/jpg" || $tipoArchivo == "image/jpeg" || $tipoArchivo == "image/png"  ||  $tipoArchivo == "application/pdf") {
                    // Guardar imagen con nombre único
                    $imagenGuardada = $this->uniqueSaveNamePayments($nombreArchivo, $rutaTemporal);

               
                    // Crear un arreglo con toda la información
                    $data = array(
                        'id_carrito' => $id_carrito,
                        'nombre' => $nombre,
                        'email' => $email,
                        'direccion' => $direccion,
                        'telefono' => $telefono,
                        'pais' => $pais,
                        'ciudad' => $ciudad,
                        'codigo_postal' => $codigo_postal,
                        'comprobante' => array(
                            'path' => $imagenGuardada,
                            'name' => $comprobante['name'],
                            'type' => $comprobante['type'],
                            'tmp_name' => $comprobante['tmp_name'],
                            'error' => $comprobante['error'],
                            'size' => $comprobante['size']
                        ),
                        'instrucciones' => $instrucciones
                    );

                 
                    //ir a buscar los producots del carrito
                    $productos = $this->productModel->productsByIdCarrito($id_carrito);
                  
                    //enviar mail al comprador
                    $result = $this->userMailer->enviarMailCompraComprador($productos, $email);

                   
                    //ir a buscar correo del vendedor
                    $emailvendedor = $this->usermodel->getEmailVendedorByIdCarrito($id_carrito);
                    
                    //enviar mail al vendedor
                    $result = $this->userMailer->enviarMailCompraVendedor( $nombre, $emailvendedor);
                 
                    $this->productModel->comprarCarrito($id_carrito, $idUser, $data, $codigo);
                    
                    var_dump('salir bien');
                    header("Location: " . BASE_URL . 'miscompras');
                    return; 
                }
            } 
        } else {
            var_dump('salir al carrito');
            header("Location: " . BASE_URL . 'carrito');
            exit();
        }
    }


    public function realizarPedidoCypher($id_carrito, $idUser, $userdata, $codigo) {
        // Obtener los productos procesados en formato JSON
        $productos = json_decode($this->productModel->buscarProductosCypher($id_carrito), true);

        $id_empresa_cypher = $this->usermodel->getIdEmpresa($idUser);
        
        $endpoint = 'https://bdxgestion.com/app';
        $dbEndpoint = $this->usermodel->getEndpoint($idUser);
        

        // SACAR CUANDO ESTE ANDANDO BDX CYPHER API
        if ($dbEndpoint === 'https://bdxgestion.com/app') {
            return; // Salimos sin ejecutar el pedido
        }


        // Verificar si el endpoint obtenido no es false
        if ($dbEndpoint) {
            $endpoint = $dbEndpoint;
        }
        var_dump($endpoint);
        // Preparar los datos en formato JSON, incluyendo $userdata y $codigo
        $data = json_encode([
            'id_empresa_cypher' => $id_empresa_cypher,
            'productos' => $productos,
            'userdata' => $userdata,
            'codigo' => $codigo
        ]);
        var_dump($data);

        // Configuración de cURL
        $ch = curl_init($endpoint . '/api/cyshop_realizarPedido.php');
    
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json'
        ]);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        
        // Ejecutar la solicitud y obtener la respuesta
        $response = curl_exec($ch);
    
        // Verificar si hubo errores en cURL
        if (curl_errno($ch)) {
            echo 'Error en cURL: ' . curl_error($ch);
        } else {
            // Procesar la respuesta
            echo 'Respuesta del servidor: ' . $response;
        }
    
        // Cerrar cURL
        curl_close($ch);
    }
    
    
    

    function addToCarrito($params = null) {
        // Verifica si la sesión está iniciada y si ID_USER está definida
        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . "login?V=" . $params[':UNIQUENAME']);
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
    
        $quantity = $_POST['quantity'];
        $idProducto = $params[':ID'];
        $UNIQUENAME = $params[':UNIQUENAME'];
        $id_shop = $this->shopmodel->getIdByShop($UNIQUENAME);
        $idUser = $_SESSION['ID_USER'];
    



        $this->productModel->AddProductToCart(
            $idProducto,
            $idUser,
            $quantity,
            $UNIQUENAME,
            $id_shop
        ); 
    
       header("Location: " . BASE_URL . 'carrito'); 
        exit(); // Agrega un exit después del header para evitar que se ejecute código adicional
    }
    


    function eliminarDelCarrito(){
        $id_carrito =   $_POST['id_carrito'];
        $id_producto = $_POST['id_producto'];
        $this->productModel->eliminarDelCarrito($id_producto, $id_carrito);
        header("Location: " . BASE_URL . 'carrito'); 
    }




    function deleteProduct($params = null){
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $id_tienda = $shopInfo[0]->id_tienda;
        $idProducto = $params[':ID'];
        $idTiendaByProducto =  $this->productModel->idTiendaByProducto($idProducto);
        var_dump($id_tienda);
        var_dump($idTiendaByProducto);
        if($id_tienda ===  $idTiendaByProducto){
            $this->productModel->deleteProduct($idProducto);

            header("Location: " . BASE_URL . 'admin/stock'); 

        }

    
    
    }



}