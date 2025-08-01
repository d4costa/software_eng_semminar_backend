/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 16.1 		*/
/*  Created On : 11-ago.-2022 12:17:30 a. m. 				*/
/*  DBMS       : PostgreSQL 						*/
/* ---------------------------------------------------- */

/* Drop Tables */

DROP TABLE IF EXISTS bicycle CASCADE
;

DROP TABLE IF EXISTS checkin_logs CASCADE
;

DROP TABLE IF EXISTS parking CASCADE
;

DROP TABLE IF EXISTS usuario CASCADE
;

/* Create Tables */

CREATE TABLE bicycle
(
	bike_id smallint NOT NULL,
	color varchar(50) NOT NULL,
	description varchar(50) NOT NULL,
	brand varchar(50) NOT NULL,
	chasis_code varchar(50) NOT NULL,
	user_id integer NULL
)
;

CREATE TABLE checkin_logs
(
	log_id integer NOT NULL,
	bike_id smallint NOT NULL,
	event_type char(10) NOT NULL,
	user_id integer NOT NULL,
	parking_id smallint NULL,
	timestamp timestamp without time zone NOT NULL   DEFAULT CURRENT_TIMESTAMP
)
;

CREATE TABLE parking
(
	parking_id smallint NOT NULL,
	parking_name varchar(50) NOT NULL,
	parking_location varchar(50) NOT NULL,
	max_capacity smallint NOT NULL,
	available_capacity smallint NULL
)
;

CREATE TABLE usuario
(
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	email varchar(320) NOT NULL,
	student_id numeric(11) NOT NULL,
	password varchar(50) NOT NULL,
	user_id integer NOT NULL
)
;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE bicycle ADD CONSTRAINT "PK_Bicycle"
	PRIMARY KEY (bike_id)
;

CREATE INDEX "IXFK_Bicycle_Usuario" ON bicycle (user_id ASC)
;

ALTER TABLE checkin_logs ADD CONSTRAINT "PK_checkin_logs"
	PRIMARY KEY (log_id)
;

ALTER TABLE checkin_logs ADD CONSTRAINT "CK_event_type" CHECK (event_type IN('check in' ,'check out'))
;

CREATE INDEX "IXFK_checkin_logs_Bicycle" ON checkin_logs (bike_id ASC)
;

CREATE INDEX "IXFK_checkin_logs_Usuario" ON checkin_logs (user_id ASC)
;

ALTER TABLE parking ADD CONSTRAINT "PK_parking"
	PRIMARY KEY (parking_id)
;

ALTER TABLE parking ADD CONSTRAINT "CK_max_capacity" CHECK (max_capacity > 0)
;

ALTER TABLE parking ADD CONSTRAINT "CK_available_capacity" CHECK (available_capacity >=0)
;

ALTER TABLE usuario ADD CONSTRAINT "PK_Usuario"
	PRIMARY KEY (user_id)
;

ALTER TABLE usuario 
  ADD CONSTRAINT "UK_email" UNIQUE (email)
;

ALTER TABLE usuario 
  ADD CONSTRAINT "UK_student_id" UNIQUE (student_id)
;

ALTER TABLE usuario ADD CONSTRAINT "CK_email" CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
;

ALTER TABLE usuario ADD CONSTRAINT "CK_student_id" CHECK (student_id >0)
;

CREATE INDEX "IX_email" ON usuario (email ASC)
;

CREATE INDEX "IX_studentID" ON usuario (student_id ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE bicycle ADD CONSTRAINT "FK_Bicycle_Usuario"
	FOREIGN KEY (user_id) REFERENCES usuario (user_id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE checkin_logs ADD CONSTRAINT "FK_checkin_logs_Bicycle"
	FOREIGN KEY (bike_id) REFERENCES bicycle (bike_id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE checkin_logs ADD CONSTRAINT "FK_checkin_logs_parking"
	FOREIGN KEY (parking_id) REFERENCES parking (parking_id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE checkin_logs ADD CONSTRAINT "FK_checkin_logs_Usuario"
	FOREIGN KEY (user_id) REFERENCES usuario (user_id) ON DELETE No Action ON UPDATE No Action
;
