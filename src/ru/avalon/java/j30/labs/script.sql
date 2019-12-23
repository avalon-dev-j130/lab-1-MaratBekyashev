--create schema marat;-- identified by qwerty
/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

create table orders(
  id       integer,
  "user"   integer,
  created  timestamp,-- default systimestamp,
  constraint order_pk primary key(id)
);

insert into orders(id, "user", created) values (1, 1, '2019-12-23 12:12:12');
insert into orders(id, "user", created) values (2, 1, '2019-12-23 15:34:34.003434');
--insert into "order"(id, "user") values (3, 2);


create table users(
  id       integer generated always as identity,
  email    varchar(255),
  password varchar(255),
  info     integer,
  role     integer,
  constraint email_pk primary key(email),
  constraint users_info_uk unique (info),
  constraint users_id_uk unique (id)
);

insert into users(email, info, role) values ('user1@mail.com',  1, 1);
--insert into users(id, email, info, role) values (1, "user2@mail.com", 2, 1);
--insert into users(id, email, info, role) values (1, "admin@mail.com", 3, 2);

create table userinfo(
  id       integer,
  name     varchar(255) not null,
  surname  varchar(255) not null,
  constraint userinfo_pk primary key (id)
);

insert into userinfo(id, name, surname) values (1, 'Вася', 'Пупкин');
insert into userinfo(id, name, surname) values (2, 'Иван', 'ургант');

create table roles(
  id    integer generated always as identity,
  name  varchar(255),
  constraint roles_pk primary key(name),
  constraint info_id_uk unique (id)
);

insert into roles (name) values ('User');
insert into roles (name) values ('Admin');

create table product(
  id            integer generated always as identity,
  code          varchar(255),
  title         varchar(255),
  supplier      integer,
  initial_price double,
  retail_Value  double,
  constraint product_pk primary key(code),
  constraint product_uk unique (id)
);

insert into product ( code, title, supplier, initial_price) values ('product 1', 'title 1', 1, 100);
insert into product ( code, title, supplier, initial_price) values ('product 2', 'title 2', 1, 200);

create table supplier (
  id             integer generated always as identity,
  name           varchar(255),
  address        varchar(255) not null,
  phone          varchar(255),
  representative varchar(255) not null,
  constraint supplier_pk primary key (name),
  constraint supplier_uk unique (id)
);

insert into supplier( name, address, phone, representative) values ('Supplier1', 'Address 1', '1234567', '????');

create table order2product(
  "order" integer not null,
  product integer not null
);

insert into order2product ("order", product) values (1, 1);



alter table orders add constraint order_info_fk foreign key("user") references users(id);
alter table users add constraint user_info_fk foreign key(info) references userinfo(id);
alter table users add constraint user_role_fk foreign key(role) references roles(id);

alter table order2product add constraint o2p_order_fk foreign key("order") references orders(id);
alter table order2product add constraint o2p_product_fk foreign key(product) references product(id);

alter table product add constraint prod_supplier_fk foreign key(supplier) references supplier(id);
