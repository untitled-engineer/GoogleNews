--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-03-31 06:45:24 EEST

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
-- TOC entry 217 (class 1259 OID 16505)
-- Name: documents; Type: TABLE; Schema: search_results; Owner: public_read
--

CREATE TABLE search_results.documents (
    id integer NOT NULL,
    html_cache text,
    html_hash text,
    ref_query_id bigint,
    status_code integer,
    ref_topic_id bigint
);


ALTER TABLE search_results.documents OWNER TO public_read;

--
-- TOC entry 216 (class 1259 OID 16504)
-- Name: documents_id_seq; Type: SEQUENCE; Schema: search_results; Owner: public_read
--

CREATE SEQUENCE search_results.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE search_results.documents_id_seq OWNER TO public_read;

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 216
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: search_results; Owner: public_read
--

ALTER SEQUENCE search_results.documents_id_seq OWNED BY search_results.documents.id;


--
-- TOC entry 3444 (class 2604 OID 16508)
-- Name: documents id; Type: DEFAULT; Schema: search_results; Owner: public_read
--

ALTER TABLE ONLY search_results.documents ALTER COLUMN id SET DEFAULT nextval('search_results.documents_id_seq'::regclass);


--
-- TOC entry 3446 (class 2606 OID 16512)
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: search_results; Owner: public_read
--

ALTER TABLE ONLY search_results.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


-- Completed on 2022-03-31 06:45:24 EEST

--
-- PostgreSQL database dump complete
--

