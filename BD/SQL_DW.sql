-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-05-14 01:41:21.232

-- tables
-- Table: Dim_cnae
CREATE TABLE Dim_cnae (
    cnae_id number(8)  NOT NULL,
    cnae_cod number(8)  NOT NULL,
    cnae_secao varchar2(150)  NOT NULL,
    CONSTRAINT cnae_ak_1 UNIQUE (cnae_cod),
    CONSTRAINT Dim_cnae_pk PRIMARY KEY (cnae_id)
) ;

-- Table: Dim_empresa
CREATE TABLE Dim_empresa (
    emp_id number(8)  NOT NULL,
    emp_cnpj varchar2(18)  NOT NULL,
    emp_origem varchar2(20)  NOT NULL,
    CONSTRAINT Dim_empresa_pk PRIMARY KEY (emp_id)
) ;

-- Table: Dim_lugar
CREATE TABLE Dim_lugar (
    lug_id number(8)  NOT NULL,
    lug_cidade varchar2(50)  NOT NULL,
    lug_estado varchar2(2)  NOT NULL,
    lug_reg varchar2(25)  NOT NULL,
    CONSTRAINT Dim_lugar_pk PRIMARY KEY (lug_id)
) ;

-- Table: Dim_tempo
CREATE TABLE Dim_tempo (
    temp_id number(8)  NOT NULL,
    temp_mes date  NOT NULL,
    temp_ano number(4)  NOT NULL,
    CONSTRAINT Dim_tempo_pk PRIMARY KEY (temp_id)
) ;

-- Table: Fato_consumo
CREATE TABLE Fato_consumo (
    cons_id number(8)  NOT NULL,
    emp_id number(8)  NOT NULL,
    temp_id number(8)  NOT NULL,
    lug_id number(8)  NOT NULL,
    cnae_id number(8)  NOT NULL,
    cons_quantidade number(8)  NOT NULL,
    CONSTRAINT Fato_consumo_pk PRIMARY KEY (cons_id)
) ;

-- End of file.

