# Mister Pizza Web

Sistema integral de gestión de e-commerce y operaciones Kanban para pizzerías.

## Descripción
Mister Pizza Web es una aplicación web empresarial desarrollada en Java EE (Servlets/JSP) que permite a los clientes realizar pedidos personalizados y al personal gestionar la producción mediante un tablero Kanban en tiempo real.

## Requisitos de Entorno
* **Java:** JDK 11 o superior.
* **Servidor:** Apache Tomcat 10+.
* **Base de Datos:** PostgreSQL 14+.
* **Gestor de dependencias:** Maven (opcional) o librerías manuales (.jar).

## Instalación y Configuración

1. **Base de Datos:**
   - Crea una base de datos en PostgreSQL llamada `mister_pizza`.
   - Ejecuta el script SQL incluido en el archivo `/database/schema.sql` para crear las tablas.

2. **Configuración del Proyecto:**
   - Clona este repositorio: `git clone https://github.com/1crisjedday-lab/MisterPizzaWeb.git`
   - Abre el proyecto en NetBeans o tu IDE de preferencia.
   - Asegúrate de agregar el Driver JDBC de PostgreSQL a las librerías del proyecto.
   - En la clase `config.Conexion.java`, ajusta las credenciales de tu base de datos (usuario y contraseña).

3. **Despliegue:**
   - Genera el archivo `.war` desde tu IDE.
   - Despliega el archivo en la carpeta `webapps` de tu servidor Apache Tomcat.
   - Inicia Tomcat y accede desde el navegador a `http://localhost:8080/MisterPizzaWeb`.

## Funcionalidades Principales
* **Catálogo Dinámico:** Gestión administrativa con persistencia de imágenes.
* **Personalización de Pedidos:** Algoritmo de personalización de ingredientes y precios en tiempo real.
* **Kanban de Cocina:** Panel con auto-refresco (10s) para seguimiento de estados: Pendiente, Cocinando, En Camino.
* **Dashboard Administrativo:** Métricas financieras acumuladas.

## Licencia
Este proyecto está bajo la licencia **MIT**. Consulta el archivo `LICENSE.txt` para más detalles.

## Soporte
Si tienes dudas, contacta al desarrollador: Cristhian Deyson Cahuana Chambi (1crisjedday@gmail.com)