<style>
.ap-full-vh {
    min-height: 50vh;
}

.ap-card {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    max-width: 700px;
    width: 100%;
}
.btn-rojo {
    background-color: #303198;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-rojo:hover {
    background-color: #3e4095;
}
.codigo-inputs {
    display: flex;
    justify-content: center;
    gap: 10px; /* Espacio entre los inputs */
}

.codigo-input {
    width: 30px; /* Ajusta el ancho para que quede pequeño */
    height: 40px; /* Altura para hacerlo proporcional */
    text-align: center; /* Centrar el texto (número) dentro del input */
    font-size: 18px; /* Tamaño de fuente para que el número sea claro */
    border: 1px solid #ccc; /* Borde de los inputs */
    border-radius: 5px; /* Bordes redondeados */
    margin: 0; /* Eliminar márgenes predeterminados */
    padding: 0; /* Sin relleno extra */
    text-transform: uppercase; /* Asegura que todo se ingrese en mayúsculas (si fuera alfabético) */
}

.codigo-input:focus {
    border-color: #007bff; /* Color de borde al enfocarse */
    outline: none; /* Eliminar el contorno azul predeterminado */
    background-color: #f0f8ff; /* Fondo claro cuando está enfocado */
}

.codigo-input::selection {
    background-color: #007bff; /* Color del texto seleccionado */
    color: white; /* Color del texto seleccionado */
}


</style>
{include file="header-offlog.tpl"}

<div class="container mt-5 d-flex justify-content-center align-items-center ap-full-vh"> 
    <!-- Formulario de Recuperación -->
    <div  id="recuperar-form" class="ap-card p-4 text-center d-flex flex-column align-items-center justify-content-center" 
   >
        <h3>Recuperar Contraseña</h3>
        <div class="mt-3">
            <div class="form-group mb-3">
                <label for="usuario">Ingrese usuario</label>
                <input type="text" id="usuario" name="usuario" class="form-control" required>
            </div>
            <button type="submit" class="btn-rojo" id="enviarBtn" onclick="recuperarContrasena()">Enviar</button>
            <div class="spinner-border" role="status" id="spinner" style="display: none;">
            </div>
            <!-- Contenedor para mostrar el mensaje de error -->
            <small id="mensaje-error" style="color: red; display: none;"></small>
        </div>
    </div>
    


    <!-- Div de Código de Acceso -->
    <div class="ap-card p-4 text-center" id="codigo-form" style="display: none;">
        <h3>Hemos enviado un código de acceso a tu mail:</h3>
        <p id="mostrar-mail"></p>
        <div class="codigo-inputs">
            <input type="text" maxlength="1" class="codigo-input" id="code-1">
            <input type="text" maxlength="1" class="codigo-input" id="code-2">
            <input type="text" maxlength="1" class="codigo-input" id="code-3">
            <input type="text" maxlength="1" class="codigo-input" id="code-4">
            <input type="text" maxlength="1" class="codigo-input" id="code-5">
            <input type="text" maxlength="1" class="codigo-input" id="code-6">
        </div>
        
        <!-- Contenedor para mostrar el mensaje de error -->
        <div id="error-container" style="display: none; margin-top: 10px;"></div>
        
        <!-- Contenedor del spinner, inicialmente oculto -->
        <div id="spinner" class="spinner-border" role="status" style="display: none;">
            <span class="visually-hidden">Cargando...</span>
        </div>
        
        <button class="btn-rojo mt-3" onclick="verificarCodigo()">Verificar Código</button>
    </div>
   
</div>



</div>
<!-- Formulario oculto que se enviará con POST -->
<form id="redirectForm" action="cambiarcontraseña" method="POST" style="display:none;">
    <input type="text" name="mail" id="mailInput">
    <input type="text" name="codigo" id="codigoInput">
</form>

<script>
    
    // Función para avanzar al siguiente input cuando se ingresa un carácter válido
    function avanzarAlSiguienteInput(event, siguienteInputId) {
        let valor = event.target.value.toUpperCase(); // Convierte a mayúscula
        
        // Verifica si el valor ingresado es una letra (A-Z) o un número (0-9)
        if (/^[A-Z0-9]$/.test(valor)) {
            event.target.value = valor; // Asegura que se muestre en mayúscula
            const siguienteInput = document.getElementById(siguienteInputId);
            if (siguienteInput) {
                siguienteInput.focus(); // Mueve el enfoque al siguiente input
            }
        } else {
            // Si el valor no es válido, lo borra
            event.target.value = '';
        }
    }

    // Añadir los eventos de 'input' para cada campo
    document.getElementById('code-1').addEventListener('input', (event) => avanzarAlSiguienteInput(event, 'code-2'));
    document.getElementById('code-2').addEventListener('input', (event) => avanzarAlSiguienteInput(event, 'code-3'));
    document.getElementById('code-3').addEventListener('input', (event) => avanzarAlSiguienteInput(event, 'code-4'));
    document.getElementById('code-4').addEventListener('input', (event) => avanzarAlSiguienteInput(event, 'code-5'));
    document.getElementById('code-5').addEventListener('input', (event) => avanzarAlSiguienteInput(event, 'code-6'));

</script>
{include file="footer.tpl"}
