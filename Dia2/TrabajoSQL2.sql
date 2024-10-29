CREATE DATABASE jesusT2_pais;

USE jesusT2_pais;

CREATE TABLE pais (
	id INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    continente VARCHAR(50) NOT NULL,
    poblacion INT NOT NULL
);

CREATE TABLE ciudad (
	id INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50),
    fk_id_pais INT NOT NULL,
    FOREIGN KEY(fk_id_pais)
    REFERENCES pais(id)
);

CREATE TABLE idioma (
	id INT NOT NULL PRIMARY KEY,
    idioma VARCHAR(50)
);

CREATE TABLE idioma_pais (
	fk_id_idioma INT NOT NULL,
    fk_id_pais INT NOT NULL,
    es_oficial tinyint,
    PRIMARY KEY(fk_id_idioma, fk_id_pais),
    FOREIGN KEY (fk_id_idioma) REFERENCES idioma(id),
    FOREIGN KEY (fk_id_pais) REFERENCES pais(id)
);

DESCRIBE idioma_pais;

INSERT INTO idioma (id, idioma) VALUES (1, 'Español');
INSERT INTO idioma (id, idioma) VALUES (2, 'Inglés'), (3, 'Francés');

-- Listar todos los idiomas
select * from idioma;
select idioma from idioma;

-- Listar el idioma con ID 1
select * from idioma where id=1;
select idioma from idioma where id=1;
INSERT INTO pais (id, nombre, continente, poblacion) VALUES (1, 'Venezuela', 'SurAmerica', 28199867);
INSERT INTO pais (id, nombre, continente, poblacion) VALUES (2, 'Colombia', 'SurAmerica', 52216000), (3, 'USA', 'NorteAmerica', 335135000), (4, 'Francia', 'Europa', 67000000);
select * from pais;

INSERT INTO idioma_pais (fk_id_idioma, fk_id_pais, es_oficial) VALUES (1, 1, 1);
INSERT INTO idioma_pais (fk_id_idioma, fk_id_pais, es_oficial) VALUES (1, 2, 1), (2, 3, 1), (3, 4, 1);
select * from idioma_pais;