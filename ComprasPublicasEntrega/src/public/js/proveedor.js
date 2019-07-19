$(window).on('load', function () {
    $.ajax({
        url: '/llenarProveedorInicio',
        success: function (proveedores) {
            let tbody = $('#cuerpoCatalogo')
            tbody.html('');
            proveedores.forEach(proveedor => {
                tbody.append(`
                <tr>
                <td id='provId'> ${proveedor.idproveedor} </td>
                <td id='provNombre'> ${proveedor.nombre} </td>
                <td id='provRUC'> ${proveedor.ruc} </td>
                <td id='provEmail'> ${proveedor.email} </td>
                <td id='provCiudad'> ${proveedor.ciudad} </td>
                <td id='provDireccion'> ${proveedor.direccion} </td>
                <td id='provMapa'>${proveedor.longitud +'$'+ proveedor.latitud} </td>
                <td id='provWeb'> ${proveedor.email}  </td>
                <td id='provEstado'> ${proveedor.estado} </td>
                <td>
                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarProveedor"> Actualizar</button>
                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarProveedor"> Eliminar </button>
                </td>
                </tr>
            `)
            }
            )
        }
    })
});
//REFRESCAR LOAD PAGINA 
/*
$.ajax({
    url: '/llenarProveedorInicio',
    success: function (proveedores) {
        let tbody = $('#cuerpoCatalogo')
        tbody.html('');
        proveedores.forEach(proveedor => {
            tbody.append(`
            <tr>
            <td id='provId'> ${proveedor.idproveedor} </td>
            <td id='provNombre'> ${proveedor.nombre} </td>
            <td id='provRUC'> ${proveedor.ruc} </td>
            <td id='provEmail'> ${proveedor.email} </td>
            <td id='provCiudad'> ${proveedor.ciudad} </td>
            <td id='provDireccion'> ${proveedor.direccion} </td>
            <td id='provMapa'>${proveedor.longitud +'$'+ proveedor.latitud} </td>
            <td id='provWeb'> ${proveedor.email}  </td>
            <td id='provEstado'> ${proveedor.estado} </td>
            <td>
                <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarProveedor"> Actualizar</button>
                <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarProveedor"> Eliminar </button>
            </td>
            </tr>
        `)
        }
        )
    }
})
*/
$(function () {
    //Agregar Nuevos Proveedor --  TERMINAR
    /*$("#btnAgregarItem").click(function () {
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
    })*/

    //Eliminar Item
    $('#divtablaProveedores').on('click', '#btnEliminarProveedor', function () {
        let row = $(this).closest('tr')
        let id = row.find('#itemId').text();
        let id = row.find('#provNombre').text();
        if (confirm("El proveedor " + id + " se inactivará. \n  ¿Confimar?")) {
            $.ajax({
                url: '/eliminarProveedor/' + id,
                method: 'delete',
                success: function (response) {
                    console.log(response)
                    let itemInfo = $('#infoProveedor')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card text-white bg-danger mb-3" >
                            <div class="card-header">Proveedor Inactivo</div>
                        </div>
                    `)
                    //refresco tabla catalogo
                    $.ajax({
                        url: '/llenarProveedorInicio',
                        success: function (proveedores) {
                            let tbody = $('#cuerpoCatalogo')
                            tbody.html('');
                            proveedores.forEach(proveedor => {
                                tbody.append(`
                                <tr>
                                <td id='provId'> ${proveedor.idproveedor} </td>
                                <td id='provNombre'> ${proveedor.nombre} </td>
                                <td id='provRUC'> ${proveedor.ruc} </td>
                                <td id='provEmail'> ${proveedor.email} </td>
                                <td id='provCiudad'> ${proveedor.ciudad} </td>
                                <td id='provDireccion'> ${proveedor.direccion} </td>
                                <td id='provMapa'>${proveedor.longitud +'$'+ proveedor.latitud} </td>
                                <td id='provWeb'> ${proveedor.email}  </td>
                                <td id='provEstado'> ${proveedor.estado} </td>
                                <td>
                                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarProveedor"> Actualizar</button>
                                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarProveedor"> Eliminar </button>
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
    $('#divtablaProveedores').on('click', '#btnActualizarProveedor', function () {
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
                    let itemInfo = $('#infoProveedor')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card text-white bg-warning mb-3" >
                            <div class="card-header">Item Actualizado</div>
                        </div>
                    `)
                    //refresco tabla catalogo
                    $.ajax({
                        url: '/llenarProveedorInicio',
                        success: function (proveedores) {
                            let tbody = $('#cuerpoCatalogo')
                            tbody.html('');
                            proveedores.forEach(proveedor => {
                                tbody.append(`
                                <tr>
                                <td id='provId'> ${proveedor.idproveedor} </td>
                                <td id='provNombre'> ${proveedor.nombre} </td>
                                <td id='provRUC'> ${proveedor.ruc} </td>
                                <td id='provEmail'> ${proveedor.email} </td>
                                <td id='provCiudad'> ${proveedor.ciudad} </td>
                                <td id='provDireccion'> ${proveedor.direccion} </td>
                                <td id='provMapa'>${proveedor.longitud +'$'+ proveedor.latitud} </td>
                                <td id='provWeb'> ${proveedor.email}  </td>
                                <td id='provEstado'> ${proveedor.estado} </td>
                                <td>
                                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarProveedor"> Actualizar</button>
                                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarProveedor"> Eliminar </button>
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