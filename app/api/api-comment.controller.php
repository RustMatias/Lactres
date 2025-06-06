

<?php


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


include_once 'app/models/comment.model.php';
include_once 'app/api/api.view.php';
include_once 'app/models/user.model.php';
include_once 'app/helpers/user.helper.php';

class ApiCommentController{
    private $modelcomment;
    private $modeluser;
    private $userhelper;
    private $view;
    private $data; // Declaramos la propiedad de forma explícita

    function __construct() {
        $this->modelcomment = new commentModel();
        $this->modeluser = new UserModel();
        $this->userhelper = new UserHelper();
        $this->view = new ApiView();
        $this->data = file_get_contents("php://input");
    }


    function getData(){ 
        return json_decode($this->data); 
    } 
    
    //util para mostrar comentarios generales en inicio
    // function getAll() {
    //     $comments = $this->modelcomment->getAllcomments();
    //     $this->view->response($comments, 200);
    // }

    // public function get($params = null) {
    //     // $params es un array asociativo con los parámetros de la ruta
    //     $idComment = $params[':ID'];
    //     $comment = $this->modelcomment->get($idComment);
    //     if ($comment)
    //         $this->view->response($comment, 200);
    //     else
    //         $this->view->response("El comentario con el id=$idComment no existe.", 404);
    // }

    public function getCommentsbySkin($params = null){
        $idSkin = $params[':ID'];
        $comments = $this->modelcomment->getcommentSkin($idSkin);
        $this->view->response($comments, 200);
    }

    //util para hacer un filtro
    // public function getCommentsbyUser($params = null){
    //     $idUser = $params[':ID'];
    //     $comments = $this->modelcomment->getcommentsUser($idUser);
    //     if($comments)
    //         $this->view->response($comments, 200);
    //     else
    //         $this->view->response("Este usuario no tiene comentarios", 404);
    // }

    public function delete($params = null) {
        $log = $this->userhelper->checkAdminLoginComment();
        if($log = 1){
            $idComment = $params[':ID'];
            $success = $this->modelcomment->delete($idComment);
            if ($success) {
                $this->view->response("El comentario con la ID = $idComment se borró exitosamente.", 200);
            }
            else { 
                $this->view->response("El comentario con la ID = $idComment no existe.", 404);
            }
        }
        else {
            $this->view->response("No tienes acceso a esta funcion", 404);
        }
    }

    public function addComment() {
        try {
            $body = $this->getData();
            $iduser = $body->userId ?? null;
            $username = $body->userName ?? null;
            $idProducto = $body->idProducto ?? null;
            $comentario = $body->comentario ?? '';
            $valoracion = $body->valoracion ?? null;
    
            if (empty($comentario) || empty($iduser) || empty($idProducto) || empty($valoracion)) {
                $this->view->response(['error' => 'Faltan datos obligatorios.'], 422);
                return;
            }
    
            $id = $this->modelcomment->insert($iduser, $username, $idProducto, $comentario, $valoracion);
    
            if (!$id) { // Si insert devuelve false, es un error en el modelo
                $this->view->response(['error' => 'Error al insertar el comentario en el modelo.'], 500);
                return;
            }
    
            $comment = $this->modelcomment->get($id);
    
            if (!$comment) { // Si no se encuentra el comentario, indica un error
                error_log("Error en el controlador: No se encontró el comentario con ID $id");
                $this->view->response(['error' => 'Error al recuperar el comentario insertado.'], 500);
                return;
            }
    
            $this->view->response($comment, 200);
        } catch (Exception $e) {
            error_log("Error en el controlador: " . $e->getMessage());
            $this->view->response(['error' => 'Error interno del servidor.'], 500);
        }
    }
    
    

    public function getName($params = null) {
        //funcion para obtener el nombre de una persona teniendo el ID, util para los comentarios
        // $params es un array asociativo con los parámetros de la ruta
        $idUser = $params[':ID'];
        $userName = $this->modeluser->getName($idUser);
        if ($userName)
            $this->view->response($userName, 200);
        else
            $this->view->response("El usuario con el id = $idUser no existe.", 404);
    }

}