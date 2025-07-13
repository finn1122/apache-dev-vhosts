# 🐳 Apache + PHP 7.4 + Laravel en Docker

Este entorno de desarrollo contiene una imagen personalizada de Apache con PHP 7.4 configurado para trabajar con múltiples proyectos Laravel mediante VirtualHosts. Está preparado para conectarse a otros contenedores como MySQL en red compartida (`devnet`).

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

El archivo `000-default.conf` define dos alias accesibles desde el navegador:

- `/api` → `www/api/public` (Laravel)
- `/back` → `www/back` (backend personalizado)

### VirtualHost de ejemplo:

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

## 🧩 Software instalado en la imagen

- PHP 7.4 con extensiones:
  - `mysqli`, `pdo`, `pdo_mysql`
- Apache con `mod_rewrite` activado
- Herramienta de red:
  - `ping` (`iputils-ping`) para diagnosticar conectividad entre contenedores

---

## 🔌 Conexión a MySQL (red `devnet`)

Este contenedor está pensado para conectarse con un contenedor `mysql-dev` en red compartida `devnet`.

### Variables recomendadas en `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=mysql-dev
DB_PORT=3306
DB_DATABASE=api
DB_USERNAME=devuser
DB_PASSWORD=Devpass123!
```

Verifica la conexión con un script PHP:

```php
$mysqli = new mysqli('mysql-dev', 'devuser', 'Devpass123!', 'api', 3306);
if ($mysqli->connect_error) {
    die("❌ Error de conexión: " . $mysqli->connect_error);
}
echo "✅ Conectado a MySQL correctamente.";
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

```bash
docker system prune -f
```

---

## 🧠 Notas adicionales

- Asegúrate de que `www/api/public/index.php` exista y sea accesible.
- Para Laravel:
  - Configura el archivo `.env`
  - Da permisos a `storage/` y `bootstrap/cache/`
  - Ejecuta `composer install`
