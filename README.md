# docker compose para instalación de SIU Toba

Genera un contenedor de PostgreSQL y PHP 8.1 con una [instalación de SIU Toba](https://github.com/SIU-Toba/framework)

# Uso

Clonar el proyecto y **renombrar .env.example como .env**

A tener en cuenta en el archivo **.env**:

# .env para configuraciones de SIU Toba

**PROYECTO_NOMBRE=gescom** Es el nombre del proyecto, los contenedores de PostgreSQL y PHP se generarán con _PROYECTO_NOMBRE-sistema_ y _PROYECTO_NOMBRE-postgres_

**WORKDIR=/data/local/sistema** Es el directorio de trabajo dentro del contenedor de PHP, donde se realizará la descarga e instalación de SIU Toba

**TOBA_USUARIO_ADMIN=toba** Es el nombre de usuario para loaguersa a toba_editor

**TOBA_PASS=toba123\*-a** Es la contraseña para loaguersa a toba_editor

**TOBA_NOMBRE_INSTALACION=toba3** Es el nombre de la instalación que solicita SIU Toba

**TOBA_BASE_NOMBRE=toba_3_3** Es el nombre de la base de datos que se creará en el momento de la instalación

**TOBA_BASE_HOST=postgres** Es el host de PostgreSQL linkeado al contenedor de PHP

**TOBA_ES_PRODUCCION=0** Se define si es una instalación de Producción o Desarrollo, siendo _0 - Desarrollo_ y _1 - Producción_

**TOBA_ID_DESARROLLADOR=75** Setea el ID de Desarrollador

**TOBA_BRANCH=v3.3.25** Es la versión de Toba a descargar del repositorio del [SIU](https://github.com/SIU-Toba/framework) (ver branch)

**AGREGAR_BOOTSTRAP=true** Agregar Bootstrap a la instalación de Toba

# .env para configuraciones de PostgreSQL

**POSTGRES_VERSION=14** Es la versión del PostgreSQL del contenedor

**TOBA_BASE_USER=postgres** Setea el usuario de PostgreSQL

**TOBA_BASE_PASS=postgres** Setea el password de PostgreSQL

**TOBA_BASE_PORT=5432** Setea el puerto _fuera del contenedor_ de PostgreSQL

# .env para configuraciones de Apache

**APACHE_PORT=8080** Setea el puerto _fuera del contenedor_ de Apache, que se utilizará en el navegador para poder navegar el proyecto

# .env para con configuraciones de zsh

**ZSH_SYNTAX_HIGHLIGHTING=true** Instala el [plugin syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

**ZSH_AUTOSUGGESTIONS=true** Instala el [plugin de autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

# Luego de clonar, renombrar .env.example como .env y editarlo

Ejecutar el siguiente comando, que realizará la descarga e instalación de SIU Toba

```bash
docker compose up -d
```

Para ingresar al contenedor (suponiendo que el PROYECTO_NOMBRE del .env sea gescom) se pueden utilizar:

```
docker exec -ti gescom-sistema bash
```

o con **zsh**

```
docker exec -ti gescom-sistema zsh
```

# Levantar entorno Toba

Habiendo ingresado al contenedor, en el WORKDIR:

```
. ./entorno_toba.env
```
