# Informe Técnico: Análisis de Sistema ALMACENREMOTOV3

## 1. Objetivo del Sistema
El sistema **ALMACENREMOTOV3** es una solución integral de **gestión comercial, logística y control de inventarios** diseñada para empresas de distribución, comercialización o retail que operan en entornos de **almacenes remotos**.

### Problemas que resuelve y procesos que automatiza:
*   **Gestión Logística Completa:** Controla el ciclo de vida de la mercadería, desde el ingreso hasta el despacho.
*   **Control de Inventarios (Kardex):** Automatiza el seguimiento de stock mediante un Kardex local y remoto, permitiendo auditorías de ingresos vs. salidas.
*   **Facturación y Documentación Comercial:** Emisión de facturas, boletas, notas de crédito, notas de débito y guías de remisión.
*   **Ciclo de Ventas:** Gestión de cotizaciones (incluyendo seguimiento y stickers), pedidos y análisis de utilidad por cliente o producto.
*   **Gestión de Cartera:** Control de cuentas por corriente (Cta. Cte.), letras, cheques y abonos.
*   **Análisis Gerencial:** Generación de rankings de clientes, reportes de utilidad y análisis de precios.

**Áreas Involucradas:** Logística, Almacén, Ventas, Facturación, Inventario, Créditos y Cobranzas, y Gerencia Comercial.

---

## 2. Tecnologías Identificadas

| Categoría | Tecnologías Detectadas |
| :--- | :--- |
| **Lenguaje Principal** | Visual FoxPro 9.0 (Inferido por el uso de FoxyPreviewer y tipos de archivos .scx/.vcx). |
| **Bases de Datos** | Tablas nativas (.DBF, .DBC), con soporte para consultas SQL y cursores. |
| **Reportes** | Motor nativo FRX, extendido con **FoxyPreviewer** para exportación avanzada. |
| **Integración / APIs** | Google Maps (geolocalización), SMTP para envío de correos (Gmail), Automatización de Excel. |
| **Librerías Externas** | `foxtools.fll`, `librerias_webview.vct` (posible integración con controles web modernos). |
| **Seguridad** | Gestión de claves, contraseñas y registros de auditoría. |
| **Infraestructura** | Scripts de automatización (.BAT) para despliegue y sincronización con GitHub. |
| **Gráficos / UI** | Skinning personalizado (fakeXP.txt), fuentes de códigos de barras (ElfringBar39). |

---

## 3. Arquitectura y Diseño
El sistema presenta una arquitectura **Monolítica Modular** con tendencia a un modelo **Cliente-Servidor Híbrido**.

*   **Estructura de Capas:** Se observa una separación lógica mediante carpetas:
    *   `formularios/`: Capa de Interfaz de Usuario (UI) basada en formularios SCX.
    *   `librerias/`: Capa de clases reutilizables (.VCX).
    *   `progs/`: Capa de lógica de negocio y procedimientos (.PRG).
    *   `informes/`: Capa de salida de datos (FRX).
*   **Patrón de Diseño:** Sigue el estándar de VFP de programación dirigida por eventos con fuerte acoplamiento a los datos (Data Environment de formularios).
*   **Modularidad:** Alta. El sistema está dividido en módulos claros (Ventas, Almacén, Cobranzas) que interactúan a través de una base de datos centralizada.

---

## 4. Módulos Funcionales

1.  **Ventas y Cotizaciones:** Gestión proactiva de clientes, emisión de cotizaciones masivas (`mergecotiza`) y seguimiento comercial.
2.  **Almacén y Stock:** Control de ingresos de mercadería, traspasos entre almacenes y gestión de lotes.
3.  **Facturación Electrónica/Tradicional:** Procesamiento de documentos legales y control de guías de remisión.
4.  **Finanzas:** Módulo de cuentas por cobrar, gestión de letras, cheques y estados de cuenta.
5.  **BI y Reportes:** Análisis estadísticos de ventas por vendedor, artículo y líneas de producto.

---

## 5. Modelo de Datos (Inferido)

### Tablas Maestras (Probables):
*   `clientes.dbf`: Datos demográficos y comerciales de clientes.
*   `productos.dbf` / `articulos.dbf`: Catálogo de mercadería y precios.
*   `vendedores.dbf`: Registro del equipo de ventas.

### Tablas Transaccionales:
*   `facturas.dbf`, `boletas.dbf`: Cabeceras de documentos de venta.
*   `kardex.dbf`: Movimientos históricos de inventario.
*   `cotizaciones.dbf`: Registro de ofertas comerciales.
*   `letras.dbf`, `cheques.dbf`: Títulos valores y créditos.

---

## 6. Integraciones y Seguridad
*   **Integraciones:**
    *   **Documental:** Exportación masiva a Excel y PDF.
    *   **Comunicación:** Envío automático de cotizaciones y alertas vía Gmail.
    *   **Visual:** Uso de Google Maps para ubicación de clientes o rutas.
    *   **Hardware:** Soporte para lectoras de códigos de barras y etiquetas de stickers.
*   **Seguridad:**
    *   Autenticación mediante formularios de login y cambio de contraseña.
    *   Módulo de auditoría para comparar ingresos vs. salidas de mercadería.

---

## 7. Análisis de Riesgos y Deuda Técnica
*   **Obsolescencia:** La plataforma Visual FoxPro está fuera de soporte oficial, lo que dificulta la integración con SO modernos a largo plazo.
*   **Hardcoding:** Se detectan rutas absolutas en scripts (`D:\GitHub\...`), lo que sugiere dependencia del entorno de desarrollo original.
*   **Acoplamiento:** La lógica de negocio suele estar embebida en los formularios (.SCT), dificultando las pruebas unitarias y la escalabilidad.
*   **Seguridad de Datos:** El uso de archivos .DBF nativos sin un motor SQL externo (como SQL Server) representa un riesgo de corrupción de datos en redes inestables.

---

## 8. Estrategia de Modernización Sugerida

Para garantizar la continuidad del negocio, se recomienda una migración gradual hacia una arquitectura de **Microservicios** o **Monolito Modular Moderno**:

1.  **Base de Datos:** Migrar los archivos .DBF a **PostgreSQL** o **SQL Server** para mejorar la integridad y seguridad.
2.  **Backend:** Implementar una API REST usando **Node.js** o **.NET 8** para centralizar la lógica de negocio.
3.  **Frontend:** Desarrollar una nueva interfaz web responsiva utilizando **React** o **Angular**, eliminando la dependencia de los formularios SCX.
4.  **Reportes:** Reemplazar FoxyPreviewer por herramientas como **Power BI** o **JasperReports** para análisis en tiempo real.

**Prioridad:** Alta. Los módulos de Almacén y Facturación son los candidatos críticos para iniciar la migración.
