
USE Ventas_Tech_DB;


-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Fuente principal para Power BI. Combina ventas, clientes, productos y categorias.

SELECT 
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region_cliente,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c 
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p 
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat 
    ON p.id_categoria = cat.id_categoria;



-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Identifica clientes registrados en el sistema que aun no realizaron compras.

SELECT 
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v 
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Identifica productos del catalogo que no tienen registros en la tabla ventas.

SELECT 
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat 
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v 
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;



-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Separa las ventas en dos canales ficticios (Online / Presencial) segun la fecha
-- y consolida el total facturado por canal usando un GROUP BY final.

SELECT 
    sub.canal,
    SUM(sub.total_venta) AS total_facturado,
    COUNT(*) AS cantidad_transacciones
FROM (
    -- Ventas canal Online (Primera mitad del mes: ventas hasta el 10 de marzo)
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    -- Ventas canal Presencial (Segunda mitad del mes: ventas posteriores al 10 de marzo)
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS sub
GROUP BY sub.canal;