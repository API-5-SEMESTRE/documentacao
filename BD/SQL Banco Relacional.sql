-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-04-08 00:09:40.55

-- tables
-- Table: cidade
CREATE TABLE cidade (
    cid_id number(8)  NOT NULL,
    cid_descricao varchar2(50)  NOT NULL,
    cid_sigla_estado varchar2(2)  NOT NULL,
    cid_reg_ibge varchar2(25)  NOT NULL,
    CONSTRAINT cidade_pk PRIMARY KEY (cid_id)
) ;

-- Table: cnae
CREATE TABLE cnae (
    cnae_id number(8)  NOT NULL,
    cnae_cod number(8)  NOT NULL,
    cnae_desc varchar2(150)  NOT NULL,
    CONSTRAINT cnae_ak_1 UNIQUE (cnae_cod),
    CONSTRAINT cnae_pk PRIMARY KEY (cnae_id)
) ;

-- Table: consumo
CREATE TABLE consumo (
    cons_mesref timestamp  NOT NULL,
    emp_cnpj number(14)  NOT NULL,
    cons_consumo number(8)  NOT NULL,
    CONSTRAINT consumo_pk PRIMARY KEY (cons_mesref,emp_cnpj)
) ;

-- Table: empresa
CREATE TABLE empresa (
    emp_cnpj number(14)  NOT NULL,
    cid_id number(8)  NOT NULL,
    cnae_id number(8)  NOT NULL,
    usu_id number(8)  NOT NULL,
    emp_origem varchar2(20)  NOT NULL,
    emp_data_cadastro_vendedor timestamp  NOT NULL,
    CONSTRAINT empresa_pk PRIMARY KEY (emp_cnpj)
) ;

-- Table: usuario
CREATE TABLE usuario (
    usu_id number(8)  NOT NULL,
    usu_nome varchar2(20)  NOT NULL,
    usu_email varchar2(40)  NOT NULL,
    usu_senha varchar2(20)  NOT NULL,
    usu_tipoacesso varchar2(20)  NOT NULL,
    CONSTRAINT usuario_pk PRIMARY KEY (usu_id)
) ;

-- End of file.

