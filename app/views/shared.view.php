<?php
require_once('libs/smarty/libs/Smarty.class.php');

class SharedView{

    //Pagina de about
    function showAbout(){
        $smarty = new Smarty();
        $smarty->display('templates/GEN_about.tpl');
    }
    //Pagina de registro
    function showRegistro($error = null, $volver_a= null){
        $smarty = new Smarty();
        $smarty->assign('error', $error);
        $smarty->assign('volver_a', $volver_a);

        $smarty->display('templates/GEN_formRegistro.tpl');       
    }

    //Pagina de log in
    function showLogin($error = null,  $volver_a= null){
        $smarty = new Smarty();
        $smarty->assign('error', $error);
        $smarty->assign('volver_a', $volver_a);
        $smarty->display('templates/GEN_formlogin.tpl');
    }



}




