# Proyecto SSU - Auth

Este repositorio contiene la configuración y despliegue de **Keycloak**, el servidor de identidad y gestión de accesos utilizado en el **Sistema de Segmentación de Usuarios (SSU)** de **La Banca**.  
Su objetivo es administrar la autenticación, autorización, usuarios y roles de la aplicación, garantizando la seguridad y el control de accesos en todos los módulos del sistema.

## Funcionalidad

- Gestión centralizada de **usuarios** (altas, bajas, modificaciones).
- Administración de **roles** y **permisos** acorde a los módulos del SSU (Segmentación, Notificaciones, Automatización, Análisis y Reportes, Seguridad y Roles).
- Implementación de **OpenID Connect** y **OAuth2** para el frontend (Angular 19) y backend (Quarkus con Java 21).
- Integración con **PostgreSQL/DB2** como base de datos para la persistencia de Keycloak.
- Despliegue en **contenedores Docker** y orquestación con **Kubernetes (AKS en Azure)**.

## Tecnologías

- [Keycloak](https://www.keycloak.org/) – Servidor de autenticación/autorización.  
- [Docker](https://www.docker.com/) – Contenerización.  
- [Kubernetes](https://kubernetes.io/) – Orquestación en AKS (Azure).  
- [PostgreSQL](https://www.postgresql.org/) o [IBM Db2](https://www.ibm.com/db2) – Base de datos de Keycloak.  

## Requisitos Previos

- Docker y Docker Compose instalados.  
- Acceso a una base de datos PostgreSQL o DB2 configurada.  
- Variables de entorno definidas para conexión a BD y parámetros de Keycloak.  

Ejemplo de variables (archivo `.env`):

```env
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin
DB_VENDOR=postgres
DB_ADDR=ssu-postgres
DB_DATABASE=keycloak
DB_USER=keycloak
DB_PASSWORD=keycloak123
```


## Ejecución Local

```bash
docker-compose up -d
```

El servicio quedará disponible en:  
 [http://localhost:8081](http://localhost:8081)

Credenciales iniciales: `admin / admin` (definidas en `.env`).

## Uso de Keycloak

1. Acceder al panel de administración en:  
   [http://localhost:8081/admin](http://localhost:8081/admin)

2. Ingresar con las credenciales de administrador configuradas (`KEYCLOAK_ADMIN` y `KEYCLOAK_ADMIN_PASSWORD`).

3. Crear un **Realm** específico para el proyecto SSU (ejemplo: `ssu-realm`).

4. Dentro del Realm, configurar:  
   - **Clientes** → Registrar el frontend (Angular) y backend (Quarkus) para la autenticación vía OIDC.  
   - **Usuarios** → Crear cuentas de usuario y asignar contraseñas.  
   - **Roles** → Definir roles como `admin`, `analyst`, `viewer`.  
   - **Grupos** → Organizar usuarios con roles predefinidos.

5. Integrar con las aplicaciones:  
   - En el **frontend Angular 19** se utiliza `keycloak-angular` para manejar login/logout y tokens.  
   - En el **backend Quarkus** se configura la extensión `quarkus-oidc` para validar los tokens de Keycloak.

6. Personalizar temas y páginas de login en Keycloak para adaptarse a la identidad visual del SSU.
7. Configurar flujos de autenticación, políticas de contraseñas y seguridad adicional según las necesidades del proyecto:
   - Habilitar en Realm las opciones de 'Resetear Contraseña', 'Registrarse' y 'Recordarme'.
8. Ingresar email en el FROM de los correos enviados por Keycloak (recuperación de contraseña, verificación de email, etc.).
   - En caso de no tener un servidor SMTP, se puede utilizar uno local:
     ```bash
        # 1) Red dedicada (una sola vez)
        docker network create ssu-net

        # 2) Mailpit en esa red
        docker run -d --name mailpit --network ssu-net \
          -p 8025:8025 -p 1025:1025 axllent/mailpit

        # 3) Conecta tu Keycloak existente a la red (no hace falta recrearlo)
        docker network connect ssu-net keycloak

        # 4) (Opcional) reiniciar Keycloak
        docker restart keycloak
     ```
   - En Keycloak poné: Host=mailpit, Port=1025, Auth=No, SSL/StartTLS=No, From cualquiera (p. ej. no-reply@ssu.local). Los mails se ven en http://localhost:8025

## Despliegue en Azure

> **Nota:** El proyecto se despliega en **Azure Kubernetes Service (AKS)** junto con los demás módulos del SSU.  

Ejemplo de integración en `kubernetes/keycloak-deployment.yml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: keycloak
  namespace: ssu-auth
spec:
  replicas: 1
  selector:
    matchLabels:
      app: keycloak
  template:
    metadata:
      labels:
        app: keycloak
    spec:
      containers:
        - name: keycloak
          image: quay.io/keycloak/keycloak:24.0
          args: ["start"]
          envFrom:
            - secretRef:
                name: keycloak-secrets
          ports:
            - containerPort: 8080
```

## Roles y Seguridad en el SSU

Keycloak administra roles a nivel de **aplicación** y **realm** para cubrir los distintos perfiles:  

- **Administrador** → Gestión completa de usuarios, roles y configuración.  
- **Analista** → Acceso a generación de reportes y análisis de datos.  
- **Visualización** → Acceso limitado a dashboards y vistas.  

## Documentación Adicional

- [Guía de Keycloak Angular 19](https://github.com/mauriciovigolo/keycloak-angular)  
- [Documentación oficial Keycloak](https://www.keycloak.org/documentation)  

## Equipo

Proyecto desarrollado por el equipo de Ingeniería de Software de la **Universidad Católica del Uruguay (UCU)** en conjunto con **La Banca**.
