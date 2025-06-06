<?php




include_once 'app/models/index.model.php';

class SkinModel {

private $db;

function __construct() {
    $index = new IndexModel(); // Crear instancia de IndexModel
    $this->db = $index->getConnection(); // Obtener la conexión
}



    //obtiene todas las skins con un limite para el paginado
    function getAllSkins($inicio) {   
        $query = $this->db->prepare('SELECT * FROM skin LIMIT :inicio , '.CANT_PAG.'');
        $query->bindParam(':inicio', $inicio, PDO::PARAM_INT);
        $query->execute();
        $skins = $query->fetchAll(PDO::FETCH_OBJ); // arreglo de tareas
        return $skins;
    }

    function getskinsarma($idarma, $inicio){
        // funcion para obtener una skin por ID de arma
        $query = $this->db->prepare('SELECT * FROM skin WHERE id_arma = :idarma LIMIT :inicio ,'.CANT_PAG.'');
        $query->bindParam(':idarma',$idarma, PDO::PARAM_INT);
        $query->bindParam(':inicio', $inicio, PDO::PARAM_INT);
        $query->execute();
        $skinarmas = $query->fetchAll(PDO::FETCH_OBJ);
        return $skinarmas;
    }

    function getskin($idskin){
        //funcion para obtener una skin por ID de skin
        $query = $this->db->prepare("SELECT * FROM skin WHERE id = ?");
        $query->execute([$idskin]);
        $skin = $query->fetch(PDO::FETCH_OBJ);
        return $skin;
    }


    function insert($nombre,$idarma,$tipo,$estado,$stattrak,$precio,$image=null){
        // funcion para insertar una skin en la base de datos
        if($image){
            $sql='INSERT INTO skin (nombre,id_arma,tipo,estado,stattrak,precio,imagen) VALUES (?,?,?,?,?,?,?)';
            $params=[$nombre,$idarma,$tipo,$estado,$stattrak,$precio,$image];
        }else{
            $sql='INSERT INTO skin (nombre,id_arma,tipo,estado,stattrak,precio) VALUES (?,?,?,?,?,?)';
            $params=[$nombre,$idarma,$tipo,$estado,$stattrak,$precio];
        }
        $query = $this->db->prepare($sql);
        $query->execute($params);
        return $this->db->lastInsertId();
    }

    function delete($id){
        // funcion para borrar una skin en la base de datos
        $query = $this->db->prepare('DELETE FROM skin WHERE id = ?');
        $query->execute([$id]);
        return $query->rowCount();
    }

    function edit($id,$nombre, $idarma, $tipo,$estado,$stattrak,$precio,$coleccion,$image=null){
        if($image){
            $sql="UPDATE skin SET nombre= ?, id_arma= ?, tipo= ?, estado=?, stattrak= ?, precio=? , coleccion=?, imagen=? WHERE id = ?";
            $params=[$nombre, $idarma, $tipo,$estado,$stattrak,$precio,$coleccion,$image,$id];
        }else{
            $sql="UPDATE skin SET nombre= ?, id_arma= ?, tipo= ?, estado=?, stattrak= ?, precio=? , coleccion=? WHERE id = ?";
            $params=[$nombre, $idarma, $tipo,$estado,$stattrak,$precio,$coleccion,$id];
        }
        // funcion para editar una skin en la base de datos
        $query = $this->db->prepare($sql);
        $query->execute($params);
    }
    //funcion para remover la imagen de una skin
    function removeimg($id,$nombre, $idarma, $tipo,$estado,$stattrak,$precio,$coleccion){
        $sql="UPDATE skin SET nombre= ?, id_arma= ?, tipo= ?, estado=?, stattrak= ?, precio=? , coleccion=?, imagen=? WHERE id = ?";
        $query = $this->db->prepare($sql);
        $query->execute([$nombre, $idarma, $tipo,$estado,$stattrak,$precio,$coleccion,null,$id]);
    }
}