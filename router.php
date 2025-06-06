<?php
require_once 'libs/Router.php';
include_once 'app/controllers/admin.controller.php';
include_once 'app/controllers/user.controller.php';
include_once 'app/controllers/shop.controller.php';
include_once 'app/controllers/product.controller.php';
include_once 'app/controllers/category.controller.php';


define('BASE_URL', '//'.$_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']).'/');

/* 
 define('BASE_URL', (isset($_SERVER['HTTPS']) ? "https" : "http") . "://" . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']));
 */
define("CANT_PAG",4);

$router = new Router();
// Secciones de la pagina
$router->addRoute('mp/oauth','GET','UserController','mpOauth');
$router->addRoute('home','GET','productController','showHome');
$router->addRoute('paginaNoDisponible','GET','ShopController','paginaNoDisponible');

$router->addRoute('emprendedores','GET','productController','showEmprendedores');

$router->addRoute('phpInfoAdmin','GET','AdminController','phpinfo');


$router->addRoute('about','GET','UserController','showAbout');
$router->addRoute('terminosycondiciones','GET','UserController','showTerminosYCondiciones');

$router->addRoute('account/:ID_USER','GET','UserController','showProfile');
$router->addRoute('payments/:ID_USER','GET','UserController','showPagos');



$router->addRoute('pagarServicio','POST','userController','pagarServicio');

// Acciones del administrador
$router->addRoute('addproduct','POST','productController','addProduct');
$router->addRoute('addbanner','POST','AdminController','addBanner');
$router->addRoute('updateLogo','POST','AdminController','updateLogo');

$router->addRoute('deletebanner/:ID','POST','AdminController','deleteBanner');

$router->addRoute('addcategory','POST','CategoryController','addCategory');

$router->addRoute(':UNIQUENAME/product/:ID','GET','productController','showProduct');
$router->addRoute(':UNIQUENAME/category/:ID','GET','CategoryController','showCategory');
$router->addRoute(':UNIQUENAME/search','POST','productController','search');
$router->addRoute(':UNIQUENAME/products','GET','productController','showProducts');
$router->addRoute(':UNIQUENAME/edit/:ID','GET','productController','showEditProduct');
$router->addRoute(':UNIQUENAME/editcategory/:ID','GET','CategoryController','showEditCategory');


$router->addRoute('product/:ID','GET','productController','showProduct');
$router->addRoute('category/:ID','GET','CategoryController','showCategory');
$router->addRoute('brand/:Q','GET','CategoryController','showBrand');

$router->addRoute('edit/:ID','GET','productController','showEditProduct');
$router->addRoute('editproduct','POST','productController','editProduct');
$router->addRoute('deleteproduct/:ID','GET','productController','deleteProduct');
$router->addRoute('deleteCategory/:ID','GET','AdminController','deleteCategory');

$router->addRoute('editCategory','POST','CategoryController','editCategory');
$router->addRoute('category/:ID','GET','CategoryController','showCategory');
// URLS del administrador
$router->addRoute('uploadCypherProducts','GET','AdminController','ShowCypherProducts');
$router->addRoute('agregarcodigocreaciontienda','POST','AdminController','agregarcodigocreaciontienda');
$router->addRoute('recuperarcontrasena','GET','UserController','recuperarContrasena');


$router->addRoute('cambiarcontraseña','POST','UserController','cambiarContraseña');
$router->addRoute('cambiarContrasenaAccion','POST','UserController','cambiarContrasenaAccion');



$router->addRoute('sudoAdmin','GET','AdminController','showSudoAdmin');

$router->addRoute('creartienda','GET','userController','creartienda');

$router->addRoute('admin','GET','AdminController','showAdmin');
$router->addRoute('admin/stock','GET','AdminController','showAdminStock');
$router->addRoute('admin/pedidos', 'GET', 'AdminController', 'showPedidos');
$router->addRoute('admin/gestionarpedido/:ID', 'GET', 'AdminController', 'showGestionarPedido');
$router->addRoute('admin/stats','GET','AdminController','showStadistics');

//Credenciales
$router->addRoute('login','GET','UserController','showLogin');
$router->addRoute('verify','POST','UserController','loginUser');
$router->addRoute('logout','GET','UserController','logout');
$router->addRoute('registrer','POST','UserController','registrer');

//seccion compras del usuario normal
$router->addRoute('miscompras','GET','UserController','showCompras');
$router->addRoute('carrito','GET','UserController','ShowCarrito');
$router->addRoute('confirmarcarrito/:ID', 'GET', 'UserController', 'confirmarCarrito');
$router->addRoute('comprarcarrito', 'POST', 'ProductController', 'comprarCarrito');

$router->addRoute('addToCarrito/:ID/:UNIQUENAME','POST','productController','addToCarrito');

$router->addRoute('eliminarDelCarrito','POST','productController','eliminarDelCarrito');


$router->addRoute('dashboard/profile/:ID_USER','GET','UserController','dashboard_profile');
$router->addRoute('dashboard/security/:ID_USER','GET','UserController','dashboard_security');
$router->addRoute('dashboard/connectivities/:ID_USER','GET','UserController','dashboard_connectivities');
$router->addRoute('dashboard/statistics/:ID_USER','GET','UserController','dashboard_statistics');
$router->addRoute('dashboard/shop/:ID_USER','GET','UserController','dashboard_shop');
$router->addRoute('dashboard/inventory/:ID_USER','GET','UserController','dashboard_inventory');
$router->addRoute('dashboard/add_product/:ID_USER','GET','UserController','dashboard_add_product');

$router->addRoute('dashboard/orders/:ID_USER','GET','UserController','dashboard_orders');
$router->addRoute('dashboard/manage_orders/:ID_USER/:ID','GET','UserController','dashboard_manage_orders');
$router->addRoute('dashboard/payments/:ID_USER','GET','UserController','dashboard_payments');

$router->addRoute('dashboard/categories/:ID_USER','GET','UserController','dashboard_categories');
$router->addRoute('dashboard/add_category/:ID_USER','GET','UserController','dashboard_add_category');

$router->addRoute('dashboard/brand/:ID_USER','GET','UserController','dashboard_brand');
$router->addRoute('dashboard/shipments/:ID_USER','GET','UserController','dashboard_shipments');




//pagina chicos


$router->addRoute('registro','GET','UserController','showRegistro');
//$router->addRoute('comprar/:ID','GET','SkinController','showSkin');
$router->addRoute('admin/:PAGE','GET','AdminController','showAdmin');
// Acciones del administrador

$router->addRoute('deleteskin/:ID','GET','AdminController','deleteSkin');
$router->addRoute('editpermisos','POST','AdminController','editpermisos');
$router->addRoute('deleteuser','POST','AdminController','deleteuser');
$router->addRoute('deleteimage/:ID','GET','AdminController','deleteimage');


// Acciones de la sesion

$router->addRoute(':UNIQUENAME','GET','ShopController','ShowShopMainPage'); 
$router->setDefaultRoute('productController','showHome'); 
$router->route($_REQUEST['action'],  $_SERVER['REQUEST_METHOD']);