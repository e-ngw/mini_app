--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 17.5

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: mini_app_db_user
--

-- *not* creating schema, since initdb creates it


-- ALTER SCHEMA public OWNER TO mini_app_db_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


-- ALTER TABLE public.ar_internal_metadata OWNER TO mini_app_db_user;

--
-- Name: follows; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.follows (
    id bigint NOT NULL,
    follower_id integer NOT NULL,
    followed_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


-- ALTER TABLE public.follows OWNER TO mini_app_db_user;

--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: mini_app_db_user
--

CREATE SEQUENCE public.follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.follows_id_seq OWNER TO mini_app_db_user;

--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mini_app_db_user
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    body text,
    restaurant_info character varying,
    food_info character varying,
    user_id bigint,
    image character varying,
    title character varying NOT NULL
);


-- ALTER TABLE public.posts OWNER TO mini_app_db_user;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: mini_app_db_user
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.posts_id_seq OWNER TO mini_app_db_user;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mini_app_db_user
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


-- ALTER TABLE public.schema_migrations OWNER TO mini_app_db_user;

--
-- Name: taggings; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.taggings (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    tag_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


-- ALTER TABLE public.taggings OWNER TO mini_app_db_user;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: mini_app_db_user
--

CREATE SEQUENCE public.taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.taggings_id_seq OWNER TO mini_app_db_user;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mini_app_db_user
--

ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


-- ALTER TABLE public.tags OWNER TO mini_app_db_user;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: mini_app_db_user
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.tags_id_seq OWNER TO mini_app_db_user;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mini_app_db_user
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: mini_app_db_user
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    introduction character varying,
    is_public boolean DEFAULT true NOT NULL
);


-- ALTER TABLE public.users OWNER TO mini_app_db_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mini_app_db_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER SEQUENCE public.users_id_seq OWNER TO mini_app_db_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mini_app_db_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2025-07-01 09:39:14.896145	2025-07-01 09:39:14.896149
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.follows (id, follower_id, followed_id, created_at, updated_at) FROM stdin;
5	2	1	2025-07-13 14:09:34.270892	2025-07-13 14:09:34.270892
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.posts (id, created_at, updated_at, body, restaurant_info, food_info, user_id, image, title) FROM stdin;
26	2025-07-29 09:17:23.206101	2025-07-29 09:17:23.206101	これ以外のポテチ食べてないくらい好き\r\nうすしおならこれ一択！	ファミリーマート	絶品うすしお味	1	sample_potato.jpg	うすしおポテチの最推し
23	2025-07-13 14:07:27.273164	2025-07-24 07:11:46.148974	アイスクリーム			2	sample_ice.jpg	アイス
24	2025-07-24 07:13:02.240738	2025-07-24 07:13:02.240738				2	cake1.jpg	チョコレートタルトケーキ
22	2025-07-12 07:33:16.504695	2025-07-24 07:14:35.086461	めちゃくちゃ濃厚		たべる牧場ミルク	2	たべる牧場.jpg	濃厚ミルクアイス
25	2025-07-24 07:16:03.462559	2025-07-24 07:16:03.462559			スーパーカップ（スイートポテト味）	2	アイス.jpg	スイートポテト味は間違いない
18	2025-07-09 11:05:00.661319	2025-07-25 10:11:38.052914			ポテトサラダ	1	ポテサラ.jpg	家庭の味
17	2025-07-09 03:30:13.472209	2025-07-25 10:12:16.299167				1	なす.jpeg	仮タイトル7
15	2025-07-08 13:25:17.978038	2025-07-25 10:13:21.058951			バナナジュース	1	バナナジュース.jpeg	ば　な　な
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.schema_migrations (version) FROM stdin;
20250701091100
20250704085904
20250705103234
20250705121154
20250706084410
20250709062449
20250709062555
20250712043552
20250712085821
20250712133157
20250716013445
20250716013724
20250720080906
20250720081443
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.taggings (id, post_id, tag_id, created_at, updated_at) FROM stdin;
1	18	1	2025-07-09 11:05:03.19137	2025-07-09 11:05:03.19137
3	18	3	2025-07-09 11:06:09.697405	2025-07-09 11:06:09.697405
7	15	5	2025-07-10 04:25:38.729142	2025-07-10 04:25:38.729142
8	15	6	2025-07-10 04:25:38.755781	2025-07-10 04:25:38.755781
9	15	7	2025-07-10 04:25:38.768823	2025-07-10 04:25:38.768823
10	22	4	2025-07-12 07:33:18.988032	2025-07-12 07:33:18.988032
11	23	4	2025-07-13 14:07:29.729121	2025-07-13 14:07:29.729121
13	23	9	2025-07-19 04:31:39.543439	2025-07-19 04:31:39.543439
17	24	13	2025-07-24 07:13:08.101246	2025-07-24 07:13:08.101246
18	24	14	2025-07-24 07:13:08.134838	2025-07-24 07:13:08.134838
19	23	15	2025-07-25 08:46:14.908049	2025-07-25 08:46:14.908049
20	26	16	2025-07-29 09:17:26.924365	2025-07-29 09:17:26.924365
21	26	15	2025-07-29 09:17:26.929868	2025-07-29 09:17:26.929868
22	26	17	2025-07-29 09:17:26.940261	2025-07-29 09:17:26.940261
23	26	18	2025-07-29 09:17:26.95071	2025-07-29 09:17:26.95071
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.tags (id, name, created_at, updated_at) FROM stdin;
1	じゃがいも	2025-07-09 11:05:03.17602	2025-07-09 11:05:03.17602
2	ポテサラ	2025-07-09 11:05:03.202684	2025-07-09 11:05:03.202684
3	和食	2025-07-09 11:06:09.689195	2025-07-09 11:06:09.689195
4	アイス	2025-07-09 11:08:37.478666	2025-07-09 11:08:37.478666
5	バナナ	2025-07-10 04:25:38.725339	2025-07-10 04:25:38.725339
6	ジュース	2025-07-10 04:25:38.749248	2025-07-10 04:25:38.749248
7	飲み物	2025-07-10 04:25:38.764273	2025-07-10 04:25:38.764273
8	ミルク	2025-07-19 04:31:39.516762	2025-07-19 04:31:39.516762
9	アイスクリーム	2025-07-19 04:31:39.53994	2025-07-19 04:31:39.53994
10	市販品	2025-07-19 04:31:39.552126	2025-07-19 04:31:39.552126
11	taaaaaaaaag	2025-07-20 09:29:22.715011	2025-07-20 09:29:22.715011
12	tagggg	2025-07-20 09:29:42.600269	2025-07-20 09:29:42.600269
13	ケーキ	2025-07-24 07:13:08.094206	2025-07-24 07:13:08.094206
14	タルト	2025-07-24 07:13:08.110799	2025-07-24 07:13:08.110799
15	市販	2025-07-25 08:46:14.903895	2025-07-25 08:46:14.903895
16	お菓子	2025-07-29 09:17:26.920103	2025-07-29 09:17:26.920103
17	コンビニ	2025-07-29 09:17:26.93681	2025-07-29 09:17:26.93681
18	ポテチ	2025-07-29 09:17:26.947101	2025-07-29 09:17:26.947101
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mini_app_db_user
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, name, created_at, updated_at, introduction, is_public) FROM stdin;
1	sa_ka321@yahoo.co.jp	$2a$12$uyS5YZBBA4FYri86oGIsqeCNIkJnvonu7B.BdN/92PxgqitXk38lu	\N	\N	\N	テスト用（dev）	2025-07-05 06:51:32.964886	2025-07-12 07:27:26.672304	test	t
2	test@2	$2a$12$QxrBSZilqcwMhYD2QPRuJuhXnIikcjxVhx4vHB3GrepFmIXntg4xK	\N	\N	\N	テスト（他人用）	2025-07-12 07:30:26.329473	2025-07-12 11:04:19.828201		t
3	test@example.com	$2a$12$tM4jyG9QcfRkLNRxJTN8bO4W7hCWJddNn10Uq3YQAY8Rg0Mi3bfOu	\N	\N	\N	テスト	2025-07-25 12:44:46.486936	2025-07-25 12:44:46.486936	\N	t
\.


--
-- Name: follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mini_app_db_user
--

SELECT pg_catalog.setval('public.follows_id_seq', 5, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mini_app_db_user
--

SELECT pg_catalog.setval('public.posts_id_seq', 26, true);


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mini_app_db_user
--

SELECT pg_catalog.setval('public.taggings_id_seq', 23, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mini_app_db_user
--

SELECT pg_catalog.setval('public.tags_id_seq', 18, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mini_app_db_user
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_follows_on_follower_id_and_followed_id; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE UNIQUE INDEX index_follows_on_follower_id_and_followed_id ON public.follows USING btree (follower_id, followed_id);


--
-- Name: index_posts_on_user_id; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE INDEX index_posts_on_user_id ON public.posts USING btree (user_id);


--
-- Name: index_taggings_on_post_id; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE INDEX index_taggings_on_post_id ON public.taggings USING btree (post_id);


--
-- Name: index_taggings_on_post_id_and_tag_id; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE UNIQUE INDEX index_taggings_on_post_id_and_tag_id ON public.taggings USING btree (post_id, tag_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE INDEX index_taggings_on_tag_id ON public.taggings USING btree (tag_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: mini_app_db_user
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: taggings fk_rails_2c662e858e; Type: FK CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT fk_rails_2c662e858e FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: posts fk_rails_5b5ddfd518; Type: FK CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_rails_5b5ddfd518 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: taggings fk_rails_9fcd2e236b; Type: FK CONSTRAINT; Schema: public; Owner: mini_app_db_user
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT fk_rails_9fcd2e236b FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- PostgreSQL database dump complete
--

