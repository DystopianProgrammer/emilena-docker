alter table absence drop constraint FKmjma8bj8usk36lgdyliycmy87;

alter table availability drop constraint FK8xuimodai9wqc2jrviehti7gb;

alter table clients_staff drop constraint FKdhbdgr1njoyjkbldid435riky;

alter table clients_staff drop constraint FKqvgj46ri8ja8xlfn3x28phy3i;

alter table invoice drop constraint FKovxik7m0rxsf4ip8ym0pifd8t;

alter table person drop constraint FKl2f58fmjq95tny1bjm2cp8wsq;

alter table rota_entry drop constraint FKadsq4jno4v8kojdyplrs1oxk3;

alter table rota_entry drop constraint FK7ofulalwncq5igwbfgn15i1j8;

alter table rota_item drop constraint FK20mxnfaegj3n7ys354us46ttg;

alter table rota_item drop constraint FKjydd0slyj9roud6nobmfvxjn4;

alter table system_user drop constraint FKxxsxrm60pwt1xexvao9bf1r1;

alter table tbl_roles drop constraint FKq45qsdxvocopwsx1h7qbuwrnm;

drop table if exists absence cascade;

drop table if exists availability cascade;

drop table if exists clients_staff cascade;

drop table if exists invoice cascade;

drop table if exists person cascade;

drop table if exists rota cascade;

drop table if exists rota_entry cascade;

drop table if exists rota_item cascade;

drop table if exists system_user cascade;

drop table if exists tbl_roles cascade;

drop table if exists traffic cascade;

drop sequence hibernate_sequence;
create sequence hibernate_sequence start 1 increment 1;

create table absence (
    id int8 not null,
    absenceType int4,
    date bytea,
    reason varchar(255),
    person_id int8,
    primary key (id)
);

create table availability (
    id int8 not null,
    day_of_week varchar(255),
    from_time bytea not null,
    to_time bytea not null,
    person_id int8,
    primary key (id)
);

create table clients_staff (
    client_id int8 not null,
    staff_id int8 not null
);

create table invoice (
    id int8 not null,
    amount numeric(19, 2),
    created bytea,
    duration int8,
    issued bytea,
    rota_item_id int8,
    primary key (id)
);

create table person (
    discriminator varchar(31) not null,
    id int8 not null,
    active boolean,
    first_line varchar(255),
    house_number varchar(255),
    post_code varchar(255),
    second_line varchar(255),
    town varchar(255),
    date_of_birth timestamp,
    email varchar(255),
    forename varchar(255) not null,
    personType varchar(255) not null,
    preferences varchar(1000),
    surname varchar(255) not null,
    telephone_number varchar(255),
    contractType varchar(255),
    contracted_hours int4,
    staffType varchar(255),
    system_user_id int8,
    primary key (id)
);

create table rota (
    id int8 not null,
    week_commencing bytea,
    primary key (id)
);

create table rota_entry (
    rota_id int8 not null,
    rota_item_id int8 not null
);

create table rota_item (
    id int8 not null,
    dayOfWeek varchar(255),
    finish_time bytea,
    start_time bytea,
    support_date bytea,
    client_id int8,
    staff_id int8,
    primary key (id)
);

create table system_user (
    id int8 not null,
    password varchar(255) not null,
    user_name varchar(255) not null,
    staff_id int8,
    primary key (id)
);

create table tbl_roles (
    id int8 not null,
    roles varchar(255) not null
);

create table traffic (
    id int8 not null,
    ip_address varchar(255),
    primary key (id)
);

alter table rota_entry add constraint UK_bps1r273bqncc8kcngk2tcw53 unique (rota_item_id);

alter table system_user add constraint UK_204b9ercidw1baj3s3m9lnr33 unique (user_name);

alter table absence add constraint FKmjma8bj8usk36lgdyliycmy87 foreign key (person_id) references person;

alter table availability add constraint FK8xuimodai9wqc2jrviehti7gb foreign key (person_id) references person;

alter table clients_staff add constraint FKdhbdgr1njoyjkbldid435riky foreign key (staff_id) references person;

alter table clients_staff add constraint FKqvgj46ri8ja8xlfn3x28phy3i foreign key (client_id) references person;

alter table invoice add constraint FKovxik7m0rxsf4ip8ym0pifd8t foreign key (rota_item_id) references rota_item;

alter table person add constraint FKl2f58fmjq95tny1bjm2cp8wsq foreign key (system_user_id) references system_user;

alter table rota_entry add constraint FKadsq4jno4v8kojdyplrs1oxk3 foreign key (rota_item_id) references rota_item;

alter table rota_entry add constraint FK7ofulalwncq5igwbfgn15i1j8 foreign key (rota_id) references rota;

alter table rota_item add constraint FK20mxnfaegj3n7ys354us46ttg foreign key (client_id) references person;

alter table rota_item add constraint FKjydd0slyj9roud6nobmfvxjn4 foreign key (staff_id) references person;

alter table system_user add constraint FKxxsxrm60pwt1xexvao9bf1r1 foreign key (staff_id) references person;

alter table tbl_roles add constraint FKq45qsdxvocopwsx1h7qbuwrnm foreign key (id) references system_user;

insert into system_user (id, password, user_name) values (1, 'superuser', 'superuser');
insert into tbl_roles (id, roles) values (1, 'STAFF');
insert into tbl_roles (id, roles) values (1, 'ADMIN');