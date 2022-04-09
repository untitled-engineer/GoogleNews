--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-03-31 06:49:27 EEST

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16451)
-- Name: languages; Type: TABLE; Schema: search_results; Owner: public_read
--

CREATE TABLE search_results.languages (
    id smallint NOT NULL,
    language text,
    hl_language text,
    gl_region text,
    ce_id text
);


ALTER TABLE search_results.languages OWNER TO public_read;

--
-- TOC entry 215 (class 1259 OID 16454)
-- Name: languages_id_seq; Type: SEQUENCE; Schema: search_results; Owner: public_read
--

CREATE SEQUENCE search_results.languages_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE search_results.languages_id_seq OWNER TO public_read;

--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 215
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: search_results; Owner: public_read
--

ALTER SEQUENCE search_results.languages_id_seq OWNED BY search_results.languages.id;


--
-- TOC entry 3444 (class 2604 OID 16455)
-- Name: languages id; Type: DEFAULT; Schema: search_results; Owner: public_read
--

ALTER TABLE ONLY search_results.languages ALTER COLUMN id SET DEFAULT nextval('search_results.languages_id_seq'::regclass);


--
-- TOC entry 3586 (class 0 OID 16451)
-- Dependencies: 214
-- Data for Name: languages; Type: TABLE DATA; Schema: search_results; Owner: public_read
--

COPY search_results.languages (id, language, hl_language, gl_region, ce_id) FROM stdin;
1	ukr	uk	UA	UA:uk
2	ukr-rus	ru	UA	UA:ru
3	russian ru	ru	RU	RU:ru
4	GB	gb	GB	GB:gb
5	USA	en-US	US	US:en
\.


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 215
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: search_results; Owner: public_read
--

SELECT pg_catalog.setval('search_results.languages_id_seq', 1, false);


--
-- TOC entry 3446 (class 2606 OID 16462)
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: search_results; Owner: public_read
--

ALTER TABLE ONLY search_results.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


-- Completed on 2022-03-31 06:49:27 EEST

--
-- PostgreSQL database dump complete
--

