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

    .form-group {
        position: relative; /* Necesario para posicionar el icono dentro del campo */
    }

    .eye-icon {
        position: absolute;
        top: 50%;
        right: 10px;
        transform: translateY(-50%);
        cursor: pointer;
        color: #ccc;
    }

    .form-control {
        padding-right: 30px; /* Para dejar espacio para el ícono */
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

/* Contenedor relativo para el campo de contraseña */
.password-container {
    position: relative;
}

/* Estilo para el icono del ojo */
.eye-icon {
    position: absolute;
    right: 10px; /* Ajusta el espacio desde la derecha */
    top: 25%; /* Centra el icono verticalmente */
    transform: translateY(-25%); /* Ajuste fino para el centrado vertical */
    cursor: pointer;
}

/* Estilo para el input */
input[type="password"] {
    padding-right: 30px; /* Espacio extra a la derecha para el icono */
}

</style>

{include file="header-offlog.tpl"}

<div class="container mt-5 d-flex justify-content-center align-items-center ap-full-vh">
    <!-- Formulario de Recuperación -->
    <div id="recuperar-form" class="ap-card p-4 text-center d-flex flex-column align-items-center justify-content-center">
        <!-- Formulario -->
        <form id="cambiarContrasenaAccion" method="POST" action="cambiarContrasenaAccion">
            <!-- Campo de correo (oculto y no editable) -->
            <input type="text" id="mail" name="mail" value="{$mail}" style="display:none;" readonly>

            <div class="form-group mb-3">
                <label for="password">Contraseña nueva</label>
                <div class="password-container">
                    <input type="password" id="password" name="password" class="form-control" minlength="6" required>
                    <span class="eye-icon" onclick="togglePasswordVisibility('password')">
                        <i class="fas fa-eye-slash"></i> <!-- Ojo tachado por defecto -->
                    </span>
                </div>
            </div>
            
            <div class="form-group mb-3">
                <label for="password-repeat">Repetir Contraseña</label>
                <div class="password-container">
                    <input type="password" id="password-repeat" name="password-repeat" class="form-control" minlength="6" required>
                    <span class="eye-icon" onclick="togglePasswordVisibility('password-repeat')">
                        <i class="fas fa-eye-slash"></i> <!-- Ojo tachado por defecto -->
                    </span>
                </div>
                <small id="password-error" class="form-text text-danger" style="display:none;">Las contraseñas no coinciden.</small> <!-- Mensaje de error -->
            </div>
            
            
            

            <button type="submit" class="btn-rojo">Cambiar Contraseña</button>
        </form>
    </div>
</div>

{include file="footer.tpl"}

<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- FontAwesome para el icono de ojo -->
<script>
   // Función para alternar la visibilidad de la contraseña
function togglePasswordVisibility(id) {
    const passwordField = document.getElementById(id);
    const eyeIcon = passwordField.nextElementSibling.querySelector('i');

    if (passwordField.type === 'password') {
        passwordField.type = 'text'; // Mostrar la contraseña
        eyeIcon.classList.remove('fa-eye-slash'); // Eliminar el ojo tachado
        eyeIcon.classList.add('fa-eye'); // Mostrar el ojo normal
    } else {
        passwordField.type = 'password'; // Ocultar la contraseña
        eyeIcon.classList.remove('fa-eye'); // Eliminar el ojo normal
        eyeIcon.classList.add('fa-eye-slash'); // Mostrar el ojo tachado
    }
}
document.getElementById("cambiarContrasenaAccion").addEventListener("submit", function(event) {
    // Recuperamos los valores de las contraseñas
    const password = document.getElementById("password").value;
    const passwordRepeat = document.getElementById("password-repeat").value;
    const passwordError = document.getElementById("password-error"); // Referencia al mensaje de error

    // Comprobamos si las contraseñas coinciden
    if (password !== passwordRepeat) {
        event.preventDefault(); // Prevenimos el envío del formulario
        passwordError.style.display = "block"; // Mostramos el mensaje de error
    } else {
        passwordError.style.display = "none"; // Ocultamos el mensaje si las contraseñas son iguales
    }
});

</script>
