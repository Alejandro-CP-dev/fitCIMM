# FitCIMM - Sistema de Gestion de Gimnasio

Aplicacion web para la administracion del gimnasio FitCIMM, ubicado en Paipa, Boyaca. Desarrollada como taller de repaso del programa Tecnologo en Analisis y Desarrollo de Software (ADSO), SENA, Centro CIMM.

Reemplaza el control que llevaba el gimnasio en cuaderno y en Excel. Permite registrar socios, vender planes de membresia y controlar el ingreso diario a las instalaciones.

## Descripcion

El sistema resuelve tres problemas del gimnasio:

- Saber si un socio tiene la membresia vigente antes de dejarlo entrar.
- Identificar cuando la membresia de un socio esta por vencer.
- Generar reportes de socios activos, recaudo por plan y ventas.

El proyecto sigue una arquitectura en capas: modelo, DAO, servicio, controlador y vista. Las reglas de negocio estan separadas del acceso a datos y de la presentacion.

## Tecnologias

- Java 11+
- Servlets (Jakarta EE) y JSP
- JDBC con PreparedStatement (sin ORM)
- MySQL (probado con XAMPP)
- Apache Maven
- Apache Tomcat 10
- Bootstrap 5.3, Bootstrap Icons
- SweetAlert2
- java.time para el manejo de fechas (LocalDate, LocalTime, ChronoUnit)

## Requisitos previos

- JDK 11 o superior
- Apache NetBeans (o cualquier IDE con soporte para proyectos Maven Web Application)
- XAMPP u otro servidor MySQL
- Apache Tomcat 10
- Conexion a internet (el frontend carga Bootstrap, Bootstrap Icons y SweetAlert2 desde CDN)

## Instalacion

### 1. Clonar el repositorio

git clone https://github.com/Alejandro-CP-dev/fitCIMM.git
cd FitCIMM

### 2. Levantar la base de datos

Inicia Apache y MySQL desde el panel de XAMPP. Luego, desde phpMyAdmin o por consola, ejecuta el script incluido:

mysql -u root -p < script.sql

Esto crea la base `fitcimm` con las 4 tablas (socio, plan, membresia, ingreso) y datos de prueba.

### 3. Configurar la conexion a la base de datos

Edita `src/main/resources/db.properties`:

properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/fitcimm?useSSL=false&serverTimezone=America/Bogota
db.user=root
db.password=

Con XAMPP, el usuario root normalmente no tiene contraseña.

### 4. Registrar Tomcat en NetBeans

Tools > Servers > Add Server > Apache Tomcat or TomEE, y selecciona la carpeta donde descomprimiste Tomcat. Luego asigna el servidor al proyecto en Properties > Run > Server.

### 5. Ejecutar

Clean and Build, luego Run. Abre el navegador en `http://localhost:8080/` (ajusta el puerto si es necesario).

## Estructura del proyecto

src/main/java/com/fitcimm/
  config/      Conexion.java
  model/       Socio, Plan, Membresia, Ingreso
  dao/         SocioDAO, PlanDAO, MembresiaDAO, IngresoDAO
  service/     SocioService, PlanService, MembresiaService, IngresoService
  controller/  SocioServlet, PlanServlet, MembresiaServlet, IngresoServlet

src/main/webapp/
  views/       vistas JSP de cada modulo
  index.jsp

script.sql       estructura de la base de datos y datos de prueba
consultas.sql    las 5 consultas requeridas por el taller

## Modulos

**Socios**: registro, edicion, busqueda por documento o apellido, borrado logico (inactivar/activar). No se elimina ningun socio fisicamente.

**Planes**: CRUD de planes de membresia (Dia, Mensual, Trimestral, Anual). Un plan con membresias asociadas no se puede eliminar, solo inactivar.

**Membresias**: venta con calculo automatico de la fecha de fin. Si el socio ya tiene una membresia vigente, la nueva se encadena a partir del vencimiento de la anterior en vez de bloquear la venta. El estado (vigente, por vencer, vencida) se calcula en el momento, no se guarda en la base de datos.

**Control de ingreso**: registro por numero de documento, valida el estado de la membresia y bloquea un segundo ingreso el mismo dia. Muestra el nombre del socio y los dias restantes de membresia. Incluye filtro por fecha para revisar ingresos de dias anteriores.

**Reportes**: socios activos con membresia vigente, total recaudado por plan en un rango de fechas, plan mas vendido del mes.

## Reglas de negocio y donde estan implementadas

| Regla | Descripcion | Ubicacion |
|---|---|---|
| RN-01 | Documento de socio unico | SocioService.registrarSocio() |
| RN-02 | Fecha de fin de membresia calculada, nunca digitada | MembresiaService.registrarVenta() |
| RN-03 | No se permiten membresias vigentes solapadas; la nueva inicia el dia siguiente al vencimiento de la anterior | MembresiaService.registrarVenta() |
| RN-04 | Estado de membresia calculado en el momento | MembresiaService.calcularEstado() |
| RN-05 | Socio vencido o inactivo no puede registrar ingreso | IngresoService.registrarAcceso() |
| RN-06 | Maximo un ingreso por socio por dia | IngresoDAO.yaIngresoHoy() y restriccion UNIQUE en la base de datos |
| RN-07 | Duracion del plan entre 1 y 365 dias, valor mayor que cero | PlanService |
| RN-08 | Plan con membresias asociadas no se elimina, solo se inactiva | PlanService |
| RN-09 | Socio debe ser mayor de 15 anos al registrarse | SocioService.registrarSocio() |
| RN-10 | Membresias e ingresos son historial inmutable, no se editan ni se eliminan | MembresiaDAO / IngresoDAO (sin metodos de UPDATE o DELETE para estas tablas) |

## Capturas de pantalla
<img width="1365" height="767" alt="Inicio" src="https://github.com/user-attachments/assets/ecf8b6d4-8a33-4279-b30e-b66ba293b194" />
<img width="1365" height="767" alt="Listado_Socios" src="https://github.com/user-attachments/assets/3cff077b-5a44-445f-9086-3bf7244070cc" />
<img width="1365" height="767" alt="Nuevo_Socio" src="https://github.com/user-attachments/assets/99d37fb1-6f22-4841-ad2e-e2192f031d0e" />
<img width="1365" height="767" alt="Listado_Planes" src="https://github.com/user-attachments/assets/3152a151-c4b8-42ba-b58c-bd12a560dfa8" />
<img width="1365" height="767" alt="Nuevo_Plan" src="https://github.com/user-attachments/assets/2684662f-42ff-49b1-ae07-fbbc50d9a921" />
<img width="1365" height="767" alt="Hitorial_Membresia" src="https://github.com/user-attachments/assets/b64503b8-2653-4489-bf8e-1285b1b0bf9a" />
<img width="1365" height="767" alt="Nueva_Membresia" src="https://github.com/user-attachments/assets/8d03d6c3-def2-48a5-b09e-93e50bb6fb6b" />
<img width="1365" height="767" alt="Control_Acceso" src="https://github.com/user-attachments/assets/8e74f375-fe82-4a83-9d00-5a25d088ef8d" />
<img width="1365" height="767" alt="Control_Acceso_2" src="https://github.com/user-attachments/assets/06110044-0ddd-465b-a37f-08227aa8131f" />
<img width="1365" height="767" alt="Reportes1" src="https://github.com/user-attachments/assets/b0c9e1a1-143e-44d4-b43f-592a9597d1e2" />
<img width="1365" height="767" alt="Reportes2" src="https://github.com/user-attachments/assets/ba9f6ff5-652c-4c19-b5e0-80f3f7cd8e38" />
