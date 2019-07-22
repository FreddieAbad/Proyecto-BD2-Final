

function cierraSesion() {
    var pageName = "index.html";
    document.location.href = pageName;
}

function actualizarInventario() {
    $.ajax({
        url: '/consumirApiExtInventario',
        success: function (items) {
            alert(items)
            var save = items
            var id = save.split('id_inventario')
            var ex = String(id[1])
            var id2 = ex.split(',')
            var ex2 = String(id2[0])
            var id3 = ex2.split(':')
            var id4 = String(id3[1])
            var idF = id4.substring(1, id4.length - 1);
            //ID
            idF = parseInt(idF)
            //            id=id[0]
            //alert(idF)

            var cant = items
            var can2 = cant.split('cantidad_producto')
            var can3=String(can2[1])
            var can4=can3.split('}')
            var can5=String(can4[0])
            var can6=can5.split(':')
            var can7=String(can6[1])
            var canF = can7.substring(1, can7.length - 1);
            canF = parseInt(canF)
            alert(canF)
            ingresarTabla(idF,canF)
        }
    })
}

function ingresarTabla(idF,canF) {
    $.ajax({
        url: '/insertarTablaAct',
        method:'post',
        data:{
            id:idF,
            cant:canF
        },
        success: function (items) {
            alert('Actualizado')
        }
    })
}