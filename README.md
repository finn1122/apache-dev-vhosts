# 🐳 Apache + PHP 7.4 + Laravel en Docker

Este entorno de desarrollo contiene una imagen personalizada de Apache con PHP 7.4 configurado para trabajar con múltiples proyectos Laravel mediante VirtualHosts. El archivo `000-default.conf` se copia y activa automáticamente al construir la imagen.

---

## 📁 Estructura del proyecto

```
project-root/
├── Dockerfile
├── docker-compose.yml
├── conf/
│   └── sites-available/
│       └── 000-default.conf
├── www/
│   ├── api/         # Proyecto Laravel
│   │   └── public/
│   └── back/        # Otro proyecto o backoffice
```

---

## ⚙️ Configuración de Apache

El archivo de configuración `000-default.conf` define dos alias accesibles desde el navegador:

- `/api` → `www/api/public` (Laravel)
- `/back` → `www/back`

Ejemplo de VirtualHost:

```apache
<VirtualHost *:80>
    ServerName localhost

    Alias /api /www/api/public
    Alias /back /www/back

    <Directory /www/api/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /www/back>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

---

## 🚀 Comandos de uso

### 1. Construir y levantar el contenedor:

```bash
docker compose up -d --build
```

### 2. Detener el contenedor:

```bash
docker compose down
```

---

## 🌐 Acceso en el navegador

- Laravel: [http://localhost:8081/api](http://localhost:8081/api)
- Backoffice: [http://localhost:8081/back](http://localhost:8081/back)

---

## 🧼 Limpieza (opcional)

Si quieres eliminar contenedores detenidos y volúmenes huérfanos:

```bash
docker system prune -f
```

---

## 🧠 Notas adicionales

- Asegúrate de que `www/api/public/index.php` exista y sea accesible.
- Si usas Laravel, recuerda configurar `.env`, permisos en `storage/` y correr `composer install`.
