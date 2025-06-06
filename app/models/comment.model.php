<?php
include_once 'app/models/index.model.php';

class commentModel {

    private $db;

    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }


    function getComments($id) {
        // Obtener los comentarios por ID de producto, ordenados por ID de manera descendente y limitados a 10
        $query = $this->db->prepare("
            SELECT * 
            FROM comentarios 
            WHERE id_producto = ? 
            ORDER BY id DESC 
            LIMIT 10
        ");
        $query->execute([$id]);
    
        $comments = $query->fetchAll(PDO::FETCH_OBJ);
    
        // Obtener el promedio de las valoraciones de ese producto
        $queryAvg = $this->db->prepare("
            SELECT AVG(valoracion) as promedio 
            FROM comentarios 
            WHERE id_producto = ?
        ");
        $queryAvg->execute([$id]);
    
        $avgRating = $queryAvg->fetch(PDO::FETCH_OBJ)->promedio;
    
        // Redondear el promedio a 1 solo decimal
        $avgRating = round($avgRating, 1);
    
        // Retornar los comentarios y el promedio
        return [
            'comments' => $comments,
            'promedio' => $avgRating
        ];
    }
    
    
    

    function get($idComment){
        //funcion para obtener un comentario por ID
        $query = $this->db->prepare("SELECT * FROM comentarios WHERE id = ?");
        $query->execute([$idComment]);

        $commentId = $query->fetch(PDO::FETCH_OBJ);

        return $commentId;
    }

    function getcommentUser($idUser){
        // funcion para obtener los comentarios de un usuario
        $query = $this->db->prepare("SELECT * FROM comentarios WHERE id_user = ?");
        $query->execute([$idUser]);

        $commentsUser = $query->fetchAll(PDO::FETCH_OBJ);

        return $commentsUser;
    }

    function delete($id){
        // funcion para borrar una skin en la base de datos
        $query = $this->db->prepare('DELETE FROM comentarios WHERE id = ?');
        $query->execute([$id]);
        return $query->rowCount();
    }

    function update($id, $iduser, $idskin, $comentario,$valoracion){
        // funcion para editar un comentario
        $query = $this->db->prepare("UPDATE comentarios SET id_user= ?, id_skin= ?, comentario= ?, valoracion=? WHERE id = ?");
        $result = $query->execute([$iduser,$idskin,$comentario,$valoracion,$id]);
        
        return $result;
    }

    public function insert($iduser, $username, $idProducto, $comentario, $valoracion) {
        $query = $this->db->prepare('INSERT INTO comentarios (id_user, usuario, id_producto, comentario, valoracion) VALUES (?, ?, ?, ?, ?)');
        $query->execute([$iduser, $username, $idProducto, $comentario, $valoracion]);
        return $this->db->lastInsertId();
    }
    

    function deletebySkin($id){
        // funcion para borrar una skin en la base de datos
        $query = $this->db->prepare('DELETE FROM comentarios WHERE id_skin = ?');
        $succes=$query->execute([$id]);
        return $succes;
    }

    function deletebyUser($id){
        // funcion para borrar una skin en la base de datos
        $query = $this->db->prepare('DELETE FROM comentarios WHERE id_user = ?');
        $succes=$query->execute([$id]);
        return $succes;
    }
}