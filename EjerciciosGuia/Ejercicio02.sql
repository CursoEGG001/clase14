-- 1. Lista el nombre de todos los productos que hay en la tabla producto. --
SELECT `producto`.`nombre`   
FROM `tienda`.`producto`;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto. --
SELECT `nombre`, `precio` FROM `tienda`.`producto`;

-- 3. Lista todas las columnas de la tabla producto. --
SELECT `producto`.`codigo`,
    `producto`.`nombre`,
    `producto`.`precio`,
    `producto`.`codigo_fabricante`
FROM `tienda`.`producto`;

/* 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando
el valor del precio. */
SELECT codigo, nombre, ROUND(precio) AS precio, codigo_fabricante
FROM producto;

/* 5. Lista el código de los fabricantes que tienen productos en la tabla producto. */

SELECT p.codigo_fabricante
FROM producto p;

/* 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar
los repetidos. */

SELECT DISTINCT p.codigo_fabricante
FROM producto p;

/* 7. Lista los nombres de los fabricantes ordenados de forma ascendente. */
SELECT `nombre` FROM `tienda`.`producto` ORDER BY `producto`.`codigo_fabricante` ASC;

/* 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
ascendente y en segundo lugar por el precio de forma descendente. */

SELECT nombre
FROM producto
ORDER BY nombre ASC, precio DESC;

/* 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante. */
SELECT `fabricante`.`codigo`,
    `fabricante`.`nombre`
FROM `tienda`.`fabricante` limit 5;

/* 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT) */

SELECT p.nombre, p.precio
FROM producto p
ORDER BY p.precio ASC
LIMIT 1;

/* 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER
BY y LIMIT) */

SELECT p.nombre, p.precio
FROM producto p
ORDER BY p.precio DESC
LIMIT 1;

/* 12. Lista el nombre de los productos que tienen un precio menor o igual a $120. */

SELECT p.nombre
FROM producto p
WHERE p.precio <= 120;

/* 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador
BETWEEN. */

SELECT p.codigo, p.nombre, p.codigo_fabricante, p.precio, f.nombre, f.codigo
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio BETWEEN 60 AND 200;

/* 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5.
 Utilizando el operador IN. */

SELECT p.codigo, p.nombre, p.codigo_fabricante, p.precio, f.nombre, f.codigo
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.codigo_fabricante IN (1, 3, 5);

/* 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
en el nombre. */

SELECT nombre
FROM producto
WHERE nombre LIKE '%Portátil%';

/* Consultas Multitabla */

/* 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante
y nombre del fabricante, de todos los productos de la base de datos. */

SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

/* 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético. */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

/* 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
más barato. */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio = (
  SELECT MIN(precio) FROM producto
)
LIMIT 1;

/* 4. Devuelve una lista de todos los productos del fabricante Lenovo. */

SELECT producto.codigo, producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

/* 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
mayor que $200. */

SELECT producto.codigo, producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

/* 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
Utilizando el operador IN. */

SELECT producto.codigo, producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard');

/* 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente) */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

/* Consultas Multitabla */

/* Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados. */


SELECT fabricante.codigo, fabricante.nombre, producto.codigo, producto.nombre, producto.precio, producto.codigo_fabricante
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
ORDER BY fabricante.codigo;


/* 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
producto asociado. */

SELECT fabricante.codigo, fabricante.nombre
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo IS NULL;

/* Subconsultas (En la cláusula WHERE) */
/* Con operadores básicos de comparación
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN). */

SELECT producto.codigo, producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto
LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

/* 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto
más caro del fabricante Lenovo. (Sin utilizar INNER JOIN). */

SELECT *
FROM producto
WHERE precio = (
    SELECT MAX(precio)
    FROM producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM fabricante
        WHERE nombre = 'Lenovo'
    )
);

/* 3. Lista el nombre del producto más caro del fabricante Lenovo. */

SELECT nombre
FROM producto
WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Lenovo'
)
ORDER BY precio DESC
LIMIT 1;

/* 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos. */

SELECT p.codigo, p.nombre, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' AND p.precio > (
    SELECT AVG(precio)
    FROM producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM fabricante
        WHERE nombre = 'Asus'
    )
)
ORDER BY p.codigo;

/* Subconsultas con IN y NOT IN
1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
NOT IN). */

SELECT f.nombre AS nombre_fabricante
FROM fabricante f
WHERE f.codigo IN (
    SELECT DISTINCT codigo_fabricante
    FROM producto
)
ORDER BY f.nombre;

/* 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando
IN o NOT IN). */

SELECT f.nombre AS nombre_fabricante
FROM fabricante f
WHERE f.codigo NOT IN (
    SELECT DISTINCT codigo_fabricante
    FROM producto
)
ORDER BY f.nombre;

/* Subconsultas (En la cláusula HAVING)
1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
de productos que el fabricante Lenovo. */

SELECT f.nombre AS nombre_fabricante
FROM fabricante f
WHERE (
    SELECT COUNT(*)
    FROM producto p
    WHERE p.codigo_fabricante = f.codigo
) = (
    SELECT COUNT(*)
    FROM producto p
    INNER JOIN fabricante fl ON p.codigo_fabricante = fl.codigo
    WHERE fl.nombre = 'Lenovo'
)
