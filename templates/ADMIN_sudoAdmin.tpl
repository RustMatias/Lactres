{include file="header-admin.tpl"}

<div class="m-4 card p-4">
    <h2>Gestión Administrativa</h2>
    
    <!-- Nav tabs -->
    <ul class="nav nav-tabs mb-4" id="adminTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="nav-link active" id="pago-tab" data-bs-toggle="tab" href="#pago" role="tab" aria-controls="pago" aria-selected="true">Pagos</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="usuarios-tab" data-bs-toggle="tab" href="#usuarios" role="tab" aria-controls="usuarios" aria-selected="false">Usuarios</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="tiendas-tab" data-bs-toggle="tab" href="#tiendas" role="tab" aria-controls="tiendas" aria-selected="false">Tiendas</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="codigos-tab" data-bs-toggle="tab" href="#codigos" role="tab" aria-controls="codigos" aria-selected="false">Codigos</a>
        </li>
    </ul>
    
    <!-- Tab content -->
    <div class="tab-content" id="adminTabsContent">
        
        <!-- Tab 1: Pagos -->
        <div class="tab-pane fade show active" id="pago" role="tabpanel" aria-labelledby="pago-tab">
            <h3>Pagos</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Pago</th>
                        <th>ID Tienda</th>
                        <th>Fecha</th>
                        <th>Monto</th>
                        <th>Comp</th>
                        <th>Pago</th>
                        <th>Accion</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$pagos item=pago}
                    <tr>
                        <td>{$pago->id_pago}</td>
                        <td>{$pago->id_tienda} - <strong>{$pago->nombre_simple}</strong> ({$pago->nombre_unico})</td>
                        <td>{$pago->fecha}</td>
                        <td>{$pago->monto}</td>

                        <td>
                        <small>{$pago->comprobante}</small>
                        <a href="{$pago->comprobante}" download>
                            <svg width="25" height="25" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                <path d="m7 10 5 5 5-5"></path>
                                <path d="M12 15V3"></path>
                              </svg> 
                        </a>
                        </td>
                        <td>

                            {if $pago->pago == 0}
                            En espera 
                            <svg width="25" height="25" fill="none" stroke="orange" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2a10 10 0 1 0 0 20 10 10 0 1 0 0-20z"></path>
                                <path d="M12 6v6l4 2"></path>
                              </svg>
                        {elseif $pago->pago == 1}
                            Validado
                            <svg width="25" height="25" fill="none" stroke="green" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M20 6 9 17l-5-5"></path>
                              </svg>
                        {elseif $pago->pago == 2}
                            Rechazado
                            <svg width="25" height="25" fill="none" stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M18 6 6 18"></path>
                                <path d="m6 6 12 12"></path>
                              </svg>
                        {/if}
                        </td>
                        <td>
                            {if $pago->pago != 1}
                            <button class="btn" onclick="editarPagoEstado({$pago->id_pago}, 1, {$pago->id_tienda})"><svg width="25" height="25" fill="none" stroke="green" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M20 6 9 17l-5-5"></path>
                              </svg></button>
                              {/if}
                              <button class="btn" onclick="editarPagoEstado({$pago->id_pago}, 2,{$pago->id_tienda})">
                                <svg width="25" height="25" fill="none" stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M18 6 6 18"></path>
                                <path d="m6 6 12 12"></path>
                              </svg>
                              </button>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        
        <!-- Tab 2: Usuarios -->
        <div class="tab-pane fade" id="usuarios" role="tabpanel" aria-labelledby="usuarios-tab">
            <h3>Usuarios</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Vendedor</th>
                        <th>Empresa</th>
                        <th>Admin</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$usuarios item=user}
                    <tr>
                        <td>{$user->id}</td>
                        <td>{$user->usuario}</td>
                        <td>{$user->email}</td>
                        <td>{$user->telefono|default:"-"}</td>
                        <td>{if $user->vendedor == "1"}Sí{else}No{/if}</td>
                        <td>{$user->nombre_gestion|default:"-"}</td>
                        <td>{if $user->admin == "1"}Sí{else}No{/if}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        
        <!-- Tab 3: Tiendas -->
        <div class="tab-pane fade" id="tiendas" role="tabpanel" aria-labelledby="tiendas-tab">
            <h3>Tiendas</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Tienda</th>
                        <th>Nombre Tienda</th>
                        <th>ir</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$tiendas item=tienda}
                    <tr>
                        <td>{$tienda->id_tienda}</td>
                        <td>{$tienda->nombre_simple}</td>
                        <td>
                        <a href="{$tienda->nombre_unico}">{$tienda->nombre_simple}</a>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        

         <!-- Tab 3: Tiendas -->
        <div class="tab-pane fade" id="codigos" role="tabpanel" aria-labelledby="codigos-tab">
            <span class="badge bg-warning">Código para tiendas sin cobro</span>
            <form action="agregarcodigocreaciontienda" method="POST" class="d-flex justify-content-between align-items-end w-100 mb-4">
                <div class="form-group me-2 flex-grow-1 m-2">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" class="form-control" id="codigo" name="codigo" required>
                </div>
                
                <div class="form-group me-2 flex-grow-1 m-2">
                    <label for="id_tienda" class="form-label">ID plantilla</label>
                    <input type="text" class="form-control" id="id_plantilla" name="id_plantilla" required>
                </div>
                
                <button type="button" class="btn btn-primary m-2" onclick="generarCodigo()">Randomizar Código</button>
                <button type="submit" class="btn btn-primary m-2" >Generar Código</button>

            </form>
            <script>
                function generarCodigo() {
                    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                    let codigo = '';
                    for (let i = 0; i < 7; i++) {
                        codigo += caracteres.charAt(Math.floor(Math.random() * caracteres.length));
                    }
                    document.getElementById('codigo').value = codigo;
                }

            </script>
            <h3>Codigos</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Codigo</th>
                                                <th>id plantilla</th>

                        <th>Usado</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$codigos item=codigo}
                    <tr>
                        <td>{$codigo->codigo}</td>
                         <td>{$codigo->id_plantilla}</td>
                         <td>
                            {if $codigo->usado == 0}
                                <!-- Ícono para usado = 0 (Verde) -->
                                <svg width="25" height="25" fill="none" stroke="green" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <rect width="18" height="11" x="3" y="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 9.9-1"></path>
                                </svg>
                            {else}
                                <!-- Ícono para usado = 1 (Rojo) -->
                                <svg width="25" height="25" fill="none" stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 2a10 10 0 1 0 0 20 10 10 0 1 0 0-20z"></path>
                                    <path d="m15 9-6 6"></path>
                                    <path d="m9 9 6 6"></path>
                                </svg>
                            {/if}
                        </td>
                        


                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>


<script type="text/javascript " src="js/admin.js"></script>

<!-- Ensure Bootstrap JS and its dependencies are included in your project -->
{include file="adminfooter.tpl"}