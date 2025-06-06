function validateQuantity(input) {
    var maxStock = parseInt(input.getAttribute('max'), 10);
    var value = parseInt(input.value, 10);

    if (value > maxStock) {
        input.value = maxStock;
    } else if (value < 1) {
        input.value = 1;
    }
}


function getProductIdFromUrl() {
    const url = window.location.href;
    const parts = url.split('/');
    return parts[parts.length - 1]; // Obtiene el último segmento de la URL
}


async function addComment() {
    const comentario = document.getElementById('comentario').value.trim();
    const valoracion = document.querySelector('input[name="valoracion"]:checked');
    const userId = document.getElementById('userId').value;
    const userName = document.getElementById('userName').value;
    const idProducto = getProductIdFromUrl();

    const errorMessage = document.querySelector('.CM_producto_detail-pd-error-message');
    
    // Validación de la valoración
    if (!valoracion) {
        errorMessage.style.display = 'block';
        return;
    } else {
        errorMessage.style.display = 'none';
    }

    // Validación de comentario vacío
    if (!comentario) {
        console.error('El comentario no puede estar vacío.');
        return;
    }

    try {
        const response = await fetch('api/comments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                comentario: comentario,
                valoracion: valoracion.value,
                userId: userId,
                userName: userName,
                idProducto: idProducto
            })
        });
    
        const result = await response.json();
    
        if (response.ok) {
            console.log('Comentario agregado:', result);
    
            comentarios = document.getElementById('comments-list');
    
            // Generar estrellas con las llenas primero y vacías después
            let estrellasHTML = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= valoracion.value) {
                    estrellasHTML += '<span class="star-filled">★</span>';  // Primero las llenas
                } else {
                    estrellasHTML += '<span class="star-nofilled">★</span>'; // Luego las vacías
                }
            }
    
            // Agregar el nuevo comentario
            let nuevocomentario = `
            <li class="CM_producto_detail-comment-item">
              <div class="CM_producto_detail-comment">
                <span class="CM_producto_detail-comment-user">${userName}</span>
                <span>
                  ${estrellasHTML}
                </span>
              </div>
              <small class="CM_producto_detail-comment-text">${comentario}</small>
            </li>`;
          
    
            comentarios.innerHTML = nuevocomentario + comentarios.innerHTML;
    
            // Actualiza la UI con el nuevo comentario
        } else {
            console.error('Error al agregar el comentario:', result.error || 'Error desconocido');
        }
    } catch (e) {
        console.error('Error en la conexión:', e);
    }
    
    
    
}

function generarEstrellas(rating) {
    let estrellas = "";
    for (let i = 1; i <= 5; i++) {
        if (i <= rating) {
            estrellas = '<span class="star-nofilled">★</span>' + estrellas; // Primero las vacías
        } else {
            estrellas = '<span class="star-filled">★</span>' + estrellas; // Luego las llenas
        }
    }
    return estrellas;
}




async function validarTienda() {
    let nombreTienda = document.getElementById('shopName').value;
/*     let alias = document.getElementById('alias').value;

    let CBU = document.getElementById('CBU').value; */
    let id_user = document.getElementById('id_user').value;

    let nombreUnico = document.getElementById('shopUniqueName').value;
    let id_plantilla = document.getElementById('shopTemplate').value;
    const hasCode = document.getElementById('hasCode');
    let codigo = null;

    if (hasCode.checked) {
        // El checkbox está marcado
        codigo = document.getElementById('codigo').value;
    }


    try {
        const response = await fetch(`api/validarNombreUnico`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json' // Aseguramos que la respuesta sea en JSON
            },
            body: JSON.stringify({ 
                nombreTienda, 
                nombreUnico,
                id_plantilla,
                codigo,
              /*   alias,
                CBU */
            })
        });

        const text = await response.text(); // Leemos como texto primero
        console.log("Response Text:", text); // Ver la respuesta cruda para debug

        // Intentamos parsear el texto a JSON
        let result;
       /*  try {
            result = JSON.parse(text);
        } catch (parseError) {
            console.error("Error al parsear JSON:", parseError);
            console.error("Respuesta cruda:", text);
            return;
        } */

        if (response.ok) {
            // Si la respuesta es exitosa
            window.location.href = 'dashboard/shop/' + id_user;
        } else {
            // Mostrar el mensaje de error
            const errorElement = document.getElementById('error_modal_existente');
            if (errorElement) {
                errorElement.innerText = result.message || "El nombre único ya está en uso.";
                errorElement.style.display = 'block';
            }
        }
    } catch (e) {
        console.error("Error al validar el nombre de la tienda:", e);
        const errorElement = document.getElementById('error_modal_existente');
        if (errorElement) {
            errorElement.innerText =" El nombre único ya está en uso.";
            errorElement.style.display = 'block';
        }
    }
}




async function guardarColor(nombreUnico) {
    let color = document.getElementById('colorPicker').value;
    let colortexto = document.getElementById("toggle").checked ? "#000000" : "#ffffff";

    
    try {
        const response = await fetch(`api/cambiarColorTienda`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({ 
                color, 
                nombreUnico,
                colortexto
            })
        });

        const data = await response.json(); // Convertir respuesta en JSON

        if (response.ok && data.success) {
            alert(data.message); // Mensaje de éxito real
        } else {
            alert(`Error: ${data.message}`); // Mensaje de error real
        }
    } catch (e) {
        console.error("Error al cambiar de color", e);
        alert('Error inesperado al conectar con el servidor');
    }
}





async function guardarHorarios(nombreUnico, event) {
    event.preventDefault(); // Evita la recarga de la página
       // Obtener los elementos
       const horaDesde = document.querySelector('input[name="hora_desde"]').value;
       const horaHasta = document.querySelector('input[name="hora_hasta"]').value;
       const sinHorario = document.querySelector('input[name="sin_horario"]').checked;
   
       // Crear objeto con la información
       const datosHorario = {
        tienda: nombreUnico,
        horario: sinHorario ? null : { desde: horaDesde, hasta: horaHasta }
    };
    
    console.log(datosHorario)

    try {
        const response = await fetch(`api/cambiarHorarioTienda`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({ 
                datosHorario
            })
        });

        const data = await response.json(); // Convertir respuesta en JSON

        if (response.ok && data.success) {
            alert(data.message); // Mensaje de éxito real
        } else {
            alert(`Error: ${data.message}`); // Mensaje de error real
        }
    } catch (e) {
        console.error("Error al cambiar de horario", e);
        alert('Error inesperado al conectar con el servidor');
    }
}





async function guardarUbicacion(nombreUnico, event) {
    event.preventDefault(); // Evita la recarga de la página
       // Obtener los elementos
       const toggleSiNoValue = document.getElementById("toggleSiNo").checked ? 1 : 0;
       const ubicacion = document.querySelector('#ubicacionTienda').value;
       
       // Crear objeto con la información
       const datosUbicacion = {
           tienda: nombreUnico,
           mostrarUbicacion: toggleSiNoValue,
           ubicacion: toggleSiNoValue === 1 ? ubicacion : null
       };
       
    
    console.log(datosUbicacion)

    try {
        const response = await fetch(`api/cambiarUbicacionTienda`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({ 
                datosUbicacion
            })
        });

        const data = await response.json(); // Convertir respuesta en JSON

        if (response.ok && data.success) {
            alert(data.message); // Mensaje de éxito real
        } else {
            alert(`Error: ${data.message}`); // Mensaje de error real
        }
    } catch (e) {
        console.error("Error al cambiar ubicación", e);
        alert('Error inesperado al conectar con el servidor');
    }
}




async function saveProfileInfo() {
    // Obteniendo valores de los inputs
    const nombreCuenta = document.getElementById('username').value;
    const emailCuenta = document.getElementById('email').value;
    const telefonoCuenta = document.getElementById('telefono').value;
/*     const aliasTienda = document.getElementById('aliasTienda') ? document.getElementById('aliasTienda').value : '';
    const cbuTienda = document.getElementById('cbuTienda') ? document.getElementById('cbuTienda').value : '';
 */
    // Construyendo el objeto a enviar
    const dataToSend = {
        nombreCuenta,
        emailCuenta,
        telefonoCuenta,
/*         aliasTienda,
        cbuTienda */
    };

    try {
        const response = await fetch(`api/saveProfileInfo`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(dataToSend) // Enviando el objeto como JSON
        });

        const data = await response.json(); // Recibiendo respuesta en JSON
        
        if (response.ok && data.success) {
            location.reload(); // Recargar la página si fue exitoso
        } else {
            alert('No se pudo guardar la información, por favor intente nuevamente en unos minutos.'); // Error real
        }
    } catch (e) {
        alert('Error inesperado al conectar con el servidor'); // Error inesperado
    }
}

async function saveShopInfo() {
    // Obteniendo valores de los inputs

    const aliasTienda = document.getElementById('aliasTienda') ? document.getElementById('aliasTienda').value : '';
    const cbuTienda = document.getElementById('cbuTienda') ? document.getElementById('cbuTienda').value : '';
    
    // Construyendo el objeto a enviar
    const dataToSend = {

        aliasTienda,
        cbuTienda
    };
   console.log("data:", JSON.stringify(dataToSend));
    try {
        const response = await fetch(`api/saveShopInfo`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(dataToSend) // Enviando el objeto como JSON
        });

        const data = await response.json(); // Recibiendo respuesta en JSON
        
        if (response.ok && data.success) {
            location.reload(); // Recargar la página si fue exitoso
        } else {
            alert('No se pudo guardar la información, por favor intente nuevamente en unos minutos.'); // Error real
        }
    } catch (e) {
        alert('Error inesperado al conectar con el servidor'); // Error inesperado
    }
}




async function recuperarContrasena() {
    // Obtener el usuario
    const nombreCuenta = document.getElementById('usuario').value;

    // Construir el objeto a enviar
    const dataToSend = {
        nombreCuenta,
    };

    // Ocultar el botón y mostrar el spinner
    document.getElementById('enviarBtn').style.display = 'none'; // Ocultar botón
    document.getElementById('spinner').style.display = 'inline-block'; // Mostrar spinner

    // Limpiar cualquier mensaje previo de error
    document.getElementById('mensaje-error').style.display = 'none';
    document.getElementById('mensaje-error').textContent = '';

    try {
        const response = await fetch(`api/enviarMailUsuarioRecuperarContrasena`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(dataToSend)
        });

        const data = await response.json(); // Recibir respuesta en JSON
        console.log(data);

        if (response.ok && data.success) {
            // Mostrar el mail y cambiar de formulario
            document.getElementById('mostrar-mail').textContent = data.email;
            document.getElementById('recuperar-form').style.setProperty('display', 'none', 'important');
            document.getElementById('codigo-form').style.display = 'block';
        } else {
            // Mostrar el mensaje de error en el contenedor small
            document.getElementById('mensaje-error').style.display = 'inline'; // Hacer visible el mensaje
            document.getElementById('mensaje-error').textContent = data.message;
        }
    } catch (e) {
        document.getElementById('mensaje-error').style.display = 'inline';
        document.getElementById('mensaje-error').textContent = 'Error inesperado al conectar con el servidor';
    } finally {
        // Mostrar el botón y ocultar el spinner al finalizar la solicitud
        document.getElementById('enviarBtn').style.display = 'inline-block'; // Mostrar botón
        document.getElementById('spinner').style.display = 'none'; // Ocultar spinner
    }
}





async function verificarCodigo() {
    // Selecciona todos los inputs con la clase 'codigo-input'
    const inputs = document.querySelectorAll('.codigo-input');
    let codigo = '';

    // Recorre los inputs en orden y concatena sus valores en mayúsculas
    inputs.forEach(input => {
        codigo += input.value.toUpperCase();
    });

    const mail = document.getElementById('mostrar-mail').innerText;

    // Crea el objeto con el correo y el código
    const dataToSend = {
        mail,
        codigo
    };

    // Muestra el spinner y oculta el botón mientras se realiza la petición
    document.getElementById('spinner').style.display = 'inline-block';
    document.querySelector('button').style.display = 'none'; // Ocultar el botón

    try {
        const response = await fetch(`api/validarCodigoRecuperacion`, {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(dataToSend)
        });

        const data = await response.json(); // Recibiendo respuesta en JSON

        // Verifica si el código es correcto o incorrecto
        if (data.status === 'success') {
            // Si el código es correcto, envía el formulario oculto con los datos a la página de cambio de contraseña
            document.getElementById('mailInput').value = mail;
            document.getElementById('codigoInput').value = codigo;
            document.getElementById('redirectForm').submit();  // Enviar formulario
        } else {
            // Si el código es incorrecto, muestra un mensaje de error
            mostrarMensajeError('Código incorrecto');
        }

    } catch (e) {
        alert('Error inesperado al conectar con el servidor');
    } finally {
        // Oculta el spinner y muestra el botón nuevamente
        document.getElementById('spinner').style.display = 'none';
        document.querySelector('button').style.display = 'inline-block';
    }
}


// Función para mostrar el mensaje de error
function mostrarMensajeError(mensaje) {
    const errorContainer = document.getElementById('error-container');
    errorContainer.innerHTML = `<small class="text-danger">${mensaje}</small>`;
    errorContainer.style.display = 'block'; // Asegúrate de que el mensaje de error se muestre
}




function seleccionarTienda(button) {
    // Obtener datos desde los atributos data- del botón
    const imagen = button.dataset.img; 
    const titulo = button.dataset.title;
    const precio = button.dataset.price;
    const id = button.dataset.id;
    const descripcion = button.dataset.description;

    const ID_USER = button.dataset.id_user;
    if (ID_USER == 0) {
        window.location.href = `login`;
    }
    
    // Referencia al contenedor de la selección
    const contenedor = document.getElementById('tiendaSeleccionada');
    const shopTemplate = document.getElementById('shopTemplate').value= id;
 
    
    // Llenar la información en el div
    document.getElementById('seleccion-imagen').src = imagen;
    document.getElementById('seleccion-imagen').alt = titulo;
    document.getElementById('seleccion-titulo').textContent = titulo;
    document.getElementById('seleccion-precio').textContent = precio;
    document.getElementById('seleccion-descripcion').textContent = descripcion;

    // Mostrar el contenedor si estaba oculto
    contenedor.style.display = 'block';

    // Desplazamiento suave al contenedor
    contenedor.scrollIntoView({ behavior: "smooth", block: "start" });
}

