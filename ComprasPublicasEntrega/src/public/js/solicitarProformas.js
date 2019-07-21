function seleccionarProveedores() {
    var table1 = document.getElementById("tablaSoliProveedores"),
        table2 = document.getElementById("tablaSeleccionadosProv"),
        checkboxes = document.getElementsByName("check-tab11");
    console.log("Val11 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // create new row and cells
            var newRow = table2.insertRow(table2.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4);
            // add values to the cells
            cell1.innerHTML = table1.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table1.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = table1.rows[i + 1].cells[2].innerHTML;
            cell4.innerHTML = table1.rows[i + 1].cells[3].innerHTML;
            cell5.innerHTML = "<input type='checkbox' name='check-tab22'>";

            // remove the transfered rows from the first table [table1]
            var index = table1.rows[i + 1].rowIndex;
            table1.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}

function deseleccionarProveedores() {
    var table1 = document.getElementById("tablaSoliProveedores"),
        table2 = document.getElementById("tablaSeleccionadosProv"),
        checkboxes = document.getElementsByName("check-tab22");
    console.log("Val11 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // create new row and cells
            var newRow = table1.insertRow(table1.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4);
            // add values to the cells
            cell1.innerHTML = table2.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table2.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = table2.rows[i + 1].cells[2].innerHTML;
            cell4.innerHTML = table2.rows[i + 1].cells[3].innerHTML;
            cell5.innerHTML = "<input type='checkbox' name='check-tab11'>";
            // remove the transfered rows from the second table [table2]
            var index = table2.rows[i + 1].rowIndex;
            table2.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}

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
                <td id='provEmail'> ${proveedor.email} </td>
                <td id='provEstado'> ${proveedor.estado} </td>
                <td><input type="checkbox" name="check-tab11"></td>
                </tr>
            `)
            }
            )
        }
    })
});

function siguienteProveedorSeleccionados() {
    var arrayAux = []
    $('#tablaSeleccionadosProv tr').each(function () {
        var texto = $(this).text();
        texto = String(texto)
        var id = texto.split("  ")
        texto = id[0].trim()
        texto = parseInt(texto)
        arrayAux.push(texto)
    });
    arrayAux.shift();
    alert(arrayAux);
    //pendiente siguiente paso
}
function anteriorProveedorSeleccionados() {
    alert('fasd')
}