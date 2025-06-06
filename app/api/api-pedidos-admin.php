<?php
include_once 'app/models/user.model.php';
include_once 'app/api/api.view.php';

class ApiPedidosController {
    private $model;
    private $view;

    function __construct() {
        $this->model = new ModelUser();
        $this->view = new ApiView();
        $this->data = file_get_contents("php://input");
    }

    function getData() { 
        return json_decode($this->data, true); 
    }

    public function getPedidos($params = null) {
        // Obtener parámetros de la consulta
        $search = isset($_GET['search']) ? $_GET['search'] : '';
        $estado = isset($_GET['estado']) ? $_GET['estado'] : null;

        // Llamar al método del modelo para obtener los pedidos
        $pedidos = $this->model->getAllPedidos($search, $estado);
        $this->view->response($pedidos, 200);
    }
}
