const express = require('express');
const morgan = require('morgan');
const path = require('path')
const app = express();

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

//Eliminar logicamente un item
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
        var sentencia = 'UPDATE items SET descripcion = \''+descripcion+'\' WHERE iditem=' + itemId + ';';
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
        var sentencia = ' Select prov.idproveedor,prov.nombre,prov.ruc,prov.ciudad,prov.direccion, '+
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


app.use(express.static(path.join(__dirname, '/public')))    //funciona incluso cambiando path
app.listen(app.get('port'), () => {
    console.log(`server on puerto ${app.get('port')}`);
})