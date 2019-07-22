//import { parse } from "url";

/* function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    // files is a FileList of File objects. List some properties.
    var output = [];
    for (var i = 0, f; f = files[i]; i++) {
        output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
            f.size, ' bytes, last modified: ',
            f.lastModifiedDate.toLocaleDateString(), '</li>');
    }
    document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
}

function buscarArchivo() {
    var aux=document.getElementById('files').addEventListener('change', handleFileSelect, false);

}) */
function abrirArchivo(path) {

}
function leerArchivo(e) {
    var archivo = e.target.files[0];
    if (!archivo) {
        return;
    }
    var lector = new FileReader();
    lector.onload = function (e) {
        var contenido = e.target.result;
        var contenidoSplit = contenido.split('!@#$%')
        alert('size '+contenidoSplit.length)
        //contenidoSplit = contenidoSplit.slice(-1)
        alert('size '+contenidoSplit.length)
        for (var i = 0; i < contenidoSplit.length; i++) {
            var strAux = contenidoSplit[i].split(':')
            var idItem = strAux[1].split(",")
            idItem = idItem[0]
            idItem = parseInt(idItem)

            var idProv = strAux[2]
            idProv = idProv[0]
            idProv = parseInt(idProv)

            var units = strAux[3]
            units = units.split(',')
            units = units[0]
            units = parseInt(units)

            var ptotal = strAux[4]
            ptotal = ptotal.split(',')
            ptotal = ptotal[0]
            ptotal = parseInt(ptotal)

            var marca = strAux[5]
            marca = marca.split(',')
            marca = marca[0]

            var idProf = strAux[6]
            idProf = idProf.split(',')
            idProf = idProf[0]
            idProf = parseInt(idProf)

            var idSol = strAux[7]
            idSol = idSol[0]
            idSol = parseInt(idSol)
            $.ajax({
                url: '/insertarProformaAceptada',
                method: 'post',
                data: {
                    idItem: idItem,
                    idProforma: idProf,
                    idProv: idProv,
                    precioTotal: ptotal,
                    marca: marca,
                    idSol: idSol,
                    unidades: units
                },
                success: function (response) {
                    console.log(response.estado)
                    if (response.estado != 0) {
                        //alert('PROFROMA AGREGADA');
                        location.reload(true);
                    } else {
                        alert('Ha surgido un error, por favor vuelve a intentar.');
                    }
                },
                error: function () {
                    alert('Ha surgido un error, por favor vuelve a intentar.')
                }
            });
        }
        mostrarContenido(contenido);
    };
    lector.readAsText(archivo);
}

function mostrarContenido(contenido) {
    var elemento = document.getElementById('contenido-archivo');
    elemento.innerHTML = contenido;
}

document.getElementById('cargarArchivo')
    .addEventListener('change', leerArchivo, false);