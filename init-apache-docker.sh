#!/bin/bash

echo "📦 Accediendo al proyecto Apache Docker..."
cd "$(dirname "$0")" || exit 1

echo "🔄 Deteniendo contenedor anterior (si existe)..."
docker compose down

echo "🧹 Limpiando contenedores detenidos y red huérfana..."
docker system prune -f > /dev/null

echo "🚀 Levantando contenedor Apache con Docker Compose..."
docker compose up -d --build

echo "⏳ Esperando unos segundos para que el contenedor se inicie..."
sleep 5

# Activar vhost dentro del contenedor
echo "🔧 Activando virtualhost en el contenedor..."
docker exec apache-dev-php74 bash -c "a2ensite 000-default.conf && apachectl restart"

echo "✅ Contenedor Apache iniciado correctamente."
echo "🌐 Accede desde tu navegador a:"
echo "   👉 http://localhost:8081/api"
echo "   👉 http://localhost:8081/back"
