$(window).on('load', function () {
    $.ajax({
        url: '/llenarCatalogoInicio',
        success: function (items) {
            let tbody = $('#cuerpoCatalogo')
            tbody.html('');
            items.forEach(soli => {
                tbody.append(`
                <tr>
                <td id='itemId'>${soli.iditem}</td>
                <td id='itemDescripcion'>${soli.descripcion}</td>
                <td>
                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarItem"> Actualizar</button>
                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarItem"> Eliminar </button>
                </td>
                </tr>
            `)
            }
            )
        }
    })
});


$(function () {
    //Agregar Nuevos Items
    $("#btnAgregarItem").click(function () {
        event.preventDefault();
        var nuevoItem = $('#iptNuevoItem').val();
        nuevoItem = String(nuevoItem);
        console.log(nuevoItem)
        if (nuevoItem.length != 0) {
            $.ajax({
                url: '/agregarNuevoItem',
                method: 'post',
                data: {
                    item: nuevoItem,
                },
                success: function (response) {
                    console.log(response.estado)
                    if (response.estado != 0) {
                        alert('Item Agregado Exitosamente');
                        var pageName = "catalogo.html";
                        document.location.href = pageName;
                    } else {
                        $("#username").val('');
                        alert('Ha surgido un error, por favor vuelve a intentar.');
                    }
                },
                error: function () {
                    alert('Ha surgido un error, por favor vuelve a intentar.')
                }
            });
        } else {
            alert('Ingrese usuario y contraseña');
        }
    })

    //Eliminar Item
    $('#divTablaCatalogo').on('click', '#btnEliminarItem', function () {
        let row = $(this).closest('tr')
        let id = row.find('#itemId').text();
        if (confirm("Eliminará el item " + id + ". \n  ¿Confimar?")) {
            $.ajax({
                url: '/eliminarItem/' + id,
                method: 'delete',
                success: function (response) {
                    console.log(response)
                    let itemInfo = $('#infoItem')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card text-white bg-danger mb-3" >
                            <div class="card-header">Item Eliminada</div>
                        </div>
                    `)
                    //refresco tabla catalogo
                    $.ajax({
                        url: '/llenarCatalogoInicio',
                        success: function (items) {
                            let tbody = $('#cuerpoCatalogo')
                            tbody.html('');
                            items.forEach(soli => {
                                tbody.append(`
                                <tr>
                                <td id='itemId'>${soli.iditem}</td>
                                <td id='itemDescripcion'>${soli.descripcion}</td>
                                <td>
                                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarItem"> Actualizar</button>
                                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarItem"> Eliminar </button>
                                </td>
                                </tr>
                            `)
                            }
                            )
                        }
                    })

                }
            })
        }
    })


    //Actualizar Item
    $('#divTablaCatalogo').on('click', '#btnActualizarItem', function () {
        let row = $(this).closest('tr')
        let id = row.find('#itemId').text();
        let descItem = row.find('#itemDescripcion').text();
        item = ""
        var ventana = prompt("Ingresa la nueva descripcion del Item ", descItem);
        if (ventana != null || ventana != "") {
            $.ajax({
                url: '/actualizarItem/' + id,
                method: 'post',
                data:{
                    descripcion:ventana
                },
                
                success: function (response) {
                    console.log(response)
                    let itemInfo = $('#infoItem')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card text-white bg-warning mb-3" >
                            <div class="card-header">Item Actualizado</div>
                        </div>
                    `)
                    //refresco tabla catalogo
                    $.ajax({
                        url: '/llenarCatalogoInicio',
                        success: function (items) {
                            let tbody = $('#cuerpoCatalogo')
                            tbody.html('');
                            items.forEach(soli => {
                                tbody.append(`
                                <tr>
                                <td id='itemId'>${soli.iditem}</td>
                                <td id='itemDescripcion'>${soli.descripcion}</td>
                                <td>
                                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarItem"> Actualizar</button>
                                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarItem"> Eliminar </button>
                                </td>
                                </tr>
                            `)
                            }
                            )
                        }
                    })

                }
            })
        }

    })
});