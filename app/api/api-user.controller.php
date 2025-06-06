<?php
require_once __DIR__ . '/../../vendor/autoload.php';
    use MercadoPago\Client\Payment\PaymentClient;
use MercadoPago\Client\Common\RequestOptions;
use MercadoPago\MercadoPagoConfig;
use MercadoPago\Exceptions\MPApiException;

include_once 'app/models/user.model.php';
include_once 'app/models/shop.model.php';
include_once 'app/helpers/user.mailer.php';

include_once 'app/api/api.view.php';
include_once 'app/helpers/user.helper.php';

class ApiUserController{
    private $usernmodel;

    private $userMailer;
    private $shopmodel;
    private $userhelper;
    private $view;
    private $data;
    function __construct() {
        $this->usernmodel = new UserModel();
        $this->shopmodel = new ShopModel();
        $this->userMailer = new UserMailer();

        $this->userhelper = new UserHelper();
        $this->view = new ApiView();
        $this->data = file_get_contents("php://input");
    }


    function getData(){ 
        return json_decode($this->data); 
    } 
    

    public function validarNombreUnico($params = null) {
        try {
            // Decodifica los datos enviados en el cuerpo de la solicitud
            $data = json_decode(file_get_contents('php://input'), true);
            $nombreTienda = $data['nombreTienda'] ?? null;
          /*   $alias = $data['alias'] ?? null;
            $CBU = $data['CBU'] ?? null; */
            $nombreUnico = $data['nombreUnico'] ?? null;
            $id_plantilla = $data['id_plantilla'] ?? null;
            $codigo = empty($data['codigo']) ? null : $data['codigo'];



            // Verifica que el nombre único no sea nulo
            if (empty($nombreUnico)) {
                // Respuesta con código 400 si el nombre único no está presente
                $this->view->response(
                    ['success' => false, 'message' => 'El nombre único es requerido.'],
                    400
                );
                return;
            }
    
            // Valida si el nombre único ya existe
            $success = $this->usernmodel->verifyUniqueShopName($nombreUnico);
    
            if ($success) {
                // Respuesta exitosa si el nombre es único
                $this->usernmodel->addNewShop($nombreUnico, $nombreTienda, $id_plantilla, $codigo);

                // Respuesta 200 con mensaje de éxito
                $this->view->response(
                    ['success' => true, 'message' => 'El nombre único está disponible.'],
                    200
                );
            } else {
                // Respuesta de error si el nombre ya existe
                $this->view->response(
                    ['success' => false, 'message' => 'El nombre único ya está en uso.'],
                    409
                );
            }
        } catch (Exception $e) {
            // Manejo de cualquier excepción y respuesta de error general
            $this->view->response(
                ['success' => false, 'message' => 'Error interno del servidor: ' . $e->getMessage()],
                500
            );
        }
    }
    
    
    
    public function cambiarColorTienda($params = null) {
        try {
            $data = json_decode(file_get_contents('php://input'), true);
            $color = $data['color'] ?? null;
            $nombreUnico = $data['nombreUnico'] ?? null;
            $colortexto = $data['colortexto'] ?? null;
     

            if (!$color || !$nombreUnico) {
                $this->view->response(['success' => false, 'message' => 'Faltan datos'], 400);
                return;
            }
    
            // Intentar actualizar
            $filasAfectadas = $this->shopmodel->cambiarColorTienda($nombreUnico, $color, $colortexto);
    
            if ($filasAfectadas > 0) {
                $this->view->response(['success' => true, 'message' => 'Color actualizado correctamente'],200);
            } else {
                $this->view->response(['success' => false, 'message' => 'No se pudo actualizar el color. Verifica el nombre único.'], 400);
            }
        } catch (Exception $e) {
            $this->view->response(
                ['success' => false, 'message' => 'Error interno del servidor: ' . $e->getMessage()],
                500
            );
        }
    }
    

    public function  cambiarHorarioTienda(){
        try {
            $inputJSON = file_get_contents('php://input');
            $datos = json_decode($inputJSON, true);
            $nombreUnico = $datos['datosHorario']['tienda'];
            $horario = $datos['datosHorario']['horario'];

            if (!$nombreUnico) {
                $this->view->response(['success' => false, 'message' => 'Faltan datos'], 400);
                return;
            }
    
            // Intentar actualizar
            $filasAfectadas = $this->shopmodel->cambiarHorarioTienda($horario, $nombreUnico);
    
            if ($filasAfectadas > 0) {
                $this->view->response(['success' => true, 'message' => 'Horario actualizado correctamente'],200);
            } else {
                $this->view->response(['success' => false, 'message' => 'No se pudo actualizar el Horario. Verifica el nombre único.'], 400);
            }
        } catch (Exception $e) {
            $this->view->response(
                ['success' => false, 'message' => 'Error interno del servidor: ' . $e->getMessage()],
                500
            );
        }
    }

    public function cambiarUbicacionTienda() {
        try {
            $inputJSON = file_get_contents('php://input');
            $datos = json_decode($inputJSON, true);
            $nombreUnico = $datos['datosUbicacion']['tienda'];
            $ubicacion = $datos['datosUbicacion']['ubicacion']; // puede ser string o null
    
            if (!$nombreUnico) {
                $this->view->response(['success' => false, 'message' => 'Faltan datos'], 400);
                return;
            }
    
            $filasAfectadas = $this->shopmodel->cambiarUbicacionTienda($ubicacion, $nombreUnico);
    
            if ($filasAfectadas > 0) {
                $this->view->response(['success' => true, 'message' => 'Ubicación actualizada correctamente'], 200);
            } else {
                $this->view->response(['success' => false, 'message' => 'No se pudo actualizar la ubicación.'], 400);
            }
        } catch (Exception $e) {
            $this->view->response(['success' => false, 'message' => 'Error interno del servidor: ' . $e->getMessage()], 500);
        }
    }
    



    public function enviarMailUsuarioRecuperarContrasena() {
        // Establecer el encabezado para JSON
        header('Content-Type: application/json');
        
        // Obtener el cuerpo de la petición
        $inputData = file_get_contents('php://input');
        
        // Decodificar el JSON recibido
        $data = json_decode($inputData, true);
       
        // Verificar si se recibió el nombre de cuenta
        if (isset($data['nombreCuenta'])) {
            $nombreCuenta = $data['nombreCuenta'];
            $mail = $this->usernmodel->getMail($nombreCuenta);
    
            // Verificar si se encontró un correo
            if (!empty($mail) && isset($mail[0]->email)) {
                // Generar un código aleatorio de 6 caracteres
                $codigoRecuperacion = substr(str_shuffle('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'), 0, 6);
    
                // Intentar enviar el correo
                $resultado = $this->userMailer->enviarMailCodigo($mail[0]->email, $codigoRecuperacion);
                $eliminarcodigosanteriores = $this->usernmodel->eliminarcodigosanteriores($mail[0]->email);
                $codigores = $this->usernmodel->saveCodigoRecuperacion($mail[0]->email, $codigoRecuperacion);
                if ($resultado['success']) {
                    echo json_encode([
                        'success' => true, 
                        'message' => 'correo de recuperación',

                        'email' => $mail[0]->email, 
                    ]);
                } else {
                    // En caso de error al enviar el correo
                    echo json_encode([
                        'success' => false,
                        'message' => 'No se pudo enviar el correo de recuperación',
                        'error' => $resultado['error'] 
                    ]);
                }
            } else {
                echo json_encode(['success' => false, 'message' => 'No se encontró un correo']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Nombre de usuario no proporcionado']);
        }
    }
    
    
    public function validarCodigoRecuperacion() {
        // Obtén los datos enviados en formato JSON
        $data = json_decode(file_get_contents("php://input"), true);
    
        // Verifica si los datos fueron recibidos correctamente
        if (isset($data['mail']) && isset($data['codigo'])) {
            $mail = $data['mail'];
            $codigo = $data['codigo'];
    
            // Llamamos al método getCodigo que ya tiene la lógica para verificar el código y el mail
            $valido = $this->usernmodel->getCodigo($codigo, $mail);
    
            // Verifica si se encontró un resultado
            if ($valido) {
                $ELIMINADO = $this->usernmodel->eliminarCodigo($codigo, $mail);
                // Si el código es válido
                echo json_encode(['status' => 'success', 'message' => 'Código validado correctamente']);
            } else {
                // Si el código o el mail no coinciden
                echo json_encode(['status' => 'error', 'message' => 'Código o correo electrónico inválido']);
            }
        } else {
            // Si no se recibieron los datos correctamente
            echo json_encode(['status' => 'error', 'message' => 'Faltan datos']);
        }
    }
    
    
    public function recibirFacturaCypher() {
        // Verifica que los datos JSON fueron enviados correctamente
        $data = json_decode(file_get_contents('php://input'), true);
    
        // Si no hay datos o están mal formateados
        if (!$data) {
            header('Content-Type: application/json');
            echo json_encode(['error' => 'Datos no válidos']);
            return;
        }
    
        // Guarda el valor de 'link' y 'email' en variables
        $link = $data['link'];  // Acceder al valor de 'link'
        $correo = $data['email'];  // Acceder al valor de 'email'
    
        // Llama al método para enviar el correo
        $result = $this->userMailer->enviarMailFactura($link, $correo);
    
        // Verifica si hubo un error al enviar el correo
        if ($result['success'] === false) {
            // Si ocurrió un error, muestra el error
            header('Content-Type: application/json');
            echo json_encode(['error' => 'Error al enviar el correo', 'details' => $result['error']]);
        } else {
            // Si el correo fue enviado correctamente
            header('Content-Type: application/json');
            echo json_encode(['mensaje' => 'Correo enviado con éxito', 'link' => $link]);
        }
    }
    
        
    
    
    
    
    
    public function process_payment() {
    // Obtener y decodificar datos JSON
    $data = json_decode(file_get_contents('php://input'), true);

    // Encabezado de respuesta
    header('Content-Type: application/json');

    if (!$data) {
        echo json_encode(['error' => 'Datos no válidos']);
        return;
    }

    // Configurar MercadoPago
    MercadoPagoConfig::setAccessToken("APP_USR-3590053151031368-052710-e9d7c9de71127f14d572e6f07e4daf4f-2005175399");

    $client = new PaymentClient();
    $request_options = new RequestOptions();
    $request_options->setCustomHeaders(["X-Idempotency-Key: " . uniqid("mp_")]);

  try {
    // Crear pago
    $payment = $client->create([
        "transaction_amount" => (float) $data['transaction_amount'],
        "token" => $data['token'],
        "description" => $data['description'],
        "installments" => (int) $data['installments'],
        "payment_method_id" => $data['payment_method_id'],
        "issuer_id" => $data['issuer_id'],
        "payer" => [
            "email" => $data['payer']['email'],
            "identification" => [
                "type" => $data['payer']['identification']['type'],
                "number" => $data['payer']['identification']['number']
            ]
        ]
    ], $request_options);

    echo json_encode([
        'success' => true,
        'status' => $payment->status, // esto extrae "approved", "rejected", etc.
        'id' => $payment->id,
        'message' => 'Pago procesado correctamente'
    ]);
} catch (MPApiException $e) {
    $response = $e->getApiResponse();

    echo json_encode([
        'success' => false,
        'error' => 'MercadoPago API error',
        'status' => $response->getStatusCode(),
        'cause' => $response->getContent()['cause'] ?? null,
        'message' => $response->getContent()['message'] ?? $e->getMessage(),
        'error_response' => $response->getContent()
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => 'General exception',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
}

    

public function process_payment_client() {
    // Obtener y decodificar datos JSON
    $data = json_decode(file_get_contents('php://input'), true);

    // Encabezado de respuesta
    header('Content-Type: application/json');

    if (!$data) {
        echo json_encode(['error' => 'Datos no válidos']);
        return;
    }

    $userInfo = $this->usernmodel->getUserById($data['id_usuario_vendedor']);
    if (!empty($userInfo->mp_credentials)) {
    $credenciales = json_decode($userInfo->mp_credentials, true); // Lo pasamos a array asociativo

    if (isset($credenciales['access_token'])) {
        $access_token = $credenciales['access_token'];
    }


    // Configurar MercadoPago
    MercadoPagoConfig::setAccessToken($access_token);

    $client = new PaymentClient();
    $request_options = new RequestOptions();
    $request_options->setCustomHeaders(["X-Idempotency-Key: " . uniqid("mp_")]);

  try {
    // Crear pago
    $payment = $client->create([
        "transaction_amount" => (float) $data['transaction_amount'],
        "token" => $data['token'],
        "description" => $data['description'],
        "installments" => (int) $data['installments'],
        "payment_method_id" => $data['payment_method_id'],
        "issuer_id" => $data['issuer_id'],
        "payer" => [
            "email" => $data['payer']['email'],
            "identification" => [
                "type" => $data['payer']['identification']['type'],
                "number" => $data['payer']['identification']['number']
            ]
        ]
    ], $request_options);

    echo json_encode([
          'success' => true,
        'status' => $payment->status,
        'id' => $payment->id,
        'message' => 'Pago procesado correctamente',
        'status_detail' => $payment->status_detail, // ⬅️ motivo técnico del rechazo
        'payment_method_id' => $payment->payment_method_id // ⬅️ tipo de tarjeta o método
    ]);
} catch (MPApiException $e) {
    $response = $e->getApiResponse();

    echo json_encode([
        'success' => false,
        'error' => 'MercadoPago API error',
        'status' => $response->getStatusCode(),
        'cause' => $response->getContent()['cause'] ?? null,
        'message' => $response->getContent()['message'] ?? $e->getMessage(),
        'error_response' => $response->getContent()
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => 'General exception',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
}
}

    

      public function pagarServicio() {
        // Verifica que los datos JSON fueron enviados correctamente
        $data = json_decode(file_get_contents('php://input'), true);
    
        // Si no hay datos o están mal formateados
        if (!$data) {
            header('Content-Type: application/json');
            echo json_encode(['error' => 'Datos no válidos']);
            return;
        }
    
        // Guarda el valor de 'link' y 'email' en variables
        $amount = $data['amount'];  // Acceder al valor de 'link'
        $id_tienda = $data['id_tienda'];  // Acceder al valor de 'email'

        //agrega el pago
         $exito = $this->usernmodel->pagarServicio($amount, $id_tienda);

         //actualiza la fecha de vto
        $exito = $this->shopmodel->actualizarFechaVto( $id_tienda);


        echo json_encode(['success' => true]);
   
       

    }
    
    

}