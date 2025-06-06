<div class="content-stats">
   <div class="activities">
      <h1>Estadisticas</h1>
      <body>
         <div class="as-grid">
            <section class="as-section">
               <h2>5 Productos Más Vendidos</h2>
               <canvas id="topSalesChart"></canvas>
            </section>
            <section class="as-section">
               <h2>Productos Mejor Valorados</h2>
               <canvas id="topRatingsChart"></canvas>
            </section>
            <section class="as-section">
               <h2>Categorias Mas Vendida</h2>
               <canvas id="categoriaMasVendidaChart"></canvas>
            </section>
            <section class="as-section">
               <h2>Categorias Mas Visitadas</h2>
               <canvas id="categoriaMasVisitadaChart"></canvas>
            </section>
         </div>
         <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
      </body>
      </html>
      <script>
         // Datos de los productos más vendidos pasados desde PHP a JavaScript usando Smarty
         const productosMasVendidos = {$productoMasVendidos|json_encode};
         
         // Extraer los nombres de productos y las cantidades de vendidos
         const nombresProductos = productosMasVendidos.map(producto => producto.nombre);
         const ventasProductos = productosMasVendidos.map(producto => producto.vendidos);
         
         // Configuración del gráfico
         const ctx = document.getElementById('topSalesChart').getContext('2d');
         const topSalesChart = new Chart(ctx, {
             type: 'bar',
             data: {
                 labels: nombresProductos, // Etiquetas de los productos
                 datasets: [{
                     label: 'Cantidad de Vendidos', // Título de la barra
                     data: ventasProductos, // Datos de las ventas
                     backgroundColor: 'rgba(54, 162, 235, 0.6)', // Color de las barras
                     borderColor: 'rgba(54, 162, 235, 1)',
                     borderWidth: 1
                 }]
             },
             options: {
                 responsive: true,
                 scales: {
                     y: {
                         beginAtZero: true // Asegura que el gráfico comience en 0
                     }
                 }
             }
         });
         
         
         
         
         
         
         
         
         
         // Datos de los productos más valorados pasados desde PHP a JavaScript usando Smarty
         const productosMejorValorados = {$productoMejorValorados|json_encode};
         
         // Extraer los nombres de productos y las valoraciones promedio
         const nombresProductosvaloracion = productosMejorValorados.map(producto => producto.nombre);
         const valoraciones = productosMejorValorados.map(producto => parseFloat(producto.promedio_valoracion));
         
         // Configuración del gráfico
         const ctxvaloracion = document.getElementById('topRatingsChart').getContext('2d');
         const topRatingsChart = new Chart(ctxvaloracion, {
         type: 'bar',
         data: {
             labels: nombresProductosvaloracion, // Etiquetas de los productos
             datasets: [{
                 label: 'Valoración Promedio', // Título de la barra
                 data: valoraciones, // Datos de las valoraciones
                 backgroundColor: 'rgba(75, 192, 192, 0.6)', // Color de las barras
                 borderColor: 'rgba(75, 192, 192, 1)',
                 borderWidth: 1
             }]
         },
         options: {
             responsive: true,
             scales: {
                 y: {
                     beginAtZero: true, // Asegura que el gráfico comience en 0
                     max: 5, // La valoración máxima será 5
                     ticks: {
                         stepSize: 1 // Incrementos de 1 en la escala Y
                     }
                 }
             }
         }
         });
         
         
         
         
         document.addEventListener("DOMContentLoaded", function () {
         // Obtener los datos desde Smarty
         const categoriaMasVisitada = {$categoriaMasVisitada|@json_encode};
         
         // Extraer nombres de categorías y sus rankings
         const nombres = categoriaMasVisitada.map(cat => cat.nombre);
         const rankings = categoriaMasVisitada.map(cat => parseInt(cat.rank));
         
         // Configurar el gráfico
         const ctx = document.getElementById('categoriaMasVisitadaChart').getContext('2d');
         new Chart(ctx, {
         type: 'bar',
         data: {
         labels: nombres,
         datasets: [{
             label: 'Ranking de Visitas',
             data: rankings,
             backgroundColor: 'rgba(54, 162, 235, 0.6)',
             borderColor: 'rgba(54, 162, 235, 1)',
             borderWidth: 1
         }]
         },
         options: {
         responsive: true,
         scales: {
             y: {
                 beginAtZero: true,
                 ticks: {
                     stepSize: 10
                 }
             }
         }
         }
         });
         });
         
         
         
         
         document.addEventListener("DOMContentLoaded", function () {
         // Obtener los datos desde Smarty
         const categoriaMasVendida = {$categoriaMasVendida|@json_encode};
         
         // Extraer nombres de categorías y sus totales vendidos
         const nombres = categoriaMasVendida.map(cat => cat.nombre);
         const totalVendidos = categoriaMasVendida.map(cat => parseInt(cat.total_vendidos));
         
         // Configurar el gráfico
         const ctx = document.getElementById('categoriaMasVendidaChart').getContext('2d');
         new Chart(ctx, {
         type: 'bar',
         data: {
         labels: nombres,
         datasets: [{
             label: 'Total Vendidos',
             data: totalVendidos,
             backgroundColor: 'rgba(255, 99, 132, 0.6)',
             borderColor: 'rgba(255, 99, 132, 1)',
             borderWidth: 1
         }]
         },
         options: {
         responsive: true,
         scales: {
             y: {
                 beginAtZero: true,
                 ticks: {
                     stepSize: 1
                 }
             }
         }
         }
         });
         });
         
      </script>
      </html>
   </div>
</div>