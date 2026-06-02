--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_rol_id_fkey;
ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_usuario_id_fkey;
ALTER TABLE ONLY public.detalle_pedidos DROP CONSTRAINT detalle_pedidos_pedido_id_fkey;
ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_correo_key;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_nombre_key;
ALTER TABLE ONLY public.pizzas DROP CONSTRAINT pizzas_pkey;
ALTER TABLE ONLY public.pizza_ingredientes DROP CONSTRAINT pizza_ingredientes_pkey;
ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
ALTER TABLE ONLY public.ingredientes DROP CONSTRAINT ingredientes_pkey;
ALTER TABLE ONLY public.detalle_pedidos DROP CONSTRAINT detalle_pedidos_pkey;
ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pizzas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pedidos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.ingredientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.detalle_pedidos ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.usuarios_id_seq;
DROP TABLE public.usuarios;
DROP SEQUENCE public.roles_id_seq;
DROP TABLE public.roles;
DROP SEQUENCE public.pizzas_id_seq;
DROP TABLE public.pizzas;
DROP TABLE public.pizza_ingredientes;
DROP SEQUENCE public.pedidos_id_seq;
DROP TABLE public.pedidos;
DROP SEQUENCE public.ingredientes_id_seq;
DROP TABLE public.ingredientes;
DROP SEQUENCE public.detalle_pedidos_id_seq;
DROP TABLE public.detalle_pedidos;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: detalle_pedidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detalle_pedidos (
    id integer NOT NULL,
    pedido_id integer,
    producto_nombre character varying(100) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    cantidad integer NOT NULL
);


--
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.detalle_pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.detalle_pedidos_id_seq OWNED BY public.detalle_pedidos.id;


--
-- Name: ingredientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredientes (
    id integer NOT NULL,
    nombre character varying(50),
    stock_gramos integer
);


--
-- Name: ingredientes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredientes_id_seq OWNED BY public.ingredientes.id;


--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pedidos (
    id integer NOT NULL,
    usuario_id integer,
    total numeric(10,2) NOT NULL,
    direccion text NOT NULL,
    metodo_pago character varying(20) NOT NULL,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;


--
-- Name: pizza_ingredientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pizza_ingredientes (
    pizza_id integer NOT NULL,
    ingrediente_id integer NOT NULL,
    cantidad_gramos integer
);


--
-- Name: pizzas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pizzas (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ingredientes text NOT NULL,
    precio numeric(8,2) NOT NULL,
    imagen_url character varying(255),
    disponible boolean DEFAULT true,
    categoria character varying(50) DEFAULT 'Pizzas Clásicas'::character varying
);


--
-- Name: pizzas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pizzas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pizzas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pizzas_id_seq OWNED BY public.pizzas.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    clave character varying(255) NOT NULL,
    dni character varying(8),
    telefono character varying(15),
    rol_id integer DEFAULT 1,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: detalle_pedidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedidos ALTER COLUMN id SET DEFAULT nextval('public.detalle_pedidos_id_seq'::regclass);


--
-- Name: ingredientes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredientes ALTER COLUMN id SET DEFAULT nextval('public.ingredientes_id_seq'::regclass);


--
-- Name: pedidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);


--
-- Name: pizzas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizzas ALTER COLUMN id SET DEFAULT nextval('public.pizzas_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: detalle_pedidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.detalle_pedidos (id, pedido_id, producto_nombre, descripcion, precio, cantidad) FROM stdin;
1	1	Pizza Hawaiana (Custom)	Personal | Masa Tradicional	18.00	1
2	2	pizza de peperoni	peperoni	15.00	1
3	3	Hawaiana Tropical	Salsa de tomate, mozzarella, jamón ahumado y piña tropical.	30.00	1
4	3	Pizza Vegetariana (Custom)	Personal | Masa Tradicional | EXTRAS: Extra Queso, Champiñones, Tocino, Pepperoni	32.00	1
5	4	Pizza Americana (Custom)	Personal | Masa Tradicional | EXTRAS: Extra Queso, Tocino	24.00	1
6	5	Hawaiana Tropical	Salsa de tomate, mozzarella, jamón ahumado y piña	30.00	1
7	6	Pizza Hawaiana (Custom)	Personal | Masa Tradicional	18.00	1
8	7	Pizza Hawaiana (Custom)	Personal | Masa Tradicional	18.00	1
9	9	Margarita Clásica	Salsa de tomate, queso mozzarella y albahaca fresca	28.00	1
10	10	Pepperoni Supreme	Doble capa de mozzarella, pepperoni picante y orégano	32.00	1
11	11	Hawaiana Tropical	Salsa de tomate, mozzarella, jamón ahumado y piña	30.00	1
12	12	Margarita Clásica	Salsa de tomate, queso mozzarella y albahaca fresca	28.00	1
13	12	Pizza Hawaiana (Custom)	Personal - Tradicional - Queso Mozzarella, Salsa de Tomate, Jamón, Piña	18.00	1
14	13	Margarita Clásica	Salsa de tomate, queso mozzarella y albahaca fresca	28.00	1
15	14	Coca Cola Personal	Gaseosa Coca Cola 500ml	4.50	1
16	14	Pepperoni Supreme	Doble capa de mozzarella, pepperoni picante y orégano	32.00	1
17	14	Margarita Clásica	Salsa de tomate, queso mozzarella y albahaca fresca	28.00	1
18	15	Pizza Hawaiana (Custom)	Mediana - Borde Queso - Queso Mozzarella, Salsa de Tomate, Piña - Extras: Extra Queso - Sin: Jamón	37.50	1
\.


--
-- Data for Name: ingredientes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredientes (id, nombre, stock_gramos) FROM stdin;
1	Peperoni	5000
2	Queso Mozzarella	10000
3	Masa	20000
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pedidos (id, usuario_id, total, direccion, metodo_pago, estado, fecha) FROM stdin;
3	7	62.00	plaza de armas	Yape	Entregado	2026-05-26 16:14:19.915366
1	6	18.00	jr. cajamarca N 966 	Yape	Entregado	2026-05-26 15:27:28.037604
2	6	15.00	jr, habram valderomar s/n	Yape	Entregado	2026-05-26 15:48:31.474918
4	8	24.00	av. sol	Yape	Entregado	2026-05-26 16:25:34.58443
5	8	30.00	av floral	Yape	Entregado	2026-05-26 16:31:47.335447
6	8	18.00	av la torre	Yape	Entregado	2026-05-26 16:38:13.122317
7	8	18.00	av progreso	Yape	Entregado	2026-05-31 10:36:24.873579
11	6	30.00	av sol	Yape	Entregado	2026-05-31 11:41:47.428897
12	6	46.00	jr cajamarca	Yape	Entregado	2026-05-31 14:58:50.259772
9	10	28.00	av universidad 	Yape	Entregado	2026-05-31 11:16:35.295188
10	10	32.00	jr tumbes	Yape	Entregado	2026-05-31 11:21:35.250742
13	6	28.00	aaa	Yape	Entregado	2026-05-31 17:48:00.716517
14	6	64.50	jr venezuela n 334	Yape	Entregado	2026-06-01 07:23:13.924547
15	6	37.50	JR CAJAMARCA N 966	Yape	Cocinando	2026-06-01 19:51:02.98097
\.


--
-- Data for Name: pizza_ingredientes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pizza_ingredientes (pizza_id, ingrediente_id, cantidad_gramos) FROM stdin;
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pizzas (id, nombre, ingredientes, precio, imagen_url, disponible, categoria) FROM stdin;
3	Hawaiana Tropical	Salsa de tomate, mozzarella, jamón ahumado y piña tropical.	30.00	/img/hawaiana.png	t	Pizzas Clásicas
4	Margarita Clásica	Salsa de tomate, queso mozzarella y albahaca fresca	28.00	https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
5	Pepperoni Supreme	Doble capa de mozzarella, pepperoni picante y orégano	32.00	https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
6	Hawaiana Tropical	Salsa de tomate, mozzarella, jamón ahumado y piña	30.00	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
7	Carnívora Extrema	Pepperoni, jamón, salchicha italiana, tocino y carne molida	38.00	https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
8	Vegetariana Gourmet	Champiñones, pimientos, cebolla, aceitunas negras y tomate	29.00	https://images.unsplash.com/photo-1573821663912-569905455b1c?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
9	Cuatro Quesos	Mozzarella, gorgonzola, parmesano y queso roquefort	35.00	https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
10	Mexicana Picante	Jalapeños, carne molida, cebolla morada, pimientos y ají	34.00	https://images.unsplash.com/photo-1590947132387-155cc02f3212?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
11	Americana	Salsa de tomate, queso mozzarella y extra jamón	27.00	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
12	Barbacoa Pollo	Pollo deshilachado, salsa BBQ, cebolla caramelizada	33.00	https://images.unsplash.com/photo-1565299507177-b0ac66763828?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
13	Inca Kola Personal	La bebida del sabor nacional 500ml, bien helada	4.50	https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
15	Chicha Morada Casera	Jarra de chicha morada con manzana, membrillo y limón (1 Litro)	7.00	https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
16	Limonada Frozen	Limonada frozen con hielo frappé y un toque de menta (1 Litro)	8.00	https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
17	Agua Mineral San Mateo	Agua mineral sin gas 600ml	3.00	https://images.unsplash.com/photo-1548839140-29a749e1bc4c?auto=format&fit=crop&w=500&q=60	t	Pizzas Clásicas
18	pizza de peperoni	peperoni	15.00	img/1779817957273_11466df7-40c3-4954-b7be-651542850479.png	t	Pizzas Clásicas
19	limonada	agua , limon 	12.00	img/1780258829419_Limonada-shutterstock_379385302.webp	t	Pizzas Clásicas
20	pizza familiar con una botella de 1lt	pizza y gaseosa	40.00	img/1780260571628_jueves_2_1_duo_familiar_con_gaseosa.webp	t	Pizzas Clásicas
21	pizza personal de peperoni	peperoni	5.00	img/1780261722853_images.jpg	t	Promociones
22	2 pizzas medianas + 1 coca cola	pizza	55.00	img/1780263150214_hut-days-duo-grande-202605251718061600.jpg	t	Promociones
23	pizza familiar con una coca cola	pizza	37.00	img/1780263837056_images_(1).jpg	t	Promociones
24	pizza de doble queso	queso	30.00	img/1780267833526_img.webp	t	Especialidades
14	Coca Cola Personal	Gaseosa Coca Cola 500ml	4.50	https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60	t	Bebidas
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, nombre) FROM stdin;
1	CLIENTE
2	COCINERO
3	ADMIN
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.usuarios (id, nombre, correo, clave, dni, telefono, rol_id, fecha_registro) FROM stdin;
5	cristhian deyson cahuana chambi	1crisjedday@gmail	123456	73853874	\N	1	2026-05-24 19:06:25.184512
6	deyson	1crisjedday@gmail.com	123456	12345678	\N	1	2026-05-26 11:04:37.089304
3	Cocinero Principal	admin@gmail.com	admin	\N	\N	2	2026-05-24 17:27:01.018932
7	Gerente General	gerente@gmail.com	gerente123	\N	\N	3	2026-05-26 11:32:32.706092
8	jhon	jhon@gmail.com	123456	12345678	\N	1	2026-05-26 11:38:25.049375
9	sergio	sergio@gmail.com	123456	12345678	\N	1	2026-05-26 11:46:56.640834
10	andre	andre@gmail.com	123456	12345678	\N	1	2026-05-31 10:59:10.832656
\.


--
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.detalle_pedidos_id_seq', 18, true);


--
-- Name: ingredientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredientes_id_seq', 3, true);


--
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 15, true);


--
-- Name: pizzas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pizzas_id_seq', 24, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 10, true);


--
-- Name: detalle_pedidos detalle_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedidos
    ADD CONSTRAINT detalle_pedidos_pkey PRIMARY KEY (id);


--
-- Name: ingredientes ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredientes
    ADD CONSTRAINT ingredientes_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- Name: pizza_ingredientes pizza_ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizza_ingredientes
    ADD CONSTRAINT pizza_ingredientes_pkey PRIMARY KEY (pizza_id, ingrediente_id);


--
-- Name: pizzas pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_pkey PRIMARY KEY (id);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: detalle_pedidos detalle_pedidos_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedidos
    ADD CONSTRAINT detalle_pedidos_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- Name: pedidos pedidos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: usuarios usuarios_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

