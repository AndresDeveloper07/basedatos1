# crear la base de datos
DROP DATABASE IF EXISTS tarea2; 
CREATE DATABASE IF NOT EXISTS tarea2 CHARACTER SET 'UTF8' COLLATE 'utf8_general_ci';
USE tarea2;

# tabla paises
CREATE TABLE IF NOT EXISTS paises(
    pais_id                 char(2) not null,
    pais_nombre             varchar(50) not null,

    CONSTRAINT pk_paises PRIMARY KEY(pais_id)
)ENGINE=InnoDB;


# tabla regiones
CREATE TABLE IF NOT EXISTS regiones(
    region_id               int(11) auto_increment not null,
    region_nombre           varchar(25) not null,
    pais_id                 char(2) not null,

    CONSTRAINT pk_regiones PRIMARY KEY(region_id),
    CONSTRAINT fk_reg_pais FOREIGN KEY(pais_id) REFERENCES paises(pais_id)
)ENGINE=InnoDB;


# tabla departamentos
CREATE TABLE IF NOT EXISTS departamentos(
    departamento_id         int(11) auto_increment not null,
    departamento_nombre     varchar(30) not null,
    region_id               int(11) not null,
    
    CONSTRAINT pk_departamentos PRIMARY KEY(departamento_id),
    CONSTRAINT fk_depto_region FOREIGN KEY(region_id) REFERENCES regiones(region_id)
)ENGINE=InnoDB;


# tabla ubicaciones
CREATE TABLE IF NOT EXISTS ubicaciones(
    ubicacion_id            int(11) auto_increment not null,
    direccion               varchar(40) not null,
    codigo_postal           varchar(12),
    ciudad                  varchar(30),
    estado_provincia        varchar(25),
    departamento_id         int(11) not null,

    CONSTRAINT pk_ubicacion PRIMARY KEY(ubicacion_id),
    CONSTRAINT fk_ubi_depart FOREIGN KEY(departamento_id) REFERENCES departamentos(departamento_id)
)ENGINE=InnoDB;



# tabla de trabajos
CREATE TABLE IF NOT EXISTS trabajos(
    trabajo_id              int(11) auto_increment not null,
    trabajo_nombre          varchar(35) not null,
    salario_min             decimal(8,2),
    salario_max             decimal(8,2),

    CONSTRAINT pk_trabajo PRIMARY KEY (trabajo_id) 
)ENGINE=InnoDB;


# tabla empleados
CREATE TABLE IF NOT EXISTS  empleados(
    empleado_id             int(11) auto_increment not null,
    nombres                 varchar(20) not null,
    apellidos               varchar(25),
    email                   varchar(100) not null,
    numero_telefono         varchar(20),
    fecha_ingreso           date,
    salario                 decimal(8,2),
    trabajo_id              int(11) not null,
    gerencia_id             int(11),
    ubicacion_id            int(11) not null,

    CONSTRAINT pk_empleado PRIMARY KEY(empleado_id),
    CONSTRAINT fk_trab_empl FOREIGN KEY(trabajo_id) REFERENCES trabajos(trabajo_id),
    CONSTRAINT fk_ubi_empl FOREIGN KEY(ubicacion_id) REFERENCES ubicaciones(ubicacion_id),
    CONSTRAINT fk_ger_emp FOREIGN KEY(gerencia_id) REFERENCES empleados(empleado_id)
)ENGINE=InnoDB;


#tabla dependientes
CREATE TABLE IF NOT EXISTS dependientes(
    dependiente_id          int(11) auto_increment not null,
    nombres                 varchar(50) not null,
    apellidos               varchar(50),
    vinculo                 varchar(50),
    empleado_id             int(11) not null,
    
    CONSTRAINT pk_dependientes PRIMARY KEY(dependiente_id),
    CONSTRAINT fk_depen_empl FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
)ENGINE=InnoDB;

