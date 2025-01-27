toc.dat                                                                                             0000600 0004000 0002000 00000110111 13515316761 0014442 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       0                    w            bd_compraspublicasCUC    10.8    10.8 l    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         �           1262    32768    bd_compraspublicasCUC    DATABASE     �   CREATE DATABASE "bd_compraspublicasCUC" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Ecuador.1252' LC_CTYPE = 'Spanish_Ecuador.1252';
 '   DROP DATABASE "bd_compraspublicasCUC";
             postgres    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                     3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1         �            1255    32965 a   agregaritemprof(integer, integer, integer, integer, integer, double precision, character varying)    FUNCTION     �  CREATE FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio double precision, _marca character varying, OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	idsi integer;
BEGIN
    insert into solicitudes_items (idsolicitud,iditem,cantidad) values (_idSolicitud,_idItem,_unidades);
    select ids_i into idsi from solicitudes_items where idsolicitud=_idSolicitud and iditem=_idItem;
    insert into solicitudes_items_proformas(ids_i,idproforma,preciounit,marca,disponible,_unidades)values(idsi,_idProf,_precio,_marca,true,_unidades) ;
END;
$$;
 �   DROP FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio double precision, _marca character varying, OUT respuesta text);
       public       postgres    false    1    3         �            1255    32966 X   agregaritemprof(integer, integer, integer, integer, integer, integer, character varying)    FUNCTION     y  CREATE FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio integer, _marca character varying, OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	idsi integer;
BEGIN
    insert into solicitudes_items (idsolicitud,iditem,cantidad) values (_idSolicitud,_idItem,_unidades);
    select ids_i into idsi from solicitudes_items where idsolicitud=_idSolicitud and iditem=_idItem;
    insert into solicitudes_items_proformas(ids_i,idproforma,preciounit,marca,disponible,unidades)values(idsi,_idProf,_precio,_marca,true,_unidades) ;
END;
$$;
 �   DROP FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio integer, _marca character varying, OUT respuesta text);
       public       postgres    false    3    1         �            1259    32771    categoriasdeitems    TABLE     �   CREATE TABLE public.categoriasdeitems (
    idcategoria integer NOT NULL,
    descripcion text,
    limitprecioinf integer,
    limitpreciosup integer
);
 %   DROP TABLE public.categoriasdeitems;
       public         postgres    false    3         �            1259    32769 !   categoriasdeitems_idcategoria_seq    SEQUENCE     �   CREATE SEQUENCE public.categoriasdeitems_idcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.categoriasdeitems_idcategoria_seq;
       public       postgres    false    3    197         �           0    0 !   categoriasdeitems_idcategoria_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.categoriasdeitems_idcategoria_seq OWNED BY public.categoriasdeitems.idcategoria;
            public       postgres    false    196         �            1259    32801    estadoproveedor    TABLE     i   CREATE TABLE public.estadoproveedor (
    idestado integer NOT NULL,
    estado character varying(30)
);
 #   DROP TABLE public.estadoproveedor;
       public         postgres    false    3         �            1259    32799    estadoproveedor_idestado_seq    SEQUENCE     �   CREATE SEQUENCE public.estadoproveedor_idestado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.estadoproveedor_idestado_seq;
       public       postgres    false    3    203         �           0    0    estadoproveedor_idestado_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.estadoproveedor_idestado_seq OWNED BY public.estadoproveedor.idestado;
            public       postgres    false    202         �            1259    32782    estadosolicitud    TABLE     ]   CREATE TABLE public.estadosolicitud (
    idestado integer NOT NULL,
    descripcion text
);
 #   DROP TABLE public.estadosolicitud;
       public         postgres    false    3         �            1259    32780    estadosolicitud_idestado_seq    SEQUENCE     �   CREATE SEQUENCE public.estadosolicitud_idestado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.estadosolicitud_idestado_seq;
       public       postgres    false    3    199         �           0    0    estadosolicitud_idestado_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.estadosolicitud_idestado_seq OWNED BY public.estadosolicitud.idestado;
            public       postgres    false    198         �            1259    32967    inventarioactualizado    TABLE     h   CREATE TABLE public.inventarioactualizado (
    iditem integer,
    cantidad integer,
    fecha text
);
 )   DROP TABLE public.inventarioactualizado;
       public         postgres    false    3         �            1259    32848    items    TABLE     �   CREATE TABLE public.items (
    iditem integer NOT NULL,
    descripcion character varying(100),
    estado character varying(25) DEFAULT 'ACTIVO'::character varying
);
    DROP TABLE public.items;
       public         postgres    false    3         �            1259    32846    items_iditem_seq    SEQUENCE     �   CREATE SEQUENCE public.items_iditem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.items_iditem_seq;
       public       postgres    false    3    211         �           0    0    items_iditem_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.items_iditem_seq OWNED BY public.items.iditem;
            public       postgres    false    210         �            1259    32973    itemsactualizado    VIEW     �   CREATE VIEW public.itemsactualizado AS
 SELECT i.iditem,
    i.cantidad,
    i.fecha,
    it.descripcion
   FROM public.inventarioactualizado i,
    public.items it
  WHERE (i.iditem = it.iditem);
 #   DROP VIEW public.itemsactualizado;
       public       postgres    false    220    211    211    220    220    3         �            1259    32793    personal    TABLE       CREATE TABLE public.personal (
    idpersonal integer NOT NULL,
    username character varying(30),
    nombres character varying(50),
    apellidos character varying(50),
    email character varying(50),
    contrasenia character varying(20),
    cargo character varying(50)
);
    DROP TABLE public.personal;
       public         postgres    false    3         �            1259    32791    personal_idpersonal_seq    SEQUENCE     �   CREATE SEQUENCE public.personal_idpersonal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.personal_idpersonal_seq;
       public       postgres    false    201    3         �           0    0    personal_idpersonal_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.personal_idpersonal_seq OWNED BY public.personal.idpersonal;
            public       postgres    false    200         �            1259    32835 	   proformas    TABLE     �   CREATE TABLE public.proformas (
    idproforma integer NOT NULL,
    idproveedor integer,
    noproforma integer,
    preciosubtotal numeric(8,2),
    preciototal numeric(8,2),
    descuento numeric(5,2),
    fechaemision timestamp without time zone
);
    DROP TABLE public.proformas;
       public         postgres    false    3         �            1259    32833    proformas_idproforma_seq    SEQUENCE     �   CREATE SEQUENCE public.proformas_idproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.proformas_idproforma_seq;
       public       postgres    false    3    209         �           0    0    proformas_idproforma_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.proformas_idproforma_seq OWNED BY public.proformas.idproforma;
            public       postgres    false    208         �            1259    32809    proveedores    TABLE     s  CREATE TABLE public.proveedores (
    idproveedor integer NOT NULL,
    ruc character varying(14) NOT NULL,
    nombre character varying(50),
    ciudad character varying(30),
    direccion character varying(50),
    email character varying(50),
    paginaweb character varying(50),
    longitud numeric(10,7),
    latitud numeric(10,7),
    idestadoproveedor integer
);
    DROP TABLE public.proveedores;
       public         postgres    false    3         �            1259    32807    proveedores_idproveedor_seq    SEQUENCE     �   CREATE SEQUENCE public.proveedores_idproveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.proveedores_idproveedor_seq;
       public       postgres    false    205    3         �           0    0    proveedores_idproveedor_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.proveedores_idproveedor_seq OWNED BY public.proveedores.idproveedor;
            public       postgres    false    204         �            1259    32879    solicitudes_items    TABLE     �   CREATE TABLE public.solicitudes_items (
    ids_i integer NOT NULL,
    idsolicitud integer,
    iditem integer,
    cantidad integer
);
 %   DROP TABLE public.solicitudes_items;
       public         postgres    false    3         �            1259    32877    solicitudes_items_ids_i_seq    SEQUENCE     �   CREATE SEQUENCE public.solicitudes_items_ids_i_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.solicitudes_items_ids_i_seq;
       public       postgres    false    215    3         �           0    0    solicitudes_items_ids_i_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.solicitudes_items_ids_i_seq OWNED BY public.solicitudes_items.ids_i;
            public       postgres    false    214         �            1259    32897    solicitudes_items_proformas    TABLE     �   CREATE TABLE public.solicitudes_items_proformas (
    ids_i_p integer NOT NULL,
    ids_i integer,
    idproforma integer,
    preciounit integer,
    marca character varying(30),
    disponible boolean DEFAULT false,
    unidades integer
);
 /   DROP TABLE public.solicitudes_items_proformas;
       public         postgres    false    3         �            1259    32916 ,   solicitudes_items_proformas_categoriadeitems    TABLE     �   CREATE TABLE public.solicitudes_items_proformas_categoriadeitems (
    ids_i_p_c integer NOT NULL,
    ids_i_p integer,
    idcategoriadeitems integer
);
 @   DROP TABLE public.solicitudes_items_proformas_categoriadeitems;
       public         postgres    false    3         �            1259    32914 :   solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq    SEQUENCE     �   CREATE SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 Q   DROP SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq;
       public       postgres    false    3    219         �           0    0 :   solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq OWNED BY public.solicitudes_items_proformas_categoriadeitems.ids_i_p_c;
            public       postgres    false    218         �            1259    32895 '   solicitudes_items_proformas_ids_i_p_seq    SEQUENCE     �   CREATE SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq;
       public       postgres    false    3    217         �           0    0 '   solicitudes_items_proformas_ids_i_p_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq OWNED BY public.solicitudes_items_proformas.ids_i_p;
            public       postgres    false    216         �            1259    32856    solicitudesadquisicionitems    TABLE     �  CREATE TABLE public.solicitudesadquisicionitems (
    idsolicitud integer NOT NULL,
    idpersonal integer,
    idestadosolicitud integer DEFAULT 1,
    preciosubtotal numeric(8,2) DEFAULT 0.0,
    preciototal numeric(8,2) DEFAULT 0.0,
    descuento numeric(5,2) DEFAULT 0.0,
    fechainicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fechafin timestamp without time zone
);
 /   DROP TABLE public.solicitudesadquisicionitems;
       public         postgres    false    3         �            1259    32854 +   solicitudesadquisicionitems_idsolicitud_seq    SEQUENCE     �   CREATE SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq;
       public       postgres    false    3    213         �           0    0 +   solicitudesadquisicionitems_idsolicitud_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq OWNED BY public.solicitudesadquisicionitems.idsolicitud;
            public       postgres    false    212         �            1259    32822    telefonosproveedores    TABLE     �   CREATE TABLE public.telefonosproveedores (
    idtelefono integer NOT NULL,
    idproveedor integer,
    telefono character varying(20)
);
 (   DROP TABLE public.telefonosproveedores;
       public         postgres    false    3         �            1259    32820 #   telefonosproveedores_idtelefono_seq    SEQUENCE     �   CREATE SEQUENCE public.telefonosproveedores_idtelefono_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.telefonosproveedores_idtelefono_seq;
       public       postgres    false    207    3         �           0    0 #   telefonosproveedores_idtelefono_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.telefonosproveedores_idtelefono_seq OWNED BY public.telefonosproveedores.idtelefono;
            public       postgres    false    206         �
           2604    32774    categoriasdeitems idcategoria    DEFAULT     �   ALTER TABLE ONLY public.categoriasdeitems ALTER COLUMN idcategoria SET DEFAULT nextval('public.categoriasdeitems_idcategoria_seq'::regclass);
 L   ALTER TABLE public.categoriasdeitems ALTER COLUMN idcategoria DROP DEFAULT;
       public       postgres    false    196    197    197         �
           2604    32804    estadoproveedor idestado    DEFAULT     �   ALTER TABLE ONLY public.estadoproveedor ALTER COLUMN idestado SET DEFAULT nextval('public.estadoproveedor_idestado_seq'::regclass);
 G   ALTER TABLE public.estadoproveedor ALTER COLUMN idestado DROP DEFAULT;
       public       postgres    false    202    203    203         �
           2604    32785    estadosolicitud idestado    DEFAULT     �   ALTER TABLE ONLY public.estadosolicitud ALTER COLUMN idestado SET DEFAULT nextval('public.estadosolicitud_idestado_seq'::regclass);
 G   ALTER TABLE public.estadosolicitud ALTER COLUMN idestado DROP DEFAULT;
       public       postgres    false    199    198    199         �
           2604    32851    items iditem    DEFAULT     l   ALTER TABLE ONLY public.items ALTER COLUMN iditem SET DEFAULT nextval('public.items_iditem_seq'::regclass);
 ;   ALTER TABLE public.items ALTER COLUMN iditem DROP DEFAULT;
       public       postgres    false    211    210    211         �
           2604    32796    personal idpersonal    DEFAULT     z   ALTER TABLE ONLY public.personal ALTER COLUMN idpersonal SET DEFAULT nextval('public.personal_idpersonal_seq'::regclass);
 B   ALTER TABLE public.personal ALTER COLUMN idpersonal DROP DEFAULT;
       public       postgres    false    200    201    201         �
           2604    32838    proformas idproforma    DEFAULT     |   ALTER TABLE ONLY public.proformas ALTER COLUMN idproforma SET DEFAULT nextval('public.proformas_idproforma_seq'::regclass);
 C   ALTER TABLE public.proformas ALTER COLUMN idproforma DROP DEFAULT;
       public       postgres    false    209    208    209         �
           2604    32812    proveedores idproveedor    DEFAULT     �   ALTER TABLE ONLY public.proveedores ALTER COLUMN idproveedor SET DEFAULT nextval('public.proveedores_idproveedor_seq'::regclass);
 F   ALTER TABLE public.proveedores ALTER COLUMN idproveedor DROP DEFAULT;
       public       postgres    false    204    205    205         �
           2604    32882    solicitudes_items ids_i    DEFAULT     �   ALTER TABLE ONLY public.solicitudes_items ALTER COLUMN ids_i SET DEFAULT nextval('public.solicitudes_items_ids_i_seq'::regclass);
 F   ALTER TABLE public.solicitudes_items ALTER COLUMN ids_i DROP DEFAULT;
       public       postgres    false    214    215    215         �
           2604    32900 #   solicitudes_items_proformas ids_i_p    DEFAULT     �   ALTER TABLE ONLY public.solicitudes_items_proformas ALTER COLUMN ids_i_p SET DEFAULT nextval('public.solicitudes_items_proformas_ids_i_p_seq'::regclass);
 R   ALTER TABLE public.solicitudes_items_proformas ALTER COLUMN ids_i_p DROP DEFAULT;
       public       postgres    false    216    217    217         �
           2604    32919 6   solicitudes_items_proformas_categoriadeitems ids_i_p_c    DEFAULT     �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems ALTER COLUMN ids_i_p_c SET DEFAULT nextval('public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq'::regclass);
 e   ALTER TABLE public.solicitudes_items_proformas_categoriadeitems ALTER COLUMN ids_i_p_c DROP DEFAULT;
       public       postgres    false    218    219    219         �
           2604    32859 '   solicitudesadquisicionitems idsolicitud    DEFAULT     �   ALTER TABLE ONLY public.solicitudesadquisicionitems ALTER COLUMN idsolicitud SET DEFAULT nextval('public.solicitudesadquisicionitems_idsolicitud_seq'::regclass);
 V   ALTER TABLE public.solicitudesadquisicionitems ALTER COLUMN idsolicitud DROP DEFAULT;
       public       postgres    false    212    213    213         �
           2604    32825    telefonosproveedores idtelefono    DEFAULT     �   ALTER TABLE ONLY public.telefonosproveedores ALTER COLUMN idtelefono SET DEFAULT nextval('public.telefonosproveedores_idtelefono_seq'::regclass);
 N   ALTER TABLE public.telefonosproveedores ALTER COLUMN idtelefono DROP DEFAULT;
       public       postgres    false    207    206    207         n          0    32771    categoriasdeitems 
   TABLE DATA               e   COPY public.categoriasdeitems (idcategoria, descripcion, limitprecioinf, limitpreciosup) FROM stdin;
    public       postgres    false    197       2926.dat t          0    32801    estadoproveedor 
   TABLE DATA               ;   COPY public.estadoproveedor (idestado, estado) FROM stdin;
    public       postgres    false    203       2932.dat p          0    32782    estadosolicitud 
   TABLE DATA               @   COPY public.estadosolicitud (idestado, descripcion) FROM stdin;
    public       postgres    false    199       2928.dat �          0    32967    inventarioactualizado 
   TABLE DATA               H   COPY public.inventarioactualizado (iditem, cantidad, fecha) FROM stdin;
    public       postgres    false    220       2949.dat |          0    32848    items 
   TABLE DATA               <   COPY public.items (iditem, descripcion, estado) FROM stdin;
    public       postgres    false    211       2940.dat r          0    32793    personal 
   TABLE DATA               g   COPY public.personal (idpersonal, username, nombres, apellidos, email, contrasenia, cargo) FROM stdin;
    public       postgres    false    201       2930.dat z          0    32835 	   proformas 
   TABLE DATA               ~   COPY public.proformas (idproforma, idproveedor, noproforma, preciosubtotal, preciototal, descuento, fechaemision) FROM stdin;
    public       postgres    false    209       2938.dat v          0    32809    proveedores 
   TABLE DATA               �   COPY public.proveedores (idproveedor, ruc, nombre, ciudad, direccion, email, paginaweb, longitud, latitud, idestadoproveedor) FROM stdin;
    public       postgres    false    205       2934.dat �          0    32879    solicitudes_items 
   TABLE DATA               Q   COPY public.solicitudes_items (ids_i, idsolicitud, iditem, cantidad) FROM stdin;
    public       postgres    false    215       2944.dat �          0    32897    solicitudes_items_proformas 
   TABLE DATA               z   COPY public.solicitudes_items_proformas (ids_i_p, ids_i, idproforma, preciounit, marca, disponible, unidades) FROM stdin;
    public       postgres    false    217       2946.dat �          0    32916 ,   solicitudes_items_proformas_categoriadeitems 
   TABLE DATA               n   COPY public.solicitudes_items_proformas_categoriadeitems (ids_i_p_c, ids_i_p, idcategoriadeitems) FROM stdin;
    public       postgres    false    219       2948.dat ~          0    32856    solicitudesadquisicionitems 
   TABLE DATA               �   COPY public.solicitudesadquisicionitems (idsolicitud, idpersonal, idestadosolicitud, preciosubtotal, preciototal, descuento, fechainicio, fechafin) FROM stdin;
    public       postgres    false    213       2942.dat x          0    32822    telefonosproveedores 
   TABLE DATA               Q   COPY public.telefonosproveedores (idtelefono, idproveedor, telefono) FROM stdin;
    public       postgres    false    207       2936.dat �           0    0 !   categoriasdeitems_idcategoria_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.categoriasdeitems_idcategoria_seq', 3, true);
            public       postgres    false    196         �           0    0    estadoproveedor_idestado_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.estadoproveedor_idestado_seq', 3, true);
            public       postgres    false    202         �           0    0    estadosolicitud_idestado_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.estadosolicitud_idestado_seq', 8, true);
            public       postgres    false    198         �           0    0    items_iditem_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.items_iditem_seq', 67, true);
            public       postgres    false    210         �           0    0    personal_idpersonal_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.personal_idpersonal_seq', 2, true);
            public       postgres    false    200         �           0    0    proformas_idproforma_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.proformas_idproforma_seq', 4, true);
            public       postgres    false    208         �           0    0    proveedores_idproveedor_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.proveedores_idproveedor_seq', 15, true);
            public       postgres    false    204         �           0    0    solicitudes_items_ids_i_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.solicitudes_items_ids_i_seq', 147, true);
            public       postgres    false    214         �           0    0 :   solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq    SEQUENCE SET     i   SELECT pg_catalog.setval('public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq', 14, true);
            public       postgres    false    218         �           0    0 '   solicitudes_items_proformas_ids_i_p_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.solicitudes_items_proformas_ids_i_p_seq', 85, true);
            public       postgres    false    216         �           0    0 +   solicitudesadquisicionitems_idsolicitud_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.solicitudesadquisicionitems_idsolicitud_seq', 4, true);
            public       postgres    false    212         �           0    0 #   telefonosproveedores_idtelefono_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.telefonosproveedores_idtelefono_seq', 5, true);
            public       postgres    false    206         �
           2606    32779 (   categoriasdeitems categoriasdeitems_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.categoriasdeitems
    ADD CONSTRAINT categoriasdeitems_pkey PRIMARY KEY (idcategoria);
 R   ALTER TABLE ONLY public.categoriasdeitems DROP CONSTRAINT categoriasdeitems_pkey;
       public         postgres    false    197         �
           2606    32806 $   estadoproveedor estadoproveedor_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.estadoproveedor
    ADD CONSTRAINT estadoproveedor_pkey PRIMARY KEY (idestado);
 N   ALTER TABLE ONLY public.estadoproveedor DROP CONSTRAINT estadoproveedor_pkey;
       public         postgres    false    203         �
           2606    32790 $   estadosolicitud estadosolicitud_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.estadosolicitud
    ADD CONSTRAINT estadosolicitud_pkey PRIMARY KEY (idestado);
 N   ALTER TABLE ONLY public.estadosolicitud DROP CONSTRAINT estadosolicitud_pkey;
       public         postgres    false    199         �
           2606    32853    items items_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (iditem);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public         postgres    false    211         �
           2606    32798    personal personal_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (idpersonal);
 @   ALTER TABLE ONLY public.personal DROP CONSTRAINT personal_pkey;
       public         postgres    false    201         �
           2606    32840    proformas proformas_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.proformas
    ADD CONSTRAINT proformas_pkey PRIMARY KEY (idproforma);
 B   ALTER TABLE ONLY public.proformas DROP CONSTRAINT proformas_pkey;
       public         postgres    false    209         �
           2606    32814    proveedores proveedores_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (idproveedor);
 F   ALTER TABLE ONLY public.proveedores DROP CONSTRAINT proveedores_pkey;
       public         postgres    false    205         �
           2606    32884 (   solicitudes_items solicitudes_items_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_pkey PRIMARY KEY (ids_i);
 R   ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_pkey;
       public         postgres    false    215         �
           2606    32921 ^   solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriadeitems_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriadeitems_pkey PRIMARY KEY (ids_i_p_c);
 �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriadeitems_pkey;
       public         postgres    false    219         �
           2606    32903 <   solicitudes_items_proformas solicitudes_items_proformas_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_pkey PRIMARY KEY (ids_i_p);
 f   ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_pkey;
       public         postgres    false    217         �
           2606    32866 <   solicitudesadquisicionitems solicitudesadquisicionitems_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_pkey PRIMARY KEY (idsolicitud);
 f   ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_pkey;
       public         postgres    false    213         �
           2606    32827 .   telefonosproveedores telefonosproveedores_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.telefonosproveedores
    ADD CONSTRAINT telefonosproveedores_pkey PRIMARY KEY (idtelefono);
 X   ALTER TABLE ONLY public.telefonosproveedores DROP CONSTRAINT telefonosproveedores_pkey;
       public         postgres    false    207         �
           2606    32841 $   proformas proformas_idproveedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.proformas
    ADD CONSTRAINT proformas_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES public.proveedores(idproveedor);
 N   ALTER TABLE ONLY public.proformas DROP CONSTRAINT proformas_idproveedor_fkey;
       public       postgres    false    209    205    2777         �
           2606    32815 .   proveedores proveedores_idestadoproveedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_idestadoproveedor_fkey FOREIGN KEY (idestadoproveedor) REFERENCES public.estadoproveedor(idestado);
 X   ALTER TABLE ONLY public.proveedores DROP CONSTRAINT proveedores_idestadoproveedor_fkey;
       public       postgres    false    2775    203    205         �
           2606    32890 /   solicitudes_items solicitudes_items_iditem_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_iditem_fkey FOREIGN KEY (iditem) REFERENCES public.items(iditem);
 Y   ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_iditem_fkey;
       public       postgres    false    211    215    2783         �
           2606    32885 4   solicitudes_items solicitudes_items_idsolicitud_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_idsolicitud_fkey FOREIGN KEY (idsolicitud) REFERENCES public.solicitudesadquisicionitems(idsolicitud);
 ^   ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_idsolicitud_fkey;
       public       postgres    false    215    2785    213         �
           2606    32927 l   solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey FOREIGN KEY (idcategoriadeitems) REFERENCES public.categoriasdeitems(idcategoria);
 �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey;
       public       postgres    false    219    197    2769         �
           2606    32922 f   solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey FOREIGN KEY (ids_i_p) REFERENCES public.solicitudes_items_proformas(ids_i_p);
 �   ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey;
       public       postgres    false    217    219    2789         �
           2606    32909 G   solicitudes_items_proformas solicitudes_items_proformas_idproforma_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_idproforma_fkey FOREIGN KEY (idproforma) REFERENCES public.proformas(idproforma);
 q   ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_idproforma_fkey;
       public       postgres    false    2781    217    209         �
           2606    32904 B   solicitudes_items_proformas solicitudes_items_proformas_ids_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_ids_i_fkey FOREIGN KEY (ids_i) REFERENCES public.solicitudes_items(ids_i);
 l   ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_ids_i_fkey;
       public       postgres    false    2787    215    217         �
           2606    32872 N   solicitudesadquisicionitems solicitudesadquisicionitems_idestadosolicitud_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_idestadosolicitud_fkey FOREIGN KEY (idestadosolicitud) REFERENCES public.estadosolicitud(idestado);
 x   ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_idestadosolicitud_fkey;
       public       postgres    false    199    2771    213         �
           2606    32867 G   solicitudesadquisicionitems solicitudesadquisicionitems_idpersonal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);
 q   ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_idpersonal_fkey;
       public       postgres    false    2773    201    213         �
           2606    32828 :   telefonosproveedores telefonosproveedores_idproveedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefonosproveedores
    ADD CONSTRAINT telefonosproveedores_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES public.proveedores(idproveedor);
 d   ALTER TABLE ONLY public.telefonosproveedores DROP CONSTRAINT telefonosproveedores_idproveedor_fkey;
       public       postgres    false    2777    205    207                                                                                                                                                                                                                                                                                                                                                                                                                                                               2926.dat                                                                                            0000600 0004000 0002000 00000000111 13515316761 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Infima Cuantia	0	90
2	Instrumentos	91	5000
3	Equipos	5001	9999999
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                       2932.dat                                                                                            0000600 0004000 0002000 00000000052 13515316761 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Activo
2	Activo en mora
3	Inactivo
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      2928.dat                                                                                            0000600 0004000 0002000 00000000517 13515316761 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Pendiente de seleccionar insumos
2	Pendiente de requerir proformas
3	Pendiente de ingresar proformas
4	Pendiente de asociar proformas ingresadas con items requeridos
5	Pendiente de enviar al Departamento Financiero
6	Pendiente de recibir aprobacion de financiero
7	Pendiente de recibir items
8	Pendiente de finalizar
9	Inactivo
\.


                                                                                                                                                                                 2949.dat                                                                                            0000600 0004000 0002000 00000000265 13515316761 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        12	14	2019/07/22
1	12	2019/07/22
2	12	2019/07/22
3	21	2019/07/22
4	11	2019/07/22
5	10	2019/07/22
6	1	2019/07/22
7	41	2019/07/22
8	61	2019/07/22
9	2	2019/07/22
12	14	2019/07/22
\.


                                                                                                                                                                                                                                                                                                                                           2940.dat                                                                                            0000600 0004000 0002000 00000003636 13515316761 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	OBTUR TEMPORAL 15G	INACTIVO
10	BANDAS CELULOIDE PAQ X 50	ACTIVO
11	Preuba 2	ACTIVO
4	Actualizar	INACTIVO
7	act	INACTIVO
8	HOJA DE BISTURI #12X CADA	ACTIVO
9	CEPILLO PROFILACTICO UNIDAD	ACTIVO
12	GUANTES LATEX SEMI-POLVEADO SMALL	ACTIVO
13	CEPILLOS NTI CHATOS X5	ACTIVO
14	CEPILLOS NTI EN PUNTA X5	ACTIVO
15	HEMOSTATICO ESPONJA X32 PCS	ACTIVO
16	SOBRE P/ESTERILIZAR 90X260	ACTIVO
17	BANDA MATRIX 5MM	ACTIVO
18	MASCARILLA TAPA BOCA X50	ACTIVO
19	EYECTORES DESCARTABLES X100	ACTIVO
20	PTA DTE RED X-GR	ACTIVO
21	TRONCO GRANO EXTRA-FINO	ACTIVO
22	PTA CILINDRO L PTA CHATA	ACTIVO
23	PAPEL ARTICULAR RECTO X CAJA	ACTIVO
24	UNIVERSAL BOND 5ML	ACTIVO
25	APLICADORES EXTRA FINOS BLANCO X 100	ACTIVO
26	TIRAS DE ACERO X SOBRE 4MM	ACTIVO
27	ALCINATO CROMATICO TIPO U 50G	ACTIVO
28	ESPEJO PLANO #5	ACTIVO
29	MICROMOTOR TIPO COLIOT	ACTIVO
30	VIBRADOR DE YESO	ACTIVO
31	GAFA PARA FOTOCURADO	ACTIVO
32	VACUM FORMUR TURMOFORMADORA	ACTIVO
33	CAVITRON ELECTRICO	ACTIVO
34	PUNTA CAVITRON MODELO T3	ACTIVO
35	MICROMOTOR SET COMPLETO	ACTIVO
36	LAVADORA ULTRASONICA	ACTIVO
37	CURETA 13/14	ACTIVO
38	CURETA 3-4	ACTIVO
39	EXPLORADOR	ACTIVO
40	PORTA MATRIX 7MM	ACTIVO
41	MANGO PARA BISTURI #3	ACTIVO
42	SACAPUENTES O CORONAS CON PTAS	ACTIVO
43	JERINGA ASPIRACION	ACTIVO
44	CUCHARILLA	ACTIVO
45	YESO PIEDRA X LIBRA	ACTIVO
46	CERA EN LAMINAS	ACTIVO
47	LAMINA DE ACETATO RIGIDA	ACTIVO
48	PASTA PROFILAXIS 100GR	ACTIVO
49	EMPRESS KIT SIN GUIA	ACTIVO
50	SCANDONEST 3% SIN VASO XCAJA 50	ACTIVO
51	FLUOR PROTECTOR DOSE 40	ACTIVO
52	LUNA ROLLO ALGODON	ACTIVO
53	ACIDO GRABADOR GEL	ACTIVO
54	BOND SL	ACTIVO
55	SPEEDEX 1	ACTIVO
56	SWISSFLEX DISC KIT	ACTIVO
57	LIMPIADOR GENERAL	ACTIVO
58	Fluor nuevo 2019	ACTIVO
59	undefined	ACTIVO
60	prueba	ACTIVO
61	prueba2	ACTIVO
62	dos	ACTIVO
63	tres	ACTIVO
64	\N	ACTIVO
65	\N	ACTIVO
2	FUJI 11 AUTO KIT GR 15G+10G	INACTIVO
6	HIDROXIDO CALCIO 13G+11G	INACTIVO
3	FUJI 1 KIT GR 35K+25G	INACTIVO
1		INACTIVO
66	Item n3	ACTIVO
67	Item n4	ACTIVO
\.


                                                                                                  2930.dat                                                                                            0000600 0004000 0002000 00000000176 13515316761 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	\N	David	Santos	david.santos@ucuenca.edu.ec	1234	personal1
2	\N	Freddy	Abad	freddy.abad@ucuenca.edu.ec	12345	personal2
\.


                                                                                                                                                                                                                                                                                                                                                                                                  2938.dat                                                                                            0000600 0004000 0002000 00000000321 13515316761 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	10993	1696.80	1893.91	0.13	2019-04-15 16:47:00
2	2	47836	2479.68	2777.24	0.13	2019-04-16 00:00:00
3	2	47829	2904.25	3252.76	0.13	2019-04-16 00:00:00
4	3	10001	1000.00	1120.00	0.13	2019-04-17 00:00:00
\.


                                                                                                                                                                                                                                                                                                               2934.dat                                                                                            0000600 0004000 0002000 00000002700 13515316761 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	0308667548001	Patito	Cuenca	Av. Oculta	ventas@patito.com	www.patito.com	0.0000000	0.0000000	1
2	0205774653001	Deposito Dental NEO-TEC	Guayaquil	Av. Kennedy Este	atencion@depositodental.com	www.depositoneotec.ec	0.0000000	0.0000000	1
3	0908447652001	Gato	Quito	Av. 6 de Diciembre No 767	admin@gato.ec	www.gato.ec	0.0000000	0.0000000	1
5							1.3000000	1.2000000	1
6	gsdf	dfgs	gsdf	gsdf	gsdf	dsfg	5.3000000	63.4000000	1
7	sdafs	fasd	fasd	fasd	fasd	fasd	132.0000000	1.2300000	1
8	panda	panda	pandap	pasdf	sdfa	asdf	1.3200000	1.2300000	1
1	RUC1	Nombre1	Ciudad1	Direccion1	freddy.abadl@ucuenca.ec	Pagina Web1	2.1000000	2.1000000	1
9	0104887446001	Krobalto	Guayaquil	Av. Kennedy No 211	ventas@krobalto.com	www.krobalto.com	0.0000000	0.0000000	1
10	0205774653001	Deposito Dental NEO-TEC	Guayaquil	Av. Kennedy Este	atencion@depositodental.com	www.depositoneotec.ec	0.0000000	0.0000000	1
11	0908447652001	Dentalayala	Guayaquil	Versatiles 5-67	admin@dentalayala.com.ec	www.dentalayala.com.ec	0.0000000	0.0000000	1
12	0308667548001	Quality Dental	Guayaquil	Av. Perez Guerrero	ventas@qualitydental.com.ec	www.qualitydental.com.ec	0.0000000	0.0000000	1
13	0458743228001	Vialdental	Guayaquil	Av.Pérez Guerrero	ventas@vialdental.ec	www.vialdental.ec	0.0000000	0.0000000	1
14	1111111111001	test 1	Cuenca	UCuenca	freddy.abad.@ucuenca.edu.ec	www.test1.com	0.0000000	0.0000000	1
15	2222222222001	test 2	Cuenca	UCuenca	david.santos@ucuenca.edu.ec	www.test2.com	0.0000000	0.0000000	1
\.


                                                                2944.dat                                                                                            0000600 0004000 0002000 00000001404 13515316761 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1	20
2	1	2	10
3	1	3	6
4	1	4	8
5	1	5	2
6	1	6	1
7	1	7	2
8	1	8	1
9	1	9	200
10	1	10	6
11	1	11	20
12	1	12	20
13	1	29	1
14	1	49	1
16	1	2	20
17	1	2	20
92	1	2	20
94	2	37	20
95	2	37	20
96	2	37	20
97	2	37	20
98	2	37	20
99	2	37	20
100	2	37	20
101	2	1	20
102	2	2	20
103	2	3	20
104	2	4	20
105	2	15	20
106	2	16	20
107	2	17	20
108	2	27	20
109	2	37	20
110	2	1	20
111	2	2	20
112	2	3	20
113	2	4	20
114	2	15	20
115	2	16	20
116	2	17	20
117	2	27	20
118	2	37	20
119	2	3	20
120	2	2	20
121	2	1	20
122	2	4	20
123	2	15	20
124	2	16	20
125	2	17	20
126	2	27	20
127	2	37	20
128	1	1	20
129	1	2	20
130	1	3	20
131	1	4	20
132	1	16	20
133	1	17	20
134	1	27	20
135	1	15	20
136	1	37	20
138	4	1	23
139	4	1	20
140	4	4	20
141	4	3	20
142	4	2	20
143	4	15	20
144	4	16	20
145	4	17	20
146	4	27	20
147	4	37	20
\.


                                                                                                                                                                                                                                                            2946.dat                                                                                            0000600 0004000 0002000 00000005026 13515316761 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	3	52	GOLD LABEL	f	20
2	2	3	42	GOLD LABEL	f	20
3	3	3	52	GOLD LABEL	f	20
4	4	3	62	GOLD LABEL	f	20
5	5	3	6	CAVIT	f	20
6	6	3	7	HIGHCAL	f	20
7	7	3	8	SMI	f	20
8	8	3	8	SMI	f	20
9	9	3	0	BECHT	f	20
10	10	3	1	AIRON	f	20
11	11	3	6	SAFARI	f	20
12	12	3	6	SAFARI	f	20
13	13	2	225	MARATHON	f	20
14	14	1	480	DIRECT BASIC	f	20
15	1	4	60	MARCA GATO	f	20
16	5	4	10	MARCA GATO	f	20
17	13	4	300	MARCA GATO	f	20
18	1	3	120	marca1	t	20
19	1	3	120	marca2	t	20
20	1	1	2	LABCity UK Poland	t	2
21	2	2	3	LABCity UK Poland	t	2
22	3	3	2	LABCity UK Poland	t	2
23	4	4	2	LABCity UK Poland	t	2
30	14	1	2	LABCity UK Poland	t	2
31	2	3	200	Marca 123	t	20
32	2	3	200	Marca 123	t	20
33	2	3	200	Marca 123	t	20
34	94	1	23014	LABCity UK Poland	t	20
35	94	1	23014	LABCity UK Poland	t	20
36	94	1	23014	LABCity UK Poland	t	20
37	94	1	23014	LABCity UK Poland	t	20
38	94	1	23014	LABCity UK Poland	t	20
39	94	1	23014	LABCity UK Poland	t	20
40	94	1	23014	LABCity UK Poland	t	20
41	101	1	23014	LABCity UK Poland	t	20
42	102	1	3014	LABCity UK Poland	t	20
43	103	1	2314	LABCity UK Poland	t	20
44	104	1	234	LABCity UK Poland	t	20
45	105	1	2014	LABCity UK Poland	t	20
46	106	1	14	LABCity UK Poland	t	20
47	107	1	2304	LABCity UK Poland	t	20
48	108	1	234	LABCity UK Poland	t	20
49	94	1	23014	LABCity UK Poland	t	20
50	101	1	23014	LABCity UK Poland	t	20
51	102	1	3014	LABCity UK Poland	t	20
52	103	1	2314	LABCity UK Poland	t	20
53	104	1	234	LABCity UK Poland	t	20
54	105	1	2014	LABCity UK Poland	t	20
55	106	1	14	LABCity UK Poland	t	20
56	107	1	2304	LABCity UK Poland	t	20
57	108	1	234	LABCity UK Poland	t	20
58	94	1	23014	LABCity UK Poland	t	20
59	103	1	2314	LABCity UK Poland	t	20
60	102	1	3014	LABCity UK Poland	t	20
61	101	1	23014	LABCity UK Poland	t	20
62	104	1	234	LABCity UK Poland	t	20
63	105	1	2014	LABCity UK Poland	t	20
64	106	1	14	LABCity UK Poland	t	20
65	107	1	2304	LABCity UK Poland	t	20
66	108	1	234	LABCity UK Poland	t	20
67	94	1	23014	LABCity UK Poland	t	20
68	1	1	23014	LABCity UK Poland	t	20
69	2	1	3014	LABCity UK Poland	t	20
70	3	1	2314	LABCity UK Poland	t	20
71	4	1	234	LABCity UK Poland	t	20
72	132	1	14	LABCity UK Poland	t	20
73	133	1	2304	LABCity UK Poland	t	20
74	134	1	234	LABCity UK Poland	t	20
75	135	1	2014	LABCity UK Poland	t	20
76	136	1	23014	LABCity UK Poland	t	20
77	138	1	23014	LABCity UK Poland	t	20
78	140	1	234	LABCity UK Poland	t	20
79	141	1	2314	LABCity UK Poland	t	20
80	142	1	3014	LABCity UK Poland	t	20
81	143	1	2014	LABCity UK Poland	t	20
82	144	1	14	LABCity UK Poland	t	20
83	145	1	2304	LABCity UK Poland	t	20
84	146	1	234	LABCity UK Poland	t	20
85	147	1	23014	LABCity UK Poland	t	20
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2948.dat                                                                                            0000600 0004000 0002000 00000000143 13515316761 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	1
11	11	1
12	12	1
13	13	2
14	14	2
\.


                                                                                                                                                                                                                                                                                                                                                                                                                             2942.dat                                                                                            0000600 0004000 0002000 00000000422 13515316761 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	2	9	0.00	0.00	0.00	2019-06-30 00:07:28.04565	2019-07-20 05:00:00
3	1	1	0.00	0.00	0.00	2019-06-30 00:07:28.04565	2019-07-20 05:00:00
4	1	1	0.00	0.00	0.00	2019-07-20 10:28:44.607228	2019-07-20 05:00:00
1	1	9	0.00	0.00	2.20	2019-06-30 00:07:28.04565	2019-07-20 05:00:00
\.


                                                                                                                                                                                                                                              2936.dat                                                                                            0000600 0004000 0002000 00000000101 13515316761 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	2395329
2	1	2394882
3	1	2394880
4	2	2293175
5	2	2299933
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               restore.sql                                                                                         0000600 0004000 0002000 00000103111 13515316761 0015371 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.8
-- Dumped by pg_dump version 10.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.telefonosproveedores DROP CONSTRAINT telefonosproveedores_idproveedor_fkey;
ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_idpersonal_fkey;
ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_idestadosolicitud_fkey;
ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_ids_i_fkey;
ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_idproforma_fkey;
ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey;
ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey;
ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_idsolicitud_fkey;
ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_iditem_fkey;
ALTER TABLE ONLY public.proveedores DROP CONSTRAINT proveedores_idestadoproveedor_fkey;
ALTER TABLE ONLY public.proformas DROP CONSTRAINT proformas_idproveedor_fkey;
ALTER TABLE ONLY public.telefonosproveedores DROP CONSTRAINT telefonosproveedores_pkey;
ALTER TABLE ONLY public.solicitudesadquisicionitems DROP CONSTRAINT solicitudesadquisicionitems_pkey;
ALTER TABLE ONLY public.solicitudes_items_proformas DROP CONSTRAINT solicitudes_items_proformas_pkey;
ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems DROP CONSTRAINT solicitudes_items_proformas_categoriadeitems_pkey;
ALTER TABLE ONLY public.solicitudes_items DROP CONSTRAINT solicitudes_items_pkey;
ALTER TABLE ONLY public.proveedores DROP CONSTRAINT proveedores_pkey;
ALTER TABLE ONLY public.proformas DROP CONSTRAINT proformas_pkey;
ALTER TABLE ONLY public.personal DROP CONSTRAINT personal_pkey;
ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
ALTER TABLE ONLY public.estadosolicitud DROP CONSTRAINT estadosolicitud_pkey;
ALTER TABLE ONLY public.estadoproveedor DROP CONSTRAINT estadoproveedor_pkey;
ALTER TABLE ONLY public.categoriasdeitems DROP CONSTRAINT categoriasdeitems_pkey;
ALTER TABLE public.telefonosproveedores ALTER COLUMN idtelefono DROP DEFAULT;
ALTER TABLE public.solicitudesadquisicionitems ALTER COLUMN idsolicitud DROP DEFAULT;
ALTER TABLE public.solicitudes_items_proformas_categoriadeitems ALTER COLUMN ids_i_p_c DROP DEFAULT;
ALTER TABLE public.solicitudes_items_proformas ALTER COLUMN ids_i_p DROP DEFAULT;
ALTER TABLE public.solicitudes_items ALTER COLUMN ids_i DROP DEFAULT;
ALTER TABLE public.proveedores ALTER COLUMN idproveedor DROP DEFAULT;
ALTER TABLE public.proformas ALTER COLUMN idproforma DROP DEFAULT;
ALTER TABLE public.personal ALTER COLUMN idpersonal DROP DEFAULT;
ALTER TABLE public.items ALTER COLUMN iditem DROP DEFAULT;
ALTER TABLE public.estadosolicitud ALTER COLUMN idestado DROP DEFAULT;
ALTER TABLE public.estadoproveedor ALTER COLUMN idestado DROP DEFAULT;
ALTER TABLE public.categoriasdeitems ALTER COLUMN idcategoria DROP DEFAULT;
DROP SEQUENCE public.telefonosproveedores_idtelefono_seq;
DROP TABLE public.telefonosproveedores;
DROP SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq;
DROP TABLE public.solicitudesadquisicionitems;
DROP SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq;
DROP SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq;
DROP TABLE public.solicitudes_items_proformas_categoriadeitems;
DROP TABLE public.solicitudes_items_proformas;
DROP SEQUENCE public.solicitudes_items_ids_i_seq;
DROP TABLE public.solicitudes_items;
DROP SEQUENCE public.proveedores_idproveedor_seq;
DROP TABLE public.proveedores;
DROP SEQUENCE public.proformas_idproforma_seq;
DROP TABLE public.proformas;
DROP SEQUENCE public.personal_idpersonal_seq;
DROP TABLE public.personal;
DROP VIEW public.itemsactualizado;
DROP SEQUENCE public.items_iditem_seq;
DROP TABLE public.items;
DROP TABLE public.inventarioactualizado;
DROP SEQUENCE public.estadosolicitud_idestado_seq;
DROP TABLE public.estadosolicitud;
DROP SEQUENCE public.estadoproveedor_idestado_seq;
DROP TABLE public.estadoproveedor;
DROP SEQUENCE public.categoriasdeitems_idcategoria_seq;
DROP TABLE public.categoriasdeitems;
DROP FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio integer, _marca character varying, OUT respuesta text);
DROP FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio double precision, _marca character varying, OUT respuesta text);
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: agregaritemprof(integer, integer, integer, integer, integer, double precision, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio double precision, _marca character varying, OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	idsi integer;
BEGIN
    insert into solicitudes_items (idsolicitud,iditem,cantidad) values (_idSolicitud,_idItem,_unidades);
    select ids_i into idsi from solicitudes_items where idsolicitud=_idSolicitud and iditem=_idItem;
    insert into solicitudes_items_proformas(ids_i,idproforma,preciounit,marca,disponible,_unidades)values(idsi,_idProf,_precio,_marca,true,_unidades) ;
END;
$$;


ALTER FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio double precision, _marca character varying, OUT respuesta text) OWNER TO postgres;

--
-- Name: agregaritemprof(integer, integer, integer, integer, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio integer, _marca character varying, OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	idsi integer;
BEGIN
    insert into solicitudes_items (idsolicitud,iditem,cantidad) values (_idSolicitud,_idItem,_unidades);
    select ids_i into idsi from solicitudes_items where idsolicitud=_idSolicitud and iditem=_idItem;
    insert into solicitudes_items_proformas(ids_i,idproforma,preciounit,marca,disponible,unidades)values(idsi,_idProf,_precio,_marca,true,_unidades) ;
END;
$$;


ALTER FUNCTION public.agregaritemprof(_idsolicitud integer, _iditem integer, _idprov integer, _idprof integer, _unidades integer, _precio integer, _marca character varying, OUT respuesta text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoriasdeitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriasdeitems (
    idcategoria integer NOT NULL,
    descripcion text,
    limitprecioinf integer,
    limitpreciosup integer
);


ALTER TABLE public.categoriasdeitems OWNER TO postgres;

--
-- Name: categoriasdeitems_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoriasdeitems_idcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoriasdeitems_idcategoria_seq OWNER TO postgres;

--
-- Name: categoriasdeitems_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoriasdeitems_idcategoria_seq OWNED BY public.categoriasdeitems.idcategoria;


--
-- Name: estadoproveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadoproveedor (
    idestado integer NOT NULL,
    estado character varying(30)
);


ALTER TABLE public.estadoproveedor OWNER TO postgres;

--
-- Name: estadoproveedor_idestado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadoproveedor_idestado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadoproveedor_idestado_seq OWNER TO postgres;

--
-- Name: estadoproveedor_idestado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadoproveedor_idestado_seq OWNED BY public.estadoproveedor.idestado;


--
-- Name: estadosolicitud; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadosolicitud (
    idestado integer NOT NULL,
    descripcion text
);


ALTER TABLE public.estadosolicitud OWNER TO postgres;

--
-- Name: estadosolicitud_idestado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadosolicitud_idestado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadosolicitud_idestado_seq OWNER TO postgres;

--
-- Name: estadosolicitud_idestado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadosolicitud_idestado_seq OWNED BY public.estadosolicitud.idestado;


--
-- Name: inventarioactualizado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventarioactualizado (
    iditem integer,
    cantidad integer,
    fecha text
);


ALTER TABLE public.inventarioactualizado OWNER TO postgres;

--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    iditem integer NOT NULL,
    descripcion character varying(100),
    estado character varying(25) DEFAULT 'ACTIVO'::character varying
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: items_iditem_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_iditem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_iditem_seq OWNER TO postgres;

--
-- Name: items_iditem_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_iditem_seq OWNED BY public.items.iditem;


--
-- Name: itemsactualizado; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.itemsactualizado AS
 SELECT i.iditem,
    i.cantidad,
    i.fecha,
    it.descripcion
   FROM public.inventarioactualizado i,
    public.items it
  WHERE (i.iditem = it.iditem);


ALTER TABLE public.itemsactualizado OWNER TO postgres;

--
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
    idpersonal integer NOT NULL,
    username character varying(30),
    nombres character varying(50),
    apellidos character varying(50),
    email character varying(50),
    contrasenia character varying(20),
    cargo character varying(50)
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- Name: personal_idpersonal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_idpersonal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_idpersonal_seq OWNER TO postgres;

--
-- Name: personal_idpersonal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_idpersonal_seq OWNED BY public.personal.idpersonal;


--
-- Name: proformas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proformas (
    idproforma integer NOT NULL,
    idproveedor integer,
    noproforma integer,
    preciosubtotal numeric(8,2),
    preciototal numeric(8,2),
    descuento numeric(5,2),
    fechaemision timestamp without time zone
);


ALTER TABLE public.proformas OWNER TO postgres;

--
-- Name: proformas_idproforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proformas_idproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proformas_idproforma_seq OWNER TO postgres;

--
-- Name: proformas_idproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proformas_idproforma_seq OWNED BY public.proformas.idproforma;


--
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    idproveedor integer NOT NULL,
    ruc character varying(14) NOT NULL,
    nombre character varying(50),
    ciudad character varying(30),
    direccion character varying(50),
    email character varying(50),
    paginaweb character varying(50),
    longitud numeric(10,7),
    latitud numeric(10,7),
    idestadoproveedor integer
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- Name: proveedores_idproveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedores_idproveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proveedores_idproveedor_seq OWNER TO postgres;

--
-- Name: proveedores_idproveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_idproveedor_seq OWNED BY public.proveedores.idproveedor;


--
-- Name: solicitudes_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_items (
    ids_i integer NOT NULL,
    idsolicitud integer,
    iditem integer,
    cantidad integer
);


ALTER TABLE public.solicitudes_items OWNER TO postgres;

--
-- Name: solicitudes_items_ids_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_items_ids_i_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solicitudes_items_ids_i_seq OWNER TO postgres;

--
-- Name: solicitudes_items_ids_i_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_items_ids_i_seq OWNED BY public.solicitudes_items.ids_i;


--
-- Name: solicitudes_items_proformas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_items_proformas (
    ids_i_p integer NOT NULL,
    ids_i integer,
    idproforma integer,
    preciounit integer,
    marca character varying(30),
    disponible boolean DEFAULT false,
    unidades integer
);


ALTER TABLE public.solicitudes_items_proformas OWNER TO postgres;

--
-- Name: solicitudes_items_proformas_categoriadeitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_items_proformas_categoriadeitems (
    ids_i_p_c integer NOT NULL,
    ids_i_p integer,
    idcategoriadeitems integer
);


ALTER TABLE public.solicitudes_items_proformas_categoriadeitems OWNER TO postgres;

--
-- Name: solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq OWNER TO postgres;

--
-- Name: solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq OWNED BY public.solicitudes_items_proformas_categoriadeitems.ids_i_p_c;


--
-- Name: solicitudes_items_proformas_ids_i_p_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solicitudes_items_proformas_ids_i_p_seq OWNER TO postgres;

--
-- Name: solicitudes_items_proformas_ids_i_p_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_items_proformas_ids_i_p_seq OWNED BY public.solicitudes_items_proformas.ids_i_p;


--
-- Name: solicitudesadquisicionitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudesadquisicionitems (
    idsolicitud integer NOT NULL,
    idpersonal integer,
    idestadosolicitud integer DEFAULT 1,
    preciosubtotal numeric(8,2) DEFAULT 0.0,
    preciototal numeric(8,2) DEFAULT 0.0,
    descuento numeric(5,2) DEFAULT 0.0,
    fechainicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fechafin timestamp without time zone
);


ALTER TABLE public.solicitudesadquisicionitems OWNER TO postgres;

--
-- Name: solicitudesadquisicionitems_idsolicitud_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solicitudesadquisicionitems_idsolicitud_seq OWNER TO postgres;

--
-- Name: solicitudesadquisicionitems_idsolicitud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudesadquisicionitems_idsolicitud_seq OWNED BY public.solicitudesadquisicionitems.idsolicitud;


--
-- Name: telefonosproveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefonosproveedores (
    idtelefono integer NOT NULL,
    idproveedor integer,
    telefono character varying(20)
);


ALTER TABLE public.telefonosproveedores OWNER TO postgres;

--
-- Name: telefonosproveedores_idtelefono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.telefonosproveedores_idtelefono_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.telefonosproveedores_idtelefono_seq OWNER TO postgres;

--
-- Name: telefonosproveedores_idtelefono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.telefonosproveedores_idtelefono_seq OWNED BY public.telefonosproveedores.idtelefono;


--
-- Name: categoriasdeitems idcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasdeitems ALTER COLUMN idcategoria SET DEFAULT nextval('public.categoriasdeitems_idcategoria_seq'::regclass);


--
-- Name: estadoproveedor idestado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadoproveedor ALTER COLUMN idestado SET DEFAULT nextval('public.estadoproveedor_idestado_seq'::regclass);


--
-- Name: estadosolicitud idestado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadosolicitud ALTER COLUMN idestado SET DEFAULT nextval('public.estadosolicitud_idestado_seq'::regclass);


--
-- Name: items iditem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN iditem SET DEFAULT nextval('public.items_iditem_seq'::regclass);


--
-- Name: personal idpersonal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal ALTER COLUMN idpersonal SET DEFAULT nextval('public.personal_idpersonal_seq'::regclass);


--
-- Name: proformas idproforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proformas ALTER COLUMN idproforma SET DEFAULT nextval('public.proformas_idproforma_seq'::regclass);


--
-- Name: proveedores idproveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN idproveedor SET DEFAULT nextval('public.proveedores_idproveedor_seq'::regclass);


--
-- Name: solicitudes_items ids_i; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items ALTER COLUMN ids_i SET DEFAULT nextval('public.solicitudes_items_ids_i_seq'::regclass);


--
-- Name: solicitudes_items_proformas ids_i_p; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas ALTER COLUMN ids_i_p SET DEFAULT nextval('public.solicitudes_items_proformas_ids_i_p_seq'::regclass);


--
-- Name: solicitudes_items_proformas_categoriadeitems ids_i_p_c; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems ALTER COLUMN ids_i_p_c SET DEFAULT nextval('public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq'::regclass);


--
-- Name: solicitudesadquisicionitems idsolicitud; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudesadquisicionitems ALTER COLUMN idsolicitud SET DEFAULT nextval('public.solicitudesadquisicionitems_idsolicitud_seq'::regclass);


--
-- Name: telefonosproveedores idtelefono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefonosproveedores ALTER COLUMN idtelefono SET DEFAULT nextval('public.telefonosproveedores_idtelefono_seq'::regclass);


--
-- Data for Name: categoriasdeitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoriasdeitems (idcategoria, descripcion, limitprecioinf, limitpreciosup) FROM stdin;
\.
COPY public.categoriasdeitems (idcategoria, descripcion, limitprecioinf, limitpreciosup) FROM '$$PATH$$/2926.dat';

--
-- Data for Name: estadoproveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadoproveedor (idestado, estado) FROM stdin;
\.
COPY public.estadoproveedor (idestado, estado) FROM '$$PATH$$/2932.dat';

--
-- Data for Name: estadosolicitud; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadosolicitud (idestado, descripcion) FROM stdin;
\.
COPY public.estadosolicitud (idestado, descripcion) FROM '$$PATH$$/2928.dat';

--
-- Data for Name: inventarioactualizado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventarioactualizado (iditem, cantidad, fecha) FROM stdin;
\.
COPY public.inventarioactualizado (iditem, cantidad, fecha) FROM '$$PATH$$/2949.dat';

--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (iditem, descripcion, estado) FROM stdin;
\.
COPY public.items (iditem, descripcion, estado) FROM '$$PATH$$/2940.dat';

--
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal (idpersonal, username, nombres, apellidos, email, contrasenia, cargo) FROM stdin;
\.
COPY public.personal (idpersonal, username, nombres, apellidos, email, contrasenia, cargo) FROM '$$PATH$$/2930.dat';

--
-- Data for Name: proformas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proformas (idproforma, idproveedor, noproforma, preciosubtotal, preciototal, descuento, fechaemision) FROM stdin;
\.
COPY public.proformas (idproforma, idproveedor, noproforma, preciosubtotal, preciototal, descuento, fechaemision) FROM '$$PATH$$/2938.dat';

--
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (idproveedor, ruc, nombre, ciudad, direccion, email, paginaweb, longitud, latitud, idestadoproveedor) FROM stdin;
\.
COPY public.proveedores (idproveedor, ruc, nombre, ciudad, direccion, email, paginaweb, longitud, latitud, idestadoproveedor) FROM '$$PATH$$/2934.dat';

--
-- Data for Name: solicitudes_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_items (ids_i, idsolicitud, iditem, cantidad) FROM stdin;
\.
COPY public.solicitudes_items (ids_i, idsolicitud, iditem, cantidad) FROM '$$PATH$$/2944.dat';

--
-- Data for Name: solicitudes_items_proformas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_items_proformas (ids_i_p, ids_i, idproforma, preciounit, marca, disponible, unidades) FROM stdin;
\.
COPY public.solicitudes_items_proformas (ids_i_p, ids_i, idproforma, preciounit, marca, disponible, unidades) FROM '$$PATH$$/2946.dat';

--
-- Data for Name: solicitudes_items_proformas_categoriadeitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_items_proformas_categoriadeitems (ids_i_p_c, ids_i_p, idcategoriadeitems) FROM stdin;
\.
COPY public.solicitudes_items_proformas_categoriadeitems (ids_i_p_c, ids_i_p, idcategoriadeitems) FROM '$$PATH$$/2948.dat';

--
-- Data for Name: solicitudesadquisicionitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudesadquisicionitems (idsolicitud, idpersonal, idestadosolicitud, preciosubtotal, preciototal, descuento, fechainicio, fechafin) FROM stdin;
\.
COPY public.solicitudesadquisicionitems (idsolicitud, idpersonal, idestadosolicitud, preciosubtotal, preciototal, descuento, fechainicio, fechafin) FROM '$$PATH$$/2942.dat';

--
-- Data for Name: telefonosproveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefonosproveedores (idtelefono, idproveedor, telefono) FROM stdin;
\.
COPY public.telefonosproveedores (idtelefono, idproveedor, telefono) FROM '$$PATH$$/2936.dat';

--
-- Name: categoriasdeitems_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoriasdeitems_idcategoria_seq', 3, true);


--
-- Name: estadoproveedor_idestado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadoproveedor_idestado_seq', 3, true);


--
-- Name: estadosolicitud_idestado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadosolicitud_idestado_seq', 8, true);


--
-- Name: items_iditem_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_iditem_seq', 67, true);


--
-- Name: personal_idpersonal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_idpersonal_seq', 2, true);


--
-- Name: proformas_idproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proformas_idproforma_seq', 4, true);


--
-- Name: proveedores_idproveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_idproveedor_seq', 15, true);


--
-- Name: solicitudes_items_ids_i_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_items_ids_i_seq', 147, true);


--
-- Name: solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_items_proformas_categoriadeitems_ids_i_p_c_seq', 14, true);


--
-- Name: solicitudes_items_proformas_ids_i_p_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_items_proformas_ids_i_p_seq', 85, true);


--
-- Name: solicitudesadquisicionitems_idsolicitud_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudesadquisicionitems_idsolicitud_seq', 4, true);


--
-- Name: telefonosproveedores_idtelefono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.telefonosproveedores_idtelefono_seq', 5, true);


--
-- Name: categoriasdeitems categoriasdeitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasdeitems
    ADD CONSTRAINT categoriasdeitems_pkey PRIMARY KEY (idcategoria);


--
-- Name: estadoproveedor estadoproveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadoproveedor
    ADD CONSTRAINT estadoproveedor_pkey PRIMARY KEY (idestado);


--
-- Name: estadosolicitud estadosolicitud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadosolicitud
    ADD CONSTRAINT estadosolicitud_pkey PRIMARY KEY (idestado);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (iditem);


--
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (idpersonal);


--
-- Name: proformas proformas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proformas
    ADD CONSTRAINT proformas_pkey PRIMARY KEY (idproforma);


--
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (idproveedor);


--
-- Name: solicitudes_items solicitudes_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_pkey PRIMARY KEY (ids_i);


--
-- Name: solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriadeitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriadeitems_pkey PRIMARY KEY (ids_i_p_c);


--
-- Name: solicitudes_items_proformas solicitudes_items_proformas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_pkey PRIMARY KEY (ids_i_p);


--
-- Name: solicitudesadquisicionitems solicitudesadquisicionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_pkey PRIMARY KEY (idsolicitud);


--
-- Name: telefonosproveedores telefonosproveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefonosproveedores
    ADD CONSTRAINT telefonosproveedores_pkey PRIMARY KEY (idtelefono);


--
-- Name: proformas proformas_idproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proformas
    ADD CONSTRAINT proformas_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES public.proveedores(idproveedor);


--
-- Name: proveedores proveedores_idestadoproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_idestadoproveedor_fkey FOREIGN KEY (idestadoproveedor) REFERENCES public.estadoproveedor(idestado);


--
-- Name: solicitudes_items solicitudes_items_iditem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_iditem_fkey FOREIGN KEY (iditem) REFERENCES public.items(iditem);


--
-- Name: solicitudes_items solicitudes_items_idsolicitud_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items
    ADD CONSTRAINT solicitudes_items_idsolicitud_fkey FOREIGN KEY (idsolicitud) REFERENCES public.solicitudesadquisicionitems(idsolicitud);


--
-- Name: solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriade_idcategoriadeitems_fkey FOREIGN KEY (idcategoriadeitems) REFERENCES public.categoriasdeitems(idcategoria);


--
-- Name: solicitudes_items_proformas_categoriadeitems solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas_categoriadeitems
    ADD CONSTRAINT solicitudes_items_proformas_categoriadeitems_ids_i_p_fkey FOREIGN KEY (ids_i_p) REFERENCES public.solicitudes_items_proformas(ids_i_p);


--
-- Name: solicitudes_items_proformas solicitudes_items_proformas_idproforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_idproforma_fkey FOREIGN KEY (idproforma) REFERENCES public.proformas(idproforma);


--
-- Name: solicitudes_items_proformas solicitudes_items_proformas_ids_i_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_items_proformas
    ADD CONSTRAINT solicitudes_items_proformas_ids_i_fkey FOREIGN KEY (ids_i) REFERENCES public.solicitudes_items(ids_i);


--
-- Name: solicitudesadquisicionitems solicitudesadquisicionitems_idestadosolicitud_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_idestadosolicitud_fkey FOREIGN KEY (idestadosolicitud) REFERENCES public.estadosolicitud(idestado);


--
-- Name: solicitudesadquisicionitems solicitudesadquisicionitems_idpersonal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudesadquisicionitems
    ADD CONSTRAINT solicitudesadquisicionitems_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);


--
-- Name: telefonosproveedores telefonosproveedores_idproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefonosproveedores
    ADD CONSTRAINT telefonosproveedores_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES public.proveedores(idproveedor);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       