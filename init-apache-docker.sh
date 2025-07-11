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

echo "✅ Contenedor Apache iniciado correctamente."
echo "🌐 Si configuraste project1.local, visita: http://project1.local:8080"
