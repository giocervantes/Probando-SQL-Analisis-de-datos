USE RetailPro_Nike;
GO

SELECT TOP 1 * FROM ventas_nike;

UPDATE ventas_nike
SET 
    Price_per_Unit   = REPLACE(Price_per_Unit, ',', '.'),
    Costo_Unitario   = REPLACE(Costo_Unitario, ',', '.'),
    Operating_Margin = REPLACE(Operating_Margin, ',', '.');
GO

ALTER TABLE ventas_nike ALTER COLUMN Price_per_Unit   DECIMAL(10, 2);
ALTER TABLE ventas_nike ALTER COLUMN Costo_Unitario   DECIMAL(10, 2);
ALTER TABLE ventas_nike ALTER COLUMN Operating_Margin DECIMAL(10, 4);
GO





--Parte 2--
--Mediana vs media--

SELECT DISTINCT
    AVG(Price_per_Unit * Units_Sold) OVER() AS Media_Ticket,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Mediana_Ticket
FROM ventas_nike;

--Conclusiones: Al analizar las 229.471 transacciones de ventas_nike, obtuve una Media de 20.153,55 y una Mediana de 12.092,05. Ambas medidas son muy distintas: la media supera a la mediana en 8.061,50 (66,7% arriba)--

-- Outliers- Método IQR--

WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q3
    FROM ventas_nike
)
SELECT 
    Q1,
    Q3,
    (Q3 - Q1) AS IQR,
    Q1 - 1.5 * (Q3 - Q1) AS Limite_Inferior,
    Q3 + 1.5 * (Q3 - Q1) AS Limite_Superior
FROM q;

--Conclusiones: Aplicando el método del rango intercuartílico sobre el importe de venta formado por la multiplicación de (Price_per_Unit * Units_Sold), obtuve estos registros, se determina que no representan errores de carga, sino eventos legítimos de negocio (órdenes mayoristas de gran volumen, de hasta 1.000 unidades por transacción, o productos de gama alta con precios unitarios de $629,95 a $2.229,95

-- Cantidad de Outliers (registros que caen afuera de esos limites)--


WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q3
    FROM ventas_nike
)
SELECT COUNT(*) AS Cantidad_Outliers
FROM ventas_nike v
CROSS JOIN q
WHERE (v.Price_per_Unit * v.Units_Sold) < (q.Q1 - 1.5 * (q.Q3 - q.Q1))
   OR (v.Price_per_Unit * v.Units_Sold) > (q.Q3 + 1.5 * (q.Q3 - q.Q1));


   --Conclusiones: 18191 outliers, estan por encima del límite superior--

--Caso Retail_nike Pro--

--Parte 2--
--Mediana vs media--

SELECT DISTINCT
    AVG(Price_per_Unit * Units_Sold) OVER() AS Media_Ticket,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Mediana_Ticket
FROM ventas_nike;

--Conclusiones: Al analizar las 229.471 transacciones de ventas_nike, obtuve una Media de 20.153,55 y una Mediana de 12.092,05. Ambas medidas son muy distintas: la media supera a la mediana en 8.061,50 (66,7% arriba)--

-- Outliers- Método IQR--

WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q3
    FROM ventas_nike
)
SELECT 
    Q1,
    Q3,
    (Q3 - Q1) AS IQR,
    Q1 - 1.5 * (Q3 - Q1) AS Limite_Inferior,
    Q3 + 1.5 * (Q3 - Q1) AS Limite_Superior
FROM q;

--Conclusiones: Aplicando el método del rango intercuartílico sobre el importe de venta formado por la multiplicación de (Price_per_Unit * Units_Sold), obtuve estos registros, se determina que no representan errores de carga, sino eventos legítimos de negocio (órdenes mayoristas de gran volumen, de hasta 1.000 unidades por transacción, o productos de gama alta con precios unitarios de $629,95 a $2.229,95

-- Cantidad de Outliers (registros que caen afuera de esos limites)--


WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q3
    FROM ventas_nike
)
SELECT COUNT(*) AS Cantidad_Outliers
FROM ventas_nike v, q
WHERE (v.Price_per_Unit * v.Units_Sold) < (q.Q1 - 1.5 * (q.Q3 - q.Q1))
   OR (v.Price_per_Unit * v.Units_Sold) > (q.Q3 + 1.5 * (q.Q3 - q.Q1));
--other:--
WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS Q3
    FROM ventas_nike
)
SELECT COUNT(*) AS Cantidad_Outliers
FROM ventas_nike v
CROSS JOIN q
WHERE (v.Price_per_Unit * v.Units_Sold) < (q.Q1 - 1.5 * (q.Q3 - q.Q1))
   OR (v.Price_per_Unit * v.Units_Sold) > (q.Q3 + 1.5 * (q.Q3 - q.Q1));


   --Conclusiones: 18191 outliers, estan por encima del límite superior--

--So:--
WITH q AS (
    SELECT DISTINCT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (Price_per_Unit * Units_Sold)) OVER() AS q3
    FROM ventas_nike
)
SELECT 
    (v.Price_per_Unit * v.Units_Sold) AS valor_outlier,
    COUNT(*)                          AS veces_que_se_repite
FROM ventas_nike v, q
WHERE (v.Price_per_Unit * v.Units_Sold) > q.q3 + 1.5 * (q.q3 - q.q1)
GROUP BY (v.Price_per_Unit * v.Units_Sold)
ORDER BY valor_outlier DESC;

