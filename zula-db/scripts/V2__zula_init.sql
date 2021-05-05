--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Debian 12.6-1.pgdg100+1)
-- Dumped by pg_dump version 12.6 (Debian 12.6-1.pgdg100+1)

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
-- Name: book; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.book CASCADE;

CREATE TABLE public.book (
    id integer NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    title character varying(255)
);


ALTER TABLE public.book OWNER TO directus;

--
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_id_seq OWNER TO directus;

--
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- Name: book_translation; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.book_translation CASCADE;

CREATE TABLE public.book_translation (
    id integer NOT NULL,
    book_id integer,
    translation_id integer
);


ALTER TABLE public.book_translation OWNER TO directus;

--
-- Name: book_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.book_translation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_translation_id_seq OWNER TO directus;

--
-- Name: book_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.book_translation_id_seq OWNED BY public.book_translation.id;


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_activity CASCADE;

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_collections CASCADE;

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_fields CASCADE;

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_files CASCADE;

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize integer,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_folders CASCADE;

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_migrations CASCADE;

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_permissions CASCADE;

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_presets CASCADE;

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_relations CASCADE;

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    many_primary character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_primary character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(255)
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_revisions CASCADE;

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_roles CASCADE;

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_sessions CASCADE;

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_settings CASCADE;

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_users CASCADE;

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.directus_webhooks CASCADE;

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: translation; Type: TABLE; Schema: public; Owner: directus
--

DROP TABLE IF EXISTS public.translation CASCADE;

CREATE TABLE public.translation (
    id integer NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    language character varying(255),
    config json,
    title character varying(255)
);


ALTER TABLE public.translation OWNER TO directus;

--
-- Name: translation_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.translation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.translation_id_seq OWNER TO directus;

--
-- Name: translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.translation_id_seq OWNED BY public.translation.id;


--
-- Name: book id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- Name: book_translation id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.book_translation ALTER COLUMN id SET DEFAULT nextval('public.book_translation_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: translation id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.translation ALTER COLUMN id SET DEFAULT nextval('public.translation_id_seq'::regclass);


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.book (id, status, user_created, date_created, user_updated, date_updated, title) FROM stdin;
1	published	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:51.086+00	\N	\N	A beautiful day
\.


--
-- Data for Name: book_translation; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.book_translation (id, book_id, translation_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) FROM stdin;
1	authenticate	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:07:43.397289+00	::ffff:172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_users	7f0bbb28-54ae-445b-b139-31b993923509	\N
2	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_collections	translation	\N
3	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	1	\N
4	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	2	\N
5	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	3	\N
6	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	4	\N
7	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	5	\N
8	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.239982+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	6	\N
9	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.38182+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	1	\N
10	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:09:15.38182+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	2	\N
11	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:10:01.960333+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	7	\N
12	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:10:24.633588+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	8	\N
13	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:00.348979+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	9	\N
14	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.657559+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	1	\N
15	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.665642+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	2	\N
16	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.672689+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	3	\N
17	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.678654+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	4	\N
18	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.686262+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	5	\N
19	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.692185+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	6	\N
20	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.709015+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	9	\N
21	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.717275+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	7	\N
22	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:11:02.723045+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	8	\N
23	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:09.872947+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	translation	1	\N
24	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_collections	book	\N
25	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	10	\N
26	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	11	\N
27	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	12	\N
28	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	13	\N
29	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	14	\N
30	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:30.91459+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	15	\N
31	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:31.04557+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	3	\N
32	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:31.04557+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	4	\N
33	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.250638+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	16	\N
34	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.326749+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_collections	book_translation	\N
35	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.326749+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	17	\N
36	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.429586+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	18	\N
37	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.430339+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	19	\N
38	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.589483+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	5	\N
39	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:10.590163+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_relations	6	\N
40	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:27.84202+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	20	\N
41	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.313121+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	10	\N
42	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.335974+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	11	\N
43	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.342278+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	12	\N
44	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.348155+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	13	\N
45	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.353863+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	14	\N
46	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.361041+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	15	\N
47	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.366368+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	20	\N
48	update	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:30.371887+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_fields	16	\N
49	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:51.086173+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	book_translation	1	\N
50	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:13:51.086173+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	book	1	\N
51	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:14:22.671839+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_permissions	1	\N
52	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:14:23.945587+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_permissions	2	\N
53	create	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:14:25.587812+00	172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36	directus_permissions	3	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) FROM stdin;
translation	\N	\N	\N	f	f	\N	status	t	archived	draft	\N	all
book	\N	\N	\N	f	f	\N	status	t	archived	draft	\N	all
book_translation	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) FROM stdin;
1	translation	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N
2	translation	status	\N	dropdown	{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	2	full	\N	\N	\N
3	translation	user_created	user-created	user	{"display":"both"}	user	\N	t	t	3	half	\N	\N	\N
4	translation	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N
5	translation	user_updated	user-updated	user	{"display":"both"}	user	\N	t	t	5	half	\N	\N	\N
6	translation	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	6	half	\N	\N	\N
9	translation	title	\N	\N	\N	\N	\N	f	f	7	full	\N	\N	\N
7	translation	language	\N	dropdown	{"choices":[{"text":"French","value":"fr"},{"text":"German","value":"de"}]}	formatted-value	{"formatTitle":true}	f	f	8	full	\N	\N	\N
8	translation	config	json	\N	\N	\N	\N	f	f	9	full	\N	\N	\N
17	book_translation	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N
18	book_translation	book_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N
19	book_translation	translation_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N
10	book	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N
11	book	status	\N	dropdown	{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	2	full	\N	\N	\N
12	book	user_created	user-created	user	{"display":"both"}	user	\N	t	t	3	half	\N	\N	\N
13	book	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N
14	book	user_updated	user-updated	user	{"display":"both"}	user	\N	t	t	5	half	\N	\N	\N
15	book	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	6	half	\N	\N	\N
20	book	title	\N	\N	\N	\N	\N	f	f	7	full	\N	\N	\N
16	book	translations	m2m	many-to-many	{"template":"{{translation_id.language}} - {{translation_id.title}}"}	\N	\N	f	f	8	full	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2021-04-29 17:07:22.549899+00
20201029A	Remove System Relations	2021-04-29 17:07:22.558594+00
20201029B	Remove System Collections	2021-04-29 17:07:22.568904+00
20201029C	Remove System Fields	2021-04-29 17:07:22.581649+00
20201105A	Add Cascade System Relations	2021-04-29 17:07:22.663133+00
20201105B	Change Webhook URL Type	2021-04-29 17:07:22.67057+00
20210225A	Add Relations Sort Field	2021-04-29 17:07:22.677293+00
20210304A	Remove Locked Fields	2021-04-29 17:07:22.683883+00
20210312A	Webhooks Collections Text	2021-04-29 17:07:22.691396+00
20210331A	Add Refresh Interval	2021-04-29 17:07:22.695771+00
20210415A	Make Filesize Nullable	2021-04-29 17:07:22.705079+00
20210416A	Add Collections Accountability	2021-04-29 17:07:22.715697+00
20210422A	Remove Files Interface	2021-04-29 17:07:22.721476+00
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
1	\N	book	read	\N	\N	\N	*	\N
2	\N	book_translation	read	\N	\N	\N	*	\N
3	\N	translation	read	\N	\N	\N	*	\N
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options, refresh_interval) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) FROM stdin;
1	translation	user_created	id	directus_users	\N	id	\N	\N	\N	\N
2	translation	user_updated	id	directus_users	\N	id	\N	\N	\N	\N
3	book	user_created	id	directus_users	\N	id	\N	\N	\N	\N
4	book	user_updated	id	directus_users	\N	id	\N	\N	\N	\N
5	book_translation	translation_id	id	translation	\N	id	\N	\N	book_id	\N
6	book_translation	book_id	id	book	translations	id	\N	\N	translation_id	\N
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	23	translation	1	{"status":"published","language":"fr","config":["https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_05.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_06.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_07.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_08.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_09.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_10.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_11.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_12.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_13.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_14.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_15.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_16.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_17.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_18.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_19.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_20.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_21.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_22.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_23.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_24.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_25.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_26.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_27.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_28.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_29.jpg"],"title":"Une belle journée","id":1}	{"status":"published","language":"fr","config":["https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_05.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_06.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_07.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_08.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_09.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_10.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_11.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_12.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_13.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_14.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_15.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_16.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_17.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_18.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_19.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_20.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_21.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_22.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_23.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_24.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_25.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_26.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_27.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_28.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_29.jpg"],"title":"Une belle journée","id":1}	\N
2	49	book_translation	1	{"translation_id":1,"book_id":1,"id":1}	{"translation_id":1,"book_id":1,"id":1}	\N
3	50	book	1	{"status":"published","title":"A beautiful day","translations":[{"translation_id":1}],"id":1}	{"status":"published","title":"A beautiful day","translations":[{"translation_id":1}],"id":1}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
f7268803-4cc8-4b56-be30-4502a55e7d2b	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
o1Gp4jhgAn0bwze4cDsJwR9GNeBhQ42gAjIWA_t5caGeW7AvYXPFMH5Mq2g4PjRJ	7f0bbb28-54ae-445b-b139-31b993923509	2021-05-06 17:07:43.379+00	::ffff:172.24.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) FROM stdin;
7f0bbb28-54ae-445b-b139-31b993923509	\N	\N	admin@example.com	$argon2i$v=19$m=4096,t=3,p=1$xa8u6BwGuxllXwNvHmxEfA$/efwEmTVsWbRTbAUjj33p1NLzFzC8AALTAzpXXiClvg	\N	\N	\N	\N	\N	en-US	auto	\N	active	f7268803-4cc8-4b56-be30-4502a55e7d2b	\N	2021-04-29 17:14:39.22+00	/settings/roles/
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections) FROM stdin;
\.


--
-- Data for Name: translation; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.translation (id, status, user_created, date_created, user_updated, date_updated, language, config, title) FROM stdin;
1	published	7f0bbb28-54ae-445b-b139-31b993923509	2021-04-29 17:12:09.874+00	\N	\N	fr	["https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_05.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_06.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_07.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_08.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_09.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_10.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_11.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_12.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_13.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_14.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_15.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_16.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_17.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_18.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_19.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_20.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_21.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_22.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_23.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_24.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_25.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_26.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_27.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_28.jpg","https://d29v32klp19rv5.cloudfront.net/a-beautiful-day_french_interior_20200602_Seite_29.jpg"]	Une belle journée
\.


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.book_id_seq', 1, true);


--
-- Name: book_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.book_translation_id_seq', 1, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 53, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 20, true);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 3, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 6, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 3, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.translation_id_seq', 1, true);


--
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- Name: book_translation book_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.book_translation
    ADD CONSTRAINT book_translation_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: translation translation_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id);


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id);


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id);


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- PostgreSQL database dump complete
--

