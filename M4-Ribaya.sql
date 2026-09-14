
USE Ventas_Tech_DB;
-- ------------------------------------------------------------------------------
-- Consulta 1 — Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes.
-- ------------------------------------------------------------------------------
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- ------------------------------------------------------------------------------
-- Consulta 2 — Ranking de productos
-- Top 5 de id_producto por total facturado, mostrando unidades y total generado.
-- ------------------------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- ------------------------------------------------------------------------------
-- Consulta 3 — Clientes recurrentes
-- Clientes con mas de un pedido, su cantidad de pedidos y total gastado.
-- ------------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;


-- ------------------------------------------------------------------------------
-- Consulta 4 — Meses por encima / por debajo del promedio mensual general
-- Compara la facturacion de cada mes frente al promedio de la facturacion mensual.
-- ------------------------------------------------------------------------------
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) >= (
            SELECT AVG(total_mensual)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS sub
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS condicion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- 1. Fuerte concentracion de ingresos en un solo producto:
--    El producto 1 concentra el 61.8% de la facturacion total de la empresa 
--    ($3,600.00 sobre un total de $5,824.00) con solo 3 unidades vendidas.

-- 2. Clientes clave (VIP) generan la gran mayoria de los ingresos:
--    A pesar de que los 5 clientes hicieron 2 compras cada uno, existe una alta 
--    disparidad en el gasto: los clientes 1 y 5 representan el 81.4% de la facturacion 
--    acumulada ($4,740.00 de los $5,824.00 totales).

-- 3. Ineficiencia en productos de alto volumen y bajo margen:
--    El producto 2 tuvo el mayor volumen de ventas en unidades (13 unidades entre 
--    dos pedidos), pero solo aporto $364.00 a la facturacion (6.2% del total), 
--    evidenciando un ticket por unidad muy bajo en comparacion con la linea de computacion.