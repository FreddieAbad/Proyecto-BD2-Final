$(window).on('load', function () {
    $.ajax({
        url: '/llenarProveedorInicio',
        success: function (proveedores) {
            let tbody = $('#cuerpoProveedores')
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
                <td id='provMapa'>${proveedor.longitud + '$' + proveedor.latitud} </td>
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

    //Eliminar Proveedor
    $('#divtablaProveedores').on('click', '#btnEliminarProveedor', function () {
        let row = $(this).closest('tr')
        let id = row.find('#provId').text();
        let nombre = row.find('#provNombre').text();
        if (confirm("El proveedor " + nombre + " se inactivará. \n  ¿Confimar?")) {
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
                    //refresco tabla proveedor
                    $.ajax({
                        url: '/llenarProveedorInicio',
                        success: function (proveedores) {
                            let tbody = $('#cuerpoProveedores')
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
                                <td id='provMapa'>${proveedor.longitud + '$' + proveedor.latitud} </td>
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


    //Actualizar Proveedor
    $('#divtablaProveedores').on('click', '#btnActualizarProveedor', function () {
        let row = $(this).closest('tr')
        let idProv = row.find('#provId').text();
        let nombreProv = row.find('#provNombre').text();
        $.ajax({
            url: '/getInfoProveedor/' + idProv,
            success: function (proveedores) {
                proveedores.forEach(soli => {
                    let itemInfo = $('#infoProveedor')
                    itemInfo.html('');
                    itemInfo.append(`
                            <div class="card mt-3 mb-3" >
                                <div class="card-header" >
                                    <form class="form-inline">
                                        <h5>Identificador de  Proveedor:  #</h5>
                                        <h5 id="idProvActualizar"> ${soli.idproveedor}</h5>
                                    </form>
                                </div>
                                <div class="card-body">
                                    <div class="row" id="infoSoliAct">
                                        <div class="col-3">
                                            <h5>Nombre </h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.nombre}" id="iptProvNombre">
                                        </div>
                                        <div class="col-3">
                                            <h5>RUC</h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.ruc}" id="iptProvRuc">
                                        </div>
                                        <div class="col-3">
                                            <h5>Ciudad</h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.ciudad}" id="iptProvCiudad">
                                        </div>
                                        <div class="col-3">
                                            <h5>Direccion</h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.direccion}" id="iptProvDir">
                                        </div>
                                        <br>
                                        <div class="col-3">
                                            <h5>E-mail </h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.email}" id="iptProvEmail">
                                        </div>
                                        <div class="col-3">
                                            <h5>Pagina Web</h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.paginaweb}" id="iptProvPaginaweb">
                                        </div>
                                        <div class="col-3">
                                            <h5>Estado</h5>
                                            <p id='estadoProv'> ${soli.estado}</p>
                                        </div>
                                        <div class="col-3">
                                            <h5>Latitud-Longitud</h5>
                                            <input class="form-control form-control-sm" type="text" value="${soli.latitud + ' - ' + soli.longitud}" id="iptLatlong">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-9">
                                        </div>
                                        <div class="col-3">
                                            <form class="form-inline">
                                                <button class="btn btn-success btn-sm" id="btnSucActualizarProv"> Actualizar </button>
                                                <button class="btn btn-danger btn-sm" id="btnCancelActualizarProv"> Cancelar </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `)
                }
                )
            }
        })

    });

    //Boton Actualizar Descuento
    $('#infoProveedor').on('click', '#btnSucActualizarProv', function () {
        var id = $("#idProvActualizar").text();
        var nombre = $('#iptProvNombre').val();
        var ruc = $('#iptProvRuc').val();
        var ciudad = $('#iptProvCiudad').val();
        var direccion = $('#iptProvDir').val();
        var email = $('#iptProvEmail').val();
        var paginaweb = $('#iptProvPaginaweb').val();
        var latlong = $('#iptLatlong').val();
        latlong = String(latlong)
        latlong = $.trim(latlong);
        var latlongarray = latlong.split("-");
        var latitud = parseFloat(latlongarray[0]);
        var longitud = parseFloat(latlongarray[1]);
        $.ajax({
            url: '/actualizarProv/' + id,
            method: 'post',
            data: {
                nombre: nombre,
                ruc: ruc,
                ciudad: ciudad,
                direccion: direccion,
                email: email,
                paginaweb: paginaweb,
                latitud: latitud,
                longitud: longitud,
            },
            success: function (response) {
                console.log(response.estado)
                if (response.estado != 0) {
                    alert('Proveedor Actualizado');
                    var pageName = "proveedor.html";
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

    //Agregar Proveedor
    $('#divAgregarProv').on('click', '#btnAgregarProveedor', function () {
        let itemInfo = $('#infoProveedor')
        itemInfo.html('');
        itemInfo.append(`
            <div class="card mt-3 mb-3" >
                <div class="card-header" >
                    <form class="form-inline">
                        <h5>Agregar Proveedor</h5>
                    </form>
                </div>
                <div class="card-body">
                    <div class="row" id="infoSoliAct">
                        <div class="col-3">
                            <h5>Nombre </h5>
                            <input class="form-control form-control-sm" type="text"  id="iptAgregarProvNombre">
                        </div>
                        <div class="col-3">
                            <h5>RUC</h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarProvRuc">
                        </div>
                        <div class="col-3">
                            <h5>Ciudad</h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarProvCiudad">
                        </div>
                        <div class="col-3">
                            <h5>Direccion</h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarProvDir">
                        </div>
                        <br>
                        <div class="col-3">
                            <h5>E-mail </h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarProvEmail">
                        </div>
                        <div class="col-3">
                            <h5>Pagina Web</h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarProvPaginaweb">
                        </div>
                        <div class="col-3">
                            <h5>Estado</h5>
                            <p id='estadoProv'>Pendiente</p>
                        </div>
                        <div class="col-3">
                            <h5>Latitud-Longitud</h5>
                            <input class="form-control form-control-sm" type="text" id="iptAgregarLatlong">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-9">
                        </div>
                        <div class="col-3">
                            <form class="form-inline" id="formProv">
                                <button class="btn btn-success btn-sm" id="btnSucAgregarProv">Agregar</button>
                                <button class="btn btn-danger btn-sm" id="btnCancelAgregarProv">Cancelar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        `)
    });
    //Boton Agregar Proveedor
    $('#infoProveedor').on('click', '#btnSucAgregarProv', function () {
        // No Refresh page
        event.preventDefault();
        var nombre = $('#iptAgregarProvNombre').val();
        var ruc = $('#iptAgregarProvRuc').val();
        var ciudad = $('#iptAgregarProvCiudad').val();
        var direccion = $('#iptAgregarProvDir').val();
        var email = $('#iptAgregarProvEmail').val();
        var paginaweb = $('#iptAgregarProvPaginaweb').val();
        var latlong = $('#iptAgregarLatlong').val();
        latlong = String(latlong)
        latlong = $.trim(latlong);
        var latlongarray = latlong.split("-");
        var latitud = parseFloat(latlongarray[0]);
        var longitud = parseFloat(latlongarray[1]);
        //alert(nombre+ruc+ciudad+direccion+email+paginaweb+latitud+longitud)
        $.ajax({
            url: '/agregarProv',
            method: 'post',
            data: {
                nombre: nombre,
                ruc: ruc,
                ciudad: ciudad,
                direccion: direccion,
                email: email,
                paginaweb: paginaweb,
                latitud: latitud,
                longitud: longitud,
            },
            success: function (response) {
                console.log(response.estado)
                if (response.estado != 0) {
                    alert('Exitoso Registro de Proveedor');
                    var pageName = "proveedor.html";
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