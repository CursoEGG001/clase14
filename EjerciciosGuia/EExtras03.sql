/* 1. Mostrar el nombre de todos los pokemon. */

SELECT `nombre` FROM `pokemondb`.`pokemon`;

/* 2. Mostrar los pokemon que pesen menos de 10k. */

SELECT `numero_pokedex`, `nombre`, `peso`FROM `pokemondb`.`pokemon` WHERE peso < 10;

/* 3. Mostrar los pokemon de tipo agua. */

SELECT p.numero_pokedex, p.nombre
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'agua';

/* 4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo. */

SELECT p.numero_pokedex, p.nombre, t.nombre AS tipo
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre IN ('agua', 'fuego', 'tierra')
ORDER BY t.nombre;

/* 5. Mostrar los pokemon que son de tipo fuego y volador. */

SELECT p.numero_pokedex, p.nombre
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre IN ('fuego', 'volador');

/* 6. Mostrar los pokemon con una estadística base de ps mayor que 200. */

SELECT p.numero_pokedex, p.nombre
FROM pokemon p
JOIN estadisticas_base eb ON p.numero_pokedex = eb.numero_pokedex
WHERE eb.ps > 200;
 
 /* 7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok. */

SELECT p.numero_pokedex, p.nombre, p.peso, p.altura
FROM pokemon p
JOIN evoluciona_de e ON p.numero_pokedex = e.pokemon_origen
JOIN pokemon a ON a.numero_pokedex = e.pokemon_evolucionado
WHERE a.nombre = 'Arbok';

/* 8. Mostrar aquellos pokemon que evolucionan por intercambio. */

SELECT p.numero_pokedex, p.nombre, p.peso, p.altura
FROM pokemon p
JOIN pokemon_forma_evolucion fe ON p.numero_pokedex = fe.numero_pokedex
JOIN tipo_evolucion te ON fe.id_forma_evolucion = te.id_tipo_evolucion
WHERE te.tipo_evolucion = 'Intercambio';

/* 9. Mostrar el nombre del movimiento con más prioridad. */

SELECT `id_movimiento`, `nombre`, `potencia`, `precision_mov`, `descripcion`, `pp`, `id_tipo`, `prioridad` 
FROM `pokemondb`.`movimiento` 
WHERE prioridad= ALL(
SELECT MAX(`prioridad`) FROM `pokemondb`.`movimiento`
);

/* 10. Mostrar el pokemon más pesado. */

SELECT `numero_pokedex`, `nombre`, `peso`, `altura` FROM `pokemondb`.`pokemon` WHERE peso = ALL(
SELECT MAX(`peso`) FROM `pokemondb`.`pokemon`
);

/* 11. Mostrar el nombre y tipo del ataque con más potencia. */

SELECT m.nombre, t.nombre AS tipo
FROM movimiento m
JOIN tipo t ON m.id_tipo = t.id_tipo 
WHERE m.potencia = (SELECT MAX(potencia) FROM movimiento);

/* 12. Mostrar el número de movimientos de cada tipo. */

SELECT t.nombre AS tipo, COUNT(m.id_movimiento) AS cantidad_movimientos
FROM tipo t
LEFT JOIN movimiento m ON t.id_tipo = m.id_tipo
GROUP BY t.nombre;

/* 13. Mostrar todos los movimientos que puedan envenenar. */

SELECT m.id_movimiento, m.nombre
FROM movimiento m
JOIN tipo t ON t.id_tipo = m.id_tipo
WHERE t.nombre = 'Veneno';

/* 14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre. */

SELECT id_movimiento, nombre
FROM movimiento
WHERE potencia > 0
ORDER BY nombre ASC;

/* 15. Mostrar todos los movimientos que aprende pikachu. */

SELECT pmf.id_movimiento, m.nombre
FROM pokemon_movimiento_forma pmf
JOIN movimiento m ON m.id_movimiento = pmf.id_movimiento
JOIN pokemon p ON p.numero_pokedex = pmf.numero_pokedex
WHERE p.nombre = 'Pikachu';

/* 16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje). */

SELECT m.nombre, tf.tipo_aprendizaje
FROM pokemon_movimiento_forma pmf
JOIN movimiento m ON m.id_movimiento = pmf.id_movimiento
JOIN mt ON mt.id_forma_aprendizaje = pmf.id_forma_aprendizaje
JOIN forma_aprendizaje fa ON fa.id_forma_aprendizaje = mt.id_forma_aprendizaje
JOIN tipo_forma_aprendizaje tf ON tf.id_tipo_aprendizaje = fa.id_tipo_aprendizaje
JOIN pokemon p ON p.numero_pokedex = pmf.numero_pokedex
WHERE p.nombre = 'Pikachu'
    AND tf.tipo_aprendizaje = 'MT';

/* 17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel. */

SELECT m.nombre
FROM pokemon p
JOIN pokemon_movimiento_forma pmf ON pmf.numero_pokedex = p.numero_pokedex
JOIN movimiento m ON m.id_movimiento = pmf.id_movimiento
JOIN forma_aprendizaje fa ON fa.id_forma_aprendizaje = pmf.id_forma_aprendizaje
JOIN nivel_aprendizaje na ON na.id_forma_aprendizaje = fa.id_forma_aprendizaje
JOIN nivel_evolucion ne ON ne.nivel = na.nivel
JOIN pokemon_forma_evolucion pfe ON pfe.id_forma_evolucion = ne.id_forma_evolucion
JOIN tipo t ON t.id_tipo = m.id_tipo
WHERE p.nombre = 'Pikachu'
    AND t.nombre = 'Normal';

/* 18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%. */

SELECT m.nombre, m.`id_movimiento`, m.`potencia`, m.`precision_mov`, m.`descripcion`, m.`pp`, m.`id_tipo`, m.`prioridad`
FROM movimiento m
JOIN movimiento_efecto_secundario mes ON mes.id_movimiento = m.id_movimiento
JOIN efecto_secundario es ON es.id_efecto_secundario = mes.id_efecto_secundario
WHERE mes.probabilidad > 0.3;

/* 19. Mostrar todos los pokemon que evolucionan por piedra.*/

SELECT p.numero_pokedex, p.nombre
FROM pokemon p
JOIN pokemon_forma_evolucion pfe ON pfe.numero_pokedex = p.numero_pokedex
JOIN forma_evolucion fe ON fe.id_forma_evolucion = pfe.id_forma_evolucion
JOIN tipo_evolucion te ON te.id_tipo_evolucion = fe.tipo_evolucion
WHERE te.tipo_evolucion = 'piedra';

/* 20. Mostrar todos los pokemon que no pueden evolucionar. */

SELECT p.numero_pokedex, p.nombre
FROM pokemon p
LEFT JOIN pokemon_forma_evolucion pfe ON pfe.numero_pokedex = p.numero_pokedex
LEFT JOIN forma_evolucion fe ON fe.id_forma_evolucion = pfe.id_forma_evolucion
LEFT JOIN tipo_evolucion te ON te.id_tipo_evolucion = fe.tipo_evolucion
WHERE te.id_tipo_evolucion IS NULL;

/*21. Mostrar la cantidad de los pokemon de cada tipo.*/

SELECT `pokemon_tipo`.`numero_pokedex`,
    `pokemon_tipo`.`id_tipo`
FROM `pokemondb`.`pokemon_tipo`;

SELECT `tipo`.`id_tipo`,
    `tipo`.`nombre`,
    `tipo`.`id_tipo_ataque`
FROM `pokemondb`.`tipo`;

SELECT `pokemon`.`numero_pokedex`,
    `pokemon`.`nombre`,
    `pokemon`.`peso`,
    `pokemon`.`altura`
FROM `pokemondb`.`pokemon`;


SELECT t.nombre AS tipo, COUNT(*) AS cantidad
FROM tipo t
JOIN pokemon_tipo pt ON pt.id_tipo = t.id_tipo
JOIN pokemon p ON p.numero_pokedex = pt.numero_pokedex
GROUP BY t.nombre

