<?php
class IndexModel {

    private $db;
    private $env = '1'; // PROD =2 | DEV = 1

    function __construct() {
        $this->db = $this->connect();
    }

    /**
     * Abre conexión a la base de datos;
     */
    private function connect() {
        if ($this->env === '2') {
            $db = new PDO('mysql:host=localhost;dbname=db_phantom;charset=utf8', 'mati_admin', 'bdx2024');
        } else {
            $db = new PDO('mysql:host=localhost;dbname=db_phantom;charset=utf8', 'root', '');
        }
        return $db;
    }

    // Método público para obtener la conexión
    public function getConnection() {
        return $this->db;
    }
}
