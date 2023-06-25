-- De Actividad 5 --
INSERT INTO `superheroes`.`creador`
(`id_creador`,
`nombre`)
VALUES
(1,
 'Marvel');
 INSERT INTO `superheroes`.`creador`
(`id_creador`,
`nombre`)
VALUES
(2,
 'DC Comics');

CREATE TABLE IF NOT EXISTS personajes(
   id_personaje INTEGER  NOT NULL PRIMARY KEY AUTO_INCREMENT
  ,nombre_real  VARCHAR(14) NOT NULL
  ,personaje    VARCHAR(17) NOT NULL
  ,Inteligencia INTEGER  NOT NULL
  ,fuerza       VARCHAR(9) NOT NULL
  ,velocidad    INTEGER  NOT NULL
  ,poder        INTEGER  NOT NULL
  ,aparicion    INTEGER  NOT NULL
  ,ocupacion    VARCHAR(23) NOT NULL
  ,id_creador   INTEGER  NOT NULL
); 

INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (1,'Bruce Banner','Hulk',160,'600 mil',75,983,1962,'Físico Nuclear',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (2,'Tony Stark','Iron Man',17,'200 mil',7,123,1963,'Inventor Industrial',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (3,'Thor Odinson','Thor',145,'infinita',100,235,1962,'Rey de Asgard',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (4,'Wanda Maximoff','Bruja Escarlata',170,'100 mil',90,345,1964,'Bruja',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (5,'Carol Danvers','Capitana Marvel',157,'250 mil',85,128,1968,'Oficial de inteligencia',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (6,'Thanos','Thanos',170,'infinita',20,306,1973,'Adorador de la muerte',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (7,'Peter Parker','Spiderman',165,'25 mil',80,74,1962,'Fotógrafo',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (8,'Steve Rogers','Capitan America',145,'600',45,60,1941,'Oficial Federal',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (9,'Bobby Drake','Ice Man',140,'2 mil',64,122,1963,'Contador',1);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (10,'Barry Allen','Flash',160,'10 mil',120,168,1956,'Científico forense',2);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (11,'Bruce Wayne','Batman',17,'500',32,47,1939,'Hombre de negocios',2);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (12,'Clark Kent','Superman',165,'infinita',120,182,1948,'Reportero',2);
INSERT INTO personajes(id_personaje,nombre_real,personaje,Inteligencia,fuerza,velocidad,poder,aparicion,ocupacion,id_creador ) VALUES (13,'Diana Prince','Mujer Maravilla',160,'infinita',95,127,1949,'Princesa guerrera',2);

SELECT `personaje` FROM `superheroes`.`personajes`;
UPDATE `superheroes`.`personajes`
SET
`aparicion` = 1938
WHERE `personajes`.`personaje` = 'Batman';
SELECT `personajes`.`id_personaje`,
    `personajes`.`nombre_real`,
    `personajes`.`personaje`,
    `personajes`.`inteligencia`,
    `personajes`.`fuerza`,
    `personajes`.`velocidad`,
    `personajes`.`poder`,
    `personajes`.`aparicion`,
    `personajes`.`ocupacion`,
    `personajes`.`id_creador`
FROM `superheroes`.`personajes`;

DELETE FROM `superheroes`.`personajes`
WHERE `personajes`.`personaje` = 'Flash';


/* Actividad 6*/
-- Usen el rayito con I para ejecutar de a una las líneas --
SELECT `id_creador`, `nombre` FROM `superheroes`.`creador`;
SELECT `personajes`.`id_personaje`,
    `personajes`.`nombre_real`,
    `personajes`.`personaje`,
    `personajes`.`inteligencia`,
    `personajes`.`fuerza`,
    `personajes`.`velocidad`,
    `personajes`.`poder`,
    `personajes`.`aparicion`,
    `personajes`.`ocupacion`,
    `personajes`.`id_creador`
FROM `superheroes`.`personajes`;
SELECT `nombre_real` FROM `superheroes`.`personajes`;

SELECT `personajes`.`id_personaje`,
    `personajes`.`nombre_real`,
    `personajes`.`personaje`,
    `personajes`.`inteligencia`,
    `personajes`.`fuerza`,
    `personajes`.`velocidad`,
    `personajes`.`poder`,
    `personajes`.`aparicion`,
    `personajes`.`ocupacion`,
    `personajes`.`id_creador`
FROM `superheroes`.`personajes` WHERE `nombre_real` LIKE 'B%';

-- Actividad 7 --
SELECT * FROM `superheroes`.`personajes` order by `inteligencia` ASC ;
SELECT `nombre_real`, `personaje`, `inteligencia`, `fuerza`, `velocidad`, `poder`, `aparicion`, `ocupacion` 
FROM `superheroes`.`personajes` order by `inteligencia` ASC;


