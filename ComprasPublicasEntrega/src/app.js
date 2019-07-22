const express = require('express');
const morgan = require('morgan');
const path = require('path')
const app = express();
//Emial
var nodemailer = require('nodemailer');

//BASE DE DATOS
const router = express.Router();
const pg = require('pg');
const {
    Pool,
    Client
} = require('pg')
app.set('port', process.env.PORT || 3000);
//MIDDLEWARE
app.use(morgan('dev'))
app.use(express.urlencoded({
    extended: false
}))
app.use(express.json())
//app.use(fileUpload())

/*  Routes
 */
const connectionString = 'postgres://postgres:admin@localhost:5432/bd_compraspublicasCUC';

//RUTA VERIFICAR USUARIO LOGIN
app.post('/verificarUsuario', (req, res, next) => {
    const {
        id
    } = req.body
    const {
        password
    } = req.body
    //    var datoConsulta ='SELECT email, contrasenia from personal where email=\'freddy.abad@ucuenca.edu.ec\' and contrasenia=\'12345\'';
    var datoConsulta = 'SELECT email, contrasenia from personal where email=\'' + id + '\' and contrasenia=\'' + password + '\'';
    console.log('USUARIO VERIFICACION >> ' + datoConsulta)
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        client.query(datoConsulta, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.json({ estado: 0 });
            } else {
                console.log()
                res.json({ estado: result.rowCount });
            }
        })
    })
});

//RUTA LLENAR TABLA SOLICITUDES
app.get('/llenarSolicitudesInicio', (req, res, next) => {
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'SELECT soli.idsolicitud,date(soli.fechainicio) fechainicio,date(soli.fechafin) fechafin,per.nombres,per.apellidos, ' +
            ' soli.preciosubtotal,soli.preciototal,soli.descuento, est.descripcion ' +
            ' from solicitudesadquisicionitems soli, personal per, estadosolicitud est ' +
            ' where soli.idpersonal=per.idpersonal and soli.idestadosolicitud=est.idestado ORDER BY soli.idsolicitud';
        console.log('Listado Solicitud: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var solicitudInfo = result.rows;
                res.json(solicitudInfo)
            }
        })
    })
});

//RUTA LLENAR TABLA CATALOGO
app.get('/llenarCatalogoInicio', (req, res, next) => {
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'SELECT * FROM ITEMS WHERE estado=\'ACTIVO\'order by iditem';
        console.log('Listado Catalogo: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var catalogoInfo = result.rows;
                res.json(catalogoInfo)
            }
        })
    })
});

//RUTA LLENAR TABLA CATALOGO
app.get('/llenarProformasInicio', (req, res, next) => {
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = ' select pf.idproforma,pv.nombre,pf.preciosubtotal,pf.preciototal,pf.descuento,pf.fechaemision  from proformas pf,proveedores pv where pv.idproveedor =pf.idproveedor'
        //        'SELECT * FROM ITEMS WHERE estado=\'ACTIVO\'order by iditem';
        console.log('Listado Catalogo: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var proformaInfo = result.rows;
                res.json(proformaInfo)
            }
        })
    })
});

//AGREGA NUEVO ITEM, PAGINA catalogo.html
app.post('/agregarNuevoItem', (req, res, next) => {
    const {
        item
    } = req.body
    var datoConsulta = 'insert into items (descripcion) values(\'' + item + '\')';
    console.log('Ingreso Item >> ' + datoConsulta);
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        client.query(datoConsulta, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.json({ estado: 0 });
            } else {
                console.log()
                res.json({ estado: result.rowCount });
            }
        })
    })
});

//RUTA LLENAR TABLA INVENTARIO
app.get('/llenarInventarioInicio', (req, res, next) => {
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'SELECT inventario.iditem, inventario.cantidad,item.descripcion FROM solicitudes_items inventario,items item where inventario.iditem =item.iditem and item.estado=\'ACTIVO\'order by iditem';
        console.log('Listado Inventario: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var inventarioInfo = result.rows;
                res.json(inventarioInfo)
            }
        })
    })
});

//Eliminar logicamente un item
app.delete('/eliminarItem/:itemId', (req, res) => {
    const {
        itemId
    } = req.params
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'UPDATE items SET estado = \'INACTIVO\' WHERE iditem=' + itemId + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Eliminado')
            }
        })
    })
})

//Actualizar item (Revisar la siguiente tb)
app.post('/actualizarItem/:itemId', (req, res) => {
    const {
        itemId
    } = req.params
    const {
        descripcion
    } = req.body
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'UPDATE items SET descripcion = \'' + descripcion + '\' WHERE iditem=' + itemId + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Actualizado')
            }
        })
    })
})
//Actualizar item (Revisar la anterior tb)
app.post('/actualizarItemDesc', (req, res) => {
    const {
        id
    } = req.body
    const {
        descripcionNueva
    } = req.body
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'UPDATE items SET descripcion = \'' + descripcionNueva + '\' WHERE iditem=' + id + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Actualizado')
            }
        })
    })
})
//RUTA LLENAR TABLA PROVEEDORES
app.get('/llenarProveedorInicio', (req, res, next) => {
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = ' Select prov.idproveedor,prov.nombre,prov.ruc,prov.ciudad,prov.direccion, ' +
            ' prov.email,prov.paginaweb, estprov.estado estado, prov.longitud longitud,' +
            ' prov.latitud latitud' +
            ' from proveedores prov,estadoproveedor estprov' +
            ' where prov.idestadoproveedor=estprov.idestado' +
            ' order by prov.idproveedor';
        console.log('Listado Inventario: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var proveedorInfo = result.rows;
                res.json(proveedorInfo)
            }
        })
    })
});

//Eliminar logicamente un item
app.delete('/eliminarProveedor/:provId', (req, res) => {
    const {
        provId
    } = req.params
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'UPDATE proveedores SET idestadoproveedor = 3 WHERE idproveedor=' + provId + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Proovedor Inactivo')
            }
        })
    })
})

//Eliminar solicitud
app.delete('/eliminarSolicitud/:soliId', (req, res) => {
    const {
        soliId
    } = req.params
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'update solicitudesadquisicionitems SET idestadosolicitud = 9 WHERE idsolicitud=' + soliId + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Proovedor Inactivo')
            }
        })
    })
});
//RUTA Actualizar Solicitud
app.get('/getInfoSolicitud/:soliId', (req, res, next) => {
    const {
        soliId
    } = req.params
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'SELECT soli.idsolicitud,date(soli.fechainicio) fechainicio,date(soli.fechafin) fechafin,per.nombres,per.apellidos, ' +
            ' soli.preciosubtotal,soli.preciototal,soli.descuento, est.descripcion ' +
            ' from solicitudesadquisicionitems soli, personal per, estadosolicitud est ' +
            ' where soli.idpersonal=per.idpersonal and soli.idestadosolicitud=est.idestado and soli.idsolicitud = ' + soliId + ' ORDER BY soli.idsolicitud';
        console.log('Listado Solicitud: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var solicitudInfo = result.rows;
                res.json(solicitudInfo)
            }
        })
    })
});

//Accion Boton actualizar, recibe nuevo descento y actualiza el registro de solicitud
app.post('/actualizarDescuento', (req, res) => {
    const {
        id
    } = req.body
    const {
        descuentoNuevo
    } = req.body
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'UPDATE solicitudesadquisicionitems SET descuento = ' + descuentoNuevo + ' WHERE idsolicitud=' + id + ';';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Actualizado')
            }
        })
    })
})

//Conseguir la informacion de un proveedor
app.get('/getInfoProveedor/:proveedorId', (req, res, next) => {
    const {
        proveedorId
    } = req.params
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'Select prov.idproveedor,prov.nombre,prov.ruc,prov.ciudad,prov.direccion,' +
            ' prov.email,prov.paginaweb, estprov.estado estado, prov.longitud longitud, prov.latitud latitud ' +
            ' from proveedores prov,estadoproveedor estprov where prov.idestadoproveedor=estprov.idestado and ' +
            ' prov.idproveedor=' + proveedorId;
        console.log('Listado Solicitud: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var proveedorInfo = result.rows;
                res.json(proveedorInfo)
            }
        })
    })
});

//Actualziar un Proveedor
app.post('/actualizarProv/:id', (req, res) => {
    const {
        id
    } = req.params
    const {
        nombre
    } = req.body
    const {
        ciudad
    } = req.body
    const {
        direccion
    } = req.body
    const {
        ruc
    } = req.body
    const {
        email
    } = req.body
    const {
        paginaweb
    } = req.body
    const {
        latitud
    } = req.body
    const {
        longitud
    } = req.body

    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'update proveedores set ruc=\'' + ruc + '\', nombre=\'' + nombre + '\', ciudad=\'' + ciudad + '\',direccion =\'' + direccion + '\', email=\''
            + email + '\',paginaweb=\'' + paginaweb + '\',longitud=' + longitud + ' ,latitud=' + latitud + ' where idproveedor=' + id;

        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Actualizado')
            }
        })
    })
})

//Insertar un nuevo Proveedor
app.post('/agregarProv', (req, res) => {

    const {
        nombre
    } = req.body
    const {
        ciudad
    } = req.body
    const {
        direccion
    } = req.body
    const {
        ruc
    } = req.body
    const {
        email
    } = req.body
    const {
        paginaweb
    } = req.body
    const {
        latitud
    } = req.body
    const {
        longitud
    } = req.body

    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'insert into proveedores (ruc,nombre,ciudad,direccion,email,paginaweb,longitud,latitud,idestadoproveedor)' +
            ' VALUES (\'' + ruc + '\', \'' + nombre + '\', \'' + ciudad + '\', \'' + direccion + '\',\'' + email + '\',\'' + paginaweb + '\',' + longitud + ' ,' + latitud + ',1) ';
        console.log(sentencia);
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                res.json('Item Actualizado')
            }
        })
    })
})

//Enviar Email
app.post('/enviarCorreo', (req, res) => {
    const {
        emails
    } = req.body
    const {
        texto
    } = req.body
    //console.log("$$$ "+texto)
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'freddy.abadl@ucuenca.edu.ec',
            pass: 'pi3.141591294'
        }
    });
    var mailOptions = {
        from: 'freddy.abadl@ucuenca.edu.ec',
        to: emails,
        subject: 'Peticion de Proformas - Consultorio Odontologico Universidad de Cuenca',
        text: texto
    };
    transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
            console.log(error);
        } else {
            console.log('Email Enviado: ' + info.response);
        }
    });
})

/**
 * Consigo los emails de los proveedores
 */
app.get('/getEmailProveedores/:idProveedors', (req, res, next) => {
    const {
        idProveedors
    } = req.params
    var auxidProveedor = idProveedors.substring(1, idProveedors.length - 1);
    var arridProveedor = auxidProveedor.split(',')
    var queryIds = ""
    var contador = 0
    var asize = idProveedors.length
    arridProveedor.forEach((idProveedor) => {
        if (contador == asize) {
            var aux = " idproveedor=" + idProveedor;
            queryIds = queryIds.concat(aux)
        } else {
            var aux = " idproveedor=" + idProveedor + " or";
            queryIds = queryIds.concat(aux)
        }
        contador = contador + 1
    });
    var queryIds2 = queryIds.substring(1, queryIds.length - 2);
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'Select idproveedor,nombre,email from proveedores where ' + queryIds2;
        console.log('Listado Solicitud: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var proveedorInfo = result.rows;
                res.json(proveedorInfo)
            }
        })
    })
});

/**
 * Consigue descripciones de items
 */
app.get('/getEmailTexto/:pageURL', (req, res, next) => {
    const {
        pageURL
    } = req.params
    var nuevoJson = JSON.parse(pageURL)
    //Ordeno JSON 
    nuevoJson.sort(ordenarJsonXProp("idItem"));
    //CONCATENO PARA QUERY
    var queryIds = ""
    var contador = 0
    var asize = pageURL.length
    nuevoJson.forEach((itms) => {
        console.log(itms.idItem + '>' + itms.cantidadItem)
        if (contador == asize) {
            var aux = " iditem=" + itms.idItem;
            queryIds = queryIds.concat(aux)
        } else {
            var aux = " iditem=" + itms.idItem + " or";
            queryIds = queryIds.concat(aux)
        }
        contador = contador + 1
    })
    var queryIds2 = queryIds.substring(1, queryIds.length - 2);
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        var sentencia = 'select descripcion from items where ' + queryIds2 + ' order by iditem'
        console.log('Listado ITEMS: ' + sentencia)
        client.query(sentencia, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.status(400).send(err);
            } else {
                var descripcionItem = result.rows;
                res.json(descripcionItem)
            }
        })
    })
});

app.post('/insertarTablaAct', (req, res, next) => {
    const {
        id
    } = req.body
    const {
        cant
    } = req.body
    //FECHA
    var utc = new Date().toJSON().slice(0, 10).replace(/-/g, '/');
    var datoConsulta = 'insert into inventarioActualizado (idItem,cantidad,fecha) values( ' + id + ',' + cant + ',\''+utc+'\')';
    console.log('Ingreso Item >> ' + datoConsulta);
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        client.query(datoConsulta, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.json({ estado: 0 });
            } else {
                console.log()
                res.json({ estado: result.rowCount });
            }
        })
    })

})

/**
 * CONSUMIR API
 */
app.get('/consumirApiExtInventario', (req, res, next) => {
    const request = require('request');
    request('http://ucuencadental.azurewebsites.net/inventarios/entrega/productos/all', function (error, response, body) {
        if (!error && response.statusCode == 200) {
            console.log(body) // Show the HTML for the Google homepage. 
            console.log(typeof body)
            res.json(body)
        }
    });
})

//AGREGA PROFORMA ACEPTADA
app.post('/insertarProformaAceptada', (req, res, next) => {
    const {
        idItem
    } = req.body
    const {
        idProforma
    } = req.body
    const {
        precioTotal
    } = req.body
    const {
        marca
    } = req.body
    const {
        unidades
    } = req.body
    const {
        idSol
    } = req.body
    const {
        idProv
    } = req.body
    /*  var idSol=1
     var idProv=1 */
    var marca2 = marca.substring(1, marca.length - 1);
    var datoConsulta = 'SELECT  agregarItemProf(' + idSol + ',' + idItem + ',' + idProv + ',' + idProforma + ',' + unidades + ',' + precioTotal + ',\'' + marca2 + '\')'
    //(IN _idSolicitud int,IN _idItem int,IN _idProv int,IN _idProf int,IN _unidades int, IN _precio int,


    //'insert into items (descripcion) values(\'' + item + '\')';
    console.log('Ingreso PROFORMA SOLICITUD >> ' + datoConsulta);
    var pool = new pg.Pool({
        connectionString: connectionString,
    })
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("Can not connect to the DB" + err);
        }
        client.query(datoConsulta, function (err, result) {
            done();
            if (err) {
                console.log(err);
                res.json({ estado: 0 });
            } else {
                console.log()
                res.json({ estado: result.rowCount });
            }
        })
    })
});

function ordenarJsonXProp(property) {
    return function (a, b) {
        if (a[property] > b[property])
            return 1;
        else if (a[property] < b[property])
            return -1;

        return 0;
    }
}

app.use(express.static(path.join(__dirname, '/public')))    //funciona incluso cambiando path
app.listen(app.get('port'), () => {
    console.log(`server on puerto ${app.get('port')}`);
})

