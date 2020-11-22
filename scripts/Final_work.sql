/* Final work of the course Netlogy-DWH
 * author: Elena Davydova
 * date: 15.11.2020 */

create schema dds;
create schema errors;


create table dds.Dim_Aircrafts
(
	aircraft_key serial,
	aircraft_code varchar(20),
	model varchar(200),
	"range" integer,
	start_dt date,
	end_dt date,
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"version" int4 NULL DEFAULT 1
);

create table errors.Aircrafts
(
	aircraft_code varchar(20),
	model varchar(200),
	"range" integer,
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	errorField varchar(100),
	errorCode varchar(10),
	errorDescr varchar(1000)
);

create table dds.Dim_Airports
(
	airport_key serial,
	airport_code varchar(20),
	airport_name varchar(200),
	city varchar(200),
	longitude float8,
	latitude float8,
	timezone varchar(200),
	start_dt date,
	end_dt date,
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"version" int4 NULL DEFAULT 1
);


create table errors.Airports
(
	airport_code varchar(20),
	airport_name varchar(200),
	city varchar(200),
	coordinates varchar(200),
	timezone varchar(200),
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	errorField varchar(100),
	errorCode varchar(10),
	errorDescr varchar(1000)
);


create table dds.Dim_Tariff
(
	tariff_key serial,
	fare_conditions varchar(200),
	start_dt date NULL,
	end_dt date NULL,
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"version" int4 NULL DEFAULT 1
);


create table errors.tariff
(
	fare_conditions varchar(200),
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	errorField varchar(100),
	errorCode varchar(10),
	errorDescr varchar(1000)
);


create table dds.dim_passengers
(
	passenger_key serial,	
	passenger_id varchar(20),
	passenger_name varchar(200),
	phone varchar(20),
	email varchar(100),
	start_dt date,
	end_dt date,
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"version" int4 NULL DEFAULT 1
);



create table errors.passengers
(	
	passenger_id varchar(20),
	passenger_name varchar(200),
	phone varchar(20),
	email varchar(100),
	insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	errorField varchar(100),
	errorCode varchar(10),
	errorDescr varchar(1000)
);



create table dds.fact_flights
(
flight_key serial,
passenger_key integer,
flight_id integer,
flight_no varchar(20),
departure_actual_dt timestamptz,
arrival_actual_dt timestamptz,
departure_airport_key integer,
arrival_airport_key integer,
departure_delay integer,
arrival_delay integer,
tariff_key integer,
aircraft_key integer,
amount numeric(10,2),
insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);


create table errors.fact_flights
(
passenger_key integer,
flight_id integer,
flight_no varchar(20),
departure_actual_dt timestamptz,
arrival_actual_dt timestamptz,
departure_airport_key integer,
arrival_airport_key integer,
departure_delay integer,
arrival_delay integer,
tariff_key integer,
aircraft_key integer,
amount numeric(10,2),
insert_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
errorField varchar(100),
errorCode varchar(10),
errorDescr varchar(1000)
);



create table dds.dim_calendar
as
select date::date,
       extract('isodow' from date) as dow,
       to_char(date, 'dy') as day,
       extract('isoyear' from date) as "iso year",
       extract('week' from date) as week,
       extract('day' from
               (date + interval '2 month - 1 day')
              )
        as feb,
       extract('year' from date) as year,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap,
       current_timestamp as insert_ts
  from generate_series(date '2010-01-01',
                       date '2022-01-01',
                       interval '1 day')
       as t(date);

alter table dds.dim_calendar add  CONSTRAINT pkey_dim_calendar PRIMARY KEY (date);







