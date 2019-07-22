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
 --- VER PROFORMA
 select pf.idproforma,pv.nombre,pf.preciosubtotal,pf.preciototal,pf.descuento,pf.fechaemision  from proformas pf,proveedores p

---FUNCION AGREGAR PROFORMA
CREATE OR REPLACE FUNCTION agregarItemProf(IN _idSolicitud int,IN _idItem int,IN _idProv int,IN _idProf int,IN _unidades int, IN _precio int,
										   IN _marca character varying(30),OUT respuesta text) AS $$
declare
	idsi integer;
BEGIN
    insert into solicitudes_items (idsolicitud,iditem,cantidad) values (_idSolicitud,_idItem,_unidades);
    select ids_i into idsi from solicitudes_items where idsolicitud=_idSolicitud and iditem=_idItem;
    insert into solicitudes_items_proformas(ids_i,idproforma,preciounit,marca,disponible,unidades)values(idsi,_idProf,_precio,_marca,true,_unidades) ;
END;
$$ LANGUAGE plpgsql;

--vista inventario

CREATE VIEW itemsActualizado AS
    select i.iditem,i.cantidad,i.fecha,it.descripcion from inventarioActualizado i, items it where i.iditem=it.iditem

select  * from itemsActualizado