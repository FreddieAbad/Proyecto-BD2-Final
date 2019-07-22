/**
 * FUNCION BOTON SELECCIONAR PROVEEDORES
 */
function seleccionarProveedores() {
    var table1 = document.getElementById("tablaSoliProveedores"),
        table2 = document.getElementById("tablaSeleccionadosProv"),
        checkboxes = document.getElementsByName("check-tab11");
    console.log("Val11 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // Crea nuevas filas y celdas
            var newRow = table2.insertRow(table2.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4);
            // Agregar valores a celdas
            cell1.innerHTML = table1.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table1.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = table1.rows[i + 1].cells[2].innerHTML;
            cell4.innerHTML = table1.rows[i + 1].cells[3].innerHTML;
            cell5.innerHTML = "<input type='checkbox' name='check-tab22'>";
            // Quitar valores seleccionados de tabla 1
            var index = table1.rows[i + 1].rowIndex;
            table1.deleteRow(index);
            // decremento contador
            i--;
            console.log(checkboxes.length);
        }
}

/**
 * FUNCION BOTON DESELECCIONAR PROVEEDORES
 */
function deseleccionarProveedores() {
    var table1 = document.getElementById("tablaSoliProveedores"),
        table2 = document.getElementById("tablaSeleccionadosProv"),
        checkboxes = document.getElementsByName("check-tab22");
    console.log("Val11 = " + checkboxes.length);
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].checked) {
            // Crea nuevas filas y celdas
            var newRow = table1.insertRow(table1.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4);
            // Agregar valores a celdas
            cell1.innerHTML = table2.rows[i + 1].cells[0].innerHTML;
            cell2.innerHTML = table2.rows[i + 1].cells[1].innerHTML;
            cell3.innerHTML = table2.rows[i + 1].cells[2].innerHTML;
            cell4.innerHTML = table2.rows[i + 1].cells[3].innerHTML;
            cell5.innerHTML = "<input type='checkbox' name='check-tab11'>";
            // Quitar valores seleccionados de tabla 1
            var index = table2.rows[i + 1].rowIndex;
            table2.deleteRow(index);
            // decremento contador
            i--;
            console.log(checkboxes.length);
        }
}

/**
 * FUNCION PARA CARGA DE DATOS EN TABLA 1 PROVEEDORES AL CARGAR/REFRESCAR DATOS
 */
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
    if (arrayAux.length == 0) {
        alert('Debes seleccionar al menos un proveedor para crear la solicitud');
    } else {
        //Items
        var pageURL = $(location).attr("href");
        pageURL = String(pageURL).split("=")
        pageURL = String(pageURL[1])
        alert('id 222de items' + pageURL);
        //send email
        $.ajax({
            url: '/getEmailProveedores/' + JSON.stringify(arrayAux),
            method: 'get',
            success: function (response) {
                console.log(response)
                var email = strEmailProv(response)
                //Consigue Datos Email y los envia a los emails de la variable email del paso anterior 
                getDataEmail(email, pageURL)
                ///enviado email
                var pageName = "proformaEnviada.html";
                alert(pageName)
                document.location.href = pageName;
            },
            error: function () {
                alert('Ha surgido un error, por favor vuelve a intentar.')
            }
        });
    }
}

function anteriorProveedorSeleccionados() {
    var arrayAux = []
    //Recupero Id items
    $('#tablaSeleccionadosProv tr').each(function () {
        var texto = $(this).text();
        texto = String(texto)
        var id = texto.split("  ")
        texto = id[0].trim()
        texto = parseInt(texto)
        arrayAux.push(texto)
    });
    arrayAux.shift();
    if (arrayAux.length != 0) {
        if (confirm("¿Desea olvidar los proveedores seleccionados?", "Borrar") == false) {
            var itemsSeleccionados = $(location).attr("href");
            itemsSeleccionados = String(itemsSeleccionados).split("?")
            itemsSeleccionados = itemsSeleccionados[1]
            var pageName = "solicitudesItems.html?proveedores=" + JSON.stringify(arrayAux) + "?" + itemsSeleccionados;
            document.location.href = pageName;
        } else {
            var itemsSeleccionados = $(location).attr("href");
            itemsSeleccionados = String(itemsSeleccionados).split("?")
            itemsSeleccionados = itemsSeleccionados[1]
            var pageName = "solicitudesItems.html?" + itemsSeleccionados;
            document.location.href = pageName;
        }
    } else {
        var pageURL = $(location).attr("href");
        pageURL = pageURL.split("?")
        pageURL = pageURL[1]
        var pageName = "solicitudesItems.html?" + pageURL;
        document.location.href = pageName;
    }
}

//Hago str de emails para enviar a correo por nodemailer
function strEmailProv(emails) {
    var emailstr = ""
    var tam = emails.length
    var contador = 0
    emails.forEach((email) => {
        if (contador == tam - 1) {
            emailstr = emailstr.concat(email.email)
        } else {
            emailstr = emailstr.concat(email.email + ", ")
        }
        contador = contador + 1
    })
    return emailstr
}

function ordenarJsonXProp2(property) {
    return function (a, b) {
        if (a[property] > b[property])
            return 1;
        else if (a[property] < b[property])
            return -1;

        return 0;
    }
}

/**
 * Peticion informacion descricpion
 */
function getDataEmail(email, pageURL) {
    $.ajax({
        url: '/getEmailTexto/' + pageURL,
        success: function (response) {
            var itemsC = strEmailItemsCantidad(response, pageURL)
            sendEmail(email, itemsC);
            alert("Items >>" + itemsC)
            return itemsC;
        },
        error: function () {
            alert('Ha surgido un error, por favor vuelve a intentar.')
            return 'error'
        }
    });
}

//Hago str de items solicitados para enviar a correo por nodemailer
function strEmailItemsCantidad(items, pageURL) {
    var strqueryIds = "\nID   CANTIDAD\n"
    var jsonCompleto = []
    var nuevoJson = pageURL.split("}")//JSON.parse(pageURL)
    nuevoJson.splice(-1, 1)
    nuevoJson.forEach((itms) => {
        var auxiliarJson = itms.split(":")
        var idItem = auxiliarJson[1]
        idItem = idItem.split(",")
        idItem = idItem[0]
        var cantItm = auxiliarJson[2]
        jsonCompleto.push({ id: idItem, cantidadItem: cantItm })
        var aux = "||" + idItem + " || " + cantItm + " ||\n";
        strqueryIds = strqueryIds.concat(aux)
        console.log(idItem + "<<" + cantItm)
    })
    strqueryIds = strqueryIds.concat("\n\nDESCRIPCIONES\n\n")
    nuevoJson.forEach(function (item, index) {
        var aux = "||" + items[index].descripcion + " ||\n";
        strqueryIds = strqueryIds.concat(aux)
    });
    console.log(strqueryIds)
    alert("Cuerpo " + strqueryIds)
    return strqueryIds
}

function sendEmail(emails, itemsC) {
    $.ajax({
        url: '/enviarCorreo',
        method: 'post',
        data: {
            emails: emails,
            texto: itemsC
        },
        success: function (response) {
            console.log(response.estado)
            if (response.estado != 0) {
                alert('EXITO');
                /*     var pageName = "proveedor.html";
                    document.location.href = pageName; */
            } else {
                alert('Ha surgido un error, por favor vuelve a intentar.');
            }
        },
        error: function () {
            alert('Ha surgido un error, por favor vuelve a intentar.')
        }
    });
}