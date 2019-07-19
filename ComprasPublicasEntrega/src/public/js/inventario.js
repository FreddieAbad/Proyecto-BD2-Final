$(window).on('load', function () {
    $.ajax({
        url: '/llenarInventarioInicio',
        success: function (items) {
            let tbody = $('#cuerpoInventario')
            tbody.html('');
            items.forEach(item => {
                tbody.append(`
                <tr>
                <td id='itemId'>${item.iditem}</td>
                <td id='itemDescripcion'>${item.descripcion}</td>
                <td id='itemCantidad'>${item.cantidad}</td>
                </tr>
            `)
            }
            )
        }
    })
});


