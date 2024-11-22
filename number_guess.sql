--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 9);
INSERT INTO public.games VALUES (2, 1, 10);
INSERT INTO public.games VALUES (3, 1, 5);
INSERT INTO public.games VALUES (4, 2, 253);
INSERT INTO public.games VALUES (5, 2, 256);
INSERT INTO public.games VALUES (6, 3, 702);
INSERT INTO public.games VALUES (7, 3, 1000);
INSERT INTO public.games VALUES (8, 2, 91);
INSERT INTO public.games VALUES (9, 2, 159);
INSERT INTO public.games VALUES (10, 2, 342);
INSERT INTO public.games VALUES (11, 4, 10);
INSERT INTO public.games VALUES (12, 5, 277);
INSERT INTO public.games VALUES (13, 5, 172);
INSERT INTO public.games VALUES (14, 6, 161);
INSERT INTO public.games VALUES (15, 6, 348);
INSERT INTO public.games VALUES (16, 5, 341);
INSERT INTO public.games VALUES (17, 5, 508);
INSERT INTO public.games VALUES (18, 5, 255);
INSERT INTO public.games VALUES (19, 1, 9);
INSERT INTO public.games VALUES (20, 7, 10);
INSERT INTO public.games VALUES (21, 8, 469);
INSERT INTO public.games VALUES (22, 8, 132);
INSERT INTO public.games VALUES (23, 9, 144);
INSERT INTO public.games VALUES (24, 9, 121);
INSERT INTO public.games VALUES (25, 8, 635);
INSERT INTO public.games VALUES (26, 8, 149);
INSERT INTO public.games VALUES (27, 8, 845);
INSERT INTO public.games VALUES (28, 10, 139);
INSERT INTO public.games VALUES (29, 10, 82);
INSERT INTO public.games VALUES (30, 11, 801);
INSERT INTO public.games VALUES (31, 11, 516);
INSERT INTO public.games VALUES (32, 10, 505);
INSERT INTO public.games VALUES (33, 10, 754);
INSERT INTO public.games VALUES (34, 10, 150);
INSERT INTO public.games VALUES (35, 12, 367);
INSERT INTO public.games VALUES (36, 12, 11);
INSERT INTO public.games VALUES (37, 13, 533);
INSERT INTO public.games VALUES (38, 13, 874);
INSERT INTO public.games VALUES (39, 12, 991);
INSERT INTO public.games VALUES (40, 12, 573);
INSERT INTO public.games VALUES (41, 12, 60);
INSERT INTO public.games VALUES (42, 1, 12);
INSERT INTO public.games VALUES (43, 14, 326);
INSERT INTO public.games VALUES (44, 14, 661);
INSERT INTO public.games VALUES (45, 15, 434);
INSERT INTO public.games VALUES (46, 15, 104);
INSERT INTO public.games VALUES (47, 14, 459);
INSERT INTO public.games VALUES (48, 14, 444);
INSERT INTO public.games VALUES (49, 14, 843);
INSERT INTO public.games VALUES (50, 16, 514);
INSERT INTO public.games VALUES (51, 16, 262);
INSERT INTO public.games VALUES (52, 17, 909);
INSERT INTO public.games VALUES (53, 17, 75);
INSERT INTO public.games VALUES (54, 16, 264);
INSERT INTO public.games VALUES (55, 16, 897);
INSERT INTO public.games VALUES (56, 16, 96);
INSERT INTO public.games VALUES (57, 18, 86);
INSERT INTO public.games VALUES (58, 18, 92);
INSERT INTO public.games VALUES (59, 19, 529);
INSERT INTO public.games VALUES (60, 19, 339);
INSERT INTO public.games VALUES (61, 18, 925);
INSERT INTO public.games VALUES (62, 18, 721);
INSERT INTO public.games VALUES (63, 18, 173);
INSERT INTO public.games VALUES (64, 20, 145);
INSERT INTO public.games VALUES (65, 20, 164);
INSERT INTO public.games VALUES (66, 21, 855);
INSERT INTO public.games VALUES (67, 21, 628);
INSERT INTO public.games VALUES (68, 20, 99);
INSERT INTO public.games VALUES (69, 20, 486);
INSERT INTO public.games VALUES (70, 20, 564);
INSERT INTO public.games VALUES (71, 22, 76);
INSERT INTO public.games VALUES (72, 22, 416);
INSERT INTO public.games VALUES (73, 23, 473);
INSERT INTO public.games VALUES (74, 23, 620);
INSERT INTO public.games VALUES (75, 22, 784);
INSERT INTO public.games VALUES (76, 22, 162);
INSERT INTO public.games VALUES (77, 22, 267);
INSERT INTO public.games VALUES (78, 4, 14);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (21, 'user_1732288354580', 3, 628);
INSERT INTO public.users VALUES (20, 'user_1732288354581', 6, 99);
INSERT INTO public.users VALUES (23, 'user_1732288576779', 3, 473);
INSERT INTO public.users VALUES (22, 'user_1732288576780', 6, 76);
INSERT INTO public.users VALUES (4, 'd', 3, 10);
INSERT INTO public.users VALUES (24, 'user_1732288704103', 1, NULL);
INSERT INTO public.users VALUES (25, 'user_1732288704102', 1, NULL);
INSERT INTO public.users VALUES (26, 'user_1732288773244', 1, NULL);
INSERT INTO public.users VALUES (27, 'user_1732288773243', 1, NULL);
INSERT INTO public.users VALUES (28, 'user_1732288834409', 1, NULL);
INSERT INTO public.users VALUES (29, 'user_1732288834408', 1, NULL);
INSERT INTO public.users VALUES (30, '2222222222222222222222', 1, NULL);
INSERT INTO public.users VALUES (31, 'a', 1, NULL);
INSERT INTO public.users VALUES (32, 'user_1732290273751', 1, NULL);
INSERT INTO public.users VALUES (33, 'user_1732290273750', 1, NULL);
INSERT INTO public.users VALUES (34, 'user_1732290334965', 1, NULL);
INSERT INTO public.users VALUES (35, 'user_1732290334964', 1, NULL);
INSERT INTO public.users VALUES (36, 'user_1732290395321', 1, NULL);
INSERT INTO public.users VALUES (37, 'user_1732290395320', 1, NULL);
INSERT INTO public.users VALUES (38, 'user_1732290527367', 1, NULL);
INSERT INTO public.users VALUES (39, 'user_1732290527366', 1, NULL);
INSERT INTO public.users VALUES (13, 'user_1732287663808', 3, 533);
INSERT INTO public.users VALUES (3, 'user_1732287273185', 3, 702);
INSERT INTO public.users VALUES (12, 'user_1732287663809', 6, 11);
INSERT INTO public.users VALUES (2, 'user_1732287273186', 6, 91);
INSERT INTO public.users VALUES (1, 's', 5, 5);
INSERT INTO public.users VALUES (6, 'user_1732287377264', 3, 161);
INSERT INTO public.users VALUES (15, 'user_1732287810281', 3, 104);
INSERT INTO public.users VALUES (5, 'user_1732287377265', 6, 172);
INSERT INTO public.users VALUES (7, 'k', 2, 10);
INSERT INTO public.users VALUES (14, 'user_1732287810282', 6, 326);
INSERT INTO public.users VALUES (9, 'user_1732287625428', 3, 121);
INSERT INTO public.users VALUES (8, 'user_1732287625429', 6, 132);
INSERT INTO public.users VALUES (17, 'user_1732287968178', 3, 75);
INSERT INTO public.users VALUES (11, 'user_1732287637004', 3, 516);
INSERT INTO public.users VALUES (16, 'user_1732287968179', 6, 96);
INSERT INTO public.users VALUES (10, 'user_1732287637005', 6, 82);
INSERT INTO public.users VALUES (19, 'user_1732288071347', 3, 339);
INSERT INTO public.users VALUES (18, 'user_1732288071348', 6, 86);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 78, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 39, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

