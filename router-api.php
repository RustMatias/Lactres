<?php
require_once 'libs/Router.php';
include_once 'app/api/api-comment.controller.php';
include_once 'app/api/api-user.controller.php';

include_once 'app/api/api-product.controller.php';
include_once 'app/api/api-category.controller.php';
include_once 'app/api/api-admin.controller.php';

$router = new Router();


$router->addRoute('process_payment_client', 'POST', 'ApiUserController', 'process_payment_client');
$router->addRoute('process_payment', 'POST', 'ApiUserController', 'process_payment');
$router->addRoute('pagarServicio', 'POST', 'ApiUserController', 'pagarServicio');
$router->addRoute('comprarcarrito', 'POST', 'ApiProductController', 'comprarCarrito');


// $router->addRoute('comments','GET','ApiCommentController','getAll'); 
// $router->addRoute('comments/:ID', 'GET', 'ApiCommentController', 'get');
$router->addRoute('products/:IDSHOP/:Q', 'GET', 'ApiProductController', 'getProductByQ');
$router->addRoute('categories', 'POST', 'ApiCategoryController', 'getCategoriesByQ');
$router->addRoute('validarNombreUnico', 'POST', 'ApiUserController', 'validarNombreUnico');
$router->addRoute('cambiarColorTienda', 'POST', 'ApiUserController', 'cambiarColorTienda');
$router->addRoute('cambiarHorarioTienda', 'POST', 'ApiUserController', 'cambiarHorarioTienda');
$router->addRoute('cambiarUbicacionTienda', 'POST', 'ApiUserController', 'cambiarUbicacionTienda');

$router->addRoute('eliminarImagenProducto', 'DELETE', 'ApiAdminController', 'eliminarImagenProducto');

$router->addRoute('uploadcypherproducts', 'POST', 'ApiAdminController', 'uploadcypherproducts');

$router->addRoute('saveCypherInformation', 'POST', 'ApiAdminController', 'saveCypherInformation');
$router->addRoute('saveProfileInfo', 'POST', 'ApiAdminController', 'saveProfileInfo');
$router->addRoute('saveShopInfo', 'POST', 'ApiAdminController', 'saveShopInfo');

$router->addRoute('editarPagoEstado', 'POST', 'ApiAdminController', 'editarPagoEstado');
$router->addRoute('enviarMailUsuarioRecuperarContrasena', 'POST', 'ApiUserController', 'enviarMailUsuarioRecuperarContrasena');
$router->addRoute('validarCodigoRecuperacion', 'POST', 'ApiUserController', 'validarCodigoRecuperacion');
$router->addRoute('VerifyOldPassword', 'POST', 'ApiAdminController', 'VerifyOldPassword');

$router->addRoute('guardarlistaenvios', 'POST', 'ApiAdminController', 'guardarlistaenvios');
$router->addRoute('updateContactInformation','POST','ApiAdminController','updateContactInformation');


$router->addRoute('cambiarContrasena', 'POST', 'ApiAdminController', 'cambiarContrasena');

$router->addRoute('recibirFacturaCypher', 'POST', 'ApiUserController', 'recibirFacturaCypher');
$router->addRoute('eliminarTienda', 'POST', 'ApiAdminController', 'eliminarTienda');
$router->addRoute('actualizarPreciosyProductosCypherGestion', 'POST', 'ApiProductController', 'actualizarPreciosyProductosCypherGestion');


$router->addRoute('eliminarpedido', 'DELETE', 'ApiAdminController', 'eliminarPedido');
$router->addRoute('eliminarpedido', 'DELETE', 'ApiAdminController', 'eliminarPedido');

$router->addRoute('deleteBanner/:ID', 'DELETE', 'ApiAdminController', 'deleteBanner');
$router->addRoute('deleteProduct/:ID', 'DELETE', 'ApiAdminController', 'deleteProduct');
$router->addRoute('changestatuspedidos', 'POST', 'ApiAdminController', 'updatestatuspedido');
$router->addRoute('comments', 'POST', 'ApiCommentController', 'addComment');


$router->addRoute('comments/:ID', 'GET', 'ApiCommentController', 'getCommentsbySkin');
$router->addRoute('comments/:ID', 'DELETE', 'ApiCommentController', 'delete');
$router->addRoute('comments/:ID', 'POST', 'ApiCommentController', 'add');
//$router->addRoute('comments/:ID', 'PUT', 'ApiCommentController', 'update');//no pedian update 
$router->addRoute('user/:ID', 'GET', 'ApiCommentController', 'getName');

$router->route($_REQUEST['resource'],  $_SERVER['REQUEST_METHOD']);


//get comentarios por skin
//post comentarios por skin
//delete por id
//sin update 