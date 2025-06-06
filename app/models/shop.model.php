<?php

include_once 'app/models/index.model.php';

class ShopModel {

    private $db;

    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }


    public function getIdByShop($UniqueShop) {
        $query = $this->db->prepare('SELECT id_tienda FROM tiendas WHERE nombre_unico = ?');
        $query->execute([$UniqueShop]);
        $result = $query->fetch(PDO::FETCH_ASSOC); // Obtener el resultado como un array asociativo
        return $result ? $result['id_tienda'] : null; // Retornar directamente el ID o null si no se encuentra
    }
    

    public function getAllBannerImg($id_tienda) {
        $query = $this->db->prepare('SELECT * FROM banner WHERE id_tienda = ?');
        $query->execute([$id_tienda]);
        return $query->fetchAll(PDO::FETCH_OBJ); // Retorna un array de objetos
    }
    
    

    public function cambiarColorTienda($nombreUnico, $color, $colortexto) {
        $query = $this->db->prepare('UPDATE tiendas SET color = ?, color_texto = ? WHERE nombre_unico = ?');
        $query->execute([$color, $colortexto, $nombreUnico]);
    
        return $query->rowCount(); // Devuelve el número de filas afectadas
    }

    public function cambiarHorarioTienda($horario, $nombreUnico) {
        // Si el horario es null, almacenar NULL en la base de datos
        if ($horario === null) {
            $query = $this->db->prepare('UPDATE tiendas SET horario = NULL WHERE nombre_unico = ?');
            $query->execute([$nombreUnico]);
        } else {
            // Convertir el objeto horario en un string "desde - hasta"
            $horarioTexto =json_encode($horario);
            $query = $this->db->prepare('UPDATE tiendas SET horario = ? WHERE nombre_unico = ?');
            $query->execute([$horarioTexto, $nombreUnico]);
        }
        
        return $query->rowCount(); // Devuelve el número de filas afectadas
    }


    public function cambiarUbicacionTienda($ubicacion, $nombreUnico) {
        if ($ubicacion === null) {
            $query = $this->db->prepare('UPDATE tiendas SET ubicacion = NULL WHERE nombre_unico = ?');
            $query->execute([$nombreUnico]);
        } else {
            $query = $this->db->prepare('UPDATE tiendas SET ubicacion = ? WHERE nombre_unico = ?');
            $query->execute([$ubicacion, $nombreUnico]);
        }
        return $query->rowCount();
    }
    



    public function getShopColors($id_shop) {
        $query = $this->db->prepare('SELECT color, color_texto FROM tiendas WHERE id_tienda = ?');
        $query->execute([$id_shop]);
        return $query->fetchAll(PDO::FETCH_OBJ);  // Devuelve el número de filas afectadas
    }
    
    
    public function getShopInfoById($id){
        $query = $this->db->prepare('SELECT * FROM tiendas WHERE id_usuario = ?');
        $query->execute([$id]);
        return $query->fetchAll(PDO::FETCH_OBJ);
    }

    
    function getTiendas(){
        $query = $this->db->prepare('SELECT * FROM tiendas');
        $query->execute();
        return $query->fetchAll(PDO::FETCH_OBJ);
    }

    function getPlantillaById($id){
        $query = $this->db->prepare('SELECT id_plantilla FROM tiendas WHERE id_tienda = ?');
        $query->execute([$id]); // Aquí pasamos el parámetro $id
        return $query->fetchAll(PDO::FETCH_OBJ);
    }
    
    function getShopFront($id_shop){
        $query = $this->db->prepare('SELECT logo, nombre_simple, medios_de_contacto FROM tiendas WHERE id_tienda = ?');
        $query->execute([$id_shop]);
        return $query->fetchAll(PDO::FETCH_OBJ);  // Devuelve el
    }
    

    function isShopActive($id) {
        $query = $this->db->prepare('SELECT fecha_vencimiento FROM tiendas WHERE id_tienda = ?');
        $query->execute([$id]);
        $result = $query->fetch(PDO::FETCH_OBJ);
        
        if ($result) {
            $fecha_vencimiento = new DateTime($result->fecha_vencimiento);
            $hoy = new DateTime();
    
            // Retorna true si la fecha de vencimiento es mayor o igual a hoy
            return $fecha_vencimiento >= $hoy;
        }
    
        return false;
    }
    
    function actualizarFechaVto($id) {
        // Obtener la fecha de vencimiento actual
        $query = $this->db->prepare('SELECT fecha_vencimiento FROM tiendas WHERE id_tienda = ?');
        $query->execute([$id]);
        $result = $query->fetch(PDO::FETCH_OBJ);

        if (!$result) return false; // No se encontró la tienda

        $fecha_vencimiento_actual = new DateTime($result->fecha_vencimiento);
        $hoy = new DateTime();

        if ($fecha_vencimiento_actual < $hoy) {
            // Si ya venció, se coloca la fecha a 1 mes desde hoy
            $nueva_fecha = $hoy->modify('+1 month');
        } else {
            // Si no venció, se le suma 1 mes a la fecha actual
            $nueva_fecha = $fecha_vencimiento_actual->modify('+1 month');
        }

        // Actualizar la nueva fecha en la base de datos
        $update = $this->db->prepare('UPDATE tiendas SET fecha_vencimiento = ? WHERE id_tienda = ?');
        return $update->execute([$nueva_fecha->format('Y-m-d'), $id]);
    }

    
    
}