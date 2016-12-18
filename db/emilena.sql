--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE address (
    id bigint NOT NULL,
    first_line character varying(255),
    post_code character varying(255),
    second_line character varying(255),
    town character varying(255),
    location_id bigint
);


--
-- Name: availability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE availability (
    id bigint NOT NULL,
    day_of_week character varying(255),
    from_time bytea NOT NULL,
    to_time bytea NOT NULL,
    person_id bigint
);


--
-- Name: clients_staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clients_staff (
    client_id bigint NOT NULL,
    staff_id bigint NOT NULL
);


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invoice (
    id bigint NOT NULL,
    amount numeric(19,2),
    created bytea,
    duration bigint,
    issued bytea,
    rota_item_id bigint
);


--
-- Name: location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE location (
    id bigint NOT NULL,
    latitude double precision,
    longitude double precision
);


--
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person (
    discriminator character varying(31) NOT NULL,
    id bigint NOT NULL,
    active boolean,
    date_of_birth timestamp without time zone,
    email character varying(255),
    forename character varying(255) NOT NULL,
    persontype character varying(255) NOT NULL,
    preferences character varying(1000),
    surname character varying(255) NOT NULL,
    telephone_number character varying(255),
    contracttype character varying(255),
    contracted_hours integer,
    stafftype character varying(255),
    person_id bigint,
    system_user_id bigint
);


--
-- Name: rota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rota (
    id bigint NOT NULL,
    week_commencing bytea
);


--
-- Name: rota_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rota_entry (
    rota_id bigint NOT NULL,
    rota_item_id bigint NOT NULL
);


--
-- Name: rota_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rota_item (
    id bigint NOT NULL,
    dayofweek character varying(255),
    finish_time bytea,
    start_time bytea,
    support_date bytea,
    client_id bigint,
    staff_id bigint
);


--
-- Name: system_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE system_user (
    id bigint NOT NULL,
    password character varying(255) NOT NULL,
    user_name character varying(255) NOT NULL,
    staff_id bigint
);


--
-- Name: tbl_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tbl_roles (
    id bigint NOT NULL,
    roles character varying(255) NOT NULL
);


--
-- Name: traffic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE traffic (
    id bigint NOT NULL,
    traffic_date character varying(255),
    ip_address character varying(255)
);


--
-- Name: address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: availability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY availability
    ADD CONSTRAINT availability_pkey PRIMARY KEY (id);


--
-- Name: invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: rota_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_item
    ADD CONSTRAINT rota_item_pkey PRIMARY KEY (id);


--
-- Name: rota_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota
    ADD CONSTRAINT rota_pkey PRIMARY KEY (id);


--
-- Name: system_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- Name: traffic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY traffic
    ADD CONSTRAINT traffic_pkey PRIMARY KEY (id);


--
-- Name: uk_204b9ercidw1baj3s3m9lnr33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT uk_204b9ercidw1baj3s3m9lnr33 UNIQUE (user_name);


--
-- Name: uk_bps1r273bqncc8kcngk2tcw53; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_entry
    ADD CONSTRAINT uk_bps1r273bqncc8kcngk2tcw53 UNIQUE (rota_item_id);


--
-- Name: uk_fwmwi44u55bo4rvwsv0cln012; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT uk_fwmwi44u55bo4rvwsv0cln012 UNIQUE (email);


--
-- Name: ukk25bnafs1ur14e4x4ymhy6mcn; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT ukk25bnafs1ur14e4x4ymhy6mcn UNIQUE (surname, telephone_number);


--
-- Name: fk20mxnfaegj3n7ys354us46ttg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_item
    ADD CONSTRAINT fk20mxnfaegj3n7ys354us46ttg FOREIGN KEY (client_id) REFERENCES person(id);


--
-- Name: fk3sbwy3lw9ts4hybjslnp1ikri; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY address
    ADD CONSTRAINT fk3sbwy3lw9ts4hybjslnp1ikri FOREIGN KEY (location_id) REFERENCES location(id);


--
-- Name: fk7ofulalwncq5igwbfgn15i1j8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_entry
    ADD CONSTRAINT fk7ofulalwncq5igwbfgn15i1j8 FOREIGN KEY (rota_id) REFERENCES rota(id);


--
-- Name: fk8xuimodai9wqc2jrviehti7gb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY availability
    ADD CONSTRAINT fk8xuimodai9wqc2jrviehti7gb FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: fkadsq4jno4v8kojdyplrs1oxk3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_entry
    ADD CONSTRAINT fkadsq4jno4v8kojdyplrs1oxk3 FOREIGN KEY (rota_item_id) REFERENCES rota_item(id);


--
-- Name: fkdhbdgr1njoyjkbldid435riky; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients_staff
    ADD CONSTRAINT fkdhbdgr1njoyjkbldid435riky FOREIGN KEY (staff_id) REFERENCES person(id);


--
-- Name: fkjydd0slyj9roud6nobmfvxjn4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rota_item
    ADD CONSTRAINT fkjydd0slyj9roud6nobmfvxjn4 FOREIGN KEY (staff_id) REFERENCES person(id);


--
-- Name: fkl2f58fmjq95tny1bjm2cp8wsq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fkl2f58fmjq95tny1bjm2cp8wsq FOREIGN KEY (system_user_id) REFERENCES system_user(id);


--
-- Name: fknltyq4hfdyltdte14tpw2m2a0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fknltyq4hfdyltdte14tpw2m2a0 FOREIGN KEY (person_id) REFERENCES address(id);


--
-- Name: fkovxik7m0rxsf4ip8ym0pifd8t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fkovxik7m0rxsf4ip8ym0pifd8t FOREIGN KEY (rota_item_id) REFERENCES rota_item(id);


--
-- Name: fkq45qsdxvocopwsx1h7qbuwrnm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tbl_roles
    ADD CONSTRAINT fkq45qsdxvocopwsx1h7qbuwrnm FOREIGN KEY (id) REFERENCES system_user(id);


--
-- Name: fkqvgj46ri8ja8xlfn3x28phy3i; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients_staff
    ADD CONSTRAINT fkqvgj46ri8ja8xlfn3x28phy3i FOREIGN KEY (client_id) REFERENCES person(id);


--
-- Name: fkxxsxrm60pwt1xexvao9bf1r1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT fkxxsxrm60pwt1xexvao9bf1r1 FOREIGN KEY (staff_id) REFERENCES person(id);

INSERT INTO system_user (id, password, user_name) VALUES (1, 'superuser', 'superuser');
INSERT INTO tbl_roles (id, roles) VALUES (1, 'STAFF');
INSERT INTO tbl_roles (id, roles) VALUES (1, 'ADMIN');
