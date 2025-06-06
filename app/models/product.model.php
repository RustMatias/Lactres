<?php

include_once 'app/models/index.model.php';

class ProductModel {

    private $db;

    function __construct() {
        $index = new IndexModel(); // Crear instancia de IndexModel
        $this->db = $index->getConnection(); // Obtener la conexión
    }


    function addProduct(
        $id_tienda,
        $nombre,
        $marca,
        $descripcion,
        $stock,
        $precio,
        $fabricante,
        $categoria,
      
        $peso,
        $dimensiones,
        $unlimitedStock,
        $images
    ) {
        // Verificar si las variables son correctas
        var_dump($id_tienda, $nombre, $marca, $descripcion, $stock, $precio, $fabricante, $categoria, $envio, $peso, $dimensiones, $images);
    
        // Convertir dimensiones a JSON si es necesario
        if (is_array($dimensiones)) {
            $dimensiones = json_encode($dimensiones);
        }
    
        // Configurar el atributo de error de PDO para excepciones
        $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        // Intentar ejecutar la consulta SQL
        try {
            $query = $this->db->prepare('INSERT INTO productos 
                (id_tienda, nombre, marca, descripcion, stock, precio, fabricante, id_categoria,  peso, dimensiones, sin_limite,imagenes) 
                VALUES (?,?,?,?,?,?,?,?,?,?,?,?)');
            
            // Ejecutar la consulta
            $result = $query->execute([
                $id_tienda,
                $nombre,
                $marca,
                $descripcion,
                $stock,
                $precio,
                $fabricante,
                $categoria,
                $peso,
                $dimensiones,
                $unlimitedStock,
                $images
            ]);
    
            // Verificar si la consulta fue exitosa
            if ($result) {
                echo "Consulta ejecutada correctamente.";
            } else {
                echo "Error al ejecutar la consulta.";
            }
    
            // Obtener el ID del último producto insertado
            $lastInsertId = $this->db->lastInsertId();
            if ($lastInsertId) {
                echo "ID del último producto insertado: " . $lastInsertId;
            } else {
                echo "No se pudo obtener el ID del último producto.";
            }
    
            return $lastInsertId;
    
        } catch (PDOException $e) {
            // Capturar y mostrar el error
            echo "Error en la base de datos: " . $e->getMessage();
        }
    }
    

function getProductImages($id) {
    $sql = "SELECT imagenes FROM productos WHERE id_producto = ?";
    $query = $this->db->prepare($sql);
    $query->execute([$id]);
    $result = $query->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        return explode(',', $result['imagenes']); // Convertir la cadena de imágenes en un array
    } else {
        return []; // Si no hay imágenes, devolvemos un array vacío
    }
}


function editProduct(
    $id,
    $nombre,
    $marca,
    $descripcion,
    $precio,
    $fabricante,
    $categoria,
    $imagenes,
    $stock,
    $unlimitedstock,

    $peso,
    $dimensiones
) {
    $fechaActual = date('Y-m-d');

    // Convertir dimensiones a JSON si es array
    if (is_array($dimensiones)) {
        $dimensiones = json_encode($dimensiones);
    }

    $sin_limite = $unlimitedstock == 1 ? 1 : 0;

    $sql = "UPDATE productos SET 
        nombre = ?, 
        marca = ?, 
        descripcion = ?, 
        precio = ?, 
        fabricante = ?, 
        id_categoria = ?, 
        imagenes = ?, 
        stock = ?, 
        sin_limite = ?, 
     
        peso = ?, 
        dimensiones = ?
    WHERE id_producto = ?";

    $params = [
        $nombre,
        $marca,
        $descripcion,
        $precio,
        $fabricante,
        $categoria,
        $imagenes,
        $stock,
        $sin_limite,

        $peso,
        $dimensiones,
        $id
    ];

    $query = $this->db->prepare($sql);
    $query->execute($params);

    return true; // Devuelve algún indicador de éxito o información relevante.
}


    

    function getAllProducts(){
        //funcion para obtener todas las armas
        $query = $this->db->prepare ('SELECT * FROM productos');
        $query->execute();
    
        $products = $query ->fetchAll(PDO::FETCH_OBJ);
    
        return $products;
    }

    function getFilteredProducts($search, $categoria, $priceOrder, $stockOrder, $offset, $limit, $id_tienda) {
        // Construir la consulta SQL
        $query = 'SELECT * FROM productos WHERE (nombre LIKE ? OR descripcion LIKE ? OR marca LIKE ? OR fabricante LIKE ?) AND id_tienda = ?';
        $params = ["%$search%", "%$search%", "%$search%", "%$search%", $id_tienda];
    
        // Filtrar por categoría
        if (!empty($categoria)) {
            $query .= ' AND id_categoria = ?';
            $params[] = $categoria;
        }
    
        // Ordenar por precio
        if (!empty($priceOrder)) {
            $query .= ' ORDER BY precio ' . ($priceOrder == 'asc' ? 'ASC' : 'DESC');
        }
    
        // Ordenar por stock
        if (!empty($stockOrder)) {
            if (!empty($priceOrder)) {
                $query .= ', ';
            } else {
                $query .= ' ORDER BY ';
            }
            $query .= 'stock ' . ($stockOrder == 'asc' ? 'ASC' : 'DESC');
        }
    
        // Añadir límites para la paginación
        $query .= ' LIMIT ' . (int)$limit . ' OFFSET ' . (int)$offset;
    
        // Preparar la consulta
        $stmt = $this->db->prepare($query);
    
        // Vincular parámetros posicionales
        foreach ($params as $i => $param) {
            $stmt->bindValue($i + 1, $param);
        }
    
        // Ejecutar la consulta
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }
    
    
    
    
    
    
    
    
    function countFilteredProducts($search, $categoria, $id_tienda) {
        $query = 'SELECT COUNT(*) AS total FROM productos WHERE (nombre LIKE ? OR descripcion LIKE ? OR marca LIKE ? OR fabricante LIKE ?) AND id_tienda = ?';
        $params = ["%$search%", "%$search%", "%$search%", "%$search%", $id_tienda];
    
        if (!empty($categoria)) {
            $query .= ' AND id_categoria = ?';
            $params[] = $categoria;
        }
    
        $stmt = $this->db->prepare($query);
        $stmt->execute($params);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return (int)$result['total'];
    }
    
    
    

    function getAllShopProducts($id_shop){
        // Función para obtener los productos de una tienda específica
        $query = $this->db->prepare('SELECT * 
                                     FROM productos
                                     WHERE id_tienda = ?
                                     ORDER BY id_producto DESC');
        $query->execute([$id_shop]); // Pasar el valor de $id_shop como parámetro
        
        $products = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $products;
    }





    function getHomeProducts($id_shop){
        // Función para obtener los productos de una tienda específica
        $query = $this->db->prepare('SELECT * 
                                     FROM productos
                                     WHERE id_tienda = ?
                                     ORDER BY id_producto DESC
                                     LIMIT 12');
        $query->execute([$id_shop]); // Pasar el valor de $id_shop como parámetro
        
        $products = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $products;
    }
    
  
    function INI_getHomeProducts($id_shop){
        // Función para obtener los productos de una tienda específica
        $query = $this->db->prepare('SELECT * 
                                     FROM productos
                                     WHERE id_tienda = ?
                                     ORDER BY id_producto ASC
                                     LIMIT 12');
        $query->execute([$id_shop]); // Pasar el valor de $id_shop como parámetro
        
        $products = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $products;
    }

    function getProductById($id, $id_shop) {
        // Prepara la consulta para obtener un producto específico basado en su ID y la tienda
        $query = $this->db->prepare("SELECT * FROM productos WHERE id_producto = ? AND id_tienda = ?");
        
        // Ejecuta la consulta pasando los valores de $id y $id_shop como parámetros
        $query->execute([$id, $id_shop]);
        
        // Obtiene el resultado como un objeto
        $product = $query->fetch(PDO::FETCH_OBJ);
        
        // Retorna el producto encontrado (o `false` si no se encuentra)
        return $product;
    }
    
    function getProductByCategory($id){
    
        //funcion para obtener todas las armas
        $query = $this->db->prepare("SELECT * FROM productos WHERE id_categoria = ?");
        $query->execute([$id]);
        $products = $query ->fetchAll(PDO::FETCH_OBJ);
   
        return $products;
        
    }

    // Obtener el total de productos en una categoría
    function getTotalProductsByCategory($id, $id_shop) {
        $query = $this->db->prepare("SELECT COUNT(*) as total FROM productos WHERE id_categoria = ? AND id_tienda = ?");
        $query->execute([$id, $id_shop]);
        $result = $query->fetch(PDO::FETCH_OBJ);
        
        return $result->total;
    }

    // Obtener productos por categoría con paginación
    function getProductByCategoryPaginated($id, $page, $productsPerPage, $id_shop) {
        $offset = ($page - 1) * $productsPerPage;
        
        // Concatenamos directamente los valores de LIMIT y OFFSET en la consulta
        $query = $this->db->prepare("SELECT * FROM productos WHERE id_categoria = ? AND id_tienda = ? LIMIT $productsPerPage OFFSET $offset");
        $query->execute([$id, $id_shop]);
        $products = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $products;
    }
    
    


    function getProductByBrand($brand, $limit, $offset) {
        // Asegúrate de que $limit y $offset sean enteros
        $limit = (int) $limit;
        $offset = (int) $offset;
    
        $query = $this->db->prepare("SELECT * FROM productos WHERE marca = ? LIMIT ? OFFSET ?");
        $query->bindValue(1, $brand, PDO::PARAM_STR);
        $query->bindValue(2, $limit, PDO::PARAM_INT);
        $query->bindValue(3, $offset, PDO::PARAM_INT);
        $query->execute();
        $products = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $products;
    }
    
    
    
    function getTotalProductsByBrand($brand) {
        $query = $this->db->prepare("SELECT COUNT(*) as total FROM productos WHERE marca = ?");
        $query->execute([$brand]);
        return $query->fetch(PDO::FETCH_OBJ)->total;
    }
    
    

    function getBrands($id_shop) {
        $query = $this->db->prepare('SELECT marca, COUNT(*) AS cantidad
                                     FROM productos
                                     WHERE id_tienda = ?
                                     GROUP BY marca');
        $query->execute([$id_shop]); // Pasar id_shop como parámetro
        
        $brands = $query->fetchAll(PDO::FETCH_OBJ);
        
        return $brands;
    }
    


    function getProductImage($id){

        $query = $this->db->prepare ('SELECT imagenes
                                    FROM productos
                                    WHERE id_producto = ?');
        $query->execute([$id]);
    
        $result  =$query->fetchColumn();
      
        return $result;
    }


    function search($query, $id_shop) {
        // Preparar la consulta base
        $sql = $this->db->prepare('SELECT *
                                  FROM productos
                                  WHERE (nombre LIKE :search
                                     OR descripcion LIKE :search
                                     OR precio LIKE :search
                                     OR marca LIKE :search)
                                    AND id_tienda = :id_shop');
        
        // Enlazar los parámetros :search y :id_shop con los valores correspondientes
        $sql->bindValue(':search', '%' . $query . '%', PDO::PARAM_STR);
        $sql->bindValue(':id_shop', $id_shop, PDO::PARAM_INT);
    
        // Ejecutar la consulta
        $sql->execute();
    
        // Obtener todos los resultados
        $result = $sql->fetchAll(PDO::FETCH_OBJ);
    
        return $result;
    }
    
    
    
    //COMPRAS ESTADOS
    public function comprarCarrito($idCarrito, $idUser, $data, $codigo) {
        $fechaActual = date('Y-m-d H:i:s');
    
        try {
            $query = $this->db->prepare('SELECT * FROM carritos WHERE id_carrito = ?');
            $query->execute([$idCarrito]);
            $result = $query->fetch();
        
            if (!$result) {
                throw new Exception("No se encontraron productos para el carrito ID: " . $idCarrito);
            }
        } catch (PDOException $e) {
            var_dump('Error SQL: ' . $e->getMessage());
        } catch (Exception $e) {
            var_dump('Error: ' . $e->getMessage());
        }
    
        $productos = $result['conceptos'] ?? '';
        $id_tienda = $result['id_tienda'] ?? '';
        $productosArray = json_decode($productos, true);
    
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception('Error al decodificar el formato de productos: ' . json_last_error_msg());
        }
    
        if (empty($productosArray)) {
            throw new Exception("El carrito está vacío o mal formado");
        } 
    
        $this->db->beginTransaction();
    
        try {
            $pesoTotal = 0;
            $productosFinal = [];
    
            foreach ($productosArray as $producto) {
                if (count($producto) !== 3) {
                    throw new Exception('Formato de producto inválido: ' . json_encode($producto));
                }
    
                $productoId = (int)$producto[0];
                $cantidad = (int)$producto[1];
    
                if ($productoId <= 0 || $cantidad <= 0) {
                    throw new Exception('ID de producto o cantidad inválidos');
                }
    
                // Obtener info del producto
                $query = $this->db->prepare('SELECT stock, vendidos, sin_limite, precio, peso FROM productos WHERE id_producto = ?');
                $query->execute([$productoId]);
                $stockResult = $query->fetch();
    
                if (!$stockResult) {
                    continue;
                }
    
                $stockActual = (int)$stockResult['stock'];
                $vendidosActual = (int)$stockResult['vendidos'];
                $sin_limite = (int)$stockResult['sin_limite'];
                $precio = (float)$stockResult['precio'];
                $peso = (float)$stockResult['peso'];
    
                // Agregar al peso total
                $pesoTotal += $peso * $cantidad;
    
                // Verificar stock
                if ($stockActual < $cantidad && $sin_limite == 0) {
                    throw new Exception("Stock insuficiente para el producto ID $productoId");
                }
    
                if ($sin_limite == 0) {
                    $nuevoStock = $stockActual - $cantidad;
                    $query = $this->db->prepare('UPDATE productos SET stock = ? WHERE id_producto = ?');
                    $query->execute([$nuevoStock, $productoId]);
                }
    
                // Sumar ventas
                $nuevoVentas = $vendidosActual + $cantidad;
                $query = $this->db->prepare('UPDATE productos SET vendidos = ? WHERE id_producto = ?');
                $query->execute([$nuevoVentas, $productoId]);
    
                // Guardar producto con precio
                $productosFinal[] = [$productoId, $cantidad, $producto[2], $precio];
            }
    
            // Obtener lista_envios de la tienda
            $query = $this->db->prepare('SELECT lista_envios FROM tiendas WHERE id_usuario = ?');
            $query->execute([$idUser]);
            $tiendaInfo = $query->fetch(PDO::FETCH_ASSOC);

            $costoEnvio = 0;
            $listaEnvios = isset($tiendaInfo['lista_envios']) ? json_decode($tiendaInfo['lista_envios'], true) : null;

            if ($listaEnvios && is_array($listaEnvios)) {
                if (!empty($listaEnvios['precioFijoActivado'])) {
                    $costoEnvio = (float)$listaEnvios['precioEnvio'];
                } elseif (!empty($listaEnvios['costosEnvio']) && is_array($listaEnvios['costosEnvio'])) {
                    foreach ($listaEnvios['costosEnvio'] as $rango) {
                        list($min, $max) = array_map('floatval', explode(' - ', $rango['rangoPeso']));
                        if ($pesoTotal >= $min && $pesoTotal <= $max) {
                            $costoEnvio = (float)$rango['costoEnvio'];
                            break;
                        }
                    }
                }
            }
    
            // Codificar productos y datos
            $productosJson = json_encode($productosFinal, JSON_UNESCAPED_UNICODE);
            $json_data = json_encode($data, JSON_UNESCAPED_UNICODE);
    
            if (!$productosJson || !$json_data) {
                throw new Exception("Error al codificar la información de compra");
            }
    
            // Insertar la compra
            $query = $this->db->prepare('INSERT INTO compras (codigo_compra, fecha, estado, id_usuario, productos, informacion, id_tienda, costo_envio) VALUES (?, ?, ?, ?, ?, ?, ?, ?)');
            $query->execute([
                $codigo,
                $fechaActual,
                1,
                $idUser,
                $productosJson,
                $json_data,
                $id_tienda,
                $costoEnvio
            ]);
    
            // Vaciar el carrito
            $query = $this->db->prepare('DELETE FROM carritos WHERE id_carrito = ?');
            $query->execute([$idCarrito]);
    
            $this->db->commit();
        } catch (Exception $e) {
            $this->db->rollBack();
            error_log("Error en la transacción: " . $e->getMessage());
            throw $e;
        }
    }
    
    
    
    
    

    
    function AddProductToCart($idProducto, $idUser, $cantidad, $UNIQUENAME, $id_shop) {
        // Recuperar el carrito actual del usuario filtrando también por id_tienda
        $query = $this->db->prepare('SELECT conceptos FROM carritos WHERE id_usuario = ? AND id_tienda = ?');
        $query->execute([$idUser, $id_shop]);
        $result = $query->fetch();
        $currentProducts = $result ? json_decode($result['conceptos'], true) : [];
    
        // Verificar si el producto ya está en el carrito de la tienda específica
        $found = false;
        foreach ($currentProducts as &$product) {
            if ($product[0] == $idProducto) {
                $product[1] += $cantidad; // Sumar la cantidad
                $found = true;
                break;
            }
        }
    
        // Si el producto no existe en el carrito de esa tienda, agregarlo
        if (!$found) {
            $currentProducts[] = [$idProducto, $cantidad, $UNIQUENAME];
        }
    
        // Convertir a JSON
        $jsonProducts = json_encode($currentProducts);
    
        if ($result) {
            // Si el carrito existe para esa tienda, actualizarlo
            $query = $this->db->prepare('UPDATE carritos SET conceptos = ? WHERE id_usuario = ? AND id_tienda = ?');
            $query->execute([$jsonProducts, $idUser, $id_shop]);
        } else {
            // Si no existe, insertar un nuevo carrito para esa tienda
            $query = $this->db->prepare('INSERT INTO carritos (id_usuario, conceptos, id_tienda) VALUES (?, ?, ?)');
            $query->execute([$idUser, $jsonProducts, $id_shop]);
        }
    }
    
    





    public function eliminarDelCarrito($id_producto, $id_carrito) {
        // Recuperar el carrito actual del usuario
        $query = $this->db->prepare('SELECT conceptos FROM carritos WHERE id_carrito = ?');
        $query->execute([$id_carrito]);
        $result = $query->fetch();
    
        if ($result) {
            // Decodificar los productos en el carrito
            $currentProducts = json_decode($result['conceptos'], true);
    
            // Verificar si el carrito tiene productos
            if (empty($currentProducts)) {
                return false; // El carrito está vacío
            }
    
            // Filtrar los productos para eliminar el producto especificado
            $updatedProducts = array_filter($currentProducts, function($product) use ($id_producto) {
                return $product[0] != $id_producto; // Compara el ID del producto (primer valor)
            });
    
            // Verificar si el producto ha sido eliminado
            if (count($updatedProducts) == count($currentProducts)) {
                return false; // El producto no se encontró en el carrito
            }
    
            // Reindexar el array para eliminar los índices vacíos
            $updatedProducts = array_values($updatedProducts);
    
            // Convertir a JSON para actualizar la base de datos
            $jsonProducts = json_encode($updatedProducts);
    
            // Actualizar la base de datos con los productos restantes
            $query = $this->db->prepare('UPDATE carritos SET conceptos = ? WHERE id_carrito = ?');
            $query->execute([$jsonProducts, $id_carrito]);
    
            return true;
        }
    
        return false; // Si no se encuentra el carrito
    }
    
    


function getProductDetails($productIds) {
    $in  = str_repeat('?,', count($productIds) - 1) . '?'; // Crear el string para IN (?,?,?,...)
    $query = $this->db->prepare("SELECT * FROM productos WHERE id_producto IN ($in)");
    $query->execute($productIds);
    return $query->fetchAll(PDO::FETCH_OBJ); // Asegúrate de devolver objetos
}

    

function getRelatedProduct($id, $id_shop){
    // Obtener la categoría del producto actual
    $query = $this->db->prepare("SELECT id_categoria FROM productos WHERE id_producto = ? AND id_tienda = ?");
    $query->execute([$id,$id_shop]);
    $categoria = $query->fetch(PDO::FETCH_OBJ);
    
    if (!$categoria) {
        return [];
    }

    // Obtener productos relacionados de la misma categoría, con un límite de 6
    $query = $this->db->prepare("SELECT * FROM productos WHERE id_categoria = ? AND id_producto != ? AND id_tienda = ? LIMIT 6");
    $query->execute([$categoria->id_categoria, $id, $id_shop]);
    $relatedProducts = $query->fetchAll(PDO::FETCH_OBJ);

    // Iterar sobre los productos relacionados y obtener el promedio de valoraciones de cada uno
    foreach ($relatedProducts as &$producto) {
        $queryAvg = $this->db->prepare("SELECT AVG(valoracion) as promedio FROM comentarios WHERE id_producto = ?");
        $queryAvg->execute([$producto->id_producto]);
        $avgRating = $queryAvg->fetch(PDO::FETCH_OBJ)->promedio;

        // Asignar el promedio de valoraciones redondeado a 1 decimal al producto
        $producto->valoracion_promedio = round($avgRating, 1);
    }

    return $relatedProducts;
}



function getBestRatedProduct($id_shop) {
    // Obtener los 6 productos mejor valorados de la tienda
    $query = $this->db->prepare("
        SELECT p.*, COALESCE(AVG(c.valoracion), 0) AS valoracion_promedio 
        FROM productos p
        LEFT JOIN comentarios c ON p.id_producto = c.id_producto
        WHERE p.id_tienda = ?
        GROUP BY p.id_producto
        ORDER BY valoracion_promedio DESC
        LIMIT 6
    ");
    $query->execute([$id_shop]);
    
    return $query->fetchAll(PDO::FETCH_OBJ);
}




function idTiendaByProducto($id){
    $query = $this->db->prepare("SELECT id_tienda FROM productos WHERE id_producto = ?");
    $query->execute([$id]);
    $categoria = $query->fetch(PDO::FETCH_OBJ);

    // Asegúrate de devolver el valor de id_tienda
    return $categoria ? $categoria->id_tienda : null; // Retorna null si no se encuentra
}


function deleteProduct($id) {
    // Preparamos la consulta SQL para eliminar el producto
    $query = $this->db->prepare("DELETE FROM productos WHERE id_producto = ?");
    
    // Ejecutamos la consulta pasando el ID del producto
    $query->execute([$id]);
    
    // Verificamos si se eliminó el producto
    if ($query->rowCount() > 0) {
        return true; // Producto eliminado con éxito
    } else {
        return false; // No se encontró el producto o no se pudo eliminar
    }
}



function productoMasVendidos($id_tienda) {
    $query = $this->db->prepare("
        SELECT * FROM productos 
        WHERE id_tienda = ? 
        ORDER BY vendidos DESC 
        LIMIT 5
    ");
    $query->execute([$id_tienda]);
    return $query->fetchAll(PDO::FETCH_OBJ);
}



function productoMejorValorados($id_tienda) {
    $query = $this->db->prepare("
        SELECT p.*, COALESCE(AVG(c.valoracion), 0) as promedio_valoracion
        FROM productos p
        LEFT JOIN comentarios c ON p.id_producto = c.id_producto
        WHERE p.id_tienda = ?
        GROUP BY p.id_producto
        ORDER BY promedio_valoracion DESC
        LIMIT 5
    ");
    $query->execute([$id_tienda]);
    return $query->fetchAll(PDO::FETCH_OBJ);
}




function uploadcypherproducts($products, $id_tienda) {
    // Preparar la consulta SQL para insertar los productos
    $query = $this->db->prepare('INSERT INTO productos (id_tienda, id_producto_cygestion, nombre, descripcion, stock, precio, imagenes, sin_limite) VALUES (?,?,?,?,?,?,?,?)');

    // Acceder a los productos dentro de la clave 'productos'
    $productos = $products['productos']; // Esto es lo que contiene los productos

    // Recorrer cada producto
    foreach ($productos as $producto) {
        // Extraer los valores del producto
        $nombre = htmlspecialchars(trim($producto['nombre']), ENT_QUOTES, 'UTF-8');
        $descripcion = htmlspecialchars(trim($producto['descripcion']), ENT_QUOTES, 'UTF-8');
        $stock = is_numeric($producto['cantidad']) ? (int)$producto['cantidad'] : 0;
        $precio = ($producto['precio'] === null || !is_numeric($producto['precio'])) ? 0.0 : floatval($producto['precio']);

        $sin_limite = isset($producto['sin_limite']) ? $producto['sin_limite'] : 0;
        
        $id_producto_cygestion = $producto['id']; // ID del producto
        
        // Ejecutar la consulta con los datos del producto
        $query->execute([
            $id_tienda,              // El id_tienda
            $id_producto_cygestion,  // El id del producto
            $nombre,                 // Nombre del producto
            $descripcion,            // Descripción del producto
            $stock,                  // Cantidad o stock del producto
            $precio,                 // Precio del producto
            "images/noimage.png",
            $sin_limite              
        ]);
        
    }

    return true;
}




public function buscarProductosCypher($id_carrito) {
    // Obtener los conceptos del carrito
    $query = $this->db->prepare("SELECT conceptos FROM carritos WHERE id_carrito = ? ");
    $query->execute([$id_carrito]);
    $result = $query->fetch(PDO::FETCH_OBJ);
    
    if (!$result) {
        return json_encode(['error' => 'Carrito no encontrado']);
    }

    // Convertir los conceptos en un arreglo
    $conceptos = json_decode($result->conceptos);

    // Inicializar los arreglos
    $cyproducts = [];
    $shopproducts = [];

    // Recorrer cada producto en los conceptos
    foreach ($conceptos as $producto) {
        $id_producto = $producto[0];
        $cantidad = $producto[1];

        // Consultar la tabla de productos para obtener información
        $queryProd = $this->db->prepare("SELECT id_producto_cygestion, nombre, precio FROM productos WHERE id_producto = ?");
        $queryProd->execute([$id_producto]);
        $prodInfo = $queryProd->fetch(PDO::FETCH_OBJ);

        if ($prodInfo) {
            // Si tiene id_producto_cygestion, va a cyproducts
            if ($prodInfo->id_producto_cygestion) {
                $cyproducts[] = [$prodInfo->id_producto_cygestion, $cantidad];
            } else {
                // Si no tiene id_producto_cygestion, va a shopproducts
                $shopproducts[] = [$prodInfo->nombre, $cantidad, $prodInfo->precio];
            }
        }
    }

    // Retornar el JSON con los resultados
    return json_encode([
        'cyproducts' => $cyproducts,
        'shopproducts' => $shopproducts
    ]);
}




function productsByIdCarrito($id_carrito) {
    // Obtener los conceptos del carrito
    $query = $this->db->prepare("SELECT conceptos FROM carritos WHERE id_carrito = ?");
    $query->execute([$id_carrito]);
    $result = $query->fetch(PDO::FETCH_OBJ);

    // Si no se encuentra el carrito
    if (!$result) {
        return json_encode(['error' => 'Carrito no encontrado']);
    }

    // Decodificar los conceptos (suponiendo que los datos están en formato JSON)
    $conceptos = json_decode($result->conceptos);

    // Lista para almacenar los productos con nombre y cantidad
    $productDetails = [];

    // Recorrer cada concepto
    foreach ($conceptos as $concept) {
        $id_producto = $concept[0]; // El ID del producto es el primer valor en el sub-arreglo
        $cantidad = $concept[1]; // La cantidad es el segundo valor en el sub-arreglo
        
        // Buscar el nombre del producto en la tabla productos
        $queryProduct = $this->db->prepare("SELECT nombre FROM productos WHERE id_producto = ?");
        $queryProduct->execute([$id_producto]);
        $product = $queryProduct->fetch(PDO::FETCH_OBJ);

        // Si encontramos el producto, agregamos su nombre y cantidad a la lista
        if ($product) {
            $productDetails[] = [
                'nombre' => $product->nombre,
                'cantidad' => $cantidad
            ];
        }
    }

    // Devolver la lista de nombres y cantidades de productos
    return $productDetails;
}





public function actualizarPreciosyProductosCypherGestion($productos, $id_tienda)
{
    // Paso 1: Obtener el id del usuario desde la tabla 'usuarios' usando el 'empresaCypher' y 'endpoint'
    $query = $this->db->prepare("SELECT id_tienda FROM tiendas WHERE id_tienda = ?");
    $query->execute([$id_tienda]);

    
    // Verificar si se encontró el usuario
    if ($query->rowCount() > 0) {
       

            // Paso 3: Recorrer la lista de productos y actualizar o crear productos en la tabla 'productos'
            foreach ($productos as $producto) {
                $id_producto = $producto[0]; // id_producto (de los datos recibidos)
                $precio = $producto[1];      // precio del producto
                $descripcion = $producto[2]; // descripción del producto
                $cantidad = $producto[3];    // cantidad del producto

                // Si el stock es null, asignar sin_limite a 1 y stock a 0
                if ($cantidad === null || $cantidad === "null") {
                    $cantidad = 0;
                    $sin_limite = 1;
                } else {
                    $sin_limite = 0;
                }

                // Verificar si el producto ya existe
                $queryProducto = $this->db->prepare("SELECT id_producto FROM productos WHERE id_producto_cygestion = ? AND id_tienda = ?");
                $queryProducto->execute([$id_producto, $id_tienda]);

                if ($queryProducto->rowCount() > 0) {
                    // Si existe, actualizar el producto
                    $updateProducto = $this->db->prepare("
                        UPDATE productos 
                        SET precio = ?, 
                            stock = ?, 
                            nombre = ?, 
                            descripcion = ?,
                            sin_limite = ?
                        WHERE id_producto_cygestion = ? AND id_tienda = ?
                    ");
                    $updateProducto->execute([$precio, $cantidad, $descripcion, 'Sin descripción' , $sin_limite, $id_producto, $id_tienda]);

                    if ($updateProducto->rowCount() > 0) {
                        echo "Producto actualizado: $id_producto<br>";
                    } else {
                        echo "Sin cambios en el producto: $id_producto<br>";
                    }
                } else {
                    // Si no existe, insertar el producto
                    $insertProducto = $this->db->prepare("
                        INSERT INTO productos (nombre, id_producto_cygestion, stock, precio, id_tienda, sin_limite)
                        VALUES (?, ?, ?, ?, ?, ?)
                    ");

                    try {
                        $insertProducto->execute([$descripcion, $id_producto, $cantidad, $precio, $id_tienda, $sin_limite]);

                        if ($insertProducto->rowCount() > 0) {
                            echo "Producto insertado: $id_producto<br>";
                        } else {
                            echo "Error: No se pudo insertar el producto.<br>";
                        }
                    } catch (PDOException $e) {
                        echo "Error al insertar el producto: " . $e->getMessage() . "<br>";
                    }
                }
            }

            return true;
       
    } else {
        echo "Tienda no encontrada con los datos proporcionados<br>";
        return false;
    }
}




}