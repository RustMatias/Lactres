<?php


include_once 'app/models/product.model.php';
include_once 'app/api/api.view.php';
include_once 'app/helpers/user.helper.php';
include_once 'app/helpers/user.mailer.php';
include_once 'app/models/user.model.php';
include_once 'app/controllers/product.controller.php';
class ApiProductController{
    private $productModel;
    private $userhelper;
    private $view;
    private $usermodel;   
    private $userMailer;
     private $data;
    private $productController; 
    function __construct() {
        $this->productModel = new ProductModel();
        $this->userhelper = new UserHelper();
        $this->view = new ApiView();
        $this->userMailer = new UserMailer();
        $this->usermodel = new UserModel();
        $this->productController = new ProductController(); 
    }


    function getData(){ 
        return json_decode($this->data); 
    } 
    

    public function getProductByQ($params = null){
        $query = $params[':Q'];
        $id_tienda = $params[':IDSHOP'];

        $products = $this->productModel->search($query, $id_tienda);
        $this->view->response($products, 200);
    }

    public function actualizarPreciosyProductosCypherGestion()
    {
       
        // Recibir datos crudos de la solicitud
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
    
        if (!empty($data['productos']) && !empty($data['id_tienda'])) {
            $productos = $data['productos'];
            $id_tienda = $data['id_tienda'];
    
            // Llamar al modelo para actualizar los productos
            $resp = $this->productModel->actualizarPreciosyProductosCypherGestion($productos, $id_tienda);
            
            // Revisar la respuesta del modelo
            if ($resp === true) {
                // Respuesta exitosa
                http_response_code(200);
                echo json_encode(["message" => "Productos actualizados correctamente"]);
            } else {
                // Respuesta fallida (error en el modelo)
                http_response_code(500);
                echo json_encode(["error" => "Hubo un problema al actualizar los productos"]);
            }
        } else {
            // Datos incompletos o mal formateados
            http_response_code(400);
            echo json_encode(["error" => "Datos incompletos o formato incorrecto"]);
        }
    }
    

    
      public function comprarCarrito() {
        header('Content-Type: application/json');

        $input = file_get_contents('php://input');
        $data = json_decode($input, true);

        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . 'login'); 
            exit(); // Asegura que el script se detenga aquí para evitar que se siga ejecutando
        }
        if (isset($data['id_carrito'])) {
              $idUser = $_SESSION['ID_USER'];
                $id_carrito       = $data['id_carrito']      ?? null;
                $nombre           = $data['nombre']          ?? null;
                $email            = $data['email']           ?? null;
                $telefono         = $data['telefono']        ?? null;
                $direccion        = $data['direccion']       ?? null;
                $pais             = $data['pais']            ?? null;
                $ciudad           = $data['ciudad']          ?? null;
                $codigo_postal    = $data['codigo_postal']   ?? null;
                $documento        = $data['documento']       ?? null;
                $razon_social     = $data['razon_social']    ?? null;
                $cuit             = $data['cuit']            ?? null;
                $condicion_iva    = isset($data['condicion_iva']) && $data['condicion_iva'] !== "" ? $data['condicion_iva'] : 5;

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
                 $this->productController->realizarPedidoCypher($id_carrito,$idUser, $userdata,  $codigo);
            }
         
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
                'instrucciones' => "",
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
            
            echo json_encode([
                'success' => true,
                'redirect' => 'miscompras'
            ]);
            return;
            
        } else {
             echo json_encode([
                'success' => false,
                'message' => 'Ocurrió un error al registrar el pedido'
            ]);
            return;
        }
    }


}