CREATE TABLE
    INSCRITOS (cantidad INT, fecha DATE, fuente VARCHAR);

BEGIN;

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (44, '01/01/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (56, '01/01/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (39, '01/02/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (81, '01/02/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (12, '01/03/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (91, '01/03/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (48, '01/04/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (45, '01/04/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (55, '01/05/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (33, '01/05/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (18, '01/06/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (12, '01/06/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (34, '01/07/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (24, '01/07/2021', 'Página');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (83, '01/08/2021', 'Blog');

INSERT INTO
    INSCRITOS (cantidad, fecha, fuente)
VALUES
    (99, '01/08/2021', 'Página');

COMMIT;

--1. ¿Cuántos registros hay?
SELECT
    COUNT(*)
FROM
    inscritos;

--2. ¿Cuántos inscritos hay en total?
SELECT
    SUM(cantidad) AS total_inscritos
FROM
    inscritos;

--3. ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT
    *
FROM
    inscritos
WHERE
    fecha IN (
        SELECT
            MIN(fecha)
        FROM
            inscritos
    );

/*
4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
ahora en adelante)
 */
SELECT
    fecha,
    SUM(cantidad)
FROM
    inscritos
GROUP BY
    fecha
ORDER BY
    fecha;

/*
5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se
inscribieron en ese día?
 */
SELECT
    fecha,
    inscritos_por_dia
FROM
    (
        SELECT
            fecha,
            SUM(cantidad) AS inscritos_por_dia
        FROM
            inscritos
        GROUP BY
            fecha
        ORDER BY
            fecha
    ) agrupacion
WHERE
    inscritos_por_dia = (
        SELECT
            MAX(inscritos_por_dia)
        FROM
            (
                SELECT
                    fecha,
                    SUM(cantidad) AS inscritos_por_dia
                FROM
                    inscritos
                GROUP BY
                    fecha
                ORDER BY
                    fecha
            ) AS agrupacion
    );

--Forma 2:
SELECT
    fecha,
    SUM(cantidad) AS inscritos_por_dia
FROM
    inscritos
GROUP BY
    fecha
HAVING
    SUM(cantidad) = (
        SELECT
            MAX(inscritos_por_dia)
        FROM
            (
                SELECT
                    fecha,
                    SUM(cantidad) AS inscritos_por_dia
                FROM
                    inscritos
                GROUP BY
                    fecha
                ORDER BY
                    fecha
            ) AS agrupado
    );

--Forma 3:
SELECT
    fecha,
    SUM(cantidad) AS inscritos_por_dia
FROM
    inscritos
GROUP BY
    fecha
ORDER BY
    inscritos_por_dia DESC
LIMIT
    1;