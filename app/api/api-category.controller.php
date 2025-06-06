<?php
include_once 'app/models/category.model.php';
include_once 'app/api/api.view.php';
include_once 'app/helpers/user.helper.php';

class ApiCategoryController{
    private $categoryModel;
    private $userhelper;
    private $view;

    function __construct() {
        $this->categoryModel = new CategoryModel();
        $this->userhelper = new UserHelper();
        $this->view = new ApiView();
        $this->data = file_get_contents("php://input");
    }


    function getData(){ 
        return json_decode($this->data); 
    } 
    

    public function getCategoriesByQ($params = null){
        // Leer el cuerpo de la solicitud y decodificarlo de JSON a un array asociativo
        $data = json_decode(file_get_contents('php://input'), true);
    
        // Verifica que la decodificación haya tenido éxito
        if (isset($data['id_tienda']) && isset($data['query'])) {
            $id_tienda = $data['id_tienda'];
            $query = $data['query'];
    
            // Realiza la búsqueda de categorías usando el query
            $products = $this->categoryModel->search($query,  $id_tienda );

            $this->view->response($products, 200);
        } else {
            // Si no se reciben los datos necesarios, enviar un error
            $this->view->response(['error' => 'Datos inválidos'], 400);
        }
    }
    



}