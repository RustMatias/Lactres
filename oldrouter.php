<?php
include_once 'app/controllers/skin.controller.php';
include_once 'app/controllers/admin.controller.php';
include_once 'app/controllers/user.controller.php';


// defino la base url para la construccion de links con urls semánticas
define('BASE_URL', '//'.$_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']).'/');

// lee la acción
if (!empty($_GET['action'])) {
    $action = $_GET['action'];
} else {
    $action = 'home'; // acción por defecto si no envían
}

// parsea la accion Ej: suma/1/2 --> ['suma', 1, 2]
$params = explode('/', $action);

// determina que camino seguir según la acción
switch ($params[0]) {
    case 'home':
        $controller = new SkinController();
        $controller->showTArma();
    break;
    case 'armas':
        switch ($params[1]){
            case 'Pistola':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;
            case'Rifle':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;
            case'Cuchillo':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;
            case'Subfusil':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;
            case'Pesada':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;
            case'Guantes':
                $controller = new SkinController();           
                $controller->showarma($params[2]);
            break;         
         }
    break;
    case 'about':
        $controller = new SkinController();
        $controller->showAbout();
    break;
    case 'registro':
        $controller = new SkinController();
        $controller->showRegistro();
    break;
    case 'admin':
        $controlleradmin = new AdminController();
        $controlleradmin->showAdmin();
    break;
    case 'addskin':
        $controlleradmin = new AdminController();
        $controlleradmin->addSkin();
    break;
    case 'addarma':
        $controlleradmin = new AdminController();
        $controlleradmin->addArma();
    break;
    case 'editarma':
        $controlleradmin = new AdminController();
        $controlleradmin->editArma();
    break;
    case 'editar':
        $controlleradmin = new AdminController();
        $controlleradmin->showEditSkin($params[1]);
    break;
    case 'editskin':
        $controlleradmin = new AdminController();
        $controlleradmin->editskin($params[1]);
    break;
    case 'deletearma':
        $controlleradmin = new AdminController();
        $controlleradmin->deleteArma();
    break;
    case 'deleteskin':
        $controlleradmin = new AdminController();
        $controlleradmin->deleteSkin($params[1]);
    break;
    case 'comprar':
        $controller = new SkinController();
        $controller->showSkin($params[1]);
    break;
    case 'login':
        $controlleruser = new UserController();
        $controlleruser->showLogin();
    break;
    case 'verify':
        $controlleruser = new UserController();
        $controlleruser->loginUser();
    break;
    case 'logout':
        $controlleruser = new UserController();
        $controlleruser->logout();
    break;
    case 'register':
        $controlleruser = new UserController();
        $controlleruser->register();
    default:
        header("HTTP/1.0 404 Not Found");
        $msg = '404 not found';
        $controller = new SkinController();
        $controller->showError($msg);
    break;
}
