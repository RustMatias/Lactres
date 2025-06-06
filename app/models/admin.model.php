<?php

include_once 'app/models/index.model.php';

class AdminModel {

    private $db;

    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }



    public function getBannerImg($user) {
        $query = $this->db->prepare('SELECT * FROM usuarios WHERE usuario = ?');
        $query->execute([$user]);
        return $query->fetch(PDO::FETCH_OBJ);
    }
    



    public function getAllShopBanners($shopInfo){
        
        $id_tienda = $shopInfo[0]->id_tienda;
        $query = $this->db->prepare('SELECT * FROM banner WHERE id_tienda = ?');
        $query->execute([$id_tienda]);
        $users = $query->fetchAll(PDO::FETCH_OBJ); 
        return $users;
    }




    //actualiza los permisos
    public function UpdateBannerImg($id,$permiso){
        $query = $this->db->prepare("UPDATE usuarios SET permiso = ? WHERE id = ?");
        $query->execute([$permiso,$id]);
    }
    
    function deleteBannerImg($id){
        // funcion para borrar una Usuario en la base de datos
        $query = $this->db->prepare('DELETE FROM usuarios WHERE id = ?');
        $succes=$query->execute([$id]);
        return $succes;
    }

    function addBanner(
                    $id_tienda,
                    $texto1,
                    $texto2,
                    $images){
                        
        //funcion para insertar una categoria de arma
        $fechaActual = date('Y-m-d');
        $query = $this->db->prepare('INSERT INTO banner (id_tienda ,texto1, texto2, imagen) VALUES (?,?,?,?)');
        $query->execute([
                        $id_tienda,
                        $texto1,
                        $texto2,
                        $images
                        ]);

    return $this->db->lastInsertId();
    }


    function updateLogo($id_tienda, $logo){
        $query = $this->db->prepare('UPDATE tiendas SET logo = ? WHERE id_tienda = ?');
        $query->execute([
            $logo,  // the logo file path or name
            $id_tienda
        ]);
    }
    

    

    function deleteBanner($id) {
        $query = $this->db->prepare('DELETE FROM banner WHERE id_imagen = ?');
        $success = $query->execute([$id]);
        return $success;
    }

    function deleteProduct($id) {
        $query = $this->db->prepare('DELETE FROM productos WHERE id_producto = ?');
        $success = $query->execute([$id]);
        return $success;
    }
        



    public function updateStatusPedido($id_compra, $status) {
        $query = $this->db->prepare('UPDATE compras SET estado = ? WHERE id_compra = ?');
        $success = $query->execute([$status, $id_compra]);
        return $success;
    }
    
    
    public function eliminarImagenProducto($id_producto, $index) {
        // 1. Recuperar las imágenes actuales del producto
        $query = $this->db->prepare('SELECT imagenes FROM productos WHERE id_producto = ?');
        $query->execute([$id_producto]);
        $result = $query->fetch(PDO::FETCH_ASSOC);
    
        if ($result) {
            // 2. Descomponer el string de imágenes en un array
            $imagenes = explode(',', $result['imagenes']);
            
            // 3. Verificar si el índice es válido
            if (isset($imagenes[$index])) {
                // 4. Eliminar la imagen en el índice especificado
                unset($imagenes[$index]);
    
                // 5. Reindexar el array para eliminar los índices vacíos
                $imagenes = array_values($imagenes);
    
                // 6. Convertir de nuevo el array a un string (si es necesario) y actualizar la base de datos
                $imagenesString = implode(',', $imagenes);
                $updateQuery = $this->db->prepare('UPDATE productos SET imagenes = ? WHERE id_producto = ?');
                $success = $updateQuery->execute([$imagenesString, $id_producto]);
    
                return $success;
            }
        }
    
        return false; // Si no se encontró el producto o el índice no es válido
    }



    function eliminarPedido($id) {
        $query = $this->db->prepare('UPDATE compras SET borrado = 1 WHERE id_compra = ?');
        $success = $query->execute([$id]);
        return $success;
    }
    


    function idTiendaByPedido($id_pedido) {
        $query = $this->db->prepare("SELECT id_tienda FROM compras WHERE id_compra = ?");
        $query->execute([$id_pedido]);
        $resultado = $query->fetch(PDO::FETCH_OBJ);
    
        // Asegúrate de devolver el valor de id_tienda
        return $resultado ? $resultado->id_tienda : null;
    }
    


    function getPagos() {
        // Query to join pagos_usuarios and tiendas tables based on id_tienda, ordered by fecha (most recent first)
        $query = $this->db->prepare('
            SELECT 
                p.id_pago, p.id_tienda, p.fecha, p.monto, p.pago, p.comprobante,
                t.nombre_unico, t.nombre_simple
            FROM pagos_usuarios p
            JOIN tiendas t ON p.id_tienda = t.id_tienda
            ORDER BY p.fecha DESC
        ');
    
        // Execute the query
        $query->execute();
    
        // Return the result as an array of objects
        return $query->fetchAll(PDO::FETCH_OBJ);
    }
    

    function getCodigos(){
        $query = $this->db->prepare('
        SELECT *
        FROM codigos_creacion_tienda
    ');

    // Execute the query
    $query->execute();

    // Return the result as an array of objects
    return $query->fetchAll(PDO::FETCH_OBJ);
    }


    function actualizarPagoYTienda($id, $estado, $id_tienda){
        try {
            // Actualizar el estado del pago
            $query = $this->db->prepare('UPDATE pagos_usuarios SET pago = ? WHERE id_pago = ?');
            $success = $query->execute([$estado, $id]);
    
            if (!$success) {
                return 'Error al actualizar el estado del pago.';
            }
    
            // Solo si el estado es 1 (pago aprobado), actualizar la tienda
            if ($estado == 1) {
                // Obtener la fecha de vencimiento actual de la tienda
                $query = $this->db->prepare("SELECT fecha_vencimiento FROM tiendas WHERE id_tienda = ?");
                $query->execute([$id_tienda]);
                $resultado = $query->fetch(PDO::FETCH_OBJ);
    
                if (!$resultado) {
                    return 'No se encontró la tienda con el ID especificado.';
                }
    
                $fecha_vencimiento_actual = $resultado->fecha_vencimiento;
    
                // Comprobar si la fecha de vencimiento ya pasó o no
                if (strtotime($fecha_vencimiento_actual) > time()) {
                    // Si el pago es antes de la fecha de vencimiento, se suma un mes a la fecha de vencimiento actual
                    $fecha_nueva_de_vencimiento = date('Y-m-d H:i:s', strtotime($fecha_vencimiento_actual . ' +1 month'));
                } else {
                    // Si la fecha de vencimiento ya pasó, se suma un mes a partir de hoy
                    $fecha_nueva_de_vencimiento = date('Y-m-d H:i:s', strtotime('+1 month'));
                }
    
                // Actualizar la fecha de vencimiento en la base de datos
                $query = $this->db->prepare('UPDATE tiendas SET fecha_vencimiento = ? WHERE id_tienda = ?');
                $success = $query->execute([$fecha_nueva_de_vencimiento, $id_tienda]);
    
                if (!$success) {
                    return 'Error al actualizar la fecha de vencimiento de la tienda.';
                }
            }
    
            // Si todo salió bien, retornar éxito
            return true;
    
        } catch (PDOException $e) {
            // Captura errores de la base de datos
            return 'Error de base de datos: ' . $e->getMessage();
        } catch (Exception $e) {
            // Captura otros errores
            return 'Error inesperado: ' . $e->getMessage();
        }
    }
    
    


    function addCodigo($codigo, $id_plantilla){
        $query = $this->db->prepare('INSERT INTO codigos_creacion_tienda (codigo ,id_plantilla) VALUES (?,?)');
        $query->execute([
                        $codigo,
                        $id_plantilla,
                        ]);
    }



    function eliminarProductosPorTienda($id_tienda){
        // Consulta SQL para eliminar productos asociados a la tienda
        $query = $this->db->prepare("DELETE FROM productos WHERE id_tienda = ?");
        $query->execute([$id_tienda]);
    
        // Verificar si la consulta fue exitosa
        if ($query->rowCount() > 0) {
            // Si se eliminaron productos
            return true;
        } else {
            // Si no se eliminaron productos, pero no hay error
            return true;  // Puedes retornar true también si no hay productos, ya que la eliminación de la tienda puede continuar sin problemas
        }
    }




    function eliminarCarritosPorTienda($id_tienda){
        // Consulta SQL para eliminar productos asociados a la tienda
        $query = $this->db->prepare("DELETE FROM productos WHERE id_tienda = ?");
        $query->execute([$id_tienda]);
    
        // Verificar si la consulta fue exitosa
        if ($query->rowCount() > 0) {
            // Si se eliminaron productos
            return true;
        } else {
            // Si no se eliminaron productos, pero no hay error
            return true;  // Puedes retornar true también si no hay productos, ya que la eliminación de la tienda puede continuar sin problemas
        }
    }


    
    function eliminarTienda($id_tienda){
        // Consulta SQL para eliminar la tienda
        $query = $this->db->prepare("DELETE FROM tiendas WHERE id_tienda = ?");
        $query->execute([$id_tienda]);
    
        // Verificar si la tienda fue eliminada
        if ($query->rowCount() > 0) {
            return true;
        } else {
            return false;
        }
    }
    

    function actualizarVendedorTienda($id_tienda) {
        // Obtener el id_usuario de la tienda
        $query = $this->db->prepare("SELECT id_usuario FROM tiendas WHERE id_tienda = ?");
        $query->execute([$id_tienda]);
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // **DEBUG**: Mostrar resultado de la consulta
       
        if (!$result) {
            die('Error: No se encontró la tienda o el id_usuario.');
        }
    
        $id_usuario = $result->id_usuario;

    
        // Actualizar el campo 'vendedor' en la tabla usuarios
        $updateQuery = $this->db->prepare("UPDATE usuarios SET vendedor = 0 WHERE id = ?");
        $updateQuery->execute([$id_usuario]);
    
   
    
        if ($updateQuery->rowCount() > 0) {
            $_SESSION['VENDEDOR'] = 0;
            return true;
        } else {
            die('Error: No se pudo actualizar el campo "vendedor".');
        }
    }
    


    public function cambiarContrasena($new_password) {
        // Obtén el ID del usuario de la sesión
        $user_id = $_SESSION['ID_USER'];
    
        // Hashea la nueva contraseña
        $passhash = password_hash($new_password, PASSWORD_DEFAULT);
    
        // Consulta SQL para actualizar la contraseña
        $updateQuery = $this->db->prepare('UPDATE usuarios SET pass = ? WHERE id = ?');
        
        // Ejecutar la consulta con los parámetros correspondientes
        $success = $updateQuery->execute([$passhash, $user_id]);
    
        // Verificar si la consulta fue exitosa
        if ($success) {
            return true; // La contraseña fue cambiada exitosamente
        } else {
            return false; // Hubo un error al cambiar la contraseña
        }
    }
    
    

    function VerifyOldPassword($old_pass) {
        // Obtener el ID del usuario de la sesión
        $user_id = $_SESSION['ID_USER'];
    
        // Preparar la consulta usando PDO
        $query = $this->db->prepare("SELECT pass FROM usuarios WHERE id = :id");
        
        // Ejecutar la consulta con el ID del usuario como parámetro
        $query->execute([':id' => $user_id]);
    
        // Obtener el resultado de la consulta
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // Verificar si se encontró un usuario
        if ($result) {
            // Verificar si la contraseña proporcionada coincide con la almacenada (hasheada)
            if (password_verify($old_pass, $result->pass)) {
                return true;  // Contraseña correcta
            } else {
                return false;  // Contraseña incorrecta
            }
        } else {
            return false;  // No se encontró el usuario
        }
    }
    
    
    function guardarlistaenvios($data) {
        $id_tienda = $data['id_tienda'];
        $lista_envios_json = json_encode($data);
    
        // Usamos PDO en este ejemplo, adaptá si usás MySQLi
        $sql = "UPDATE tiendas SET lista_envios = :lista_envios WHERE id_tienda = :id_tienda";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':lista_envios', $lista_envios_json);
        $stmt->bindParam(':id_tienda', $id_tienda, PDO::PARAM_INT);
    
        if ($stmt->execute()) {
            return ['success' => true];
        } else {
            return ['success' => false, 'error' => $stmt->errorInfo()];
        }
    }
    
    public function updateContactInformation($contactInfo, $id_tienda) {
        $contactJson = json_encode($contactInfo, JSON_UNESCAPED_UNICODE);
    
        $sql = "UPDATE tiendas SET medios_de_contacto = :medios WHERE id_tienda = :id";
        $stmt = $this->db->prepare($sql);
    
        return $stmt->execute([
            ':medios' => $contactJson,
            ':id' => $id_tienda
        ]);
    }
    
    
    

}