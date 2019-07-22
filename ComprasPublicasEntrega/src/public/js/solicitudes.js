/**
 * CARGA DE DATOS DE SOLICITUDES AL REFRESCAR-ABRIR PAGINA
 */
$(window).on('load', function () {
    $.ajax({
        url: '/llenarSolicitudesInicio',
        success: function (solicitudes) {
            let tbody = $('#cuerpoSolicitudes')
            tbody.html('');
            solicitudes.forEach(soli => {
                /*if (soli.nombre === "123321123") {
                    console.log('Aqui no ha pasado nada')
                } else {
                    */
                tbody.append(`
                <tr>
                <td id='soliId'>${soli.idsolicitud}</td>
                <td id='soliFechaCreacion'>${soli.fechainicio}</td>
                <td id='soliFechaFin'>${soli.fechafin}</td>
                <td id='soliEncargado'>${soli.nombres + ' ' + soli.apellidos}</td>
                <td id='soliSubtotal'>${soli.preciosubtotal}</td>
                <td id='soliTotal'>${soli.preciototal}</td>
                <td id='soliDescuento'>${soli.descuento}</td>
                <td id='soliEstado'>${soli.descripcion}</td>
                <td>
                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarSoli"> Actualizar</button>
                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarSoli"> Eliminar </button>
                </td>
                </tr>
            `)
            }
            )
        }
    })
});

/**
 * CRUD ITEMS
 */
$(function () {
    //Eliminar Item
    $('#divTablaSolicitudes').on('click', '#btnEliminarSoli', function () {
        let row = $(this).closest('tr')
        let id = row.find('#soliId').text();
        if (confirm("La solicitud " + id + " se inactivará. \n  ¿Confimar?")) {
            $.ajax({
                url: '/eliminarSolicitud/' + id,
                method: 'delete',
                success: function (response) {
                    console.log(response)
                    let itemInfo = $('#infoSoli')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card text-white bg-danger mb-3" >
                            <div class="card-header">Solicitud Inactiva</div>
                        </div>
                    `)
                    //refresco tabla solicitud
                    $.ajax({
                        url: '/llenarSolicitudesInicio',
                        success: function (solicitudes) {
                            let tbody = $('#cuerpoSolicitudes')
                            tbody.html('');
                            solicitudes.forEach(soli => {
                                /*if (soli.nombre === "123321123") {
                                    console.log('Aqui no ha pasado nada')
                                } else {
                                    */
                                tbody.append(`
                                <tr>
                                <td id='soliId'>${soli.idsolicitud}</td>
                                <td id='soliFechaCreacion'>${soli.fechainicio}</td>
                                <td id='soliFechaFin'>${soli.fechafin}</td>
                                <td id='soliEncargado'>${soli.nombres + ' ' + soli.apellidos}</td>
                                <td id='soliSubtotal'>${soli.preciosubtotal}</td>
                                <td id='soliTotal'>${soli.preciototal}</td>
                                <td id='soliDescuento'>${soli.descuento}</td>
                                <td id='soliEstado'>${soli.descripcion}</td>
                                <td>
                                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarSoli"> Actualizar</button>
                                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarSoli"> Eliminar </button>
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
    $('#divTablaSolicitudes').on('click', '#btnActualizarSoli', function () {
        let row = $(this).closest('tr')
        let id = row.find('#soliId').text();
        $.ajax({
            url: '/getInfoSolicitud/' + id,
            success: function (solicitudes) {
                let tbody = $('#cuerpoSolicitudes')
                tbody.html('');
                solicitudes.forEach(soli => {
                    let itemInfo = $('#infoSoli')
                    itemInfo.html('');
                    itemInfo.append(`
                        <div class="card mt-3 mb-3" >
                            <div class="card-header" >
                                <form class="form-inline">
                                    <h5>Identificador de  Solicitud:  #</h5>
                                    <h5 id="idSoliActualizar"> ${soli.idsolicitud}</h5>
                                </form>
                            </div>
                            <div class="card-body">
                                <div class="row" id="infoSoliAct">
                                    <div class="col-3">
                                        <h5>Descuento </h5>
                                        <input class="form-control form-control-sm" type="text" value="${soli.descuento}" id="descuentoActualizar">
                                    </div>
                                    <div class="col-3">
                                        <h5>Estado</h5>
                                        <p id="estadoActualizar"> ${soli.descripcion}</p>
                                    </div>
                                    <div class="col-3">
                                        <h5>Encargado</h5>
                                        <p id='soliEncargado'> ${soli.nombres + ' ' + soli.apellidos}</p>
                                    </div>
                                    <div class="col-3">
                                        <h5>Fecha Fin</h5>
                                        <p id='soliFechaFin'> ${soli.fechafin}</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-8">
                                    </div>
                                    <div class="col-4">
                                        <form class="form-inline">
                                            <button class="btn btn-info btn-sm" id="btnSucListarItemSoli"> Listar Items </button>
                                            <button class="btn btn-success btn-sm" id="btnSucActualizarSoli"> Actualizar </button>
                                            <button class="btn btn-danger btn-sm" id="btnCancelActualizarSoli"> Cancelar </button>
                                        </form>
                                    </div>
                                </div>
                                <div id="tablaItemSoliAct">
                                </div>
                            </div>
                        </div>
                    `)
                }
                )
            }
        })
    })
    //Boton Actualizar Descuento
    $('#infoSoli').on('click', '#btnSucActualizarSoli', function () {
        var id = $("#idSoliActualizar").text();
        var descAct = $('#descuentoActualizar').val();
        $.ajax({
            url: '/actualizarDescuento',
            method: 'post',
            data: {
                id: id,
                descuentoNuevo: descAct
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

/**
 * Abre Pagina - Solicitar Items
 */
$(function () {
    $('#divAccionesSolicitud').on('click', '#btnCrearSolicitud', function () {
        var pageName = "solicitudesItems.html";
        document.location.href = pageName;
    })
})

function cargarProformaBtn() {
    var pageName = "cargarProforma.html";
    document.location.href = pageName;
}