<?php
include_once 'app/models/index.model.php';

class CategoryModel {

    private $db;

    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }

    function addCategory($id_tienda, $nombre,$descripcion,$imagen){
        //funcion para insertar una categoria de arma
        $query = $this->db->prepare('INSERT INTO categorias (nombre,descripcion,imagen, id_tienda) VALUES (?,?,?,?)');
        $query->execute([$nombre,$descripcion,$imagen,$id_tienda]);
        return $this->db->lastInsertId();
    }

    function getRankCategories($id_shop){
        $query = $this->db->prepare('SELECT * 
                             FROM categorias
                             WHERE id_tienda = ?
                             ORDER BY `posicionamiento` DESC
                             LIMIT 3');

        $query->execute([$id_shop]); // Pasar $id_shop como parámetro
        
        $cat = $query->fetchAll(PDO::FETCH_OBJ);
        return $cat;
    }
    

   

    function getHomeCategories($id_shop){
        // Consulta para obtener categorías con productos, filtrando por id_tienda
        $query = $this->db->prepare('SELECT c.*, COUNT(p.id_producto) AS cantidad_productos
                                     FROM categorias c
                                     LEFT JOIN productos p 
                                     ON c.id_categoria = p.id_categoria AND p.id_tienda = ?
                                     WHERE c.id_tienda = ?
                                     GROUP BY c.id_categoria
                                     ORDER BY c.id_categoria DESC
                                     LIMIT 10');
        $query->execute([$id_shop, $id_shop]); // Pasar id_shop como parámetro para ambas condiciones
        
        $cat = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $cat;
    }
    

    function GetCategories($id_tienda){
        $query = $this->db->prepare ('SELECT *
                                    FROM categorias
                                    WHERE id_tienda = ?');
        $query->execute([$id_tienda]);

        $cat = $query ->fetchAll(PDO::FETCH_OBJ);

        return $cat;
    }

    function getCategory($id){
        $query = $this->db->prepare("SELECT * FROM categorias WHERE id_categoria = ?");
        $query->execute([$id]);
        $cat = $query ->fetch(PDO::FETCH_OBJ);

        return $cat;
    }

    function deleteCategory($id) {
        $query = $this->db->prepare("DELETE FROM categorias WHERE id_categoria = ?");
        $query->execute([$id]);
    }
    function deleteCategorySafeMode($id) {
        // 1. Actualizar los productos con esa categoría a 0
        $update = $this->db->prepare("UPDATE productos SET id_categoria = 0 WHERE id_categoria = ?");
        $update->execute([$id]);
    
        // 2. Eliminar la categoría
        $query = $this->db->prepare("DELETE FROM categorias WHERE id_categoria = ?");
        $query->execute([$id]);
    }
    
  
    function getAllCategorias() {
        $query = 'SELECT * FROM categorias';
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    
    function actRankCategory($id){
        $query = $this->db->prepare("UPDATE categorias
                                    SET posicionamiento = posicionamiento + 1
                                    WHERE id_categoria = ?");
        $query->execute([$id]);
    }


    function search($query, $id_tienda) {
        // Preparar la consulta base
        $sql = $this->db->prepare('SELECT *
                                   FROM categorias
                                   WHERE (nombre LIKE :search OR descripcion LIKE :search)
                                     AND id_tienda = :id_tienda');
        
        // Enlazar los parámetros con sus valores
        $sql->bindValue(':search', '%' . $query . '%', PDO::PARAM_STR);
        $sql->bindValue(':id_tienda', $id_tienda, PDO::PARAM_INT); // Asegúrate de que id_tienda sea un número entero
        
        // Ejecutar la consulta
        $sql->execute();
        
        // Obtener todos los resultados
        $result = $sql->fetchAll(PDO::FETCH_OBJ);
        
        return $result;
    }
    


    function editCategory($id, $nombre, $descripcion, $imagename) {
        $query = $this->db->prepare("UPDATE categorias 
                                     SET nombre = ?, descripcion = ?, imagen = ? 
                                     WHERE id_categoria = ?");
        $query->execute([$nombre, $descripcion, $imagename, $id]);
    }

    
    function categoriaMasVisitada($id_tienda) {
        $query = $this->db->prepare("
            SELECT * FROM categorias 
            WHERE id_tienda = ? 
            ORDER BY `posicionamiento` DESC 
            LIMIT 5
        ");
        $query->execute([$id_tienda]);
        return $query->fetchAll(PDO::FETCH_OBJ);
    }


    function categoriaMasVendida($id_tienda) {
        $query = $this->db->prepare("
            SELECT c.*, COALESCE(SUM(p.vendidos), 0) as total_vendidos
            FROM categorias c
            JOIN productos p ON c.id_categoria = p.id_categoria
            WHERE c.id_tienda = ?
            GROUP BY c.id_categoria
            ORDER BY total_vendidos DESC
            LIMIT 5
        ");
        $query->execute([$id_tienda]);
        return $query->fetchAll(PDO::FETCH_OBJ);
    }
    
}