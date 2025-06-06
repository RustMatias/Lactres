<?php



include_once 'app/models/admin.model.php';
include_once 'app/models/shop.model.php';
include_once 'app/models/user.model.php';
include_once 'app/models/product.model.php';
include_once 'app/api/api.view.php';
include_once 'app/helpers/user.helper.php';

class ApiAdminController{
    private $adminmodel;
    private $shopmodel;
    private $productModel;
    private $usermodel;
    private $userhelper;
    private $view;
    private $data;
    function __construct() {
        $this->adminmodel = new AdminModel();
        $this->shopmodel = new ShopModel();
        $this->productModel = new ProductModel();
        $this->usermodel = new UserModel();
        $this->userhelper = new UserHelper();
        $this->view = new ApiView();
        $this->data = file_get_contents("php://input");
    }


    function getData(){ 
        return json_decode($this->data); 
    } 
    

    public function deleteBanner($params = null) {
        $ID = $params[':ID'];
    
        try {
            // Llama al modelo para eliminar el banner
            $success = $this->adminmodel->deleteBanner($ID);
    
            // Verificar si la eliminación fue exitosa
            if ($success) {
                $this->view->response(['success' => true], 200);
            } else {
                $this->view->response(['success' => false, 'message' => 'No se pudo eliminar la imagen'], 400);
            }
        } catch (Exception $e) {
            // Manejar cualquier excepción
            $this->view->response(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
    
    

    public function deleteProduct($params = null) {
        $ID = $params[':ID'];
    
        try {
            // Llama al modelo para eliminar el banner
            $success = $this->adminmodel->deleteProduct($ID);
    
            // Verificar si la eliminación fue exitosa
            if ($success) {
                $this->view->response(['success' => true], 200);
            } else {
                $this->view->response(['success' => false, 'message' => 'No se pudo eliminar la imagen'], 400);
            }
        } catch (Exception $e) {
            // Manejar cualquier excepción
            $this->view->response(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }






    public function updatestatuspedido() {
        try {
            $data = json_decode(file_get_contents('php://input'), true);
            $status = $data['status'];
            $id_compra = $data['id_compra'];
    
            $success = $this->adminmodel->updateStatusPedido($id_compra, $status);

            if ($success) {
                echo json_encode(['message' => 'Estado actualizado correctamente']);
            } else {
                echo json_encode(['message' => 'Error al actualizar el estado']);
            }
        } catch (Exception $e) {
            echo json_encode(['error' => $e->getMessage()]);
        }
    }
    
    


    public function eliminarImagenProducto() {
        // Obtén los datos enviados en el cuerpo de la solicitud
        $inputData = json_decode(file_get_contents("php://input"), true);
    
        // Verifica que los datos se hayan recibido correctamente
        if ($inputData && isset($inputData['imagenIndex']) && isset($inputData['id_producto'])) {
            // Recupera los datos
            $imagenIndex = $inputData['imagenIndex'];
            $id_producto = $inputData['id_producto'];
    
            $success = $this->adminmodel->eliminarImagenProducto($id_producto, $imagenIndex);

    
            echo json_encode(['status' => 'success', 'message' => 'Imagen eliminada con éxito']);
        } else {
            // Si no se reciben los parámetros correctamente, devolver un error
            echo json_encode(['status' => 'error', 'message' => 'Datos incorrectos']);
        }
    }
    


    public function eliminarPedido(){
        $inputData = json_decode(file_get_contents("php://input"), true);
    
        // Verifica que los datos se hayan recibido correctamente
        if (isset($inputData['id_pedido'])) {
            // Recupera los datos
            $id_pedido = $inputData['id_pedido'];

            $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
            $id_tienda = $shopInfo[0]->id_tienda;

            $idTiendaByPedido =  $this->adminmodel->idTiendaByPedido($id_pedido);

            if($id_tienda ===  $idTiendaByPedido){
                $success = $this->adminmodel->eliminarPedido($id_pedido);
                echo json_encode(['status' => 'success', 'message' => 'pedido eliminado con éxito']);

            }else{
                echo json_encode(['status' => 'error', 'message' => 'No se pudo eliminar']);

            }

        } else {
            // Si no se reciben los parámetros correctamente, devolver un error
            echo json_encode(['status' => 'error', 'message' => 'Datos incorrectos']);
        }
    


    }



    public function uploadcypherproducts(){
        // Obtener los datos JSON enviados desde el frontend
        $productos = json_decode(file_get_contents("php://input"), true);
        $shopInfo = $this->shopmodel->getShopInfoById($_SESSION['ID_USER']);
        $idTienda = $shopInfo[0]->id_tienda;
        // Verificar si la decodificación fue exitosa
        if ($productos === null) {
            // En caso de error en la decodificación, devolver un mensaje de error
            echo json_encode(['success' => false, 'message' => 'Datos inválidos']);
            return;
        }
        
     

        // Llamar al modelo para procesar los productos
        $success = $this->productModel->uploadcypherproducts($productos,$idTienda);
    
        // Verificar si la carga fue exitosa
        if ($success) {
            // Respuesta exitosa
            echo json_encode(['success' => true, 'message' => 'Productos importados correctamente']);
        } else {
            // Respuesta de error si no se pudieron importar los productos
            echo json_encode(['success' => false, 'message' => 'Error al importar productos']);
        }
    }
    

    function saveCypherInformation(){
        $informacion = json_decode(file_get_contents("php://input"), true);
        $success = $this->usermodel->saveCypherInformation($informacion);
       // $success = $this->usermodel->changeplantoCypher($informacion);

        if ($success) {
            // Respuesta exitosa
            echo json_encode(['success' => true, 'message' => 'Informacion guardada correctamente']);
        } else {
            // Respuesta de error si no se pudieron importar los productos
            echo json_encode(['success' => false, 'message' => 'Error al guardar productos']);
        }
    }

    function saveProfileInfo(){
        $informacion = json_decode(file_get_contents("php://input"), true);
        $success = $this->usermodel->saveProfileInfo($informacion);
        if ($success) {
            // Respuesta exitosa
            echo json_encode(['success' => true, 'message' => 'Informacion guardada correctamente']);
        } else {
            // Respuesta de error si no se pudieron importar los productos
            echo json_encode(['success' => false, 'message' => 'Error al guardar productos']);
        }
    }

    function saveShopInfo(){
        $informacion = json_decode(file_get_contents("php://input"), true);
    
        $success = $this->usermodel->saveShopInfo($informacion);
     
        if ($success) {
            // Respuesta exitosa
            echo json_encode(['success' => true, 'message' => 'Informacion guardada correctamente']);
        } else {
            // Respuesta de error si no se pudieron importar los productos
            echo json_encode(['success' => false, 'message' => 'Error al guardar productos']);
        }
    }


    function editarPagoEstado() {
        // Obtiene el cuerpo de la solicitud y lo decodifica
        $data = json_decode(file_get_contents('php://input'), true);
    
        // Accede a los datos específicos
        $id_pedido = $data['id_pedido'];
        $estado = $data['estado'];
        $id_tienda = $data['id_tienda'];
        
        // Llamada al modelo para actualizar el pago y la tienda
        $resultado = $this->adminmodel->actualizarPagoYTienda($id_pedido, $estado, $id_tienda);
    
        // Preparar respuesta en JSON
        $response = [
            'success' => false,
            'message' => 'No se pudo actualizar el estado.'
        ];
    
        if ($resultado === true) {
            $response['success'] = true;
            $response['message'] = 'Estado actualizado correctamente.';
        } elseif (is_string($resultado)) {
            $response['message'] = $resultado;
        }
    
        // Devolver respuesta JSON
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    
    function eliminarTienda(){
        // Obtener los datos enviados por POST en formato JSON
        $data = json_decode(file_get_contents('php://input'), true);
        
        // Verificar si el campo id_tienda existe en los datos enviados
        if (!isset($data['id_tienda'])) {
            echo json_encode(['error' => 'Falta el id_tienda']);
            return;
        }
    
        // Acceder al id_tienda que se envió
        $id_tienda = $data['id_tienda'];
    
        // Actualizar el campo vendedor en la tabla usuarios
        $resultadoVendedor = $this->adminmodel->actualizarVendedorTienda($id_tienda);
    
        if ($resultadoVendedor === false) {
            echo json_encode(['error' => 'Hubo un problema al actualizar el vendedor']);
            return;
        }
    
        // Eliminar los productos asociados a esta tienda
        $resultadoProductos = $this->adminmodel->eliminarProductosPorTienda($id_tienda);
    
        if ($resultadoProductos === false) {
            echo json_encode(['error' => 'Hubo un problema al eliminar los productos asociados a la tienda']);
            return;
        }
    
        // Eliminar la tienda
        $resultadoTienda = $this->adminmodel->eliminarTienda($id_tienda);
    
        if ($resultadoTienda) {
            // Si la tienda fue eliminada correctamente
            echo json_encode(['success' => 'Tienda y productos eliminados correctamente']);
        } else {
            // Si hubo un error al eliminar la tienda
            echo json_encode(['error' => 'Hubo un problema al eliminar la tienda']);
        }
    }
    
    

    function cambiarContrasena() {
        
         // Leer los datos del cuerpo de la solicitud
         $data = json_decode(file_get_contents('php://input'), true);

         // Obtener la contraseña antigua del JSON
         $nueva_contrasena = $data['new_password'] ?? '';

    
        if (!empty($nueva_contrasena)) {
            // Suponiendo que $this->adminmodel->cambiarContrasena() es el método que realiza el cambio
            $resultado = $this->adminmodel->cambiarContrasena($nueva_contrasena);
    
            if ($resultado) {
                echo json_encode(['status' => 'success', 'message' => 'Contraseña cambiada exitosamente']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Error al cambiar la contraseña']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Contraseña no válida']);
        }
    }


    function VerifyOldPassword() {
        // Leer los datos del cuerpo de la solicitud
        $data = json_decode(file_get_contents('php://input'), true);

        // Obtener la contraseña antigua del JSON
        $old_pass = $data['old_pass'] ?? '';
    
        // Verificar si se recibió una contraseña
        if (!empty($old_pass)) {
            // Llamar al modelo para verificar la contraseña antigua
            $resultado = $this->adminmodel->VerifyOldPassword($old_pass);
    
            // Devolver el resultado (true o false)
            echo json_encode($resultado);
        } else {
            // Si no se recibió una contraseña válida, devolver false
            echo json_encode(false);
        }
    }
    
    
    

    function guardarlistaenvios() {
        header('Content-Type: application/json');
    
        $json = file_get_contents('php://input');
        $data = json_decode($json, true);
    
        $resultado = $this->adminmodel->guardarlistaenvios($data);
    
        if ($resultado['success']) {
            echo json_encode([
                'success' => true,
                'message' => 'Lista de envíos guardada correctamente'
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Error al guardar la lista de envíos',
                'error' => $resultado['error'] ?? 'Desconocido'
            ]);
        }
    }


   public function updateContactInformation() {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Obtener los datos desde POST
        $telefono = $_POST['contact-phone'] ?? '';
        $email = $_POST['contact-email'] ?? '';
        $facebook = $_POST['contact-facebook'] ?? '';
        $instagram = $_POST['contact-instagram'] ?? '';
        $whatsapp = $_POST['contact-whatsapp'] ?? '';
        $id_tienda = $_POST['id_tienda'] ?? null;

        // Validar que venga el ID de la tienda
        if (!$id_tienda) {
            echo json_encode(['status' => 'error', 'message' => 'ID de tienda faltante']);
            return;
        }

        // Crear objeto de contacto
        $contactInfo = (object)[
            'telefono' => $telefono,
            'email' => $email,
            'facebook' => $facebook,
            'instagram' => $instagram,
            'whatsapp' => $whatsapp
        ];

        // Llamar al modelo
        $ok = $this->adminmodel->updateContactInformation($contactInfo, $id_tienda);

        echo json_encode(['status' => $ok ? 'ok' : 'error']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Método no permitido']);
    }
}

    

}
