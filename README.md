# Apache Dockerizado con Virtual Hosts

Este proyecto contiene una imagen personalizada de Apache + PHP 8.2 usando tu configuración original extraída desde `/etc/apache2` y tu backup de sitios en `/var/www`.

## 📁 Estructura

```
apache-docker-vhosts/
├── Dockerfile
├── docker-compose.yml
├── init-apache-docker.sh
├── conf/                    # Configuración personalizada de Apache
│   ├── apache2.conf
│   ├── ports.conf
│   ├── envvars
│   ├── magic
│   ├── conf-available/
│   ├── mods-available/
│   ├── sites-available/
│   └── sites-enabled/
├── www/                     # Contenido de tus sitios web (document root)
```

## 🚀 Instrucciones

1. Asegúrate de tener Docker y Docker Compose instalados.
2. Coloca los archivos de tus sitios dentro de `www/`
3. Levanta el contenedor:

```bash
./init-apache-docker.sh
```

## 🌐 Acceso

Ejemplo si tienes un virtual host `project1.local`:

```
http://project1.local:8080
```

Recuerda editar tu `/etc/hosts` en el sistema anfitrión si lo necesitas:

```
127.0.0.1  project1.local
```

# ejemplo 127.0.0.1 project1.local travele.local bakery.local api.local


## 🛠️ Personalización

Puedes modificar cualquier archivo de configuración dentro de `conf/` y reiniciar el contenedor para aplicar los cambios.



---

## 🧭 Configurar dominios locales (`/etc/hosts`)

Para que puedas acceder a tus sitios virtuales por nombres como `project1.local`, necesitas agregar esos dominios a tu archivo de hosts del sistema operativo anfitrión.

### ✏️ Edita el archivo `/etc/hosts`

```bash
sudo nano /etc/hosts
```

Agrega esta línea (y tantos dominios como necesites):

```
127.0.0.1  project1.local travele.local back.local bakery.local
```

Guarda y cierra. Luego puedes acceder a tus sitios por ejemplo en:

- `http://project1.local:8080`
- `http://travele.local:8080`
- `http://bakery.local:8080`

