/* Consultas sobre una tabla
1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/

SELECT `codigo_oficina`, `ciudad` FROM `jardineria`.`oficina`;

/* 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España. */

SELECT `telefono`, `ciudad` FROM `jardineria`.`oficina` WHERE `oficina`.`pais`='España';

/* 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
código de jefe igual a 7.*/

SELECT `nombre`, `apellido1`, `apellido2`, `email` FROM `jardineria`.`empleado` WHERE `empleado`.`codigo_jefe` > 7;

/* 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa. */

SELECT `puesto`, `nombre`, `apellido1`, `apellido2`,`empleado`.`email` FROM `jardineria`.`empleado`;

/* 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas. */

SELECT `nombre`, `apellido1`, `apellido2`, `puesto` FROM `jardineria`.`empleado` WHERE NOT `empleado`.`puesto`='REPRESENTANTE VENTAS';

/* 6. Devuelve un listado con el nombre de los todos los clientes españoles.
*/

SELECT `nombre_cliente`, `pais` FROM `jardineria`.`cliente` WHERE `cliente`.`pais`='Spain';

/* 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido. */

SELECT distinct `estado` FROM `jardineria`.`pedido`;

/* 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
° Utilizando la función YEAR de MySQL.
° Utilizando la función DATE_FORMAT de MySQL.
° Sin utilizar ninguna de las funciones anteriores. */

SELECT DISTINCT `pago`.`codigo_cliente` FROM `jardineria`.`pago` WHERE YEAR(`pago`.`fecha_pago`)=2008;
SELECT DISTINCT `codigo_cliente` FROM `jardineria`.`pago` WHERE DATE_FORMAT(`pago`.`fecha_pago`, '%Y') = '2008';
SELECT DISTINCT `codigo_cliente` FROM `jardineria`.`pago` WHERE `pago`.`fecha_pago` BETWEEN '2008-01-01' AND '2008-12-31';

/* 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo. */

SELECT `detalle_pedido`.`codigo_pedido`, cliente.codigo_cliente, pedido.fecha_esperada, pedido.fecha_entrega
FROM detalle_pedido
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE pedido.fecha_entrega > pedido.fecha_esperada;

/* 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
° Utilizando la función ADDDATE de MySQL.
° Utilizando la función DATEDIFF de MySQL. */

SELECT detalle_pedido.codigo_pedido, cliente.codigo_cliente, pedido.fecha_esperada, pedido.fecha_entrega
FROM detalle_pedido
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE pedido.fecha_entrega <= DATE_SUB(pedido.fecha_esperada, INTERVAL 2 DAY);

SELECT detalle_pedido.codigo_pedido, cliente.codigo_cliente, pedido.fecha_esperada, pedido.fecha_entrega
FROM detalle_pedido
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE DATEDIFF(pedido.fecha_entrega, pedido.fecha_esperada) <= -2;

SELECT detalle_pedido.codigo_pedido, cliente.codigo_cliente, pedido.fecha_esperada, pedido.fecha_entrega
FROM detalle_pedido
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE ADDDATE(pedido.fecha_entrega, INTERVAL 2 DAY) <= pedido.fecha_esperada;

/* 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009. */

SELECT `estado`, `fecha_pedido` FROM `jardineria`.`pedido` WHERE estado='rechazado' AND YEAR(`fecha_pedido`)=2009;

/* 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año. */

SELECT `fecha_entrega` FROM `jardineria`.`pedido` WHERE date_format(`fecha_entrega`, '%m')=01 AND date_format(`fecha_entrega`, '%Y') IS NOT NULL;

/* 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor. */

SELECT `fecha_pago`, `forma_pago`,`pago`.`total` FROM `jardineria`.`pago` WHERE `forma_pago`='paypal' AND date_format(`fecha_pago`, '%Y')=2008 ORDER BY `pago`.`total` DESC;

/* 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas */

SELECT DISTINCT `forma_pago` FROM `jardineria`.`pago`;

/* 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio. */

SELECT `gama`, `cantidad_en_stock` FROM `jardineria`.`producto` WHERE `cantidad_en_stock` > 100 order by `producto`.`precio_venta` DESC;

/* 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30. */

SELECT `codigo_empleado_rep_ventas`, `codigo_cliente`, `ciudad`, `nombre_cliente`, `nombre_contacto`, `apellido_contacto` FROM `jardineria`.`cliente` WHERE `cliente`.`ciudad`='Madrid' AND (codigo_empleado_rep_ventas=11 OR codigo_empleado_rep_ventas=30);

/* Consultas multitabla (Composición interna)
Las consultas se deben resolver con INNER JOIN.
1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
de ventas. */

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido2, empleado.apellido1
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

/* 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas. */

SELECT cliente.nombre_cliente, empleado.nombre AS nombre_representante
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente;

/* 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas. */ 

SELECT cliente.nombre_cliente, empleado.nombre AS nombre_representante
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente WHERE pago.fecha_pago IS NULL;

/* 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante. */

SELECT cliente.nombre_cliente, empleado.nombre AS nombre_representante, oficina.ciudad
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente;

/* 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante. */

SELECT cliente.nombre_cliente, empleado.nombre AS nombre_representante, oficina.ciudad
FROM cliente
LEFT JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL; 

/* 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada. */

SELECT oficina.linea_direccion1, oficina.linea_direccion2, oficina.ciudad, oficina.region, oficina.pais
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.ciudad = 'Fuenlabrada';

/* 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante. */

SELECT cliente.nombre_cliente, empleado.nombre, oficina.ciudad
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

/* 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes. */

SELECT empleado.nombre, empleado.apellido1,empleado.apellido2, empleado.codigo_empleado,empleado.codigo_jefe AS nombre_empleado, jefe.nombre AS nombre_jefe
FROM empleado
INNER JOIN empleado AS jefe ON empleado.codigo_jefe = jefe.codigo_empleado;

/* 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. */

SELECT cliente.nombre_cliente
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.fecha_entrega > pedido.fecha_esperada;

/* 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente. */

SELECT cliente.codigo_cliente, cliente.nombre_cliente, producto.gama
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
INNER JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
GROUP BY cliente.codigo_cliente, cliente.nombre_cliente, producto.gama;

/* Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. */

SELECT cliente.codigo_cliente, cliente.nombre_cliente
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL;

/* 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pedido. */

SELECT cliente.codigo_cliente, cliente.nombre_cliente
FROM pedido
RIGHT JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
 WHERE pedido.codigo_pedido IS NULL;

/* 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
no han realizado ningún pedido. */

SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pd.codigo_pedido IS NULL;

/* 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
asociada. */

SELECT e.codigo_empleado, e.nombre
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

/* 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
asociado. */

SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

/* 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado. */

SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL
UNION
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
RIGHT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

/* 7. Devuelve un listado de los productos que nunca han aparecido en un pedido. */

SELECT p.codigo_producto, p.nombre
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
LEFT JOIN pedido pe ON dp.codigo_pedido = pe.codigo_pedido
WHERE pe.codigo_pedido IS NULL;

/* 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales. */

SELECT o.codigo_oficina
FROM oficina o
WHERE NOT EXISTS ( 
  SELECT 1
  FROM empleado e
  INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
  INNER JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
  INNER JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
  INNER JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
  INNER JOIN gama_producto gp ON pr.gama = gp.gama
  WHERE gp.gama = 'Frutales' AND e.codigo_oficina = o.codigo_oficina
); 

/* 9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago. */

SELECT c.codigo_cliente, c.nombre_cliente 
FROM cliente c
WHERE EXISTS (
  SELECT 1
  FROM pedido p
  WHERE p.codigo_cliente = c.codigo_cliente
) AND c.codigo_cliente NOT IN (
  SELECT codigo_cliente
  FROM pago
);

/* 10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado. */

SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, j.nombre AS nombre_jefe
FROM empleado e
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE NOT EXISTS (
  SELECT 1
  FROM cliente c
  WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
);

/* Consultas resumen
1. ¿Cuántos empleados hay en la compañía? */

SELECT count(`codigo_empleado`) FROM `jardineria`.`empleado`;

/* 2. ¿Cuántos clientes tiene cada país? */

SELECT pais, COUNT(codigo_cliente) AS total_clientes
FROM cliente
GROUP BY pais;

/* 3. ¿Cuál fue el pago medio en 2009? */ 

SELECT ROUND(AVG(total)) AS pago_medio_2009
FROM pago
WHERE YEAR(fecha_pago) = 2009;


