/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

create table order(
  id      integer(10),
  user    integer(10),
  created timestamp default systimestamp,
  constraint order_pk primary key(id)
);

insert into order(id, user) values (1, 1);
insert into order(id, user) values (2, 1);
insert into order(id, user) values (3, 2);


create table user(
  id       integer(10) generated always as identity,
  email    varchar(255),
  password varchar(255) not null,
  info     integer(10),
  role     integer(10),
  constraint email_pk primary key(email),
  constraint info_uk unique (info)
);
create table userinfo(
  id       integer(10),
  name     varchar(255) not null,
  surname  varchar(255) not null,
  constraint userinfo_pk primary key (id)
);

create table roles(
  id    integer(10) generated always as identity,
  name  varchar(255),
  constraint roles_pk primary key(name),
  constraint info_uk unique (id)
);

create table product(
  id            integer(10) generated always as identity,
  code          varchar(255),
  title         varchar(255), --not null
  supplier      integer(10),
  initial_price double(10),
  retail_Value  double(10),
  constraint product_pk primary key(code),
  constraint product_uk unique (id)

);

create table supplier (
  id             integer(10) generated always as identity,
  name           varchar(255),
  address        varchar(255) not null,
  phone          varchar(255),
  representative varchar(255) not null,
  constraint supplier_pk primary key (name),
  constraint supplier_uk unique (id)

);

create table order2product(
  order integer(10) not null,
  product integer(10) not null
);


alter table order add constraint order_info_fk foreign key(user) references user(id);
alter table user add constraint user_info_fk foreign key(info) references userinfo(id);
alter table user add constraint user_role_fk foreign key(role) references roles(id);

alter table order2product add constraint o2p_order_fk foreign key(order) references order(id);
alter table order2product add constraint o2p_product_fk foreign key(product) references product(id);

alter table product add constraint prod_supplier_fk foreign key(supplier) references supplier(id);
