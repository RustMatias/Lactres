{include file="header-admin.tpl"}

<div class="cypher-container">
    <div class="cypher-header-options">
        <h2>Lista de productos</h2>
        <button id="importarSeleccionados">Importar seleccionados
            <svg class="ml-2" width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                <path d="m17 8-5-5-5 5"></path>
                <path d="M12 3v12"></path>
            </svg>
        </button>
    </div>
    <hr>

    <small>A diferencia de Cypher gestion, aqui es 100% necesario establecer el stock de los productos, debido a que los usuarios compradores (clientes) necesitan ver el respaldo real.</small>

    <table class="cypher-table">
        <thead>
            <tr>
                <th><input type="checkbox" id="seleccionarTodo" checked></th>
                <th>Nombre</th>
                <th>Cantidad / Stock</th>
                <th>Precio</th>
                <th>Descripción</th>
            </tr>
        </thead>
        <tbody id="productosTabla">
            <!-- Aquí se insertarán los productos dinámicamente con JavaScript -->
        </tbody>
    </table>
</div>

{include file="adminfooter.tpl"}

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const productos = JSON.parse(sessionStorage.getItem('productos')) || [];

    console.log("Productos cargados:", productos);

    if (productos.length > 0) {
        const tabla = document.getElementById("productosTabla");

        productos.forEach(function(producto) {
            let row = document.createElement("tr");
            row.innerHTML = 
                "<td><input type='checkbox' class='cypher-checkbox' checked data-id='" + producto.id_producto + "'></td>" +
                "<td><input type='text' name='nombre[]' value='" + producto.descripcion + "' class='cypher-input'></td>" +
                "<td class='d-flex'>" +
                    "<input type='number' name='cantidad[]' value='" + (producto.cantidad !== null ? producto.cantidad : '') + "' class='cypher-input cypher-cantidad' " + (producto.cantidad === null ? "disabled" : "") + ">" +
                    "<label class='cypher-label ml-2'>" +
                        "<input type='checkbox' class='cypher-checkbox sin-limite' " + (producto.cantidad === null ? "checked" : "") + "> Sin límite" +
                    "</label>" +
                "</td>" +
                "<td><input type='text' name='valor_venta[]' value='" + producto.valor_venta + "' class='cypher-input cypher-valor'></td>" +
                "<td><input type='text' name='descripcion[]' value='' class='cypher-input' placeholder='Agregue descripción'></td>";

            tabla.appendChild(row);
        });
    } else {
        console.warn("No se encontraron productos en sessionStorage.");
    }

    // Marcar o desmarcar todos los checkboxes, excepto los de "Sin límite"
    document.getElementById("seleccionarTodo").addEventListener("change", function() {
        document.querySelectorAll(".cypher-checkbox").forEach(checkbox => {
            // Verifica si el checkbox NO tiene la clase 'sin-limite' (evita modificarlo)
            if (!checkbox.classList.contains("sin-limite")) {
                checkbox.checked = this.checked;
            }
        });
    });

    // Función para manejar el checkbox "Sin límite"
    document.querySelectorAll('.sin-limite').forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            let inputCantidad = this.closest('td').querySelector('.cypher-cantidad');
            inputCantidad.disabled = this.checked; // Si "sin límite" está marcado, deshabilita la cantidad
            if (this.checked) {
                inputCantidad.value = ''; // Borra la cantidad si "sin límite" está marcado
            }
        });
    });

    // Función para importar productos seleccionados (solo los de la primera columna)
    document.getElementById("importarSeleccionados").addEventListener("click", function() {
        const productosSeleccionados = [];
        const boton = this;
        const textoOriginal = boton.textContent;

        boton.disabled = true;
        boton.textContent = "INSERTANDO, POR FAVOR ESPERE...";

        // Recolectar solo los productos cuyo checkbox en la primera columna está marcado
        document.querySelectorAll(".cypher-checkbox:checked").forEach(checkbox => {
            // Verifica si el checkbox está en la primera columna (no el "sin-limite")
            if (!checkbox.classList.contains("sin-limite")) {
                const row = checkbox.closest("tr");
                const sinLimiteCheckbox = row.querySelector(".sin-limite"); // Checkbox "Sin límite"

                const producto = {
                    id: checkbox.dataset.id,
                    nombre: row.querySelector("input[name='nombre[]']").value,
                    cantidad: row.querySelector("input[name='cantidad[]']").value,
                    precio: row.querySelector("input[name='valor_venta[]']").value,
                    descripcion: row.querySelector("input[name='descripcion[]']").value,
                    sin_limite: sinLimiteCheckbox.checked ? 1 : 0 // Convertir true/false a 1/0
                    };

                // Solo agregar productos si están seleccionados en la primera columna
                productosSeleccionados.push(producto);
            }
        });

        // Verificar si los productos están correctos
        console.log("Productos seleccionados:", JSON.stringify(productosSeleccionados));

        // Hacer la solicitud
        fetch("api/uploadcypherproducts", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                productos: productosSeleccionados
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                 window.location.href = "/admin/stock";
            } else {
                console.error("Error al importar los productos:", data.message);
                boton.disabled = false; // Rehabilita el botón si hubo un error
                boton.textContent = textoOriginal;
            }
        })
        .catch(error => {
            console.error("Error en la solicitud:", error);
            boton.disabled = false; // Rehabilita el botón si hay error de red
            boton.textContent = textoOriginal;
        });
    });
});

</script>
