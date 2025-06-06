<div class="left-content">
               <div class="activities">
                  <h1>Cambiar contraseña</h1>
                  <div class="activity-container">


                     <label for="username" class="dashboard-profile-info-label">Contraseña actual</label>
                     <input type="password" id="old_pass" name="username" class="dashboard-profile-info-input" onkeydown="return evitarEspacios(event)">


                     <label for="email" class="dashboard-profile-info-label">Contraseña nueva</label>
                     <input type="password" id="new_pass" id="email" name="email" class="dashboard-profile-info-input">


                     <label for="telefono" class="dashboard-profile-info-label">Repetir nueva contraseña</label>
                     <input type="password" id="r_new_pass" id="telefono" name="telefono" class="dashboard-profile-info-input" ">


                     <button   onclick="changePassword()" class="dashboard-profile-info-save-button" id="change-password">
                        Cambiar contraseña
                     </button>

                     <script>
                     document.addEventListener("DOMContentLoaded", function () {
                         const oldPass = document.getElementById("old_pass");
                         const newPass = document.getElementById("new_pass");
                         const rNewPass = document.getElementById("r_new_pass");
                         const changeButton = document.getElementById("change-password");
                         
                         // Crear y agregar el mensaje de validación
                         const validationMessage = document.createElement("small");
                         validationMessage.style.display = "block";
                         validationMessage.style.marginTop = "5px";
                         rNewPass.parentNode.appendChild(validationMessage);
                         
                         // Asegurar que el botón esté oculto al inicio
                         changeButton.style.display = "none";
                         
                         function checkInputs() {
                             if (oldPass.value || newPass.value || rNewPass.value) {
                                 changeButton.style.display = "block";
                             } else {
                                 changeButton.style.display = "none";
                             }
                         }
                         
                         function validatePasswords() {
                             if (newPass.value === rNewPass.value && newPass.value.length > 0) {
                                 validationMessage.textContent = "Las contraseñas coinciden";
                                 validationMessage.style.color = "green";
                             } else {
                                 validationMessage.textContent = "Las contraseñas no coinciden";
                                 validationMessage.style.color = "red";
                             }
                         }
                         
                         oldPass.addEventListener("input", checkInputs);
                         newPass.addEventListener("input", checkInputs);
                         rNewPass.addEventListener("input", checkInputs);
                         newPass.addEventListener("input", validatePasswords);
                         rNewPass.addEventListener("input", validatePasswords);
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