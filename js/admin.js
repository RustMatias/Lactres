

function adminsubmenu(q){

    hideAll()
    switch (q) {
        case "addproduct":
            let addProduct = document.getElementById('addproduct')
            addProduct.classList.remove('hideform');
            let buton = document.getElementById('delete-buton')
            buton.classList.add('hideform');


         
            break;
        case 'editproduct':
            let editProduct =  document.getElementById('editproduct')
            editProduct.classList.remove('hideform');
            break;
      /*   case "addcategory":
            let addCategory =  document.getElementById('addcategory')
            addCategory.classList.remove('hideform');
            break; */
        case 'editcategory':
            let editCategory =  document.getElementById('editcategory')
            editCategory.classList.remove('hideform');
            break;
       
        case 'banner':
            let banner =  document.getElementById('banner')
            banner.classList.remove('hideform');

            break;
/*         case 'logo':
            let logo =  document.getElementById('logo')
            logo.classList.remove('hideform');

            break; */
        case 'addCat':
            let addCat =  document.getElementById('addCat')
            addCat.classList.remove('hideform');

            break;

        case 'logoPage':
            let logoPage =  document.getElementById('logoPage')
            logoPage.classList.remove('hideform');

            break;
        case 'enviosPage':
            let enviosPage =  document.getElementById('enviosPage')
            enviosPage.classList.remove('hideform');

            break;
        case 'contact':
            let contact =  document.getElementById('contact')
            contact.classList.remove('hideform');

            break;
        default:
            console.log("El valor no coincide con ninguno de los cases");
    }
    
}

function hideAll(){
    let addProduct = document.getElementById('addproduct')
/*     let addCategory =  document.getElementById('addcategory')
*/     let editProduct = document.getElementById('editproduct')
    let editCategory =  document.getElementById('editcategory')
    let stockcontrol =  document.getElementById('stockcontrol')
    let banner =  document.getElementById('banner')
    let addCat =  document.getElementById('addCat')
/*     let logo =  document.getElementById('logo') */
    let logoPage =  document.getElementById('logoPage')
    let enviosPage =  document.getElementById('enviosPage')
    let contact =  document.getElementById('contact')

/*     console.log(addCategory)
 */
    stockcontrol.classList.add('hideform');
/*     addCategory.classList.add('hideform');
 */    addProduct.classList.add('hideform');
    editProduct.classList.add('hideform');
    editCategory.classList.add('hideform');
    banner.classList.add('hideform');
/*     logo.classList.add('hideform'); */
    addCat.classList.add('hideform');
    logoPage.classList.add('hideform');
    enviosPage.classList.add('hideform');
    contact.classList.add('hideform');

}

async function getProducts(event) {
    let query = document.getElementById('admin-product-input');
    let id_tienda = document.getElementById('id_tienda');
    let shopName = document.getElementById('shopNameEP');

    try {
        let resultBox = document.querySelector('#productsresult');
        resultBox.innerHTML = '';

        const response = await fetch(`api/products/${id_tienda.value}/${query.value}`);
        const products = await response.json();
        products.forEach(product => {
            // Extraer la primera imagen del string de imágenes separado por comas
            let firstImage = product.imagenes ? product.imagenes.split(',')[0] : 'banner.jpg';

            resultBox.innerHTML +=  `
                <a href="${shopName.value}/edit/${product.id_producto}" class="EditProduct-result-item">
                    <div class="EditProduct-img-container">
                        <img src="${firstImage}" alt="resultado" class="EditProduct-thumbnail">
                    </div>
                    <div class="EditProduct-info">
                        <h3>${product.nombre}</h3>
                        <p class="EditProduct-description">
                            ${product.descripcion.length > 20 ? product.descripcion.substring(0, 20) + '...' : product.descripcion}
                        </p>
                        <div class="EditProduct-details">
                            <span>Marca: ${product.marca}</span>
                            <span>Precio: $${(Number(product.precio) || 0).toFixed(2)}</span>
                            <span>Stock: ${product.stock}</span>
                            <span>Fabricante: ${product.fabricante}</span>
                        </div>
                    </div>
                </a>`;
        });
    } catch (e) {
        console.log(e);
    }
};



async function getCategories(event) {
    let id_tienda = document.getElementById('id_tienda_ec').value;
    let shopName = document.getElementById('shopName_ec').value;
    let query = document.getElementById('admin-category-input').value;

    
    try {
        let resultBox = document.querySelector('#productsresultcat');
        resultBox.innerHTML = '';

        const response = await fetch('api/categories', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ id_tienda: id_tienda, query: query })
        });

        // Verifica si la respuesta fue exitosa antes de intentar parsear
        if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
        }

        // Intenta analizar el JSON
        const categories = await response.json();

        // Verifica si la respuesta contiene datos
        if (!categories) {
            throw new Error('Respuesta vacía o no válida');
        }

        categories.forEach(cat => {
            resultBox.innerHTML +=  '<a href="'+shopName+'/editcategory/'+cat.id_categoria+'" class="category-home-card">'+
                                        '<img src="'+cat.imagen+'" alt="'+cat.imagen+'">'+
                                        '<h3>'+cat.nombre+'</h3>'+
                                    '</a>';
        });
    } catch (e) {
        console.error('Error al obtener las categorías:', e);
    }
}

async function changePassword(event) {
    if (event) event.preventDefault(); // Evita el recargo de la página en un formulario
    let old_pass = document.getElementById('old_pass').value;
    let new_password = document.getElementById('new_pass').value;
    let r_new_pass = document.getElementById('r_new_pass').value;

    const oldPassContainer = document.getElementById('old-pass-container'); // Contenedor de la contraseña antigua
/*     const errorMessage = oldPassContainer.querySelector('.error-message'); // Mensaje de error
 */
    // Verificar la contraseña antigua
    const isOldPasswordValid = await verifiPassword(old_pass);
    if (!isOldPasswordValid) {
        // Si la contraseña es incorrecta, mostrar el mensaje de error
       
            const error = document.createElement('small');
            error.classList.add('error-message');
            error.style.color = 'red';
            error.textContent = 'Contraseña incorrecta';
            oldPassContainer.appendChild(error);
        
        return; // Detener la ejecución si la contraseña es incorrecta
    }

    // Verificar que las nuevas contraseñas coincidan
    if (new_password === r_new_pass) {
        try {
            const response = await fetch('api/cambiarContrasena', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ new_password }) // Corregido el nombre de la variable
            });

            const data = await response.json(); // Obtener los datos de la respuesta como JSON

            if (response.ok) {
                // Manejar el caso de éxito
                if (data.status === 'success') {
             
                    location.reload(); // Corregir: puedes recargar la página o hacer algo más
                } else {
                    alert(data.message); // Mostrar el mensaje de error
                }
            } else {
                console.error('Error en la respuesta del servidor');
            }
        } catch (e) {
            console.error('Error al cambiar la contraseña:', e);
        }
    } else {
        console.error('Las contraseñas no coinciden');
    }
}




async function verifiPassword(old_pass) {
   
    try {
        const response = await fetch('api/VerifyOldPassword', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ old_pass }) // Enviando la contraseña antigua
        });

        if (response.ok) {
            const result = await response.json(); // Se espera una respuesta en formato JSON
            
            // Si el resultado es true o false, lo devolvemos tal cual
            return result;
        } else {
            console.error('Error en la respuesta del servidor');
            return false;
        }
    } catch (e) {
        console.error('Error al verificar la contraseña:', e);
        return false;
    }
}




async function deleteBanner(buttonElement) {
    const imagenId = buttonElement.getAttribute('data-imagen-id');

    try {
        const response = await fetch(`api/deleteBanner/${imagenId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        console.log('Respuesta del servidor:', response);

        // Verifica el tipo de contenido de la respuesta

        if (response.ok) {
            // Elimina la tarjeta visualmente si la solicitud fue exitosa
            let imagenElement = document.querySelector(`#banner-col-${imagenId}`);
            if (imagenElement) {
                imagenElement.remove();
            }

            closeDeleteModal(imagenId);


        } else {
            const text = await response.text();
            console.error('Error en la solicitud:', text);
            alert('Error al realizar la solicitud: ' + text);
        }

       
    } catch (e) {
        console.error('Error:', e);
        alert('Error al realizar la solicitud');
    }
}

async function deleteProduct (buttonElement, event) {
    const pID = buttonElement.getAttribute('data-product-id');
    event.stopPropagation(); // Detiene la propagación del clic

    try {
        const response = await fetch(`api/deleteProduct/${pID}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        console.log('Respuesta del servidor:', response);

        // Verifica el tipo de contenido de la respuesta

        if (response.ok) {
            // Elimina la tarjeta visualmente si la solicitud fue exitosa
            let imagenElement = document.querySelector(`#row-producto-${pID}`);
            if (imagenElement) {
                imagenElement.remove();
            }
        } else {
            const text = await response.text();
            console.error('Error en la solicitud:', text);
            alert('Error al realizar la solicitud: ' + text);
        }

       
    } catch (e) {
        console.error('Error:', e);
        alert('Error al realizar la solicitud');
    }
}




async function changestatus() {
    let status = document.getElementById('estado').value;
    let id_compra = document.getElementById('id_compra').value;

    try {
        const response = await fetch(`api/changestatuspedidos`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ 
                status: status, 
                id_compra: id_compra 
            })
        });

        const text = await response.text(); // Captura la respuesta como texto
        console.log(text); // Muestra el texto en la consola

        // Intenta convertir el texto a JSON solo si estás seguro de que es JSON
        try {
            const json = JSON.parse(text);
            console.log(json);
        } catch (e) {
            console.log("La respuesta no es JSON válido:", e);
        }

    } catch (e) {
        console.log(e);
    }
}


let imagenIndexAEliminar = null;

async function eliminarImagenProducto() {
    console.log(imagenIndexAEliminar);
    
    // Obtiene el valor del id_producto
    let id_producto = document.getElementById('producto_id').value;
    console.log(id_producto);

    // Crea el objeto con los datos que se van a enviar
    const dataToSend = {
        imagenIndex: imagenIndexAEliminar,
        id_producto: id_producto
    };

    try {
        // Realiza la solicitud con el método DELETE
        const response = await fetch('api/eliminarImagenProducto', {
            method: 'DELETE', // Puedes usar 'POST' o 'PUT' si prefieres, ya que estamos enviando un cuerpo
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToSend) // Aquí enviamos el cuerpo con los datos
        });

        console.log('Respuesta del servidor:', response);

        if (response.ok) {
           location.reload();
        } else {
            // Maneja el error
        }

    } catch (e) {
        console.error('Error:', e);
        alert('Error al realizar la solicitud');
    }
}


    async function finalizarPedido() {

        console.log('algo')
        // Obtiene el valor del id_producto
        let id_pedido = document.getElementById('id_compra').value;
    
        // Crea el objeto con los datos que se van a enviar
        const dataToSend = {

            id_pedido: id_pedido
        };
    
        try {
            // Realiza la solicitud con el método DELETE
            const response = await fetch('api/eliminarpedido', {
                method: 'DELETE', // Puedes usar 'POST' o 'PUT' si prefieres, ya que estamos enviando un cuerpo
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(dataToSend) // Aquí enviamos el cuerpo con los datos
            });
    
            console.log('Respuesta del servidor:', response);
    
            if (response.ok) {
                window.location.reload();
            } else {
                // Maneja el error
            }
    
        } catch (e) {
            console.error('Error:', e);
            alert('Error al realizar la solicitud');
        }
   
}


async function conectarCypher() {
    let usuario_cypher = document.getElementById('usuario_cypher').value;
    let password_cypher = document.getElementById('password_cypher').value;
    let softwareInput_cypher = document.getElementById('softwareInput_cypher').value;
    let id_tienda = document.getElementById('id_tienda').value;
    let id_usuario = document.getElementById('id_usuario').value;

    console.table({ usuario_cypher, password_cypher, softwareInput_cypher, id_tienda, id_usuario });

    const dataToSend = {
        usuario: usuario_cypher,
        contrasena: password_cypher,
        id_tienda: id_tienda
    };

    let endpoint = "https://bdxgestion.com/app";
    if (softwareInput_cypher.length !== 0) {
        endpoint = softwareInput_cypher;
    }

    try {
        const response = await fetch(endpoint + '/api/cyshop_verificacion.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(dataToSend)
        });

        const responseData = await response.json(); // Convierte la respuesta a JSON
        console.log('Respuesta del servidor:', responseData);

        if (response.ok) {
            if (responseData.estado === 200) {
              //  console.log("Productos:", responseData.productos);
                sessionStorage.setItem('productos', JSON.stringify(responseData.productos));

                const infoToSend = {
                    id_empresa: responseData.userdata.id_empresa,
                    nombre_gestion: `(${responseData.userdata.alias}) ${responseData.userdata.nombre} ${responseData.userdata.apellido}`,
                    id_usuario: id_usuario,
                    endpoint
                };

                const saveResponse = await fetch('api/saveCypherInformation', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(infoToSend)
                });

                if (saveResponse.ok) {
                  //  console.log("Información de Cypher guardada correctamente.");
                    console.log(window.location.origin)
                    console.log(JSON.stringify(infoToSend))
                    window.location.href = `${window.location.origin}/uploadCypherProducts`;

                 // window.location.href = `${window.location.origin}/uploadCypherProducts`;
                } else {
                    console.error("Error al guardar la información de Cypher:", await saveResponse.text());
                    alert("No se pudo guardar la información de Cypher.");
                }

            } else if (responseData.estado === 404) {
                console.error("Error:", responseData.error);
                alert(`Error: ${responseData.error}`);
            } else {
                console.warn("Respuesta inesperada:", responseData);
                alert("Hubo un problema con la solicitud.");
            }
        } else {
            console.error("Error HTTP:", response.status, response.statusText);
            alert(`Error HTTP: ${response.status} - ${response.statusText}`);
        }
    } catch (e) {
        console.error('Error en la solicitud:', e);
        alert('Error al conectar con el servidor');
    }
}








async function editarPagoEstado(id, estado, id_tienda) {

    // Crea el objeto con los datos que se van a enviar
    const dataToSend = {
        estado,
        id_pedido: id,
        id_tienda
    };

    try {
        // Realiza la solicitud con el método DELETE
        const response = await fetch('api/editarPagoEstado', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToSend) // Aquí enviamos el cuerpo con los datos
        });

        console.log('Respuesta del servidor:', response);

        if (response.ok) {
            window.location.reload();
        }

    } catch (e) {
        console.error('Error:', e);
        alert('Error al realizar la solicitud');
    }

}
