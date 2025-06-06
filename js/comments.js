'use strict';

document.addEventListener('DOMContentLoaded', e => {
    let idSkin = document.querySelector('param[name=idSkin]').value;
    getComments(idSkin);
    document.querySelector('#comment-form').addEventListener('submit', e => {
        e.preventDefault();
        if(document.querySelector('textarea[name=comment]').value == ''){
            alert("Escribe un comentario");
        }else{
            addComment(idSkin);
        };
    });
    // document.querySelector('#Iremove').addEventListener('remove', e => {
    //     e.preventDefault();
    //     remove(this.idcomment);
    // });
});

async function getComments(idSkin) {
    let valoracionpromedio = 0;
    try {
        // limpio la caja de comentarios : 
        document.querySelector('#commentbox').innerHTML = '';

        let comentarios = [];
        let adminlog = document.querySelector('param[name=admin]').value;
        let valoraciontotal = 0;

        // Me encargo de traer unicamente los comentarios de la skin que estamos viendo.
        const response = await fetch(`api/comments/${idSkin}`);
        const comments = await response.json();
        comentarios = comments;
        for (let index = 0; index < comentarios.length; index++) {
            //if (comentarios[index].usuario != undefined) { // Si existen comentarios
                // calculo la valoracion total
                valoraciontotal = valoraciontotal + Number(comentarios[index].valoracion);
                valoracionpromedio = (valoraciontotal / comentarios.length);
                document.querySelector("#valtotal").innerHTML = "Valoración promedio: " + valoracionpromedio;
                // escribo cantidad total de comentarios
                if (comentarios.length == 1) { document.querySelector("#comTotal").innerHTML = comentarios.length + " comentario "; } else { document.querySelector("#comTotal").innerHTML = comentarios.length + " comentarios "; };
                // Escribo el comentario en la caja de comentarios.

                if (adminlog == 1) { // Si el usuario es un admin, va a tener una lista de comentarios distinta
                    document.querySelector('#commentbox').innerHTML += `
                        <tr>
                        <td class"col-2"><svg  onclick="remove(${comentarios[index].id})" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                        </svg></td>
                    
                        <td class="text-center col-3" >${comentarios[index].usuario}</td>
                        <td class="text-center text-warning col 3" id="${comentarios[index].id}">${comentarios[index].valoracion}</td>
                        <td class="col">${comentarios[index].comentario}</td>
                        </tr>
                    `;
                } else { // Si no es admin, una lista mas basica
                    document.querySelector('#commentbox').innerHTML += `
                        <tr>
                        <td class="text-center col-3" >${comentarios[index].usuario}</td>
                        <td class="text-center text-warning col-3" id="${comentarios[index].id}">${comentarios[index].valoracion}</td>
                        <td class="col">${comentarios[index].comentario}</td>
                        </tr>`;
                }
                // Script que cambia estrellas por el numero de valoracion
                let star = `<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                     </svg>`;

                if (comentarios[index].valoracion == 1) {
                    document.getElementById("" + comentarios[index].id + "").innerHTML = `${star}`;
                } else if (comentarios[index].valoracion == 2) {
                    document.getElementById("" + comentarios[index].id + "").innerHTML = `${star}${star}`;
                } else if (comentarios[index].valoracion == 3) {
                    document.getElementById("" + comentarios[index].id + "").innerHTML = `${star}${star}${star}`;
                } else if (comentarios[index].valoracion == 4) {
                    document.getElementById("" + comentarios[index].id + "").innerHTML = `${star}${star}${star}${star}`;
                } else if (comentarios[index].valoracion == 5) {
                    document.getElementById("" + comentarios[index].id + "").innerHTML = `${star}${star}${star}${star}${star}`;
                };
            //}
        }
    } catch (e) {
        console.log(e);
        valoracionpromedio = 0;
        document.querySelector("#valtotal").innerHTML = "Valoración promedio: " + valoracionpromedio;
    }

};

// Agregar un comentario
async function addComment(idSkin) {
    const comment = {
        usuario: document.querySelector('param[name=username]').value,
        id_user: document.querySelector('param[name=user]').value,
        comentario: document.querySelector('textarea[name=comment]').value,
        valoracion: document.querySelector('#valoracion').innerHTML,
    }
    try {
        const response = await fetch('api/comments/' + idSkin, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(comment)
        });

        const c = await response.json();
        document.querySelector('textarea[name=comment]').value = '';
        getComments(idSkin);
    } catch (e) {
        console.log(e);
    }
}

// Eliminar un comentario
async function remove(idcomment) {
    try {
        const response = await fetch('api/comments/' + idcomment, {
            method: 'DELETE',
        })
        let idSkin = document.querySelector('param[name=idSkin]').value;
        getComments(idSkin);
    } catch (e) {
        console.log(e);
    }
}