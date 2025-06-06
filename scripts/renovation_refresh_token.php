<?php
$clientId = '3590053151031368';
$clientSecret = 'WKuUqBPpQY5dtRjqSm2zCflJnaZexcg1';

try {
    $pdo = new PDO("mysql:host=localhost;dbname=db_phantom;charset=utf8", "mati_admin", "bdx2024");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Traer todos los usuarios con credenciales
    $stmt = $pdo->query("SELECT id, mp_credentials FROM usuarios WHERE mp_credentials IS NOT NULL");

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $id = $row['id'];
        $credentials = json_decode($row['mp_credentials'], true);
        var_dump($credentials);
        if ($credentials === null) {
            echo "Error al decodificar las credenciales JSON para el usuario $id\n";
            continue;
        }
        if (!isset($credentials['refresh_token']) || !isset($credentials['expires_in']) || !isset($credentials['created_at'])) {
            echo "Usuario $id no tiene refresh_token, expires_in o created_at\n";
            continue;
        }

        // Convertir la fecha de creación a timestamp
        $createdAt = strtotime($credentials['created_at']);
        // Calcular la fecha de expiración sumando expires_in (segundos) a la fecha de creación
        $expiresAt = $createdAt + $credentials['expires_in'];

        // Calcular el tiempo restante hasta la expiración
        $timeRemaining = $expiresAt - time();

        // Definir el umbral de 30 días en segundos
        $segundosAntesDeRenovar = 30 * 24 * 60 * 60; // 30 días en segundos

        // Si el tiempo restante es menor a 30 días (menos de 30 días para la renovación)
        if ($timeRemaining > $segundosAntesDeRenovar) {
            echo "Usuario $id: el token no necesita renovación aún\n";
            continue;
        }

        // Renovar token
        $data = [
            'grant_type' => 'refresh_token',
            'client_id' => $clientId,
            'client_secret' => $clientSecret,
            'refresh_token' => $credentials['refresh_token'],
        ];

        $ch = curl_init('https://api.mercadopago.com/oauth/token');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'accept: application/json',
            'content-type: application/x-www-form-urlencoded'
        ]);

        $response = curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

       if ($httpcode === 200) {
            $newCredentials = json_decode($response, true);

            // Verificamos si 'created_at' está presente, si no lo agregamos
            if (!isset($newCredentials['created_at'])) {
                // Obtener el 'created_at' de las credenciales anteriores que ya guardaste en la base de datos
                $newCredentials['created_at'] = date('Y-m-d H:i:s'); // Fecha actual
            }

            // Mantenemos claves útiles del token anterior y actualizamos la nueva fecha de creación
            $merged = array_merge($credentials, $newCredentials);

            // Actualizar las credenciales en la base de datos
            $stmtUpdate = $pdo->prepare("UPDATE usuarios SET mp_credentials = ? WHERE id = ?");
            $stmtUpdate->execute([json_encode($merged), $id]);

            echo "Token renovado para usuario $id\n";
        } else {
            echo "Error al renovar token para usuario $id (HTTP $httpcode): $response\n";
        }
    }

} catch (PDOException $e) {
    echo "Error de conexión a la base de datos: " . $e->getMessage() . "\n";
}
?>
