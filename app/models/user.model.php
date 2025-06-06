<?php

    include_once 'app/models/index.model.php';

    class UserModel {
    
    private $db;
    
    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }
    

    /**
     * Devuelve un usuario dado un nombre de usuario.
     */
    public function getUser($user) {
        $query = $this->db->prepare(
            'SELECT u.*, t.id_plantilla 
             FROM usuarios u
             LEFT JOIN tiendas t ON u.id = t.id_usuario
             WHERE u.usuario = ?'
        );
        $query->execute([$user]);
        $usuario = $query->fetch(PDO::FETCH_OBJ);
    
        // Si no se encuentra el usuario, devuelve null
        if (!$usuario) {
            return null;
        }
    
        if ($usuario->id_plantilla) {
            $query = $this->db->prepare(
                'SELECT grupo FROM tipos_plantillas WHERE id_tipo_plantilla = ?'
            );
            $query->execute([$usuario->id_plantilla]);
            $plantilla = $query->fetch(PDO::FETCH_OBJ);
    
            if ($plantilla) {
                $usuario->grupo = $plantilla->grupo;
            } else {
                $usuario->grupo = null;
            }
        } else {
            $usuario->grupo = null;
        }
    
        return $usuario;
    }
    
    
    
    
    // devuelve el nombre de usuario segun el id
    public function getName($id) {
        $query = $this->db->prepare('SELECT usuario FROM usuarios WHERE id = ?');
        $query->execute([$id]);
        return $query->fetch(PDO::FETCH_OBJ);
    }
    //devuelve un usuario por el email
    public function getEmail($email) {
        $query = $this->db->prepare('SELECT * FROM usuarios WHERE email = ?');
        $query->execute([$email]);
        return $query->fetch(PDO::FETCH_OBJ);
    }
    //inserta un usuario
    public function insert($username, $passhash, $email, $telefono) {
        try {
            // Configurar PDO para lanzar excepciones en caso de error
            $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
            // Preparar y ejecutar la consulta
            $query = $this->db->prepare('INSERT INTO `usuarios` (usuario, email, pass,  telefono) VALUES (?, ?, ?, ?)');
            $query->execute([$username, $email, $passhash,  $telefono]);
      
            // Retornar el ID del último registro insertado
            return $this->db->lastInsertId();
        } catch (PDOException $e) {
            // Manejo de errores: Mostrar el mensaje para depuración
            echo "Error al insertar usuario: " . $e->getMessage();
      
            return false;
        }
    }
    
    //obtiene todos los usuarios
    public function GetAll(){
        $query = $this->db->prepare('SELECT * FROM usuarios');
        $query->execute();
        $users = $query->fetchAll(PDO::FETCH_OBJ); 
        return $users;
    }
    //actualiza los permisos
    public function UpdatePermiso($id,$permiso){
        $query = $this->db->prepare("UPDATE usuarios SET permiso = ? WHERE id = ?");
        $query->execute([$permiso,$id]);
    }
    
    function deleteUser($id){
        // funcion para borrar una Usuario en la base de datos
        $query = $this->db->prepare('DELETE FROM usuarios WHERE id = ?');
        $succes=$query->execute([$id]);
        return $succes;
    }


    function verifyUniqueShopName($nombreUnico) {
        // Prepara la consulta para verificar si el nombre ya existe en la tabla 'tiendas'
        $query = $this->db->prepare('SELECT COUNT(*) as count FROM tiendas WHERE nombre_unico = :nombreUnico');
        
        // Asocia el parámetro para evitar inyección SQL
        $query->bindParam(':nombreUnico', $nombreUnico, PDO::PARAM_STR);
        
        // Ejecuta la consulta
        $query->execute();
    
        // Obtiene el resultado
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // Retorna true si no existe el nombre, false si ya existe
        return $result->count == 0;
    }
    
    function addNewShop($nombreUnico, $nombreTienda, $id_plantilla, $codigo) {
        $valor = isset($valor) ? trim($valor) : '';
         try {
            $id_user = $_SESSION['ID_USER'];
            
            // Verificar si se proporcionó un código
            if ($codigo != null) {
                // Buscar el id_plantilla asociado al código
                $query = $this->db->prepare('
                    SELECT id_plantilla 
                    FROM codigos_creacion_tienda 
                    WHERE codigo = ? AND usado != 1
                ');
                $query->execute([$codigo]);
                $codigoData = $query->fetch(PDO::FETCH_ASSOC);
               
                // Si existe un código válido, usar su id_plantilla
                if ($codigoData) {
                    $id_plantilla = $codigoData['id_plantilla'];
                    $_SESSION['PLANTILLA'] =  $id_plantilla;

                    // Marcar el código como usado
                    $query = $this->db->prepare('
                        DELETE FROM codigos_creacion_tienda 
                        WHERE codigo = ?
                    ');
                    $query->execute([$codigo]);

                         // Obtener la fecha actual y sumarle 200 años
                    $fechaVencimiento = new DateTime();
                    $fechaVencimiento->modify('+200 years');
                    $fechaVencimiento = $fechaVencimiento->format('Y-m-d'); // Formato 'AAAA-MM-DD'
            
                  
                } else {
                    throw new Exception("El código proporcionado no es válido o ya fue utilizado.");
                }
            }
       
         // Obtener la fecha actual y sumarle 1 semana
         $fechaVencimiento = (new DateTime())->modify('+2 months')->format('Y-m-d H:i:s');

        // Insertar en la tabla tiendas
        $queryInsert = $this->db->prepare('
            INSERT INTO tiendas (id_plantilla, id_usuario, nombre_unico, nombre_simple, fecha_vencimiento) 
            VALUES (?, ?, ?, ?, ?)
        ');
        $queryInsert->execute([$id_plantilla, $id_user, $nombreUnico, $nombreTienda, $fechaVencimiento]);


            $queryGrupo = $this->db->prepare('
            SELECT grupo 
            FROM tipos_plantillas 
            WHERE id_tipo_plantilla = ?
                ');
                $queryGrupo->execute([$id_plantilla]);
                $grupoData = $queryGrupo->fetch(PDO::FETCH_ASSOC);

                // Si existe un grupo válido, asignarlo a la sesión
                if ($grupoData) {
                    $grupo = $grupoData['grupo'];
                    $_SESSION['GRUPO'] = $grupo;
                }


            // Verificar si la inserción fue exitosa
            if ($queryInsert->rowCount() > 0) {
                // Actualizar el usuario como vendedor
                $queryUpdate = $this->db->prepare('
                    UPDATE usuarios 
                    SET vendedor = ?
                    WHERE id = ?
                ');
                $queryUpdate->execute([1, $id_user]);
                $_SESSION['VENDEDOR'] = 1;
                
                return true; // Insertado con éxito
            } else {
                throw new Exception("No se pudo insertar el registro en la tabla tiendas.");
            }
        } catch (Exception $e) {
            // Manejo de errores al insertar
            throw new Exception("Error al insertar en la base de datos: " . $e->getMessage());
        }
    }
    
    
    


    public function getCompras() {
        $idUser = $_SESSION['ID_USER'];
        $query = $this->db->prepare('SELECT * FROM compras WHERE id_usuario = ? ORDER BY id_compra DESC');
        $query->execute([$idUser]);
        $compras = $query->fetchAll(PDO::FETCH_OBJ);
    
        // Obtener detalles de productos para cada compra
        foreach ($compras as $compra) {
            $productos = json_decode($compra->productos, true);
            $id_tienda = json_decode($compra->id_tienda, true);

            $query = $this->db->prepare('SELECT nombre_simple, logo, color, color_texto FROM tiendas WHERE id_tienda = ?');
            $query->execute([$id_tienda]);
            $resultado = $query->fetch(PDO::FETCH_OBJ); // Solo uno

            if ($resultado) {
                $compra->nombreTienda = $resultado->nombre_simple;
                $compra->logoTienda = $resultado->logo;
                $compra->color = $resultado->color;
                $compra->color_texto = $resultado->color_texto;
            } else {
                $compra->nombreTienda = null; // o algún valor por defecto
                $compra->logoTienda = null;
                $compra->nombreTienda = null;
                $compra->logoTienda =null;
            }

            // Verificar si $productos es un array válido
            if (!is_array($productos) || empty($productos)) {
                $compra->productos = []; // Evita errores posteriores
                $compra->total = 0; // Asegura que al menos tenga un total
                continue; // Saltar a la siguiente compra
            }
            
            $productIds = array_column($productos, 0); // Obtener solo los IDs de productos
    
            $productDetails = $this->getProductDetails($productIds);
            $productDetailsMap = [];
            foreach ($productDetails as $product) {
                $productDetailsMap[$product['id_producto']] = $product;
            }
    
            $detailedProductos = [];
            $totalCompra = 0; // Variable para acumular el total de la compra
    
            foreach ($productos as $producto) {
                $id = $producto[0];        // ID del producto
                $quantity = $producto[1];  // Cantidad del producto
                $compra->shopName = $producto[2]; // Nombre de la tienda
                $precioProducto = floatval($producto[3]); // Precio del producto desde el array de productos (último valor)
    
                if (isset($productDetailsMap[$id])) {
                    $productDetail = $productDetailsMap[$id];
                    $productDetail['precio'] = $precioProducto; // Sobrescribir el precio con el precio del array productos
                    $subtotal = $quantity * $productDetail['precio']; // Calcular subtotal
                    $totalCompra += $subtotal; // Acumular en el total de la compra
                    $detailedProductos[] = array_merge($productDetail, ['quantity' => $quantity, 'subtotal' => $subtotal]);
                }
            }
            // Agregar el costo de envío al total de la compra
            $costoEnvio = floatval($compra->costo_envio);
            $compra->total = $totalCompra + $costoEnvio; // Sumar el costo de envío al total de la compra
            $compra->productos = $detailedProductos;




        }
    
        return $compras;
    }
    
    
    

    public function getContactByShopId($id_tienda) {
        $query = $this->db->prepare('
            SELECT medios_de_contacto, ubicacion
            FROM tiendas 
            WHERE id_tienda = ?
        ');
        $query->execute([$id_tienda]);
        $row = $query->fetch(PDO::FETCH_OBJ);
    
        if ($row && $row->medios_de_contacto) {
            $contacto = json_decode($row->medios_de_contacto); // email, telefono, etc.
            $contacto->ubicacion = $row->ubicacion; // agregamos la ubicación al objeto
            return $contacto;
        }
    
        return null;
    }
    
    
    
    



    public function getPedidos($search, $estado, $limit, $offset, $idtienda) {
        $sql = 'SELECT c.*, u.usuario 
                FROM compras c 
                LEFT JOIN usuarios u ON c.id_usuario = u.id 
                WHERE 1=1';
    
        // Aplicar filtros
        if (!empty($search)) {
            $sql .= ' AND (c.codigo_compra LIKE :search OR u.usuario LIKE :search)';
        }
        if (!empty($estado)) {
            $sql .= ' AND c.estado = :estado';
        }
        // Filtrar por id_tienda
        if (!empty($idtienda)) {
            $sql .= ' AND c.id_tienda = :id_tienda';
        }
    
        $sql .= ' LIMIT :limit OFFSET :offset';
    
        $query = $this->db->prepare($sql);
        
        // Bind de parámetros
        if (!empty($search)) {
            $query->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
        }
        if (!empty($estado)) {
            $query->bindValue(':estado', $estado, PDO::PARAM_INT);
        }
        if (!empty($idtienda)) {
            $query->bindValue(':id_tienda', $idtienda, PDO::PARAM_INT);
        }
        $query->bindValue(':limit', (int)$limit, PDO::PARAM_INT);
        $query->bindValue(':offset', (int)$offset, PDO::PARAM_INT);
    
        $query->execute();
        $pedidos = $query->fetchAll(PDO::FETCH_OBJ);
    
        // Calcular el monto total para cada pedido
        foreach ($pedidos as $pedido) {
            $productos = json_decode($pedido->productos);
            $total_monto = 0;
    
            // Para cada producto, obtener el precio y calcular el monto
            foreach ($productos as $producto) {
                $id_producto = $producto[0];
                $cantidad = $producto[1];
    
                // Obtener el precio del producto desde la tabla productos
                $precio_query = $this->db->prepare('SELECT precio FROM productos WHERE id_producto = :id_producto');
                $precio_query->bindValue(':id_producto', $id_producto, PDO::PARAM_INT);
                $precio_query->execute();
                $producto_info = $precio_query->fetch(PDO::FETCH_OBJ);
    
                if ($producto_info) {
                    // Sumar el monto del producto al total
                    $total_monto += $producto_info->precio * $cantidad;
                }
            }
    
            // Asignar el monto total al pedido
            $pedido->total_monto = $total_monto +  $pedido->costo_envio;
        }
    
        return $pedidos;
    }
    
    
    
    public function getAllPedidos() {
        $sql = 'SELECT * FROM compras'; // Aquí agregué el punto y coma al final de la cadena SQL
        
        $query = $this->db->prepare($sql);
        $query->execute();
        return $query->fetchAll(PDO::FETCH_OBJ);
    }
    
    
    
    public function countPedidos($search, $estado, $idTienda) {
        $sql = 'SELECT COUNT(*) as total 
                FROM compras c 
                LEFT JOIN usuarios u ON c.id_usuario = u.id 
                WHERE 1=1';
        
        // Aplicar filtros
        if (!empty($search)) {
            $sql .= ' AND (c.codigo_compra LIKE :search OR u.usuario LIKE :search)';
        }
        if (!empty($estado)) {
            $sql .= ' AND c.estado = :estado';
        }
        // Filtrar por id_tienda
        if (!empty($idTienda)) {
            $sql .= ' AND c.id_tienda = :id_tienda';
        }
    
        $query = $this->db->prepare($sql);
        
        // Bind de parámetros
        if (!empty($search)) {
            $query->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
        }
        if (!empty($estado)) {
            $query->bindValue(':estado', $estado, PDO::PARAM_INT);
        }
        if (!empty($idTienda)) {
            $query->bindValue(':id_tienda', $idTienda, PDO::PARAM_INT);
        }
    
        $query->execute();
        $result = $query->fetch(PDO::FETCH_OBJ);
        return $result ? $result->total : 0;
    }
    

    
    
    
   
    

    
    


    function getPedidoById($id){ //Admin
        $query = $this->db->prepare('SELECT * FROM compras WHERE id_compra = ?');
        $query->execute([$id]);
        return $query->fetch(PDO::FETCH_OBJ);
    }
    
    function getUserById($id){
        $query = $this->db->prepare('SELECT * FROM usuarios WHERE id = ?');
        $query->execute([$id]);
        return $query->fetch(PDO::FETCH_OBJ);
    }





    public function getCarritoByUser($idUser) {
        $query = $this->db->prepare('SELECT productos FROM carritos WHERE id_usuario = ?');
        $query->execute([$idUser]);
        $result = $query->fetch();
        return $result ? json_decode($result['productos'], true) : [];
    }

    // Recupera los detalles de los productos
    public function getProductDetails($productIds) {
        if (empty($productIds)) {
            return []; // Devuelve un array vacío si no hay productos
        }
        $placeholders = implode(',', array_fill(0, count($productIds), '?'));
        $query = $this->db->prepare("SELECT *
                                     FROM productos 
                                     WHERE id_producto IN ($placeholders)");
        $query->execute($productIds);
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }

    // Recupera el carrito con los detalles de los productos
    public function getCarritosWithProductDetails($idUser) {
        $query = $this->db->prepare('SELECT id_carrito, id_tienda, conceptos FROM carritos WHERE id_usuario = ?');
        $query->execute([$idUser]);
        $results = $query->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$results) return [];
    
        $allCarts = [];
    
        foreach ($results as $result) {
            $cartProducts = json_decode($result['conceptos'], true);
            if (!$cartProducts) continue;
    
            $productIds = array_column($cartProducts, 0);
            $productDetails = $this->getProductDetails($productIds);
            $productDetailsMap = [];
    
            foreach ($productDetails as $product) {
                $productDetailsMap[$product['id_producto']] = $product;
            }
    
            $detailedCart = [];
            $totalPeso = 0;
            $haySinStock = false;
            
            foreach ($cartProducts as $product) {
                $id = $product[0];
                $quantity = $product[1];
                $shop = $product[2];
    
                if (isset($productDetailsMap[$id])) {
                    $detalle = $productDetailsMap[$id];
                    $stockDisponible = $detalle['stock'];
                    $sinLimite = $detalle['sin_limite'];
    
                    $peso = floatval($detalle['peso']) * intval($quantity);
                    $totalPeso += $peso;
    
                    $item = array_merge($detalle, [
                        'quantity' => $quantity,
                        'shopname' => $shop,
                        'sin_stock' => false
                    ]);
    
                    if (!($sinLimite == 1 || $stockDisponible >= $quantity)) {
                        $item['sin_stock'] = true;
                        $haySinStock = true;
                    }
    
                    $detailedCart[] = $item;
                }
            }
           
            // Obtener info de la tienda (nombre + lista_envios)
            $storeQuery = $this->db->prepare('SELECT nombre_simple,nombre_unico, lista_envios, logo, color, color_texto FROM tiendas WHERE id_tienda = ?');
            $storeQuery->execute([$result['id_tienda']]);
            $store = $storeQuery->fetch(PDO::FETCH_ASSOC);
    
            $storeName = $store ? $store['nombre_simple'] : 'Tienda desconocida';
            $costoEnvio = 0;
            $logo = $store['logo'];
        $color = $store['color'];
            $color_texto = $store['color_texto'];
  $nombre_unico = $store['nombre_unico'];
            if ($store && $store['lista_envios']) {
                $configEnvios = json_decode($store['lista_envios'], true);
    
                if ($configEnvios['precioFijoActivado']) {
                    $costoEnvio = floatval($configEnvios['precioEnvio']);
                    
                } else if (isset($configEnvios['costosEnvio'])) {
                    foreach ($configEnvios['costosEnvio'] as $rango) {
                        
                        if (isset($rango['rangoPeso'], $rango['costoEnvio'])) {
                            $rangoStr = trim($rango['rangoPeso']);
                            $partes = preg_split('/\s*-\s*/', $rangoStr);
                            
                            if (count($partes) === 2) {
                                $min = floatval($partes[0]);
                                $max = floatval($partes[1]);
                               
                                if ($totalPeso >= $min && $totalPeso <= $max) {
                                    $costoEnvio = floatval($rango['costoEnvio']);
                                    break;
                                }
                            }
                        }
                    }
                }
            }
    
            $allCarts[] = [
                'id_carrito' => $result['id_carrito'],
                'store_name' => $storeName,
                'nombre_unico' => $nombre_unico,
                'id_tienda' => $result['id_tienda'],
                'items' => $detailedCart,
                'hay_sin_stock' => $haySinStock,
                'peso_total' => $totalPeso,
                'costo_envio' => $costoEnvio,
                'color' => $color,
                'color_texto' => $color_texto,
                'logo' =>  $logo
            ];
        }
    
        return $allCarts;
    }
    
    
    
    
    


    public function getCarritoInfo($id_carrito) {
        // Consulta para obtener el carrito específico
        $query = $this->db->prepare('SELECT id_carrito, id_tienda, conceptos FROM carritos WHERE id_carrito = ?');
        $query->execute([$id_carrito]);
        $result = $query->fetch(PDO::FETCH_ASSOC); // Recupera el carrito específico
    
        if (!$result) {
            return null; // Si no se encuentra el carrito, devuelve null
        }
    
        $cartProducts = json_decode($result['conceptos'], true);
        if (!$cartProducts) {
            return null; // Si no se encuentran productos, devuelve null
        }
    
        $productIds = array_column($cartProducts, 0); // Extrae todos los ID de productos
        $productDetails = $this->getProductDetails($productIds); // Función para obtener detalles de los productos
        $productDetailsMap = [];
        
        // Mapa para asociar ID de producto con sus detalles
        foreach ($productDetails as $product) {
            $productDetailsMap[$product['id_producto']] = $product;
        }
    
        $detailedCart = [];
        $outOfStock = []; // Array para productos sin stock suficiente
    
        foreach ($cartProducts as $product) {
            $id = $product[0];
            $quantity = $product[1];
            $shop = $product[2]; // Nombre único de la tienda
        
            if (isset($productDetailsMap[$id])) {
                // Obtener el stock actual y la propiedad sin_limite del producto
                $stockQuery = $this->db->prepare('SELECT stock, sin_limite FROM productos WHERE id_producto = ?');
                $stockQuery->execute([$id]);
                $productData = $stockQuery->fetch(PDO::FETCH_ASSOC);
        
                $stock = $productData['stock'];
                $sinLimite = $productData['sin_limite'];
        
                // Si sin_limite es 0 y el stock es insuficiente, agregar a la lista de outOfStock
                if ($sinLimite != 1 && ($stock === false || $stock < $quantity)) {
                    $outOfStock[] = $id;
                }
        
                $detailedCart[] = array_merge($productDetailsMap[$id], [
                    'quantity' => $quantity,
                    'shopname' => $shop
                ]);
            }
        }
        
    
        // Obtener el nombre de la tienda a partir de id_tienda
        $storeQuery = $this->db->prepare('SELECT nombre_simple, logo, color, color_texto, id_usuario FROM tiendas WHERE id_tienda = ?');
        $storeQuery->execute([$result['id_tienda']]);
        $store = $storeQuery->fetch(PDO::FETCH_ASSOC);
        $storeName = $store ? $store['nombre_simple'] : 'Tienda desconocida'; // Nombre por defecto si no encuentra la tienda
        $logo = isset($store['logo']) ? $store['logo'] : '';
          $id_usuario = isset($store['id_usuario']) ? $store['id_usuario'] : '';
        $color = isset($store['color']) ? $store['color'] : '#000000';
        $color_texto = isset($store['color_texto']) ? $store['color_texto'] : '#ffffff';
        // Devuelve los detalles del carrito
       
       
       
       
       
        return [
            'id_usuario' => $id_usuario,
            'logo' => $logo,
            'color' =>  $color,
            'color_texto' =>  $color_texto,
            'id_carrito' => $result['id_carrito'],
            'store_name' => $storeName,
            'id_tienda' => $result['id_tienda'],
            'items' => $detailedCart,
            'sin_stock' => $outOfStock // Lista de productos sin stock suficiente
        ];
    }
    
    public function calcularCostoEnvio($idTienda, $items) {
        // Calcular el peso total de los productos en el carrito
        $totalPeso = 0;
        foreach ($items as $item) {
            $totalPeso += floatval($item['peso']) * intval($item['quantity']);
        }
    
        // Obtener la información de envíos de la tienda
        $storeQuery = $this->db->prepare('SELECT lista_envios FROM tiendas WHERE id_tienda = ?');
        $storeQuery->execute([$idTienda]);
        $store = $storeQuery->fetch(PDO::FETCH_ASSOC);
        $costoEnvio = 0;
    
        if ($store && $store['lista_envios']) {
            $configEnvios = json_decode($store['lista_envios'], true);
    
            // Si tiene un precio fijo activado
            if ($configEnvios['precioFijoActivado']) {
                $costoEnvio = floatval($configEnvios['precioEnvio']);
            } 
            // Si no tiene precio fijo, calculamos el costo por el peso
            else if (isset($configEnvios['costosEnvio'])) {
                foreach ($configEnvios['costosEnvio'] as $rango) {
                    if (isset($rango['rangoPeso'], $rango['costoEnvio'])) {
                        list($min, $max) = array_map('floatval', preg_split('/\s*-\s*/', $rango['rangoPeso']));
                        if ($totalPeso >= $min && $totalPeso <= $max) {
                            $costoEnvio = floatval($rango['costoEnvio']);
                            break;
                        }
                    }
                }
            }
        }
    
        return $costoEnvio;
    }
    


    public function getProfileInfo($idUser) {
        // Información del usuario
        $query = $this->db->prepare('SELECT * FROM usuarios WHERE id = ?');
        $query->execute([$idUser]);
        $usuario = $query->fetch(PDO::FETCH_ASSOC);
    
        // Información de la tienda (puede no existir)
        $query = $this->db->prepare('SELECT * FROM tiendas WHERE id_usuario = ?');
        $query->execute([$idUser]);
        $tienda = $query->fetch(PDO::FETCH_ASSOC);
        $id_tienda = $tienda['id_tienda'] ?? null;
        // Verificar si existe una tienda y obtener la plantilla
        $plantilla = null;
        $colores = null;
        $atributos = null;
        $descripcion = null;
        if (isset($tienda['id_plantilla']) && (int)$tienda['id_plantilla'] > 0) {
            $query = $this->db->prepare('SELECT colores, atributos, descripcion FROM tipos_plantillas WHERE id_tipo_plantilla = ? AND seleccionable = ?');
            $query->execute([(int)$tienda['id_plantilla'], 1]);
            $plantillaData = $query->fetch(PDO::FETCH_ASSOC);
            
            if ($plantillaData) {
                $descripcion = $plantillaData['descripcion'];
                $colores = $plantillaData['colores'];
                $atributos = explode(',', $plantillaData['atributos']);
            }
        }
    
        // Obtener todos los tipos de plantillas
        $query = $this->db->prepare('SELECT * FROM tipos_plantillas WHERE seleccionable = ?');
        $query->execute([1]);
        $tipos_plantillas = $query->fetchAll(PDO::FETCH_ASSOC);
    
        // Obtener estadísticas de compras
        $compras = [
            'hoy' => 0,
            'semana' => 0,
            'total' => 0
        ];
    
        // Compras de hoy
        $query = $this->db->prepare("SELECT COUNT(*) FROM compras WHERE id_tienda = ? AND DATE(fecha) = CURDATE()");
        $query->execute([$id_tienda]);
        $compras['hoy'] = (int)$query->fetchColumn();
    
        // Compras de esta semana (desde lunes)
        $query = $this->db->prepare("SELECT COUNT(*) FROM compras WHERE id_tienda = ? AND YEARWEEK(fecha, 1) = YEARWEEK(CURDATE(), 1)");
        $query->execute([$id_tienda]);
        $compras['semana'] = (int)$query->fetchColumn();
    
        // Compras totales
        $query = $this->db->prepare("SELECT COUNT(*) FROM compras WHERE id_tienda = ?");
        $query->execute([$id_tienda]);
        $compras['total'] = (int)$query->fetchColumn();
    
        // Devolver toda la información
        return [
            'usuario' => $usuario,
            'tienda' => $tienda,
            'plantilla' => $plantilla,
            'descripcion' => $descripcion,
            'colores' => $colores,
            'atributos' => $atributos,
            'tipos_plantillas' => $tipos_plantillas,
            'compras' => $compras
        ];
    }
    
    
    

    function getPagos($id_user) {
        try {

    
            // Obtener id_plantilla de la tienda
            $query = $this->db->prepare('SELECT id_plantilla,id_tienda, fecha_vencimiento FROM tiendas WHERE id_usuario = :id_usuario');
            $query->bindParam(':id_usuario', $id_user, PDO::PARAM_INT);
            $query->execute();
            $tienda = $query->fetch(PDO::FETCH_ASSOC);
            
            if (!$tienda) {
                return ['error' => 'Tienda no encontrada'];
            }
    
            $id_plantilla = $tienda['id_plantilla'];
            $id_tienda = $tienda['id_tienda'];
            $fecha_vencimiento = $tienda['fecha_vencimiento'];

            // Obtener el precio de la plantilla
            $query = $this->db->prepare('SELECT precio FROM tipos_plantillas WHERE id_tipo_plantilla = :id_plantilla');
            $query->bindParam(':id_plantilla', $id_plantilla, PDO::PARAM_INT);
            $query->execute();
            $plantilla = $query->fetch(PDO::FETCH_ASSOC);
            if (!$plantilla) {
                return ['error' => 'Plantilla no encontrada'];
            }
    
            $precio_plantilla = $plantilla['precio'];
           

            // Obtener los pagos ordenados por fecha
            $query = $this->db->prepare('SELECT fecha, monto, pago FROM pagos_usuarios WHERE id_tienda = :id_tienda ORDER BY fecha ASC');
            $query->bindParam(':id_tienda', $id_tienda, PDO::PARAM_INT);
            $query->execute();
            $pagos = $query->fetchAll(PDO::FETCH_ASSOC);
    
            // Retornar toda la información
            return [
                'fecha_vencimiento' => $fecha_vencimiento,
                'id_user' => $id_user,
                'id_tienda' => $id_tienda,
                'id_plantilla' => $id_plantilla,
                'precio_plantilla' => $precio_plantilla,
                'pagos' => $pagos
            ];
        } catch (PDOException $e) {
            return ['error' => 'Error en la consulta: ' . $e->getMessage()];
        }
    }
    






    function saveCypherInformation($informacion) {
        var_dump($informacion); // Verifica los datos que recibe la función
    
        try {
            // Extraer valores del array
            $id_empresa = $informacion["id_empresa"];
            $nombre_gestion = $informacion["nombre_gestion"];
            $id_usuario = $informacion["id_usuario"];
            $endpoint = $informacion["endpoint"];

            // Preparar la consulta correctamente
            $query = $this->db->prepare("UPDATE usuarios SET id_empresa_gestion = ?, nombre_gestion = ?, endpoint_cypher = ?  WHERE id = ?");
            
            // Ejecutar la consulta con los valores correctos
            $success = $query->execute([$id_empresa, $nombre_gestion, $endpoint, $id_usuario]);
    
            // Retornar true si la consulta se ejecutó correctamente
            return $success;
        } catch (Exception $e) {
            // Registrar el error (puedes guardarlo en un log si es necesario)
            error_log("Error en saveCypherInformation: " . $e->getMessage());
            return false;
        }
    }
    
    function changeplantoCypher($informacion) {
    
        try {

            $id_usuario = $informacion["id_usuario"];
 

            // Preparar la consulta correctamente
            $query = $this->db->prepare("UPDATE tiendas SET id_plantilla = 2 WHERE id_usuario  = ?");
            
            // Ejecutar la consulta con los valores correctos
            $success = $query->execute([ $id_usuario]);
    
            // Retornar true si la consulta se ejecutó correctamente
            return $success;
        } catch (Exception $e) {
            // Registrar el error (puedes guardarlo en un log si es necesario)
            error_log("Error en changeplantoCypher: " . $e->getMessage());
            return false;
        }
    }
    


    public function isShopConected($id_user) {
        // Preparar la consulta para verificar el id_empresa_gestion
        $query = $this->db->prepare("SELECT id_empresa_gestion FROM usuarios WHERE id = ?");
        $query->execute([$id_user]);
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // Verificar si tiene un número en id_empresa_gestion
        if ($result && !empty($result->id_empresa_gestion)) {
            return true;
        } else {
            return false;
        }
    }
    



    public function getEndpoint($id_user) {
        // Preparar la consulta para obtener el endpoint_cypher
        $query = $this->db->prepare("SELECT endpoint_cypher FROM usuarios WHERE id = ?");
        $query->execute([$id_user]);
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // Retornar endpoint_cypher si existe, de lo contrario retornar false
        return $result ? $result->endpoint_cypher : false;
    }
    

    
    public function getIdEmpresa($id_user) {
        // Preparar la consulta para obtener el endpoint_cypher
        $query = $this->db->prepare("SELECT id_empresa_gestion FROM usuarios WHERE id = ?");
        $query->execute([$id_user]);
        $result = $query->fetch(PDO::FETCH_OBJ);
    
        // Retornar endpoint_cypher si existe, de lo contrario retornar false
        return $result ? $result->id_empresa_gestion : false;
    }



    public function saveProfileInfo($info){
        $id_user = $_SESSION['ID_USER'];
    
        // Actualizar datos en la tabla usuarios
        $query = $this->db->prepare("UPDATE usuarios 
                                    SET usuario = ?, 
                                        email = ?, 
                                        telefono = ? 
                                    WHERE id = ?");
        $success = $query->execute([
            $info['nombreCuenta'], 
            $info['emailCuenta'], 
            $info['telefonoCuenta'], 
            $id_user
        ]);
    
        // Verificación del éxito de la primera consulta
        if(!$success){
            return false;
        }
    
        // Actualizar datos en la tabla tiendas solo si alias y cbu existen
        if (!empty($info['aliasTienda']) || !empty($info['cbuTienda'])) {
            $query = $this->db->prepare("UPDATE tiendas 
                                        SET alias = ?, 
                                            cbu = ? 
                                        WHERE id_usuario = ?");
            $success = $query->execute([
                $info['aliasTienda'], 
                $info['cbuTienda'], 
                $id_user
            ]);
        }
    
        return $success;
    }
    
    
   public function saveShopInfo($info){
    $id_user = $_SESSION['ID_USER'];
    $success = false;


    // Solo actualizar si las claves existen (aunque estén vacías)
    if (isset($info['aliasTienda']) && isset($info['cbuTienda'])) {
        $query = $this->db->prepare("UPDATE tiendas 
                                    SET alias = ?, 
                                        cbu = ? 
                                    WHERE id_usuario = ?");
        $success = $query->execute([
            $info['aliasTienda'], 
            $info['cbuTienda'], 
            $id_user
        ]);
    }

    return $success;
}


    function getUsuarios(){
        $query = $this->db->prepare('SELECT * FROM usuarios');
        $query->execute();
        return $query->fetchAll(PDO::FETCH_OBJ);
    }



    function pagarServicio($monto, $id_tienda) {
        // Obtén la fecha actual en formato DATETIME
        $fecha = date('Y-m-d H:i:s'); // Usa PHP para obtener la fecha y hora actual en formato adecuado
    
        // Mostrar las variables antes de la ejecución (para depuración)

        $query = $this->db->prepare('
            INSERT INTO pagos_usuarios (monto, id_tienda, fecha, pago) 
            VALUES (?, ?, ?, ?)
        ');
    
        // Ejecutar la consulta con los parámetros proporcionados
        $result = $query->execute([$monto, $id_tienda,  $fecha, 1]);
    
    }
    
    
    function getMail($nombreCuenta) {
        $query = $this->db->prepare('SELECT email FROM usuarios WHERE usuario = ?');
        $query->execute([$nombreCuenta]);
        return $query->fetchAll(PDO::FETCH_OBJ);
    }
 
    



    function saveCodigoRecuperacion($email, $codigo) {
        $query = $this->db->prepare('INSERT INTO codigos_recuperacion (email, codigo) VALUES (:email, :codigo)');
        $query->bindParam(':email', $email, PDO::PARAM_STR);
        $query->bindParam(':codigo', $codigo, PDO::PARAM_STR);
        $query->execute();
    }
    
    function getCodigo($codigo, $mail) {
        // Modificamos la consulta para que también busque el mail
        $query = $this->db->prepare('SELECT * FROM codigos_recuperacion WHERE codigo = :codigo AND email = :mail LIMIT 1');
        
        // Vinculamos los parámetros con los valores correspondientes
        $query->bindParam(':codigo', $codigo, PDO::PARAM_STR);
        $query->bindParam(':mail', $mail, PDO::PARAM_STR);
        
        // Ejecutamos la consulta
        $query->execute();
        
        // Obtenemos el resultado
        $resultado = $query->fetch(PDO::FETCH_OBJ);
        
        // Si encontramos un resultado, lo devolvemos, si no, devolvemos null
        return $resultado ? $resultado : null;
    }
    
    
    public function eliminarCodigo($codigo, $mail) {
        // Preparamos la consulta para eliminar el código correspondiente
        $query = $this->db->prepare('DELETE FROM codigos_recuperacion WHERE codigo = :codigo AND email = :mail LIMIT 1');
        
        // Vinculamos los parámetros con los valores correspondientes
        $query->bindParam(':codigo', $codigo, PDO::PARAM_STR);
        $query->bindParam(':mail', $mail, PDO::PARAM_STR);
        
        // Ejecutamos la consulta
        $query->execute();
        
        // Verificamos si la eliminación fue exitosa (afectó al menos una fila)
        if ($query->rowCount() > 0) {
            // Si se eliminó un registro, devolvemos un mensaje de éxito
            return ['status' => 'success', 'message' => 'Código eliminado correctamente'];
        } else {
            // Si no se eliminó ningún registro, devolvemos un mensaje de error
            return ['status' => 'error', 'message' => 'No se encontró el código o el correo'];
        }
    }
    
    

    public function eliminarcodigosanteriores($mail) {
        // Preparamos la consulta para eliminar todos los códigos correspondientes a un correo
        $query = $this->db->prepare('DELETE FROM codigos_recuperacion WHERE email = :mail');
        
        // Vinculamos el parámetro con el valor correspondiente
        $query->bindParam(':mail', $mail, PDO::PARAM_STR);
        
        // Ejecutamos la consulta
        $query->execute();
        
        // Verificamos si la eliminación fue exitosa (afectó al menos una fila)
        if ($query->rowCount() > 0) {
            // Si se eliminaron registros, devolvemos un mensaje de éxito
            return ['status' => 'success', 'message' => 'Códigos eliminados correctamente'];
        } else {
            // Si no se eliminaron registros, devolvemos un mensaje de error
            return ['status' => 'error', 'message' => 'No se encontraron códigos asociados a ese correo'];
        }
    }
    
    public function actualizarContraseña($mail, $hashedPassword) {
        $query = $this->db->prepare("UPDATE usuarios SET pass = ? WHERE email = ?");
        
        $resultado = $query->execute([$hashedPassword, $mail]);
        
        // Debuguear el resultado y los posibles errores

    
        return $resultado;
    }
    
    
    

    public function getEmailVendedorByIdCarrito($id_carrito) {
        try {
            // Verificamos si el ID del carrito es válido
            if (empty($id_carrito)) {
                throw new Exception('El ID del carrito no puede estar vacío.');
            }
    
            // Verificar si el carrito existe
            $queryCheckCarrito = $this->db->prepare("SELECT id_carrito FROM carritos WHERE id_carrito = ?");
            $queryCheckCarrito->execute([$id_carrito]);
            if ($queryCheckCarrito->rowCount() == 0) {
                throw new Exception('El carrito con ID ' . $id_carrito . ' no existe.');
            }
    
            // Consulta para obtener el correo del vendedor en una sola consulta usando JOIN
            $query = $this->db->prepare(
                "SELECT u.email 
                FROM carritos c
                JOIN tiendas t ON c.id_tienda = t.id_tienda
                JOIN usuarios u ON t.id_usuario = u.id
                WHERE c.id_carrito = ?"
            );
    
            // Ejecutar la consulta
            $query->execute([$id_carrito]);
    
            // Obtener el resultado
            $result = $query->fetch(PDO::FETCH_OBJ);
    
            // Si no se encuentra el resultado, lanzar un error
            if (!$result) {
                throw new Exception('Correo del vendedor no encontrado para el carrito con ID: ' . $id_carrito);
            }
    
            // Devolver el correo del vendedor
            return $result->email;
    
        } catch (PDOException $e) {
            // Si hay un error de base de datos, lo mostramos
            return json_encode(['error' => 'Error de base de datos: ' . $e->getMessage()]);
        } catch (Exception $e) {
            // Otros errores generales
            return json_encode(['error' => $e->getMessage()]);
        }
    }
    
    


    function getPlantillas(){
        $query = $this->db->prepare('SELECT * FROM tipos_plantillas');
        $query->execute();
        return $query->fetchAll(PDO::FETCH_ASSOC);  // Esto devuelve todos los registros en un array asociativo
    }
    

    function save_mp_credentials($data, $id_user){
        $data['created_at'] = date('Y-m-d H:i:s');
        $query = $this->db->prepare("UPDATE usuarios SET mp_credentials = ? WHERE id = ?");
        $data = json_encode($data);
        $query->execute([$data,$id_user]);
    }

}