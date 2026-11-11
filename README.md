# Probando-SQL
Codigos de consultas

# RetailPro — Proyecto Analítico

## Descripción

Proyecto de análisis de datos retail para la empresa RetailPro.
El objetivo es procesar, modelar y visualizar datos de ventas
para habilitar decisiones informadas al equipo comercial de la empresa.

## Estructura del repositor con IA
```
Retailpro/
├── sql/
│ ├── 01_etl_pipeline.sql
│ ├── 02_pre_entrega_4.sql
│ ├── 03_pre_entrega_5.sql
├── powerbi/
│ ├── Pipeline_ETL_Apellido_Nombre.pbix
│ └── Apellido_Nombre_Checkpoint2.pbix
├── docs/
│ └── checkpoint_docs.md
└── README.md
```

## Estructura corregida:
```
Retailpro/
├── sql/
│ ├── Ventas_Tech_DB.sql
│ ├── m4_consultas_negocios.sql
│ ├── m4_consultas_negocios(REV).sql
│ ├── m5_consultas_join.sql
├── powerbi/
│ ├── TP_6_Pipeline_ETL_Cervantes_Giordano.pbix
│ └── TP8_Girodano_Cervantes_Checkpoint2.pbix
├── docs/
│ └── README.md
└──
```

## Herramientas

| Herramienta | Uso |
|-------------|-----|
| SQL Server | Base de datos relacional |
| SQL Server Management Studio (SSMS) 22 | Cliente para ejecutar scripts SQL |
| Power BI Desktop | Modelado DAX y visualización |
| Git / GitHub | Control de versiones |

## Cómo ejecutar los scripts SQL

1. Abrí *SQL Server Management Studio (SSMS) 22* y conectate a tu instancia de SQL Server.
2. Seleccioná la base de datos retailpro.
3. Abrí una *Nueva consulta* (Ctrl + N).
4. Pegá o cargá los scripts en orden:
   - 01_etl_pipeline.sql — Carga y limpieza de datos
   - 02_pre_entrega_4.sql — Consultas analíticas
   - 03_pre_entrega_5.sql — Vistas y optimización
5. Hacé clic en *Ejecutar* (F5) y verificá los resultados en el panel inferior.

## Cómo abrir los archivos Power BI

1. Descargar los archivos .pbix desde el repositorio.
2. Abrí Power BI Desktop → Archivo → Abrir → seleccioná el .pbix.
3. Hacé clic en *Actualizar* para recargar los datos.

## Requisitos

- SQL Server (Express o superior)
- SQL Server Management Studio 22
- Power BI Desktop (versión gratuita)
- Cuenta de GitHub

## Tabla de cambios (para el Google Doc)

#	Infor de la IA, cómo quedó	y por qué lo cambiaste:
1	PostgreSQL 15 + DBeaver pero no usé ese soft. Lo reemplacé	SQL Server + SQL Server Management Studio (SSMS) 22.	El proyecto usa SQL Server, no PostgreSQL. La IA asumió el motor por defecto.

2	Estructura de subcarpetas (sql/,powerbi/,docs). lo reemplacé con los datos datos, archivos reales del repo ya que la IA genero una estructura generica.

3	Pipeline_ETL_Apellido_Nombre.pbix lo cambié por TP_6_Pipeline_ETL_Cervantes_Giordano.pbix (tu nombre real); el README debe tener el nombre real del archivo.


