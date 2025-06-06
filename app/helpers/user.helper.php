<?php

class UserHelper {
    /**
     * Barrera de seguridad para usuario logueado
     */
    function __construct  (){
        if (session_status() != PHP_SESSION_ACTIVE) {
            session_start();
        }
    }
    function checkAdminLogin() {
        //Detectamos la sesion, si esta activa o inactiva.
        if (!isset($_SESSION['ID_USER'])) {
            header("Location: " . BASE_URL . 'home');
            die();
        }
    }

    function checkAdminLoginComment() {
        $log;
        //Detectamos la sesion, si esta activa o inactiva.
        if (!isset($_SESSION['ID_USER']) || !($_SESSION['PERMISOS'] == 1)) {
            $log=0;
            return $log;
        }else{
            $log=1;
            return $log;
        }
    }
    
    function checkUserLogin() {
        //Detectamos la sesion, si esta activa o inactiva.
        $log;
        if (!isset($_SESSION['ID_USER'])) {
            $log=0;
            return $log;
        }
        else{
            $log=1;
            return $log;
        }
    } 
    
    function logout() {
        //Funcion para desconectar al usuario de la sesion.
        session_destroy();
        header("Location: " . BASE_URL . 'home');
    }    

    function login($user) {   
        //funcion para logearse
        $_SESSION['GRUPO'] = $user->grupo ;
        $_SESSION['PLANTILLA'] = $user->id_plantilla ;
        $_SESSION['VENDEDOR'] = $user->vendedor;
        $_SESSION['ADMIN'] = $user->admin;
        $_SESSION['ID_USER'] = $user->id;
        $_SESSION['USER_NAME'] = $user->usuario;
    }


}