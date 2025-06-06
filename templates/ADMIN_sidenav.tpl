<div class="col-md-1 desktop-admin-menu">
<div class="aside-admin ">

    <div class="d-flex flex-column align-items-center ">
       
        <a href="admin" class="btn d-flex btn-empresarial mb-2">
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M21 12c0-4.969-4.031-9-9-9s-9 4.031-9 9 4.031 9 9 9 9-4.031 9-9Z"></path>
                <path d="M12 8.25v7.5"></path>
                <path d="M15.75 12h-7.5"></path>
              </svg>
            <span class="btn-text">Acciones</span>
        </a>

        <a href="admin/stock" class="btn d-flex btn-empresarial mb-2">
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
            <path d="M3.27 6.96 12 12.01l8.73-5.05"></path>
            <path d="M12 22.08V12"></path>
            </svg>
            <span class="btn-text">Control de productos</span>
        </a>

        </a>
        
        <a href="admin/pedidos" class="btn d-flex btn-empresarial mb-2">
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="m16.5 9.4-9-5.19"></path>
            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
            <path d="M3.27 6.96 12 12.01l8.73-5.05"></path>
            <path d="M12 22.08V12"></path>
            </svg>
            <span class="btn-text">Pedidos</span>
        </a>
        {if $smarty.session.GRUPO == "C"} 
        <a href="admin/stats" class="btn d-flex btn-empresarial mb-2">
            <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" stroke-width="2">
                <path d="M22.5 23.25H2.25a1.5 1.5 0 0 1-1.5-1.5V1.5a.75.75 0 0 1 1.5 0v20.25H22.5a.75.75 0 1 1 0 1.5Z"></path>
                <path d="M7.313 20.25H5.438a1.687 1.687 0 0 1-1.688-1.688v-7.125A1.687 1.687 0 0 1 5.438 9.75h1.875A1.687 1.687 0 0 1 9 11.438v7.124a1.687 1.687 0 0 1-1.688 1.688Z"></path>
                <path d="M14.063 20.25h-1.876a1.687 1.687 0 0 1-1.687-1.688V9.188A1.687 1.687 0 0 1 12.188 7.5h1.874a1.687 1.687 0 0 1 1.688 1.688v9.374a1.687 1.687 0 0 1-1.688 1.688Z"></path>
                <path d="M20.795 20.25H18.92a1.687 1.687 0 0 1-1.688-1.688V6.188A1.687 1.687 0 0 1 18.92 4.5h1.875a1.688 1.688 0 0 1 1.687 1.688v12.375a1.687 1.687 0 0 1-1.687 1.687Z"></path>
              </svg>
            <span class="btn-text">Estadisticas</span>
        </a>
        {/if}
     </div>
</div>
</div>