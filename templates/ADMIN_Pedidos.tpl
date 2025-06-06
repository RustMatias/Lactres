{include file="header-admin.tpl"}



<div class="container-fluid mt-3 ">

{include file="ADMIN_sidenav_mobile.tpl"}

    <div class="row">
    {include file="ADMIN_sidenav.tpl"}
        
        
        <div class="col-md-11">

            <div class="d-flex flex-wrap align-items-center">

                <div class=" ap-btn-admin-up d-flex align-items-center mb-2">
                    <small>Realizados: {$estadisticas[1]}</small>
                </div>
                <div class=" ap-btn-admin-up d-flex align-items-center mb-2">
                    <small>Confirmados: {$estadisticas[2]}</small>
                </div>
                <div class=" ap-btn-admin-up d-flex align-items-center mb-2">
                    <small>Preparados: {$estadisticas[3]}</small>
                </div>
                <div class=" ap-btn-admin-up d-flex align-items-center mb-2">
                    <small>Enviados: {$estadisticas[4]}</small>
                </div>
                <div class=" ap-btn-admin-up d-flex align-items-center mb-2">
                    <small>Entregados: {$estadisticas[5]}</small>
                </div>
            </div>
            
            <div class="gp-container">
                <h1>Administrar Pedidos</h1>
                
                <!-- Barra de filtros -->
                <div class="ap-filters">
                   
                    
                    <form method="GET" action="admin/pedidos">
                        <input type="text" name="search" placeholder="Nombre o código" class="ap-input" value="{$search}">
                        {if $smarty.session.GRUPO == "C"}  
                        <select name="estado" class="ap-select">
                            <option value="">Todos los estados</option>
                      

                            {foreach from=$estadoNombres item=estadoValue key=estadoKey}
                                <option value="{$estadoKey}" {if $estadoKey == $currentEstado}selected{/if}>{$estadoValue}</option>
                            {/foreach}

                  
                        </select>
                    {/if}
                        <button type="submit" class="ap-button">Filtrar</button>
                    </form>
                </div>
                
                <table class="ap-order-table ">
                    <thead>
                        <tr>
                      <!--       <th>ID</th> -->

                            <th>Código de Compra</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Cantidad de Productos</th>
                            <th>Monto Total</th>
                            <th>Nombre Usuario</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$pedidos item=pedido}
                            <tr>
                              <!--   <td>{$pedido->id_compra}</td> -->

                                <td>{$pedido->codigo_compra}</td>
                                <td>{$pedido->fecha}</td>
                                <td>{$estadoNombres[$pedido->estado]}</td>
                                <td>
                                    {if $pedido->productos}
                                        {assign var="productos" value=$pedido->productos|@json_decode:true}
                                        {if $productos && $productos|@count > 0}
                                            {assign var="cantidadProductos" value=0}
                                            {foreach from=$productos item=producto}
                                                {assign var="cantidadProductos" value=$cantidadProductos + $producto[1]|@intval}
                                            {/foreach}
                                            {$cantidadProductos}
                                        {else}
                                            0
                                        {/if}
                                    {else}
                                        0
                                    {/if}
                                </td>
                                <td>
                                    {if isset($pedido->total_monto) && $pedido->total_monto}
                                        ${$pedido->total_monto|number_format:2}
                                    {else}
                                        $0.00
                                    {/if}
                                </td>
                                <td>{$pedido->usuario}</td>
                                <td><a href="admin/gestionarpedido/{$pedido->id_compra}" class="ap-manage-button">Gestionar</a></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                <nav aria-label="Page navigation" class="ap-pagination">
                    <ul class="pagination">
                        {if $currentPage > 1}
                        <li class="page-item">
                            <a class="page-link" href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$currentPage-1}">Anterior</a>
                        </li>
                        {/if}

                        {section name=page loop=$totalPages}
                        <li class="page-item {if $smarty.section.page.index+1 == $currentPage}active{/if}">
                            <a class="page-link" href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$smarty.section.page.index+1}">
                                {$smarty.section.page.index+1}
                            </a>
                        </li>
                        {/section}

                        {if $currentPage < $totalPages}
                        <li class="page-item">
                            <a class="page-link" href="admin/pedidos?search={$search}&estado={$currentEstado}&page={$currentPage+1}">Siguiente</a>
                        </li>
                        {/if}
                    </ul>
                </nav>
                
                </div>

        </div>
    </div>




{include file="adminfooter.tpl"}
