-- 1. Obtener los datos completos de los empleados. --
SELECT `empleados`.`id_emp`,
    `empleados`.`nombre`,
    `empleados`.`sex_emp`,
    `empleados`.`fec_nac`,
    `empleados`.`fec_incorporacion`,
    `empleados`.`sal_emp`,
    `empleados`.`comision_emp`,
    `empleados`.`cargo_emp`,
    `empleados`.`id_depto`
FROM `personal`.`empleados`;

-- 2. Obtener los datos completos de los departamentos. --
SELECT `departamentos`.`id_depto`,
    `departamentos`.`nombre_depto`,
    `departamentos`.`ciudad`,
    `departamentos`.`nombre_jefe_depto`
FROM `personal`.`departamentos`;

-- 3. Listar el nombre de los departamentos. --
SELECT `nombre_depto` FROM `personal`.`departamentos`;

-- 4. Obtener el nombre y salario de todos los empleados. --
SELECT `comision_emp`, `nombre`, `id_emp`,`sal_emp` FROM `personal`.`empleados`;

-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’. --
SELECT `id_emp`, `nombre`, `sex_emp`, `fec_nac`, `fec_incorporacion`, `sal_emp`, `comision_emp`, `cargo_emp`, `id_depto` FROM `personal`.`empleados` WHERE `empleados`.`cargo_emp` LIKE 'secretaria';

-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente. --
SELECT `empleados`.`id_emp`, `empleados`.`nombre`, `empleados`.`sex_emp`, `empleados`.`fec_nac`, `empleados`.`fec_incorporacion`, `empleados`.`sal_emp`, `empleados`.`comision_emp`, `empleados`.`cargo_emp`, `empleados`.`id_depto`
FROM `personal`.`empleados` 
WHERE `empleados`.`cargo_emp` 
LIKE 'vendedor' 
ORDER BY `nombre` asc;

-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor. --
SELECT `nombre`, `cargo_emp` FROM `personal`.`empleados` order by `empleados`.`sal_emp` asc;

-- 9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real” --
SELECT `nombre_jefe_depto`, `ciudad` FROM `personal`.`departamentos` where `departamentos`.`ciudad` like 'Ciudad Real';

/* 10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las
respectivas tablas de empleados. */

SELECT `cargo_emp` AS 'Cargo', `nombre` AS 'Nombre' FROM `personal`.`empleados` ;

/* 11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado
por comisión de menor a mayor. */

SELECT `sal_emp`, `comision_emp`, `id_depto` 
FROM `personal`.`empleados` 
where `empleados`.`id_depto`=2000 
order by `empleados`.`comision_emp` asc;

/* 12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético. */

SELECT nombre, (sal_emp + comision_emp + 500) AS total_a_pagar
FROM personal.empleados
WHERE id_depto = 3000
ORDER BY nombre;

/* 13. Muestra los empleados cuyo nombre empiece con la letra J. */

SELECT *
FROM personal.empleados
WHERE nombre LIKE 'J%';

/* 14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos 
empleados que tienen comisión superior a 1000. */

SELECT sal_emp, comision_emp, sal_emp + comision_emp AS salario_total, nombre
FROM personal.empleados
WHERE comision_emp > 1000;

/* 15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión. */

SELECT sal_emp, comision_emp, sal_emp AS salario_total, nombre
FROM personal.empleados
WHERE comision_emp IS NULL OR comision_emp = 0;

/* 16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo. */

SELECT *
FROM personal.empleados
WHERE comision_emp > sal_emp;

/* 17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo. */

SELECT nombre, sal_emp, comision_emp
FROM personal.empleados
WHERE comision_emp <= 0.3 * sal_emp;

/* 18. Hallar los empleados cuyo nombre no contiene la cadena “MA” */

SELECT nombre
FROM personal.empleados
WHERE nombre NOT LIKE '%MA%';

/* 19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento. */

-- Correciones echas porque era inútil al ejemplo --
SELECT DISTINCT id_depto, nombre, cargo_emp
FROM personal.empleados
WHERE cargo_emp in ('vendedor', 'investigador', 'mecánico');

SELECT nombre_depto
FROM departamentos
WHERE nombre_depto IN ('Ventas', 'Investigación', 'Mantenimiento');

/* 20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento. */

-- Mismo caso del anterior --
SELECT DISTINCT id_depto, nombre , cargo_emp
FROM personal.empleados
WHERE cargo_emp NOT IN ('vendedor', 'investigador', 'mecánico');

SELECT nombre_depto
FROM departamentos
WHERE nombre_depto NOT IN ('Ventas', 'Investigación', 'Mantenimiento');

-- 21. Mostrar el salario más alto de la empresa. --
SELECT MAX(sal_emp) AS salario_mas_alto;

/* 22. Mostrar el nombre del último empleado de la lista por orden alfabético. */
SELECT nombre
FROM personal.empleados
ORDER BY nombre DESC
LIMIT 1;

/* 23. Hallar el salario más alto, el más bajo y la diferencia entre ellos. */
SELECT MAX(sal_emp) AS salario_mas_alto, MIN(sal_emp) AS salario_mas_bajo, MAX(sal_emp) - MIN(sal_emp) AS diferencia_salarios
FROM personal.empleados;

SELECT `empleados`.`id_emp`,
    `empleados`.`nombre`,
    `empleados`.`sex_emp`,
    `empleados`.`fec_nac`,
    `empleados`.`fec_incorporacion`,
    `empleados`.`sal_emp`,
    `empleados`.`comision_emp`,
    `empleados`.`cargo_emp`,
    `empleados`.`id_depto`
FROM `personal`.`empleados`
WHERE `sal_emp` = (SELECT MAX(`sal_emp`) from empleados)
OR `sal_emp` =(select MIN(`sal_emp`)from empleados)
OR `sal_emp` = (Select (MAX(`sal_emp`) - MIN(`sal_emp`)) from empleados);

SELECT `empleados`.`id_emp`,
    `empleados`.`nombre`,
    `empleados`.`sex_emp`,
    `empleados`.`fec_nac`,
    `empleados`.`fec_incorporacion`,
    `empleados`.`sal_emp`,
    `empleados`.`comision_emp`,
    `empleados`.`cargo_emp`,
    `empleados`.`id_depto`
FROM `personal`.`empleados`
WHERE `sal_emp` IN (
    (SELECT MAX(`sal_emp`) FROM `personal`.`empleados`),
    (SELECT MIN(`sal_emp`) FROM `personal`.`empleados`),
    (SELECT (MAX(`sal_emp`) - MIN(`sal_emp`)) FROM `personal`.`empleados`)
);


/* 24. Hallar el salario promedio por departamento. */
SELECT id_depto, AVG(sal_emp) AS salario_promedio
FROM personal.empleados
GROUP BY id_depto;

SELECT d.id_depto, d.nombre_depto, ROUND(AVG(e.sal_emp), 2) AS avg_sal
FROM empleados e
INNER JOIN departamentos d ON e.id_depto = d.id_depto
GROUP BY d.id_depto, d.nombre_depto;

/* 25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos. */

SELECT d.nombre_depto, COUNT(e.id_emp) AS numero_empleados
FROM departamentos d
JOIN empleados e ON d.id_depto = e.id_depto
GROUP BY d.nombre_depto
HAVING COUNT(e.id_emp) > 3;

/* 26. Hallar los departamentos que no tienen empleados */

SELECT `id_depto`, `nombre_depto` FROM `personal`.`departamentos`;
SELECT `id_emp`, `id_depto`, `nombre` FROM `personal`.`empleados`;


SELECT d.nombre_depto, e.id_emp
FROM departamentos d
LEFT JOIN empleados e ON d.id_depto = e.id_depto
WHERE e.id_emp IS NULL;

/* 28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento. */

SELECT e.id_emp, e.nombre, e.sal_emp, e.id_depto, d.nombre_depto
FROM empleados e
JOIN departamentos d ON e.id_depto = d.id_depto
WHERE e.sal_emp >= (SELECT AVG(sal_emp) FROM empleados)
ORDER BY e.id_depto;

