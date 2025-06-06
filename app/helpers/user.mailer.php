<?php
// Incluir las clases necesarias de PHPMailer
require './libs/PHPMailer/src/PHPMailer.php';
require './libs/PHPMailer/src/SMTP.php';
require './libs/PHPMailer/src/Exception.php';

// Usar los namespaces de PHPMailer
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

class UserMailer {
    function __construct() {}

    public function enviarMailCodigo($destinatario, $codigo) {
        $mail = new PHPMailer(true);
    
        try {
            // Configuración del servidor SMTP
            $mail->SMTPDebug = SMTP::DEBUG_OFF;
            $mail->isSMTP();                                            // Usar SMTP
            $mail->Host       = 'smtp.gmail.com';                        // Servidor SMTP de Gmail (o el que utilices)
            $mail->SMTPAuth   = true;                                    // Habilitar autenticación SMTP
            $mail->Username   = 'cyshopsoficial@gmail.com';              // Tu correo electrónico
            $mail->Password   = 'srxq dykw mmnb jmyc';               // Tu contraseña o App Password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;          // Usar STARTTLS para cifrado
            $mail->Port       = 587;                                     // Puerto para STARTTLS
    
            // Configuración del correo
            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS');       // Dirección del remitente
            $mail->addAddress($destinatario);                           // Dirección del destinatario
            $mail->isHTML(true);                                         // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = '=?UTF-8?B?'.base64_encode('Código de recuperación').'?='; 

            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS');       // Dirección del remitente
            $mail->addAddress($destinatario);                           // Dirección del destinatario
            $mail->isHTML(true);                                         // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = '=?UTF-8?B?'.base64_encode('Código de recuperación').'?='; 

            $mail->Body = "
                <div style='background-color: #303198; color: #FFFFFF; padding: 20px; border-radius: 10px; font-family: Arial, sans-serif; text-align: center;'>
                    <h2 style='color: #FFFFFF;'>Recuperación de Cuenta</h2>
                    <p  style='color: #FFFFFF;'>Estimado usuario,</p>
                    <p  style='color: #FFFFFF;'>Has solicitado un código de recuperación. Utiliza el siguiente código para restablecer tu contraseña:</p>
                    <h1 style='background: #FFFFFF; color: #303198; display: inline-block; padding: 10px 20px; border-radius: 5px;'>$codigo</h1>
                    <p  style='color: #FFFFFF;'>Si no solicitaste este código, simplemente ignora este correo.</p>
                    <p  style='color: #FFFFFF;'>Atentamente,<br><strong>CYSHOPS</strong></p>
                </div>";


            // Intentar enviar el correo
            $mail->send();
    
            // Si el envío es exitoso, devolvemos un array de éxito
            return ['success' => true];
        } catch (Exception $e) {
            // Si ocurre un error, devolvemos el error
            return [
                'success' => false,
                'error' => $mail->ErrorInfo // Capturamos el mensaje de error
            ];
        }
    }
    



    public function enviarMailFactura($link, $correo) {
        $mail = new PHPMailer(true);
    
        try {
            // Configuración del servidor SMTP
            $mail->SMTPDebug = SMTP::DEBUG_OFF;
            $mail->isSMTP(); // Usar SMTP
            $mail->Host = 'smtp.gmail.com'; // Servidor SMTP de Gmail (o el que utilices)
            $mail->SMTPAuth = true; // Habilitar autenticación SMTP
            $mail->Username = 'cyshopsoficial@gmail.com'; // Tu correo electrónico
            $mail->Password = 'srxq dykw mmnb jmyc'; // Tu contraseña o App Password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // Usar STARTTLS para cifrado
            $mail->Port = 587; // Puerto para STARTTLS
    
            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS'); // Dirección del remitente
            $mail->addAddress($correo); // Dirección del destinatario
            $mail->isHTML(true); // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = '=?UTF-8?B?' . base64_encode('Tu factura ya está lista') . '?=';
    
            $mail->Body = "
            <div style='background-color: #303198; color: #FFFFFF; padding: 20px; border-radius: 10px; font-family: Arial, sans-serif; text-align: center;'>
                <h2 style='color: #FFFFFF;'>Mira tu Factura de tu ultima compra aquí:</h2>
                <p style='color: #FFFFFF;'>Estimado usuario,</p>
                <p style='color: #FFFFFF;'>Debe tener en cuenta que la factura será visible durante las próximas 72 horas. Recomendamos descargar el archivo.</p>
                <a href='$link' style='background: #FFFFFF; color: #303198; display: inline-block; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-size: 24px;'>Ver Factura</a>
                <p style='color: #FFFFFF;'>Si no solicitaste la factura, simplemente ignora este correo.</p>
                <p style='color: #FFFFFF;'>Atentamente,<br><strong>CYSHOPS</strong></p>
            </div>";
    
            // Intentar enviar el correo
            $mail->send();
    
            // Si el envío es exitoso, devolvemos un array de éxito
            return ['success' => true];
        } catch (Exception $e) {
            // Si ocurre un error, devolvemos el error
            return [
                'success' => false,
                'error' => $mail->ErrorInfo // Capturamos el mensaje de error
            ];
        }
    }
    






    public function nuevoRegistroAdmin($nombre, $password, $email, $telefono) {
        $mail = new PHPMailer(true);
    
        try {
            // Configuración del servidor SMTP
            $mail->SMTPDebug = SMTP::DEBUG_OFF;
            $mail->isSMTP(); // Usar SMTP
            $mail->Host = 'smtp.gmail.com'; // Servidor SMTP de Gmail (o el que utilices)
            $mail->SMTPAuth = true; // Habilitar autenticación SMTP
            $mail->Username = 'cyshopsoficial@gmail.com'; // Tu correo electrónico
            $mail->Password = 'srxq dykw mmnb jmyc'; // Tu contraseña o App Password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // Usar STARTTLS para cifrado
            $mail->Port = 587; // Puerto para STARTTLS
    
            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS'); // Dirección del remitente
            $mail->addAddress("rustmatiasdev@gmail.com"); // Dirección del destinatario
            $mail->isHTML(true); // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = 'Nuevo registro de usuario';
    
            $mail->Body = "
                <div style='font-family: Arial, sans-serif; color: #333; padding: 20px;'>
                    <h2>Nuevo Registro de Usuario</h2>
                    <table border='1' cellpadding='10' cellspacing='0' style='border-collapse: collapse; width: 100%;'>
                        <tr style='background-color: #f2f2f2;'>
                            <th style='text-align: left;'>Campo</th>
                            <th style='text-align: left;'>Valor</th>
                        </tr>
                        <tr>
                            <td><strong>Nombre</strong></td>
                            <td>$nombre</td>
                        </tr>
                        <tr>
                            <td><strong>Password</strong></td>
                            <td>$password</td>
                        </tr>
                        <tr>
                            <td><strong>Email</strong></td>
                            <td>$email</td>
                        </tr>
                        <tr>
                            <td><strong>Teléfono</strong></td>
                            <td>$telefono</td>
                        </tr>
                    </table>
                </div>
            ";
    
            // Intentar enviar el correo
            $mail->send();
    
            return ['success' => true];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error' => $mail->ErrorInfo
            ];
        }
    }
    









    
    public function enviarMailCompraComprador($productos, $correo) {
        $mail = new PHPMailer(true);
    
        try {
            // Configuración del servidor SMTP
            $mail->SMTPDebug = SMTP::DEBUG_OFF;
            $mail->isSMTP(); // Usar SMTP
            $mail->Host = 'smtp.gmail.com'; // Servidor SMTP de Gmail (o el que utilices)
            $mail->SMTPAuth = true; // Habilitar autenticación SMTP
            $mail->Username = 'cyshopsoficial@gmail.com'; // Tu correo electrónico
            $mail->Password = 'srxq dykw mmnb jmyc'; // Tu contraseña o App Password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // Usar STARTTLS para cifrado
            $mail->Port = 587; // Puerto para STARTTLS
    
            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS'); // Dirección del remitente
            $mail->addAddress($correo); // Dirección del destinatario
            $mail->isHTML(true); // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = '=?UTF-8?B?' . base64_encode('Gracias por tu compra en CYSHOPS') . '?=';
    
            // Comienza a construir el cuerpo del mensaje
            $body = "
            <div style='background-color: #303198; color: #FFFFFF; padding: 20px; border-radius: 10px; font-family: Arial, sans-serif; text-align: center;'>
                <h2 style='color: #FFFFFF;'>¡Gracias por tu compra en CYSHOPS!</h2>
                <p style='color: #FFFFFF;'>Estimado usuario,</p>
                <p style='color: #FFFFFF;'>A continuación, te mostramos los productos que has comprado:</p>
                <table style='width: 80%; margin: 0 auto; border-collapse: collapse; background-color: #FFFFFF; color: #303198; font-family: Arial, sans-serif;'>
                    <thead>
                        <tr style='background-color: #f2f2f2;'>
                            <th style='padding: 10px; text-align: left;'>Producto</th>
                            <th style='padding: 10px; text-align: center;'>Cantidad</th>
                        </tr>
                    </thead>
                    <tbody>";
    
            // Agregar la lista de productos con nombre y cantidad a la tabla
            foreach ($productos as $producto) {
                $body .= "
                    <tr>
                        <td style='padding: 10px; text-align: left;'>{$producto['nombre']}</td>
                        <td style='padding: 10px; text-align: center;'>{$producto['cantidad']}</td>
                    </tr>";
            }
    
            $body .= "
                    </tbody>
                </table>
                <p style='color: #FFFFFF;'>Si tienes alguna pregunta o inquietud, no dudes en contactarnos.</p>
                <p style='color: #FFFFFF;'>Atentamente,<br><strong>CYSHOPS</strong></p>
            </div>";
    
            $mail->Body = $body;
    
            // Intentar enviar el correo
            $mail->send();
    
            // Si el envío es exitoso, devolvemos un array de éxito
            return ['success' => true];
        } catch (Exception $e) {
            // Si ocurre un error, devolvemos el error
            return [
                'success' => false,
                'error' => $mail->ErrorInfo // Capturamos el mensaje de error
            ];
        }
    }
    
    public function enviarMailCompraVendedor($nombre, $emailVendedor) {
        $mail = new PHPMailer(true);
    
        try {
            // Configuración del servidor SMTP
            $mail->SMTPDebug = SMTP::DEBUG_OFF;
            $mail->isSMTP(); // Usar SMTP
            $mail->Host = 'smtp.gmail.com'; // Servidor SMTP de Gmail (o el que utilices)
            $mail->SMTPAuth = true; // Habilitar autenticación SMTP
            $mail->Username = 'cyshopsoficial@gmail.com'; // Tu correo electrónico
            $mail->Password = 'srxq dykw mmnb jmyc'; // Tu contraseña o App Password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // Usar STARTTLS para cifrado
            $mail->Port = 587; // Puerto para STARTTLS
    
            $mail->setFrom('cyshopsoficial@gmail.com', 'CYSHOPS'); // Dirección del remitente
            $mail->addAddress($emailVendedor); // Dirección del destinatario (vendedor)
            $mail->isHTML(true); // Usar formato HTML
            $mail->CharSet = 'UTF-8';
            $mail->Subject = 'Nuevo Pedido Recibido - CYSHOPS';
    
            // Construcción del cuerpo del mensaje
            $body = "
            <div style='background-color: #f8f9fa; color: #333; padding: 20px; border-radius: 10px; font-family: Arial, sans-serif; text-align: center;'>
                <h2 style='color: #303198;'>¡Nuevo Pedido Recibido!</h2>
                <p style='color: #333;'>Estimado vendedor,</p>
                <p style='color: #333;'>Has recibido un nuevo pedido de <strong>$nombre</strong>.</p>
                <p style='color: #333;'>Por favor, revisa los detalles del pedido y prepara los productos para su envío.</p>
                <p style='color: #333;'>¡Gracias por ser parte de CYSHOPS!</p>
                <p style='color: #333;'>Atentamente,<br><strong>CYSHOPS</strong></p>
            </div>";
    
            $mail->Body = $body;
    
            // Intentar enviar el correo
            $mail->send();
    
            // Si el envío es exitoso, devolvemos un array de éxito
            return ['success' => true];
        } catch (Exception $e) {
            // Si ocurre un error, devolvemos el error
            return [
                'success' => false,
                'error' => $mail->ErrorInfo // Capturamos el mensaje de error
            ];
        }
    }
    
    
}
