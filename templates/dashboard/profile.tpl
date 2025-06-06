<div class="left-content">
               <div class="activities">
                  <h1>Informacion de la cuenta</h1>
                  <div class="activity-container">
                     <label for="username" class="dashboard-profile-info-label">Nombre de usuario</label>
                     <input type="text" id="username" name="username" class="dashboard-profile-info-input" value="{$userinfo.usuario.usuario}" onkeydown="return evitarEspacios(event)">
                     <label for="email" class="dashboard-profile-info-label">Email</label>
                     <input type="text" id="email" name="email" class="dashboard-profile-info-input" value="{$userinfo.usuario.email}">
                     <label for="telefono" class="dashboard-profile-info-label">Teléfono</label>
                     <input type="text" id="telefono" name="telefono" class="dashboard-profile-info-input" value="{$userinfo.usuario.telefono}">
                     <button onclick="saveProfileInfo()" class="dashboard-profile-info-save-button" id="save-info-profile-1" style="display: none;">
                        Guardar
                     </button>

                     <script>
                        // Evitar espacios en el nombre de usuario
                        function evitarEspacios(event) {
                           if (event.key === ' ') {
                              event.preventDefault();
                              return false;
                           }
                        }

                        document.addEventListener('DOMContentLoaded', () => {
                           const inputs = document.querySelectorAll('.dashboard-profile-info-input');
                           const saveButton = document.querySelector('#save-info-profile-1');
                           
                           // Guardar valores iniciales
                           const initialValues = {};
                           inputs.forEach(input => {
                              initialValues[input.id] = input.value;
                              input.addEventListener('input', checkChanges);
                           });

                           function checkChanges() {
                              let hasChanges = false;
                              inputs.forEach(input => {
                                    if (input.value !== initialValues[input.id]) {
                                       hasChanges = true;
                                    }
                              });

                              saveButton.style.display = hasChanges ? 'block' : 'none';
                           }
                        });
                     </script>
                    
                  </div>
               </div>
               
            </div>
            <div class="right-content">
             <div>
               <div class="user-info">
                  
                  <h4> {$smarty.session.USER_NAME}</h4>
                  <img src="https://cdn-icons-png.flaticon.com/512/219/219986.png" alt="user" />
               </div>

               <div class="user-info-use-links">
                  
                  <a href="miscompras"><svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="M8 5.6a4 4 0 0 1 8 0v.8h1.6v-.8a5.6 5.6 0 1 0-11.2 0v.8H8v-.8Z"></path>
                     <path d="M3.047 10.135A2.4 2.4 0 0 1 5.432 8h13.136a2.4 2.4 0 0 1 2.385 2.135l1.245 11.2A2.4 2.4 0 0 1 19.812 24H4.188a2.4 2.4 0 0 1-2.386-2.665l1.245-11.2Z"></path>
                   </svg>Mis compras</a>
                  <a href="carrito"><svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                     <path d="m1.566.57-1.532.46 4.97 16.57H24V7.2a4 4 0 0 0-4-4H2.355L1.566.57Z"></path>
                     <path fill-rule="evenodd" d="M8.8 19.2a2.4 2.4 0 1 0 0 4.8 2.4 2.4 0 0 0 0-4.8ZM8 21.6a.8.8 0 1 1 1.6 0 .8.8 0 0 1-1.6 0Z" clip-rule="evenodd"></path>
                     <path fill-rule="evenodd" d="M20 19.2a2.4 2.4 0 1 0 0 4.8 2.4 2.4 0 0 0 0-4.8Zm-.8 2.4a.8.8 0 1 1 1.6 0 .8.8 0 0 1-1.6 0Z" clip-rule="evenodd"></path>
                   </svg>Carrito</a>
               </div>
               <div>
                  <div class="active-calories">
                     <h1 style="align-self: flex-start">Objetivo de ventas en el mes</h1>
                   
                     {assign var="objetivo" value=100}
                     {assign var="totalCompras" value=$userinfo.compras.total}
                     {assign var="porcentaje" value=($totalCompras * 100) / $objetivo}
                     {if $porcentaje > 100}
                     {assign var="porcentaje" value=100}
                     {/if}
   
                     <div class="active-calories-container">
                        <div class="box" style="--i: {$porcentaje}%">
                           <div class="circle">
                                 <h2>{$porcentaje|round}<small>%</small></h2>
                           </div>
                        </div>
                        <div class="calories-content">
                           <p><span>Hoy:</span> {$userinfo.compras.hoy}</p>
                           <p><span>Esta semana:</span> {$userinfo.compras.semana}</p>
                           <p><span>Hasta ahora:</span> {$userinfo.compras.total}</p>
                        </div>
                     </div>
               </div>
             </div>
               
              

                 

                  </div>
               </div>
              
            </div>