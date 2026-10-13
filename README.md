# RetailPro --- Análisis de ventas con SQL y Power BI

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos comerciales de un negocio
minorista (*retail*). El objetivo es organizar y consultar información
de ventas, clientes, productos y categorías para obtener indicadores
útiles para la toma de decisiones comerciales.

El repositorio reúne entregas SQL de distintas etapas y un archivo de
Power BI. Las consultas permiten explorar la información, calcular
importes de venta y analizar el desempeño comercial desde distintas
perspectivas.

## Objetivos

-   Consultar y relacionar datos de ventas, clientes, productos y
    categorías.
-   Calcular el importe de las ventas a partir de la cantidad y el
    precio unitario.
-   Analizar la facturación por producto y cliente.
-   Preparar datos para su exploración y visualización en Power BI.
-   Obtener hallazgos que ayuden al equipo comercial a identificar
    oportunidades y concentraciones de ventas.

## Herramientas utilizadas

-   **SQL:** creación y ejecución de consultas, uso de `SELECT`,
    `INNER JOIN`, agregaciones y cálculos.
-   **Sistema gestor de bases de datos compatible con los scripts:**
    permite ejecutar las consultas sobre la base de datos
    correspondiente. Antes de ejecutarlas, hay que confirmar que el
    motor utilizado y los nombres de las tablas y columnas coincidan con
    el entorno local.
-   **Power BI Desktop:** apertura del archivo `.pbix` incluido en el
    repositorio para explorar las visualizaciones y el análisis
    realizado.
-   **GitHub:** almacenamiento y versionado de los archivos del
    proyecto.

## Estructura del repositorio

  -------------------------------------------------------------------------
  Archivo                               Descripción
  ------------------------------------- -----------------------------------
  `M4-Ribaya.sql`                       Consultas SQL de la etapa M4 para
                                        explorar y analizar los datos.

  `M5-Ribaya.sql`                       Consulta base de la etapa M5 que
                                        integra ventas, clientes, productos
                                        y categorías.

  `Ribaya_Santiago_Checkpoint2.pbix`    Archivo de Power BI asociado al
                                        análisis.

  `SQLQuery - Entrega 3 - Ribaya.sql`   Script SQL correspondiente a una
                                        entrega anterior.
  -------------------------------------------------------------------------

## Modelo de datos utilizado

La consulta base de M5 parte de la tabla `ventas` y la relaciona con
otras tres tablas:

-   `clientes`: información de los clientes.
-   `productos`: información de los productos vendidos.
-   `categorias`: clasificación de los productos.

Las relaciones se realizan mediante claves compartidas (`id_cliente`,
`id_producto` e `id_categoria`). La consulta calcula además
`total_venta` multiplicando `cantidad` por `precio_unitario`.

Ejemplo de la lógica principal:

``` sql
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,
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
```

> **Importante:** al usar `INNER JOIN`, solo se incluyen registros que
> tienen coincidencias en todas las tablas relacionadas. Conviene
> verificar la integridad de las claves para confirmar que no se
> excluyan ventas relevantes.

## Requisitos previos

1.  Tener acceso a la base de datos que contiene las tablas utilizadas
    por los scripts.
2.  Contar con un cliente SQL compatible con el motor de base de datos
    del proyecto.
3.  Tener Power BI Desktop si se desea abrir el archivo `.pbix`.
4.  Verificar que los nombres de tablas y columnas de la base de datos
    coincidan con los utilizados en los scripts.

El repositorio no documenta explícitamente la configuración de conexión
ni incluye aquí instrucciones de instalación de un motor específico. Por
eso, primero confirmá cuál es el gestor de base de datos utilizado en tu
entorno.

## Cómo ejecutar los scripts SQL

### 1. Clonar o descargar el repositorio

Con Git instalado, ejecutá:

``` bash
git clone https://github.com/SantiRibaya14/Checkpoint-Script-SQL-para-esquema-normalizado-y-datos-iniciales.git
cd Checkpoint-Script-SQL-para-esquema-normalizado-y-datos-iniciales
```

También podés descargar el repositorio como ZIP desde GitHub y
descomprimirlo.

### 2. Conectarse a la base de datos

Abrí tu cliente SQL y conectate a la base de datos que contiene las
tablas `ventas`, `clientes`, `productos` y `categorias`. Seleccioná la
base de datos correcta antes de ejecutar las consultas.

### 3. Ejecutar las consultas de M4

Abrí `M4-Ribaya.sql`, revisá las consultas y ejecutalas en el cliente
SQL. Revisá los resultados devueltos y comprobá que coincidan con los
datos disponibles en la base.

### 4. Ejecutar la consulta base de M5

Abrí `M5-Ribaya.sql` y ejecutá la consulta que une las cuatro tablas.
Verificá que los campos aparezcan correctamente y que el cálculo de
`total_venta` sea consistente con la cantidad y el precio unitario.

### 5. Abrir el análisis en Power BI

Abrí `Ribaya_Santiago_Checkpoint2.pbix` con Power BI Desktop. Si el
archivo solicita credenciales o una conexión a la base de datos,
configurá el origen correspondiente. Actualizá los datos si la conexión
está disponible en tu entorno.

### 6. Validar los resultados

Antes de compartir conclusiones, comprobá:

-   Que las uniones no estén eliminando ventas por falta de
    coincidencias.
-   Que el nivel de detalle de cada fila esté claro y no se dupliquen
    importes al agregar datos.
-   Que `cantidad * precio_unitario` represente el importe que se busca
    analizar.
-   Que los indicadores de Power BI coincidan con los resultados de las
    consultas SQL.

## Posibles análisis comerciales

Con los datos consultados se pueden explorar, entre otros, los
siguientes indicadores:

-   Facturación total y por período.
-   Facturación por cliente.
-   Unidades e importe vendidos por producto.
-   Participación de cada categoría en la facturación.
-   Concentración de ingresos en los principales clientes o productos.

La facturación no equivale necesariamente a rentabilidad. Para analizar
márgenes, se necesita contar también con información de costos y, cuando
corresponda, descuentos e impuestos.

## Alcance y consideraciones

Este repositorio documenta un ejercicio de análisis de datos comerciales
mediante SQL y Power BI. Para reproducirlo en otro entorno, es necesario
disponer de la base de datos compatible con los scripts y configurar
correctamente la conexión. Los resultados dependen de los datos cargados
y de la estructura efectiva de las tablas.

## Autor

**Santiago Ribaya**
