$(window).on('load', function () {
    $.ajax({
        url: '/llenarProformasInicio',
        success: function (proformas) {
            let tbody = $('#cuerpoProformas')
            tbody.html('');
            proformas.forEach(proforma => {
                tbody.append(`
                <tr>
                <td id='profNombre'> ${proforma.nombre} </td>
                <td id='profId'> ${proforma.idproforma} </td>
                <td id='profpreciosubtotal'> ${proforma.preciosubtotal} </td>
                <td id='profdescuento'> ${proforma.descuento} </td>
                <td id='profpreciototal'> ${proforma.preciototal} </td>
                <td id='proffechaemision'> ${proforma.fechaemision} </td>
                </tr>
            `)
            }
            )
        }
    })
});

