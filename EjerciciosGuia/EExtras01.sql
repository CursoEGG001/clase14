-- Ejercicios Extra 01 --
/* 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente. */

SELECT Nombre
FROM jugadores
ORDER BY Nombre ASC;

/* 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente. */

SELECT jugadores.Nombre
FROM jugadores
WHERE jugadores.Posicion = 'C' AND jugadores.Peso > 200
ORDER BY jugadores.Nombre ASC;

/* 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/

SELECT equipos.Nombre
FROM equipos
ORDER BY equipos.Nombre ASC;

/* 4. Mostrar el nombre de los equipos del este (East). */

SELECT equipos.Nombre
FROM equipos
WHERE equipos.Conferencia = 'Este'
ORDER BY equipos.Nombre ASC;

/* 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre. */

SELECT equipos.Nombre
FROM equipos
WHERE equipos.Ciudad LIKE 'C%'
ORDER BY equipos.Nombre ASC;

/* 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo. */

SELECT jugadores.Nombre, equipos.Nombre AS NombreEquipo
FROM jugadores
JOIN equipos ON jugadores.Nombre_equipo = equipos.Nombre
ORDER BY equipos.Nombre ASC;

/* 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre. */

SELECT jugadores.Nombre, jugadores.Posicion, jugadores.Peso, jugadores.Altura, jugadores.Procedencia
FROM jugadores
JOIN equipos ON jugadores.Nombre_equipo = equipos.Nombre
WHERE equipos.Nombre = 'Raptors'
ORDER BY jugadores.Nombre ASC;

/* 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’. */

SELECT estadisticas.Puntos_por_partido
FROM estadisticas
JOIN jugadores ON estadisticas.jugador = jugadores.codigo
WHERE jugadores.Nombre = 'Pau Gasol';

/* 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′. */

SELECT estadisticas.Puntos_por_partido
FROM estadisticas
JOIN jugadores ON estadisticas.jugador = jugadores.codigo
WHERE jugadores.Nombre = 'Pau Gasol'
AND estadisticas.temporada = '04/05';

/* 10. Mostrar el número de puntos de cada jugador en toda su carrera. */

SELECT jugadores.Nombre, ROUND(SUM(estadisticas.Puntos_por_partido)) AS Total_Puntos
FROM jugadores
JOIN estadisticas ON jugadores.codigo = estadisticas.jugador
GROUP BY jugadores.Nombre;

/* 11. Mostrar el número de jugadores de cada equipo. */

SELECT equipos.Nombre, COUNT(jugadores.codigo) AS Numero_Jugadores
FROM equipos
JOIN jugadores ON equipos.Nombre = jugadores.Nombre_equipo
GROUP BY equipos.Nombre;

/* 12. Mostrar el jugador que más puntos ha realizado en toda su carrera. */

 SELECT jugadores.Nombre, SUM(estadisticas.Puntos_por_partido) AS Total_Puntos
FROM jugadores
JOIN estadisticas ON jugadores.codigo = estadisticas.jugador
GROUP BY jugadores.Nombre
ORDER BY Total_Puntos DESC
LIMIT 1;

/* 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA. */

SELECT equipos.Nombre AS Nombre_equipo, equipos.Conferencia, equipos.Division
FROM jugadores
JOIN equipos ON jugadores.Nombre_equipo = equipos.Nombre
WHERE jugadores.Altura = (SELECT MAX(Altura) FROM jugadores)
LIMIT 1;

/* 14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos. */

SELECT
    p.equipo_local,
    p.equipo_visitante,
    (p.puntos_local - p.puntos_visitante) AS diferencia
FROM
    partidos p
ORDER BY
    diferencia DESC
LIMIT 1;

/* 15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null. */




