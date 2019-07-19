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
                <td id='soliEncargado'>${soli.nombres +' '+ soli.apellidos}</td>
                <td id='soliSubtotal'>${soli.preciosubtotal}</td>
                <td id='soliTotal'>${soli.preciototal}</td>
                <td id='soliDescuento'>${soli.descuento}</td>
                <td id='soliEstado'>${soli.descripcion}</td>
                <td>
                    <button class="delete-button btn btn-warning text-light btn-sm" id="btnActualizarSoli"> Actualizar</button>
                </td>
                <td>
                    <button class="delete-button btn btn-danger text-light btn-sm" id="btnEliminarSoli"> Eliminar </button>
                </td>
                </tr>
            `)
            }
            )
        }
    })
});