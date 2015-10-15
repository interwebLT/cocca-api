--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tr_ids; Type: TABLE; Schema: public; Owner: coccaadmin; Tablespace: 
--

CREATE TABLE tr_ids (
    id integer NOT NULL,
    tr_id character varying,
    transaction_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE tr_ids OWNER TO coccaadmin;

--
-- Name: tr_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: coccaadmin
--

CREATE SEQUENCE tr_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tr_ids_id_seq OWNER TO coccaadmin;

--
-- Name: tr_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coccaadmin
--

ALTER SEQUENCE tr_ids_id_seq OWNED BY tr_ids.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: coccaadmin
--

ALTER TABLE ONLY tr_ids ALTER COLUMN id SET DEFAULT nextval('tr_ids_id_seq'::regclass);


--
-- Data for Name: tr_ids; Type: TABLE DATA; Schema: public; Owner: coccaadmin
--

COPY tr_ids (id, tr_id, transaction_date, created_at, updated_at) FROM stdin;
\.


--
-- Name: tr_ids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coccaadmin
--

SELECT pg_catalog.setval('tr_ids_id_seq', 1, false);


--
-- Name: tr_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: coccaadmin; Tablespace: 
--

ALTER TABLE ONLY tr_ids
    ADD CONSTRAINT tr_ids_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--