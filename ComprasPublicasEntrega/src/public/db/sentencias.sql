--LISTADO SOLICITUDES PAGINA solicitudes.html
SELECT soli.idsolicitud,date(soli.fechainicio) fechainicio,date(soli.fechafin) fechafin,per.nombres,per.apellidos,  soli.preciosubtotal,soli.preciototal,soli.descuento, est.descripcion  from solicitudesadquisicionitems soli, personal per, estadosolicitud est  where soli.idpersonal=per.idpersonal and soli.idestadosolicitud=est.idestado

--LISTADO ITEMS CANTIDAD DE INVENTARIO
SELECT inventario.iditem, inventario.cantidad,item.descripcion FROM solicitudes_items inventario,items item where inventario.iditem =item.iditem



--LISTADO PROVEEDOR COMPLETO
select prov.idproveedor,prov.nombre,prov.ruc,prov.ciudad,prov.direccion,
prov.email,prov.paginaweb, estprov.estado estado, prov.longitud longitud,
prov.latitud latitud
from proveedores prov,estadoproveedor estprov
where prov.idestadoproveedor=estprov.idestado
order by prov.idproveedor

--- ACTUALIZAR ESTADO DE SOLICITUD A INACTIVO
update solicitudesadquisicionitems SET idestadosolicitud = 9 WHERE idsolicitud=1

--- Ingresar prvoeedor

insert into proveedores (ruc,nombre,ciudad,direccion,email,paginaweb,longitud,latitud) VALUES ('', '', '', '','','',1.3 ,1.2)
