PGDMP     4    #                z           news.google.com    14.2    14.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16387    news.google.com    DATABASE     \   CREATE DATABASE "news.google.com" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
 !   DROP DATABASE "news.google.com";
                public_read    false                        2615    16389    search_results    SCHEMA        CREATE SCHEMA search_results;
    DROP SCHEMA search_results;
                public_read    false            �            1259    16505 	   documents    TABLE     �   CREATE TABLE search_results.documents (
    id integer NOT NULL,
    html_cache text,
    html_hash text,
    ref_query_id bigint,
    status_code integer,
    ref_topic_id bigint
);
 %   DROP TABLE search_results.documents;
       search_results         heap    public_read    false    4            �            1259    16504    documents_id_seq    SEQUENCE     �   CREATE SEQUENCE search_results.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE search_results.documents_id_seq;
       search_results          public_read    false    217    4                       0    0    documents_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE search_results.documents_id_seq OWNED BY search_results.documents.id;
          search_results          public_read    false    216            �            1259    16392    gnews_topics    TABLE     �  CREATE TABLE search_results.gnews_topics (
    id integer NOT NULL,
    title text,
    date text,
    link text,
    img text,
    media text,
    site text,
    internal_id text,
    insert_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    ref_query_id smallint,
    tokenize text,
    ref_document_id integer,
    is_complete boolean DEFAULT false,
    status_code smallint
);
 (   DROP TABLE search_results.gnews_topics;
       search_results         heap    public_read    false    4            �            1259    16410    queries    TABLE     �   CREATE TABLE search_results.queries (
    id integer NOT NULL,
    query text,
    ref_language_id smallint,
    ref_topic_id bigint
);
 #   DROP TABLE search_results.queries;
       search_results         heap    public_read    false    4            �            1259    16409    keywords_id_seq    SEQUENCE     �   CREATE SEQUENCE search_results.keywords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE search_results.keywords_id_seq;
       search_results          public_read    false    4    213                       0    0    keywords_id_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE search_results.keywords_id_seq OWNED BY search_results.queries.id;
          search_results          public_read    false    212            �            1259    16451 	   languages    TABLE     �   CREATE TABLE search_results.languages (
    id smallint NOT NULL,
    language text,
    hl_language text,
    gl_region text,
    ce_id text
);
 %   DROP TABLE search_results.languages;
       search_results         heap    public_read    false    4            �            1259    16454    languages_id_seq    SEQUENCE     �   CREATE SEQUENCE search_results.languages_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE search_results.languages_id_seq;
       search_results          public_read    false    214    4                       0    0    languages_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE search_results.languages_id_seq OWNED BY search_results.languages.id;
          search_results          public_read    false    215            �            1259    16391    records_id_seq    SEQUENCE     �   CREATE SEQUENCE search_results.records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE search_results.records_id_seq;
       search_results          public_read    false    4    211                       0    0    records_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE search_results.records_id_seq OWNED BY search_results.gnews_topics.id;
          search_results          public_read    false    210            }           2604    16508    documents id    DEFAULT     |   ALTER TABLE ONLY search_results.documents ALTER COLUMN id SET DEFAULT nextval('search_results.documents_id_seq'::regclass);
 C   ALTER TABLE search_results.documents ALTER COLUMN id DROP DEFAULT;
       search_results          public_read    false    216    217    217            x           2604    16395    gnews_topics id    DEFAULT     }   ALTER TABLE ONLY search_results.gnews_topics ALTER COLUMN id SET DEFAULT nextval('search_results.records_id_seq'::regclass);
 F   ALTER TABLE search_results.gnews_topics ALTER COLUMN id DROP DEFAULT;
       search_results          public_read    false    210    211    211            |           2604    16455    languages id    DEFAULT     |   ALTER TABLE ONLY search_results.languages ALTER COLUMN id SET DEFAULT nextval('search_results.languages_id_seq'::regclass);
 C   ALTER TABLE search_results.languages ALTER COLUMN id DROP DEFAULT;
       search_results          public_read    false    215    214            {           2604    16413 
   queries id    DEFAULT     y   ALTER TABLE ONLY search_results.queries ALTER COLUMN id SET DEFAULT nextval('search_results.keywords_id_seq'::regclass);
 A   ALTER TABLE search_results.queries ALTER COLUMN id DROP DEFAULT;
       search_results          public_read    false    212    213    213            �           2606    16512    documents documents_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY search_results.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY search_results.documents DROP CONSTRAINT documents_pkey;
       search_results            public_read    false    217            �           2606    16417    queries keywords_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY search_results.queries
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY search_results.queries DROP CONSTRAINT keywords_pkey;
       search_results            public_read    false    213            �           2606    16462    languages languages_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY search_results.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY search_results.languages DROP CONSTRAINT languages_pkey;
       search_results            public_read    false    214            �           2606    16399    gnews_topics records_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY search_results.gnews_topics
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY search_results.gnews_topics DROP CONSTRAINT records_pkey;
       search_results            public_read    false    211            ~           1259    16400    internal_id    INDEX     R   CREATE INDEX internal_id ON search_results.gnews_topics USING hash (internal_id);
 '   DROP INDEX search_results.internal_id;
       search_results            public_read    false    211                       1259    16404    internal_id_tmp    INDEX     ^   CREATE UNIQUE INDEX internal_id_tmp ON search_results.gnews_topics USING btree (internal_id);
 +   DROP INDEX search_results.internal_id_tmp;
       search_results            public_read    false    211            �           826    16390    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     i   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA search_results GRANT ALL ON TABLES  TO public_read;
          search_results          postgres    false    4           