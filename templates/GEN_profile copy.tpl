{include file="header-admin.tpl"}

<body>

    <div class="container">
        
        {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
        {assign var="fecha_actual" value=$smarty.now|date_format:"%Y-%m-%d"}

        <div class="profile-vencimiento mt-4">
            {if !isset($userinfo.tienda.fecha_vencimiento)}
            <strong>
                Para activar su cuenta debe abonar
               
            </strong>
            {else}
            <strong>
                El vencimiento de tu tienda es el {$userinfo.tienda.fecha_vencimiento}
                {if $userinfo.tienda.fecha_vencimiento < $fecha_actual}
                    <span class="pagos-vencido"> (VENCIDO)</span>
                {/if}
            </strong>
            {/if}
            
            <a href="payments/{$userinfo.usuario.id}">Ir a pagos 
                <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
                    <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
                    <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
                </svg>
            </a>
        </div>

    {/if}
        

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">   
     <div class="card p-4 mt-4">
        <ul class="nav nav-tabs  " id="myTab" role="tablist">
            <li class="nav-item mr-1" role="presentation">
                <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="true">Perfil</button>
            </li>
            <li class="nav-item mr-1" role="presentation">
                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#Shop" type="button" role="tab" aria-controls="Shop" aria-selected="false">Profile</button>
            </li>

            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="profile-basic-info">
                        <div class="d-flex">
                            <div class="profile-acount-fhalf">
                                <h2>Mi perfil</h2>
                                <hr>
                                <div class="profile-control-info">
                                    <span>Nombre de la cuenta</span>
                                    <input type="text" id="nombreCuenta" value="{$userinfo.usuario.usuario}">
                                </div>
                                <div class="profile-control-info">
                                    <span>Email de la cuenta</span>
                                    <input type="text" id="emailCuenta" value="{$userinfo.usuario.email}">
                                </div>
                                <div class="profile-control-info">
                                    <span>Teléfono de la cuenta</span>
                                    <input type="text" id="telefonoCuenta" value="{$userinfo.usuario.telefono}">
                                </div>
                                
                                {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
                                <hr>
                                <h3>Datos para tus compradores.</h3>
                                <small>Completar estos datos para que tus clientes puedan enviarte dinero.</small>
                                <div class="profile-control-info">
                                    <span>Alias</span>
                                    <input type="text" id="aliasTienda" value="{$userinfo.tienda.alias}">
                                </div>
                                <div class="profile-control-info">
                                    <span>Cbu / Cvu</span>
                                    <input type="text" id="cbuTienda" value="{$userinfo.tienda.cbu}">
                                </div>
                                {/if}
                                
                                <hr>
                                <button 
                                    onclick="saveProfileInfo()"
                                    class="profile-personal-info-save-button">
                                    Guardar
                                </button>
                                
                            </div>
    
                            <script>
                            document.addEventListener('DOMContentLoaded', () => {
                                const inputs = document.querySelectorAll('.profile-control-info input');
                                const saveButton = document.querySelector('.profile-personal-info-save-button');
                                
                                // Ocultar el botón inicialmente
                                saveButton.style.display = 'none';
                                
                                // Almacenar los valores originales de los inputs
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
                        
                                    // Mostrar el botón solo si hay cambios
                                    saveButton.style.display = hasChanges ? 'block' : 'none';
                                }
                            });
                        </script>
                        
                            
                            {if isset($userinfo.tienda) && $userinfo.tienda}
                                {if isset($userinfo.usuario.id_empresa_gestion) && $userinfo.usuario.id_empresa_gestion}
                                    <!-- Aquí el contenido si existe tienda y id_empresa_gestion -->
                                    <div class="profile-acount-shalf">
                                        <strong class="profile-account-title">Enlazado con Cypher Gestión</strong>
    
                                        <div class="profile-account-header">
                                            <img src="./images/cygestionlogo.png" alt="Cypher Gestion" class="profile-account-logo">
                                        </div>
                                        <div class="profile-account-info">
                                            <span>Usuario conectado:</span>
                                            <span class="profile-account-username">{$userinfo.usuario.nombre_gestion}</span>
                                        </div>
                                       
                                    </div>
                                    
                                {else}
                                <div class="profile-acount-shalf">
                                    <!-- Botón para abrir el modal -->
                                    <button class="profile-btn-link-gestion" data-bs-toggle="modal" data-bs-target="#gestionModal">
                                        <span>Enlazar con</span>
                                        <img src="./images/cygestionlogo.png" alt="logo">
                                        
                                    </button>
    
                                    <!-- Modal -->
                                    <div class="modal fade" id="gestionModal" tabindex="-1" aria-labelledby="gestionModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="gestionModalLabel">Enlazar con Cypher Gestión</h5>
                                                </div>
                                                <div class="modal-body">
                                                    <form>
                                                        <!-- Input de Usuario -->
                                                        <div class="mb-3">
                                                            <label for="usuario" class="form-label">Usuario</label>
                                                            <input type="text" class="form-control" id="usuario_cypher" placeholder="Ingrese su usuario">
                                                        </div>
    
                                                        <!-- Input de Contraseña -->
                                                        <div class="mb-3">
                                                            <label for="password" class="form-label">Contraseña</label>
                                                            <input type="password" class="form-control" id="password_cypher" placeholder="Ingrese su contraseña">
                                                        </div>
                                                        <input type="hidden" id="id_usuario" value="{$userinfo.usuario.id}">
                                                        <input type="hidden" id="id_tienda" value="{$userinfo.tienda.id_tienda}">
                                                        <!-- Checkbox para habilitar el input adicional -->
                                                        <div class="form-check mb-3">
                                                            <input type="checkbox" class="form-check-input" id="softwareCheckbox">
                                                            <label class="form-check-label" for="softwareCheckbox">Tengo software dedicado</label>
                                                        </div>
    
                                                        <!-- Input adicional (deshabilitado por defecto) -->
                                                        <div class="mb-3">
                                                            <label for="softwareInput" class="form-label">Nombre del Software</label>
                                                            <input type="text" class="form-control" id="softwareInput_cypher" placeholder="Ingrese el nombre del software" disabled>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                    <button type="submit" class="btn btn-primary" onclick="conectarCypher()">Confirmar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
    
                                    <!-- JavaScript para habilitar/deshabilitar el input -->
                                    <script>
                                    document.getElementById('softwareCheckbox').addEventListener('change', function() {
                                        document.getElementById('softwareInput_cypher').disabled = !this.checked;
                                    });
                                    </script>
    
                                    <!-- Agregar Bootstrap si no lo tienes -->
                              
                                    <small>Si usted cuenta con un usuario en Cypher Gestion, podría importar todos sus productos a la tienda (Requiere plan Medium o superior).</small>
                                </div>
                                {/if}
                            {else}
                            <div class="profile-acount-shalf">
                                <button class="profile-btn-link-gestion">
                                    <small>Si usted cuenta con un usuario en Cypher Gestion, podría importar todos sus productos a la tienda. <strong>Primero crea una tienda.</strong></small>
                                
                                    <img src="./images/cygestionlogo.png" alt="logo">
                                </button>
                            </div>
                            {/if}
    
    
    
    
                                
                          
    
    
                        </div>
                    </div>

                </div>






                
                <div class="tab-pane fade" id="Shop" role="tabpanel" aria-labelledby="contact-tab">

                    <div class="profile-shop-info">
                    



                    


                        {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
                        {if !isset($userinfo.tienda.fecha_vencimiento)}
                        <div class="profile-created-shop-info">
                            <span class="pagos-vencido"> (Realice el primer pago)</span>
                            <span class="pagos-vencido">PARA HABILITAR SU TIENDA DEBE ABONAR EL MES.</span>
                                </div>
                                <a class="pagos-ir-a-pagos" href="payments/{$userinfo.usuario.id}">Ir a pagos 
                                    <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
                                        <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
                                        <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
                                    </svg>
                                </a>
                                <hr>
                           
                            
                                
                            </button>
                            <!-- Botón para abrir el modal -->
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            Eliminar tienda
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 6h18"></path>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                <path d="M10 11v6"></path>
                                <path d="M14 11v6"></path>
                            </svg>
                            </button>
                        {else}
                        {if $userinfo.tienda.fecha_vencimiento < $fecha_actual}
                        <div class="profile-created-shop-info">
                            <span class="pagos-vencido"> (VENCIDO)</span>
                            <span class="pagos-vencido">Su tienda esta vencida, por abone la mensualidad para volver a habilidarla</span>
                                </div>
                                <a class="pagos-ir-a-pagos" href="payments/{$userinfo.usuario.id}">Ir a pagos 
                                    <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
                                        <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
                                        <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
                                    </svg>
                                </a>
                                <hr>
                           
                            
                                
                            </button>
                            <!-- Botón para abrir el modal -->
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            Eliminar tienda
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 6h18"></path>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                <path d="M10 11v6"></path>
                                <path d="M14 11v6"></path>
                            </svg>
                            </button>
                        {else}
                       
                        <div class="profile-created-shop-info">
                         
                            <h5 class="mt-2">{$userinfo.tienda.nombre_simple}</h5>
                            <button class="profile-tienda-button-link">
                                <a href="{$userinfo.tienda.nombre_unico}">
                                    ir a mi tienda
                                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path d="m3 3 7.07 16.97 2.51-7.39 7.39-2.51L3 3z"></path>
                                        <path d="m13 13 6 6"></path>
                                    </svg>
                            </a>
                            </button>
                            <hr>
                            <small>Nombre del dominio</small>
                            {$userinfo.tienda.nombre_unico}
                            <small>cyshops.com/{$userinfo.tienda.nombre_unico}</small>
                            <hr>
                            <small>Colores</small>
                            <label for="colorPicker">Selecciona un color:</label>
                            <div>
                                <input type="color" id="colorPicker" name="color" value="{$userinfo.tienda.color}" class="profile-colorpicker-input">
                            </div>
                            <label for="colorPicker">Selecciona un color para el texto</label>
    
                            {assign var="isChecked" value=($userinfo.tienda.color_texto == '#000000') ? 'checked' : ''}
    
                            <div class="profile-toggle">
                                <input type="checkbox" id="toggle" class="profile-toggle-input" {$isChecked}>
                                <label for="toggle" class="profile-toggle-label">
                                    <span class="profile-toggle-text profile-toggle-white">Blanco</span>
                                    <span class="profile-toggle-text profile-toggle-black">Negro</span>
                                </label>
                            </div>
    
                            
                            
                            <button class="mt-2" onclick="guardarColor('{$userinfo.tienda.nombre_unico}')">
                                Guardar Colores
                            </button>
                            
                           
                           
                            
                                <hr>
                           
                            
                                
                            </button>
                            <!-- Botón para abrir el modal -->
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            Eliminar tienda
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 6h18"></path>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                <path d="M10 11v6"></path>
                                <path d="M14 11v6"></path>
                            </svg>
                            </button>
    
                        </div>
                        {/if}
                        {/if}
                        
                    {else}
                        <!-- Mostrar el enlace para crear la tienda si no existe -->
                        <a href="#" class="profile-create-shop-button" data-bs-toggle="modal" data-bs-target="#createShopModal">
                            Crear tienda 
                            <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 12v6m-6-6h6-6Zm12 0h-6 6Zm-6 0V6v6Z"></path>
                            </svg>
                        </a>
                        
                    {/if}
    
    
    
    
    
                    </div>
                </div>
            </div>
                </div>
            </div>
    </div>
 






        <div class="d-flex mt-4">
            <!-- Div 1: 70% width -->
            <div class="profile-info-col">
                <div class="profile-basic-info">
                    <div class="d-flex">
                        <div class="profile-acount-fhalf">
                            <h2>Mi perfil</h2>
                            <hr>
                            <div class="profile-control-info">
                                <span>Nombre de la cuenta</span>
                                <input type="text" id="nombreCuenta" value="{$userinfo.usuario.usuario}">
                            </div>
                            <div class="profile-control-info">
                                <span>Email de la cuenta</span>
                                <input type="text" id="emailCuenta" value="{$userinfo.usuario.email}">
                            </div>
                            <div class="profile-control-info">
                                <span>Teléfono de la cuenta</span>
                                <input type="text" id="telefonoCuenta" value="{$userinfo.usuario.telefono}">
                            </div>
                            
                            {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
                            <hr>
                            <h3>Datos para tus compradores.</h3>
                            <small>Completar estos datos para que tus clientes puedan enviarte dinero.</small>
                            <div class="profile-control-info">
                                <span>Alias</span>
                                <input type="text" id="aliasTienda" value="{$userinfo.tienda.alias}">
                            </div>
                            <div class="profile-control-info">
                                <span>Cbu / Cvu</span>
                                <input type="text" id="cbuTienda" value="{$userinfo.tienda.cbu}">
                            </div>
                            {/if}
                            
                            <hr>
                            <button 
                                onclick="saveProfileInfo()"
                                class="profile-personal-info-save-button">
                                Guardar
                            </button>
                            
                        </div>

                        <script>
                        document.addEventListener('DOMContentLoaded', () => {
                            const inputs = document.querySelectorAll('.profile-control-info input');
                            const saveButton = document.querySelector('.profile-personal-info-save-button');
                            
                            // Ocultar el botón inicialmente
                            saveButton.style.display = 'none';
                            
                            // Almacenar los valores originales de los inputs
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
                    
                                // Mostrar el botón solo si hay cambios
                                saveButton.style.display = hasChanges ? 'block' : 'none';
                            }
                        });
                    </script>
                    
                        
                        {if isset($userinfo.tienda) && $userinfo.tienda}
                            {if isset($userinfo.usuario.id_empresa_gestion) && $userinfo.usuario.id_empresa_gestion}
                                <!-- Aquí el contenido si existe tienda y id_empresa_gestion -->
                                <div class="profile-acount-shalf">
                                    <strong class="profile-account-title">Enlazado con Cypher Gestión</strong>

                                    <div class="profile-account-header">
                                        <img src="./images/cygestionlogo.png" alt="Cypher Gestion" class="profile-account-logo">
                                    </div>
                                    <div class="profile-account-info">
                                        <span>Usuario conectado:</span>
                                        <span class="profile-account-username">{$userinfo.usuario.nombre_gestion}</span>
                                    </div>
                                   
                                </div>
                                
                            {else}
                            <div class="profile-acount-shalf">
                                <!-- Botón para abrir el modal -->
                                <button class="profile-btn-link-gestion" data-bs-toggle="modal" data-bs-target="#gestionModal">
                                    <span>Enlazar con</span>
                                    <img src="./images/cygestionlogo.png" alt="logo">
                                    
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="gestionModal" tabindex="-1" aria-labelledby="gestionModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="gestionModalLabel">Enlazar con Cypher Gestión</h5>
                                            </div>
                                            <div class="modal-body">
                                                <form>
                                                    <!-- Input de Usuario -->
                                                    <div class="mb-3">
                                                        <label for="usuario" class="form-label">Usuario</label>
                                                        <input type="text" class="form-control" id="usuario_cypher" placeholder="Ingrese su usuario">
                                                    </div>

                                                    <!-- Input de Contraseña -->
                                                    <div class="mb-3">
                                                        <label for="password" class="form-label">Contraseña</label>
                                                        <input type="password" class="form-control" id="password_cypher" placeholder="Ingrese su contraseña">
                                                    </div>
                                                    <input type="hidden" id="id_usuario" value="{$userinfo.usuario.id}">
                                                    <input type="hidden" id="id_tienda" value="{$userinfo.tienda.id_tienda}">
                                                    <!-- Checkbox para habilitar el input adicional -->
                                                    <div class="form-check mb-3">
                                                        <input type="checkbox" class="form-check-input" id="softwareCheckbox">
                                                        <label class="form-check-label" for="softwareCheckbox">Tengo software dedicado</label>
                                                    </div>

                                                    <!-- Input adicional (deshabilitado por defecto) -->
                                                    <div class="mb-3">
                                                        <label for="softwareInput" class="form-label">Nombre del Software</label>
                                                        <input type="text" class="form-control" id="softwareInput_cypher" placeholder="Ingrese el nombre del software" disabled>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                <button type="submit" class="btn btn-primary" onclick="conectarCypher()">Confirmar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- JavaScript para habilitar/deshabilitar el input -->
                                <script>
                                document.getElementById('softwareCheckbox').addEventListener('change', function() {
                                    document.getElementById('softwareInput_cypher').disabled = !this.checked;
                                });
                                </script>

                                <!-- Agregar Bootstrap si no lo tienes -->
                          
                                <small>Si usted cuenta con un usuario en Cypher Gestion, podría importar todos sus productos a la tienda (Requiere plan Medium o superior).</small>
                            </div>
                            {/if}
                        {else}
                        <div class="profile-acount-shalf">
                            <button class="profile-btn-link-gestion">
                                <small>Si usted cuenta con un usuario en Cypher Gestion, podría importar todos sus productos a la tienda. <strong>Primero crea una tienda.</strong></small>
                            
                                <img src="./images/cygestionlogo.png" alt="logo">
                            </button>
                        </div>
                        {/if}




                            
                      


                    </div>
                </div>
            </div>
            
            <!-- Div 2: 30% width -->
            <div class="profile-shop-col">
                <div class="profile-shop-info">
                    



                    


                    {if isset($userinfo.tienda) && !empty($userinfo.tienda)}
                    {if !isset($userinfo.tienda.fecha_vencimiento)}
                    <div class="profile-created-shop-info">
                        <span class="pagos-vencido"> (Realice el primer pago)</span>
                        <span class="pagos-vencido">PARA HABILITAR SU TIENDA DEBE ABONAR EL MES.</span>
                            </div>
                            <a class="pagos-ir-a-pagos" href="payments/{$userinfo.usuario.id}">Ir a pagos 
                                <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
                                    <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
                                    <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
                                </svg>
                            </a>
                            <hr>
                       
                        
                            
                        </button>
                        <!-- Botón para abrir el modal -->
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        Eliminar tienda
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3 6h18"></path>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                        </svg>
                        </button>
                    {else}
                    {if $userinfo.tienda.fecha_vencimiento < $fecha_actual}
                    <div class="profile-created-shop-info">
                        <span class="pagos-vencido"> (VENCIDO)</span>
                        <span class="pagos-vencido">Su tienda esta vencida, por abone la mensualidad para volver a habilidarla</span>
                            </div>
                            <a class="pagos-ir-a-pagos" href="payments/{$userinfo.usuario.id}">Ir a pagos 
                                <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M19 20H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2Z"></path>
                                    <path fill="currentColor" d="M16.5 14a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Z"></path>
                                    <path d="M18 7V5.602a2 2 0 0 0-2.515-1.933l-11 2.934A2 2 0 0 0 3 8.536v.463"></path>
                                </svg>
                            </a>
                            <hr>
                       
                        
                            
                        </button>
                        <!-- Botón para abrir el modal -->
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        Eliminar tienda
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3 6h18"></path>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                        </svg>
                        </button>
                    {else}
                   
                    <div class="profile-created-shop-info">
                     
                        <h5 class="mt-2">{$userinfo.tienda.nombre_simple}</h5>
                        <button class="profile-tienda-button-link">
                            <a href="{$userinfo.tienda.nombre_unico}">
                                ir a mi tienda
                                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path d="m3 3 7.07 16.97 2.51-7.39 7.39-2.51L3 3z"></path>
                                    <path d="m13 13 6 6"></path>
                                </svg>
                        </a>
                        </button>
                        <hr>
                        <small>Nombre del dominio</small>
                        {$userinfo.tienda.nombre_unico}
                        <small>cyshops.com/{$userinfo.tienda.nombre_unico}</small>
                        <hr>
                        <small>Colores</small>
                        <label for="colorPicker">Selecciona un color:</label>
                        <div>
                            <input type="color" id="colorPicker" name="color" value="{$userinfo.tienda.color}" class="profile-colorpicker-input">
                        </div>
                        <label for="colorPicker">Selecciona un color para el texto</label>

                        {assign var="isChecked" value=($userinfo.tienda.color_texto == '#000000') ? 'checked' : ''}

                        <div class="profile-toggle">
                            <input type="checkbox" id="toggle" class="profile-toggle-input" {$isChecked}>
                            <label for="toggle" class="profile-toggle-label">
                                <span class="profile-toggle-text profile-toggle-white">Blanco</span>
                                <span class="profile-toggle-text profile-toggle-black">Negro</span>
                            </label>
                        </div>

                        
                        
                        <button class="mt-2" onclick="guardarColor('{$userinfo.tienda.nombre_unico}')">
                            Guardar Colores
                        </button>
                        
                       
                       
                        
                            <hr>
                       
                        
                            
                        </button>
                        <!-- Botón para abrir el modal -->
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        Eliminar tienda
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3 6h18"></path>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                        </svg>
                        </button>

                    </div>
                    {/if}
                    {/if}
                    
                {else}
                    <!-- Mostrar el enlace para crear la tienda si no existe -->
                    <a href="#" class="profile-create-shop-button" data-bs-toggle="modal" data-bs-target="#createShopModal">
                        Crear tienda 
                        <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 12v6m-6-6h6-6Zm12 0h-6 6Zm-6 0V6v6Z"></path>
                        </svg>
                    </a>
                    
                {/if}





                </div>
            </div>
        </div>
        
    
       
        
    </div>
    
</body>




<div class="modal fade" id="createShopModal" tabindex="-1" aria-labelledby="createShopModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createShopModalLabel">Crear tienda</h5>
                <button type="button" class="btn-close btn" data-bs-dismiss="modal" aria-label="Close">X</button>
            </div>
            <div class="modal-body">
                <div class="d-flex"> <!-- Contenedor flex para alinear todo horizontalmente -->
                    <!-- Card del Formulario -->
                    <div class="profile-modal-info-form flex-grow-1 me-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="shopName" class="form-label">CBU / CVU</label>
                                    <input type="text" class="form-control" id="CBU" name="CBU" required>

                                </div>
                                <div class="mb-3">
                                    <label for="shopName" class="form-label">Alias</label>
                                    <input type="text" class="form-control" id="alias" name="alias" required>

                                </div>
                                    <div class="mb-3">
                                        <label for="shopName" class="form-label">Nombre de la tienda</label>
                                        <input type="text" class="form-control" id="shopName" name="shopName" required>

                                    </div>
                                  
                                    <div class="mb-3">
                                        <label for="shopName" class="form-label">Nombre unico</label>
                                        <input type="text" class="form-control" id="shopUniqueName" name="shopUniqueName" required>
                                        <small>Debe de ser un nombre unico, este sera el url de tu tienda ej: www.cyshops.com/<strong>nombre_unico</strong></small>
                                        <p class="text-danger " id="error_modal_existente"></p>
                                    </div>

                                    <div class="mb-3">
                                        <label for="shopTemplate" class="form-label">Plantilla</label>
                                        <select class="form-select" id="shopTemplate" name="shopTemplate" required>
                                            {foreach from=$userinfo.tipos_plantillas item=plantilla}
                                                <option value="{$plantilla.id_tipo_plantilla}">{$plantilla.nombre}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="mb-3 pl-4">
                                        <input type="checkbox" id="hasCode" name="hasCode" class="form-check-input" onclick="toggleInput()">
                                        <label for="hasCode" class="form-check-label">¿Usted tiene un código?</label>
                                    </div>
                                    
                                    <div class="mb-3 " id="inputContainer" style="display: none;">
                                        <label for="codigo" class="form-label" id="shopLabel">Código:</label>
                                        <input type="text" class="form-control" id="codigo" name="codigo" required>
                                    </div>
                                    
                                    <script>
                                        function toggleInput() {
                                            const checkbox = document.getElementById('hasCode');
                                            const inputContainer = document.getElementById('inputContainer');
                                            
                                            // Mostrar u ocultar el input según el estado del checkbox
                                            if (checkbox.checked) {
                                                inputContainer.style.display = 'block';
                                            } else {
                                                inputContainer.style.display = 'none';
                                            }
                                        }
                                    </script>
                            


                                    <button onclick="validarTienda()" class="btn btn-success">Crear tienda</button>
                            </div>
                        </div>
                    </div>

                    <!-- Cards de Plantillas -->
                    <div class="profile-modal-info-templates d-flex"> <!-- Cards dispuestas horizontalmente -->
                        {foreach from=$userinfo.tipos_plantillas item=plantilla}
                            <div class="card profile-modal-info-card mb-3" style="width: 18rem; margin-right: 10px;" data-id="{$plantilla.id}" data-descripcion="{$plantilla.descripcion}" data-colores="{$plantilla.colores}" data-atributos="{$plantilla.atributos}">
                                <div class="card-body">
                                    <h5 class="card-title">{$plantilla.nombre}</h5>
                                    <p class="card-text">{$plantilla.descripcion}</p>
                                    <p><strong>Colores:</strong> {$plantilla.colores}</p>
                                    <p><strong>Atributos:</strong> {$plantilla.atributos}</p>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Modal de confirmación -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Confirmación de Eliminación</h5>
            </div>
            <div class="modal-body">
                <p>¿Está seguro de que desea eliminar esta tienda? Por favor, escriba la palabra <strong>"Borrar"</strong> para confirmar.</p>
                <input type="text" id="confirmationText" class="form-control" placeholder="Escriba 'Borrar'">
                <div id="error-message" class="text-danger mt-2" style="display:none;">Debe escribir "borrar" para continuar.</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" id="confirmButton" class="btn btn-danger" data-bs-dismiss="modal" disabled
                    
                >Eliminar</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript " src="js/user.js"></script>
<script type="text/javascript " src="js/admin.js"></script>
{include file="adminfooter.tpl"}
<script>
    // Cuando se escribe en el campo de texto
    document.getElementById("confirmationText").addEventListener("input", function() {
        const inputText = this.value.toLowerCase().trim();
        const confirmButton = document.getElementById("confirmButton");
        const errorMessage = document.getElementById("error-message");

        // Verificar si el texto escrito es 'borrar'
        if (inputText === "borrar") {
            confirmButton.disabled = false;  // Habilitar el botón de eliminación
            errorMessage.style.display = "none";  // Ocultar mensaje de error
        } else {
            confirmButton.disabled = true;  // Deshabilitar el botón de eliminación
            errorMessage.style.display = "block";  // Mostrar mensaje de error
        }
    });

    // Lógica para el botón de confirmar eliminación (esto solo se ejecuta cuando el botón está habilitado)
    document.getElementById("confirmButton").addEventListener("click", function() {
       // Obtener el id_tienda desde el input
        const idTienda = document.getElementById("id_tienda").value;

        // Hacer una petición fetch para eliminar la imagen del producto
        fetch('api/eliminarTienda', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json', // Especifica el tipo de contenido
            },
            body: JSON.stringify({
                id_tienda: idTienda // Enviar el id_tienda en el cuerpo de la solicitud
            })
        })
        .then(response => response.json())  // Convertir la respuesta en formato JSON
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert("Hubo un error al eliminar la tienda, intente en unos minutos");
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al realizar la solicitud.');
        });

    });
</script>


