--TP 10--
--Valiaciones estadísticas--



DROP TABLE IF EXISTS ventas_semana;

CREATE TABLE ventas_semana (
    sucursal VARCHAR(20),
    venta DECIMAL(10,2)
);

INSERT INTO ventas_semana (sucursal, venta)
VALUES
    ('Norte', 500),
    ('Norte', 510),
    ('Norte', 490),
    ('Norte', 505),
    ('Norte', 495),
    ('Sur', 100),
    ('Sur', 900),
    ('Sur', 50),
    ('Sur', 1200),
    ('Sur', 250);


SELECT
    sucursal,
    AVG(venta) AS media,
    MAX(venta) - MIN(venta) AS rango
FROM ventas_semana
GROUP BY sucursal;


SELECT
    sucursal,
    STDEV(venta) AS desvio_muestral
FROM ventas_semana
GROUP BY sucursal;


--Conclusiones:--

--Elijo gestionar la sucursal Norte porque presenta ventas mucho más estables. Aunque ambas sucursales tienen una media de USD 500, Norte tiene un rango de apenas USD 20 y una desviación estándar de USD 7,91. Sur presenta una variabilidad considerablemente mayor, lo que dificulta la planificación y la previsibilidad de los ingresos--


-- 2da parte--

SELECT
    id_venta,
    fecha_venta,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_venta
FROM ventas;

--media versus mediana:--

SELECT
  AVG(cantidad*precio_unitario) OVER ()                                     AS media,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cantidad*precio_unitario) OVER () AS mediana
FROM ventas;





--Media vs Mediana:--



--other form:--
SELECT
    AVG(total_venta) AS media,
    FROM ventas_calculadas;





WITH ventas_calculadas AS (
    SELECT
        CAST(cantidad * precio_unitario AS DECIMAL(10,2)) AS total_venta
    FROM ventas
),
cuartiles AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY total_venta) OVER () AS q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY total_venta) OVER () AS q3
    FROM ventas_calculadas
)
SELECT
    q1,
    q3,
    q3 - q1 AS iqr,
    q1 - 1.5 * (q3 - q1) AS limite_inferior,
    q3 + 1.5 * (q3 - q1) AS limite_superior
FROM cuartiles;


--pther way:--

WITH q AS (
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cantidad * precio_unitario) OVER () AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cantidad * precio_unitario) OVER () AS q3
  FROM ventas
)
SELECT
  q1, q3,
  (q3 - q1)          AS iqr,
  q1 - 1.5*(q3 - q1) AS limite_inferior,
  q3 + 1.5*(q3 - q1) AS limite_superior
FROM q;

--afuera de rango:--

WITH q AS (
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cantidad * precio_unitario) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cantidad * precio_unitario) OVER() AS q3
  FROM ventas
)
SELECT v.*
FROM ventas v, q
WHERE v.cantidad * precio_unitario < q.q1 - 1.5*(q.q3 - q.q1)
   OR v.cantidad * precio_unitario > q.q3 + 1.5*(q.q3 - q.q1);





	--Conclusiones:--