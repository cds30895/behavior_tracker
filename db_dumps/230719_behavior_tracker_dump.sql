--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_seq OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: antecedents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antecedents (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.antecedents OWNER TO postgres;

--
-- Name: antecedents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antecedents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antecedents_id_seq OWNER TO postgres;

--
-- Name: antecedents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antecedents_id_seq OWNED BY public.antecedents.id;


--
-- Name: behavior_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behavior_desc (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.behavior_desc OWNER TO postgres;

--
-- Name: behavior_desc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.behavior_desc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.behavior_desc_id_seq OWNER TO postgres;

--
-- Name: behavior_desc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.behavior_desc_id_seq OWNED BY public.behavior_desc.id;


--
-- Name: behaviors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors (
    id integer NOT NULL,
    student integer NOT NULL,
    antecedent_other text,
    behavior_other text,
    consequence_other text,
    date_of_behavior date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL
);


ALTER TABLE public.behaviors OWNER TO postgres;

--
-- Name: behaviors_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_activities (
    behavior_id integer NOT NULL,
    activity_id integer NOT NULL
);


ALTER TABLE public.behaviors_activities OWNER TO postgres;

--
-- Name: behaviors_antecedents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_antecedents (
    behavior_id integer NOT NULL,
    antecedent_id integer NOT NULL
);


ALTER TABLE public.behaviors_antecedents OWNER TO postgres;

--
-- Name: behaviors_behavior_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_behavior_desc (
    behavior_id integer NOT NULL,
    behavior_desc_id integer NOT NULL
);


ALTER TABLE public.behaviors_behavior_desc OWNER TO postgres;

--
-- Name: behaviors_consequences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_consequences (
    behavior_id integer NOT NULL,
    consequence_id integer NOT NULL
);


ALTER TABLE public.behaviors_consequences OWNER TO postgres;

--
-- Name: behaviors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.behaviors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.behaviors_id_seq OWNER TO postgres;

--
-- Name: behaviors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.behaviors_id_seq OWNED BY public.behaviors.id;


--
-- Name: behaviors_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_settings (
    behavior_id integer NOT NULL,
    setting_id integer NOT NULL
);


ALTER TABLE public.behaviors_settings OWNER TO postgres;

--
-- Name: behaviors_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.behaviors_subjects (
    behavior_id integer NOT NULL,
    subject_id integer NOT NULL
);


ALTER TABLE public.behaviors_subjects OWNER TO postgres;

--
-- Name: consequences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consequences (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.consequences OWNER TO postgres;

--
-- Name: consequences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consequences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consequences_id_seq OWNER TO postgres;

--
-- Name: consequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consequences_id_seq OWNED BY public.consequences.id;


--
-- Name: observing_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.observing_staff (
    behavior_id integer NOT NULL,
    staff_present integer NOT NULL
);


ALTER TABLE public.observing_staff OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    student_id integer,
    first_name text NOT NULL,
    last_name text NOT NULL,
    grade character varying(2) NOT NULL,
    case_manager integer NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_id_seq OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: antecedents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedents ALTER COLUMN id SET DEFAULT nextval('public.antecedents_id_seq'::regclass);


--
-- Name: behavior_desc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behavior_desc ALTER COLUMN id SET DEFAULT nextval('public.behavior_desc_id_seq'::regclass);


--
-- Name: behaviors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors ALTER COLUMN id SET DEFAULT nextval('public.behaviors_id_seq'::regclass);


--
-- Name: consequences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consequences ALTER COLUMN id SET DEFAULT nextval('public.consequences_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id, description) FROM stdin;
1	Whole group instruction
2	Practice task
3	Cooperative task
4	Unstructured task
5	Transition
6	Group Time
7	Work out of class
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
c1abd6b9b6f4
\.


--
-- Data for Name: antecedents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antecedents (id, description) FROM stdin;
1	Work expectations
2	Undesired task/plan
3	Peer conflict
4	Redirection
5	Percieved Unfairness
6	Missed directions
7	Change in routine or adults
8	Not ready for transition
9	Competition
10	Mistake
11	Other
\.


--
-- Data for Name: behavior_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behavior_desc (id, description) FROM stdin;
1	Elopement
2	Aggression - adult
3	Aggression - peer
4	Aggression - items, minor
5	Aggression - items, major
6	Misuse of objects
7	Negative talk - self
8	Negative talk - others
9	Yelling, screaming
10	Refusal, ignoring
11	Threatening
12	Inappropriate use of tech
13	Other
\.


--
-- Data for Name: behaviors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors (id, student, antecedent_other, behavior_other, consequence_other, date_of_behavior, start_time, end_time) FROM stdin;
1	1	\N	\N	\N	2023-09-14	09:00:00	14:00:00
2	2	\N	\N	\N	2023-09-13	10:28:00	10:30:00
43	1	\N	Planting trees	\N	2023-09-15	09:00:00	14:00:00
\.


--
-- Data for Name: behaviors_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_activities (behavior_id, activity_id) FROM stdin;
1	5
2	4
43	5
\.


--
-- Data for Name: behaviors_antecedents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_antecedents (behavior_id, antecedent_id) FROM stdin;
1	2
2	3
2	5
43	1
43	2
43	8
\.


--
-- Data for Name: behaviors_behavior_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_behavior_desc (behavior_id, behavior_desc_id) FROM stdin;
1	1
1	10
2	3
2	9
43	1
43	4
43	10
\.


--
-- Data for Name: behaviors_consequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_consequences (behavior_id, consequence_id) FROM stdin;
1	6
1	9
1	12
1	13
2	2
2	16
2	19
43	9
43	11
43	14
43	17
\.


--
-- Data for Name: behaviors_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_settings (behavior_id, setting_id) FROM stdin;
1	4
1	7
1	8
1	9
2	7
43	4
43	8
43	9
\.


--
-- Data for Name: behaviors_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.behaviors_subjects (behavior_id, subject_id) FROM stdin;
2	10
\.


--
-- Data for Name: consequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consequences (id, description) FROM stdin;
1	Offer Break
2	Supported calming strategies
3	Task support
4	Task alteration
5	Visual/gestural prompts
6	Questioning/Clarifying thinking
7	Validation ("I hear you")
8	Processing time/space
9	Proximity
10	Modeling task
11	Only restate expectations
12	Clarify expectation
13	"Positive Helper"
14	Staff switch
15	Limited reaction
16	Problem solving
17	Reminder of reinforcement
18	Offer what was desired
19	Snack
20	Isolation/Restraint (CONTACT ADMIN)
21	Other
\.


--
-- Data for Name: observing_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.observing_staff (behavior_id, staff_present) FROM stdin;
1	1
2	4
2	3
43	1
43	2
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, description) FROM stdin;
1	GenEd Classroom
2	SpEd Classroom
3	Specialist
4	Hallway
5	Gym
6	Lunchroom
7	Playground
8	Outside - School Grounds
9	Outside - Off Campus
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, first_name, last_name, email) FROM stdin;
1	Chris	Smith	csmith@school.edu
2	William	Taft	wtaft@school.edu
3	John	Madison	jmadison@school.edu
4	Diana	Prince	dprince@themyscira.az
5	Professor	Xavier	wouldntyouliketoknow@x-men_academy.edu
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, student_id, first_name, last_name, grade, case_manager) FROM stdin;
1	12345	Johnny	Appleseed	2	2
2	34012	Steve	Rogers	5	3
3	68392	Anung	Un Rama	K	4
4	10506	Tony	Stark	10	4
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, description) FROM stdin;
1	Reading
2	Math
3	Writing
4	Science
5	Social Studies
6	Art
7	Music
8	PE
9	Library
10	Recess
11	Lunch
12	Group
13	Other
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_seq', 7, true);


--
-- Name: antecedents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antecedents_id_seq', 11, true);


--
-- Name: behavior_desc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.behavior_desc_id_seq', 13, true);


--
-- Name: behaviors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.behaviors_id_seq', 43, true);


--
-- Name: consequences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consequences_id_seq', 21, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 9, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 5, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 4, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 13, true);


--
-- Name: activities activities_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_description_key UNIQUE (description);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: antecedents antecedents_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedents
    ADD CONSTRAINT antecedents_description_key UNIQUE (description);


--
-- Name: antecedents antecedents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedents
    ADD CONSTRAINT antecedents_pkey PRIMARY KEY (id);


--
-- Name: behavior_desc behavior_desc_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behavior_desc
    ADD CONSTRAINT behavior_desc_description_key UNIQUE (description);


--
-- Name: behavior_desc behavior_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behavior_desc
    ADD CONSTRAINT behavior_desc_pkey PRIMARY KEY (id);


--
-- Name: behaviors_activities behaviors_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_activities
    ADD CONSTRAINT behaviors_activities_pkey PRIMARY KEY (behavior_id, activity_id);


--
-- Name: behaviors_antecedents behaviors_antecedents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_antecedents
    ADD CONSTRAINT behaviors_antecedents_pkey PRIMARY KEY (behavior_id, antecedent_id);


--
-- Name: behaviors_behavior_desc behaviors_behavior_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_behavior_desc
    ADD CONSTRAINT behaviors_behavior_desc_pkey PRIMARY KEY (behavior_id, behavior_desc_id);


--
-- Name: behaviors_consequences behaviors_consequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_consequences
    ADD CONSTRAINT behaviors_consequences_pkey PRIMARY KEY (behavior_id, consequence_id);


--
-- Name: behaviors behaviors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors
    ADD CONSTRAINT behaviors_pkey PRIMARY KEY (id);


--
-- Name: behaviors_settings behaviors_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_settings
    ADD CONSTRAINT behaviors_settings_pkey PRIMARY KEY (behavior_id, setting_id);


--
-- Name: behaviors_subjects behaviors_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_subjects
    ADD CONSTRAINT behaviors_subjects_pkey PRIMARY KEY (behavior_id, subject_id);


--
-- Name: consequences consequences_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consequences
    ADD CONSTRAINT consequences_description_key UNIQUE (description);


--
-- Name: consequences consequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consequences
    ADD CONSTRAINT consequences_pkey PRIMARY KEY (id);


--
-- Name: observing_staff observing_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observing_staff
    ADD CONSTRAINT observing_staff_pkey PRIMARY KEY (behavior_id, staff_present);


--
-- Name: settings settings_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_description_key UNIQUE (description);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: staff staff_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students students_student_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_student_id_key UNIQUE (student_id);


--
-- Name: subjects subjects_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_description_key UNIQUE (description);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: ix_behaviors_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_behaviors_student ON public.behaviors USING btree (student);


--
-- Name: behaviors_activities behaviors_activities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_activities
    ADD CONSTRAINT behaviors_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id);


--
-- Name: behaviors_activities behaviors_activities_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_activities
    ADD CONSTRAINT behaviors_activities_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_antecedents behaviors_antecedents_antecedent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_antecedents
    ADD CONSTRAINT behaviors_antecedents_antecedent_id_fkey FOREIGN KEY (antecedent_id) REFERENCES public.antecedents(id);


--
-- Name: behaviors_antecedents behaviors_antecedents_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_antecedents
    ADD CONSTRAINT behaviors_antecedents_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_behavior_desc behaviors_behavior_desc_behavior_desc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_behavior_desc
    ADD CONSTRAINT behaviors_behavior_desc_behavior_desc_id_fkey FOREIGN KEY (behavior_desc_id) REFERENCES public.behavior_desc(id);


--
-- Name: behaviors_behavior_desc behaviors_behavior_desc_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_behavior_desc
    ADD CONSTRAINT behaviors_behavior_desc_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_consequences behaviors_consequences_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_consequences
    ADD CONSTRAINT behaviors_consequences_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_consequences behaviors_consequences_consequence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_consequences
    ADD CONSTRAINT behaviors_consequences_consequence_id_fkey FOREIGN KEY (consequence_id) REFERENCES public.consequences(id);


--
-- Name: behaviors_settings behaviors_settings_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_settings
    ADD CONSTRAINT behaviors_settings_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_settings behaviors_settings_setting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_settings
    ADD CONSTRAINT behaviors_settings_setting_id_fkey FOREIGN KEY (setting_id) REFERENCES public.settings(id);


--
-- Name: behaviors behaviors_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors
    ADD CONSTRAINT behaviors_student_fkey FOREIGN KEY (student) REFERENCES public.students(id) ON DELETE SET NULL;


--
-- Name: behaviors_subjects behaviors_subjects_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_subjects
    ADD CONSTRAINT behaviors_subjects_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: behaviors_subjects behaviors_subjects_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.behaviors_subjects
    ADD CONSTRAINT behaviors_subjects_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- Name: observing_staff observing_staff_behavior_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observing_staff
    ADD CONSTRAINT observing_staff_behavior_id_fkey FOREIGN KEY (behavior_id) REFERENCES public.behaviors(id) ON DELETE CASCADE;


--
-- Name: observing_staff observing_staff_staff_present_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observing_staff
    ADD CONSTRAINT observing_staff_staff_present_fkey FOREIGN KEY (staff_present) REFERENCES public.staff(id);


--
-- Name: students students_case_manager_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_case_manager_fkey FOREIGN KEY (case_manager) REFERENCES public.staff(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

