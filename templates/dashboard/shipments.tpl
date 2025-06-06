<div class="content-stats">
   <div class="activities">
      <h1>Costos de envio</h1>
      <body>
        









      {assign var="enviosData" value=$enviosData}
      {assign var="precioFijoActivado" value=$enviosData.precioFijoActivado}
      {assign var="precioEnvio" value=$enviosData.precioEnvio}
      {assign var="costosEnvio" value=$enviosData.costosEnvio}
      
      <div id="enviosPage" class="formadmin hideform">
      <input type="hidden" name="id_tienda" id="id_tienda" value="{$shopInfo[0]->id_tienda}">

      {if $shopInfo[0]->nombre_unico neq null}
      <div class="dashboard-shipping-alert">
        Hemos detectado que ya tiene una ubicación configurada en su perfil. Para evitar conflictos en los cálculos de envío, recomendamos no modificar este apartado. Si decide hacerlo, le sugerimos seleccionar la opción "precio fijo" y establecer el valor en 0.
      </div>
      {/if}
    
      <hr>
    
      <div class="dashboard-shipping-form-group">
        <div class="dashboard-shipping-checkbox-group">
          <input class="dashboard-shipping-checkbox" type="checkbox" id="precios-envios-togglePrecioEnvio" {if $precioFijoActivado}checked{/if}>
          <label class="dashboard-shipping-checkbox-label" for="precios-envios-togglePrecioEnvio">
            ¿Desea poner un precio fijo en los envíos?
          </label>
        </div>
    
        <div id="precios-envios-precioEnvioContainer" style="{if $precioFijoActivado}display:block;{else}display:none;{/if}">
          <label for="precios-envios-precio_envio" class="dashboard-shipping-checkbox-label">Precio fijo de envío</label>
          <input class="dashboard-shipping-input" id="precios-envios-precio_envio" name="precio_envio" type="text" placeholder="Ingrese el precio fijo" value="{$precioEnvio}">
        </div>
      </div>
    
      <small>Al tener habilitada esta opción TODOS tus pedidos tendrán este valor. Para usar la tabla de costos, desactiva esta opción.</small>
    
      <hr>
    
      <script>
        document.getElementById('precios-envios-togglePrecioEnvio').addEventListener('change', function () {
          const container = document.getElementById('precios-envios-precioEnvioContainer');
          container.style.display = this.checked ? 'block' : 'none';
        });
      </script>
    
      <div class="dashboard-shipping-form-group">
        <h2>Tabla de Costos de Envío</h2>
        <table class="dashboard-shipping-table">
          <thead class="dashboard-shipping-table-head">
            <tr>
              <th>Rango de Peso (kg)</th>
              <th>Costo de Envío (ARS)</th>
              <th>Opciones</th>
            </tr>
          </thead>
          <tbody id="precios-envios-tabla-envio">
            {if $costosEnvio|@count > 0}
              {foreach from=$costosEnvio item=envio key=idx}
              <tr>
                <td>
                  <span>{$envio.rangoPesoMin} - </span>
                  <input type="number" class="dashboard-shipping-input" value="{$envio.rangoPesoMax}" min="{$envio.rangoPesoMin}" id="precios-envios-peso-min-{$idx+1}">
                </td>
                <td>
                  <input type="number" class="dashboard-shipping-input" value="{$envio.costoEnvio}" id="precios-envios-costo-{$idx+1}">
                </td>
                <td>
                  <button class="dashboard-shipping-btn dashboard-shipping-btn-danger" onclick="eliminarFila(this)">Eliminar</button>
                </td>
              </tr>
              {/foreach}
            {else}
            <tr>
              <td>
                <span>1 - </span>
                <input type="number" class="dashboard-shipping-input" value="5" min="1" id="precios-envios-peso-min-1">
              </td>
              <td>
                <input type="number" class="dashboard-shipping-input" value="500" id="precios-envios-costo-1">
              </td>
              <td>
                <button class="dashboard-shipping-btn dashboard-shipping-btn-danger" onclick="eliminarFila(this)">Eliminar</button>
              </td>
            </tr>
            {/if}
          </tbody>
        </table>
    
        <button class="dashboard-shipping-btn dashboard-shipping-btn-add" onclick="agregarFila()">Agregar fila</button>
      </div>
    
      <hr>
    
      <button id="precios-envios-GuardarLista" class="dashboard-shipping-btn dashboard-shipping-btn-save">Guardar Lista</button>
    </div>
    
          <script>
              function eliminarFila(btn) {
                  const fila = btn.closest('tr');
                  fila.remove();
              }
      
              function agregarFila() {
                  const tabla = document.getElementById('precios-envios-tabla-envio');
                  const filas = tabla.getElementsByTagName('tr');
                  const ultimaFila = filas[filas.length - 1];
                  const ultimoInputMax = ultimaFila.querySelector('td input[type="number"]');
                  const ultimoMax = parseInt(ultimoInputMax.value);
      
                  const nuevoMin = ultimoMax + 1;
                  const nuevoMax = nuevoMin + 4;
      
                  // Crear nueva fila
                  const nuevaFila = document.createElement('tr');
      
                  // Columna rango
                  const tdRango = document.createElement('td');
                  const spanMin = document.createElement('span');
                  spanMin.textContent = nuevoMin + ' - ';
                  const inputMax = document.createElement('input');
                  inputMax.type = 'number';
                  inputMax.className = 'form-control d-inline w-auto';
                  inputMax.value = nuevoMax;
                  inputMax.min = nuevoMin;
                  tdRango.appendChild(spanMin);
                  tdRango.appendChild(inputMax);
      
                  // Columna precio
                  const tdPrecio = document.createElement('td');
                  const inputPrecio = document.createElement('input');
                  inputPrecio.type = 'number';
                  inputPrecio.className = 'form-control';
                  inputPrecio.value = 0;
                  tdPrecio.appendChild(inputPrecio);
      
                  // Columna opciones
                  const tdOpciones = document.createElement('td');
                  const btnEliminar = document.createElement('button');
                  btnEliminar.className = 'dashboard-shipping-btn dashboard-shipping-btn-danger';
                  btnEliminar.textContent = 'Eliminar';
                  btnEliminar.onclick = function () {
                      eliminarFila(btnEliminar);
                  };
                  tdOpciones.appendChild(btnEliminar);
  
                  // Agregar columnas a la fila
                  nuevaFila.appendChild(tdRango);
                  nuevaFila.appendChild(tdPrecio);
                  nuevaFila.appendChild(tdOpciones);
      
                  // Agregar fila a la tabla
                  tabla.appendChild(nuevaFila);
              }
      
              // Evento para el botón de guardar lista
              document.querySelector('#precios-envios-GuardarLista').addEventListener('click', function (e) {
              e.preventDefault();
      
              const precioFijoActivado = document.getElementById('precios-envios-togglePrecioEnvio').checked;
              const precioEnvio = document.getElementById('precios-envios-precio_envio').value;
              const idTienda = document.getElementById('id_tienda').value;
      
              const tablaEnvio = document.getElementById('precios-envios-tabla-envio');
              const filas = tablaEnvio.getElementsByTagName('tr');
              const costosEnvio = [];
      
              for (let i = 0; i < filas.length; i++) {
                  const celdas = filas[i].getElementsByTagName('td');
      
                  const rangoMin = celdas[0].querySelector('span')?.textContent.replace(' - ', '') ?? '';
                  const rangoMax = celdas[0].querySelector('input[type="number"]')?.value ?? '';
                  const costoEnvio = celdas[1].querySelector('input')?.value ?? '';
      
                  const rangoPeso = rangoMin + ' - ' + rangoMax;
      
                  costosEnvio.push({
                      rangoPeso: rangoPeso,
                      costoEnvio: costoEnvio
                  });
              }
      
              const datos = {
                  id_tienda: idTienda,
                  precioFijoActivado: precioFijoActivado,
                  precioEnvio: precioEnvio,
                  costosEnvio: costosEnvio
              };
      
              fetch('api/guardarlistaenvios', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: JSON.stringify(datos)
              })
              .then(response => response.json())
              .then(data => {
                  if (data.success) {
                      alert(data.message);
                  } else {
                      alert("Error: " + data.message);
                      console.error(data.error);
                  }
              })
              .catch(error => {
                  console.error('Error en la solicitud:', error);
                  alert('Error al comunicarse con el servidor.');
              });
          });
      </script>
      </div>

























      </body>
      </html>

      </html>
   </div>
</div>