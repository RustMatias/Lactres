{include file="header-offlog.tpl"}


<style>


.edit-category-container {
    padding: 20px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
}

.edit-category-container form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.edit-category-container label {
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
    display: block;
}

.edit-category-container input,
.edit-category-container textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s ease;
}

.edit-category-container input:focus,
.edit-category-container textarea:focus {
    border-color: #303198;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
    outline: none;
}

.edit-category-container textarea {
    min-height: 80px;
    resize: vertical;
}

.edit-category-container img {
    max-width: 400px;
    object-fit: cover;
    border-radius: 8px;
    margin-top: 10px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.edit-category-container input[type="file"] {
    border: none;
    background: none;
    cursor: pointer;
    font-size: 14px;
    color: #303198;
}

.edit-category-container input[type="file"]::-webkit-file-upload-button {
    background: #303198;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.edit-category-container input[type="file"]::-webkit-file-upload-button:hover {
    background: #0056b3;
}

.edit-category-container button {
    background: #303198;
    color: white;
    border: none;
    padding: 12px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.edit-category-container button:hover {
    background: #0056b3;
}

@media (max-width: 600px) {
    .edit-category-container {
        max-width: 90%;
    }
}



</style>


<div class="container mt-3">
    <div class="edit-category-container">
        <form action="editCategory" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="id_categoria" value="{$categoryInfo->id_categoria}">
            
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" id="nombre" value="{$categoryInfo->nombre}" required>
    
            <label for="descripcion">Descripción:</label>
            <textarea name="descripcion" id="descripcion">{$categoryInfo->descripcion}</textarea>
    
            <label for="imagen">Imagen actual:</label>
            <img src="{$categoryInfo->imagen}" alt="{$categoryInfo->imagen}" name="imagen">
    
            <label for="nueva_imagen">Subir nueva imagen:</label>
            <input type="file" name="nueva_imagen" id="nueva_imagen" accept="image/*">
    
            <button type="submit">Guardar</button>
        </form>
    </div>
</div>

















{include file="footer.tpl"}
