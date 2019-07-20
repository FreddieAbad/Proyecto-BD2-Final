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
       // var ventana = prompt("Ingresa la nueva descripcion del Item ", descItem);
        
        //
        let itemInfo = $('#infoItem')
        itemInfo.html('');
        itemInfo.append(`
            <div class="card mt-3 mb-3" >
                <div class="card-header" >
                    <form class="form-inline">
                        <h4>Actualizar Item</h4>
                        <h5>Identificador de  Item:  #</h5>
                        <h5 id="idItemActualizar"> ${id}</h5>
                    </form>
                </div>
                <div class="card-body">
                    <div class="row" id="infoItemAct">
                        <div class="col-9">
                            <h5>Descripcion </h5>
                            <input class="form-control form-control-sm" type="text" value="${descItem}" id="descripcionActualizar">
                        </div>
                        <div class="col-3">
                            <form class="form-inline">
                                <button class="btn btn-success btn-sm" id="btnSucActualizarItem"> Actualizar </button>
                                <button class="btn btn-danger btn-sm" id="btnCancelActualizarItem"> Cancelar </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        `)

        //
/*
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
        }*/

    });
    //Boton Actualizar Descuento
    $('#infoItem').on('click', '#btnSucActualizarItem', function () {
        var id = $("#idItemActualizar").text();
        var descAct = $('#descripcionActualizar').val();
        $.ajax({
            url: '/actualizarItemDesc',
            method: 'post',
            data: {
                id: id,
                descripcionNueva: descAct
            },
            success: function (response) {
                console.log(response.estado)
                if (response.estado != 0) {
                    alert('Item Actualizado');
                    var pageName = "principal.html";
                    document.location.href = pageName;
                } else {
                    alert('Ha surgido un error, por favor vuelve a intentar.');
                }
            },
            error: function () {
                alert('Ha surgido un error, por favor vuelve a intentar.')
            }
        });
    });
});