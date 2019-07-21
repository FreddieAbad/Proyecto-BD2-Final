/**
 * Evento Seleccionar Item
 */
function btnSeleccionarItem() {
    var table1 = document.getElementById("tablaSeleccionarItem"),
        table2 = document.getElementById("tablaSeleccionadosItem"),
        checkboxes = document.getElementsByName("check-tab1");
    console.log("Val1 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // Creo filas y celdas
            var newRow = table2.insertRow(table2.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // Agrego valores a celdas
            cell1.innerHTML = table1.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table1.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab2'>";
            cell4.innerHTML = "<input id=\"iptCantidadItem_" + table1.rows[i + 1].cells[0].innerHTML + "\" type=\"number\" name=\"quantity\" min=\"1\" max=\"100000\" value=\"1\">";
            // Retiro valores seleccionados de tabla 1
            var index = table1.rows[i + 1].rowIndex;
            table1.deleteRow(index);
            // Decremento contador
            i--;
            console.log(checkboxes.length);
        }
}
/**
 * Evento Deseleccionar Item
 */
function btnDeseleccionarItem() {
    var table1 = document.getElementById("tablaSeleccionarItem"),
        table2 = document.getElementById("tablaSeleccionadosItem"),
        checkboxes = document.getElementsByName("check-tab2");
    console.log("Val1 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // Creo filas y celdas
            var newRow = table1.insertRow(table1.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // Agrego valores a celdas
            cell1.innerHTML = table2.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table2.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab1'>";
            cell4.innerHTML = "";
            // Retiro valores seleccionados
            var index = table2.rows[i + 1].rowIndex;
            table2.deleteRow(index);
            // Decremento contador
            i--;
            console.log(checkboxes.length);
        }
}
/**
 * Evento Bton siguiente pagina
 */
function siguienteItemSeleccionados() {
    var arrayAux = []
    $('#tablaSeleccionadosItem tr').each(function () {
        var texto = $(this).text();
        texto = String(texto)
        var id = texto.split("  ")
        texto = id[0].trim()
        texto = parseInt(texto)
        var aux = "#iptCantidadItem_" + texto
        var cantidad = $(aux).val()//document.getElementById(aux);
        cantidad = parseInt(cantidad)
        var jsonAux = { idItem: texto, cantidadItem: cantidad }
        arrayAux.push(jsonAux)
    });
    arrayAux.shift();
    //alert(JSON.stringify(arrayAux));
    if (arrayAux.length == 0) {
        alert('Debes seleccionar al menos un proveedor para crear la solicitud');
    } else {
        //Items
        var pageName = "solicitarProformas.html?items=" + JSON.stringify(arrayAux);
        document.location.href = pageName;
    }
}

function anteriorItemSeleccionados() {
    var arrayAux = []
    //Recupero Id items
    $('#tablaSeleccionadosItem tr').each(function () {
        var texto = $(this).text();
        texto = String(texto)
        var id = texto.split("  ")
        texto = id[0].trim()
        texto = parseInt(texto)
        arrayAux.push(texto)
    });
    arrayAux.shift();
    //RECUPERO CANTIDAD DE ITEMS
    var temporal = []
    arrayAux.forEach((temp) => {
        var cantidad = "#iptCantidadItem_" + temp
        cantidad = $(cantidad).val()
        alert(temp)
        temporal.push({ idItem: temp, cantidad: cantidad })
    })
    alert(JSON.stringify(temporal));
    if (arrayAux.length != 0) {
        if (confirm("¿Desea olvidar los items seleccionados?", "Borrar")) {
            alert(JSON.stringify(arrayAux));
            var pageName = "principal.html?items=" + JSON.stringify(arrayAux);
            alert(pageName);
            document.location.href = pageName;
        } else {
            var pageName = "principal.html";
            document.location.href = pageName;
        }
    }
}
/**
 * Llena la tabla items al cargar o refrescar pagina
 */
$(window).on('load', function () {
    var pageURL = $(location).attr("href");
    if (pageURL.includes('?') == false) {
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
    } else {
        var url = $(location).attr("href");
        url = url.split('?')
        alert('Validar casos en los que se guardo los adtso '+url)
    }
});
