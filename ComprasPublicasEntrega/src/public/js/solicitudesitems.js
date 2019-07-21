function btnSeleccionarItem()
{
    var table1 = document.getElementById("tablaSeleccionarItem"),
        table2 = document.getElementById("tablaSeleccionadosItem"),
        checkboxes = document.getElementsByName("check-tab1");
    console.log("Val1 = " + checkboxes.length);
    for(var i = 0; i < checkboxes.length; i++)
        if(checkboxes[i].checked)
        {
            // create new row and cells
            var newRow = table2.insertRow(table2.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // add values to the cells
            cell1.innerHTML = table1.rows[i+1].cells[0].innerHTML;
            cell2.innerHTML = table1.rows[i+1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab2'>";
            cell4.innerHTML = "<input id=\"iptCantidadItem_"+table1.rows[i+1].cells[0].innerHTML+"\" type=\"number\" name=\"quantity\" min=\"1\" max=\"100000\">";

            // remove the transfered rows from the first table [table1]
            var index = table1.rows[i+1].rowIndex;
            table1.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}

function btnDeseleccionarItem()
{
    var table1 = document.getElementById("tablaSeleccionarItem"),
        table2 = document.getElementById("tablaSeleccionadosItem"),
        checkboxes = document.getElementsByName("check-tab2");
    console.log("Val1 = " + checkboxes.length);
    for(var i = 0; i < checkboxes.length; i++)
        if(checkboxes[i].checked)
        {
            // create new row and cells
            var newRow = table1.insertRow(table1.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // add values to the cells
            cell1.innerHTML = table2.rows[i+1].cells[0].innerHTML;
            cell2.innerHTML = table2.rows[i+1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab1'>";
            cell4.innerHTML = "";

            // remove the transfered rows from the second table [table2]
            var index = table2.rows[i+1].rowIndex;
            table2.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}

function siguienteItemSeleccionados() {
    var arrayAux = []
    $('#tablaSeleccionadosItem tr').each(function () {
        var texto = $(this).text();
        texto = String(texto)
        var id = texto.split("  ")
        texto = id[0].trim()
        texto = parseInt(texto)
        var aux="#iptCantidadItem_"+texto
        var cantidad= $(aux).val()//document.getElementById(aux);
        cantidad=parseInt(cantidad)
        var jsonAux={idItem:texto,cantidadItem:cantidad}
        arrayAux.push(jsonAux)
    });
    arrayAux.shift();
    alert(JSON.stringify(arrayAux));
    //pendiente siguiente paso
}

function anteriorItemSeleccionados() {
    alert('fasd')
}

$(window).on('load', function () {
    $.ajax({
        url: '/llenarCatalogoInicio',
        success: function (items) {
            let tbody = $('#cuerpoItemsSelect')
            tbody.html('');
            items.forEach(item => {
                tbody.append(`
                <tr>
                <td id='itemId'>${item.iditem}</td>
                <td id='itemDescripcion'>${item.descripcion}</td>
                <td><input type="checkbox" name="check-tab1"></td>
                </tr>
            `)
            }
            )
        }
    })
});
