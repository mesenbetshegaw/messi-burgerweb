#!/bin/bash

# Ethiopian Burger Website Deployment Script
echo "🚀 Deploying Messi Burger Website..."

# Check for required environment variables
if [ -z "$DB_PASSWORD" ]; then
    echo "❌ ERROR: DB_PASSWORD environment variable is required!"
    exit 1
fi

if [ -z "$JWT_SECRET" ]; then
    echo "❌ ERROR: JWT_SECRET environment variable is required!"
    exit 1
fi

# Create actual config file from template
echo "🔧 Creating configuration files..."
cp src/main/resources/application.yml.example src/main/resources/application.yml

# Replace placeholders with environment variables
sed -i "s/YOUR_DB_PASSWORD_HERE/$DB_PASSWORD/g" src/main/resources/application.yml
sed -i "s/YOUR_JWT_SECRET_KEY_MIN_32_CHARS_HERE/$JWT_SECRET/g" src/main/resources/application.yml

# Build and deploy
echo "🔨 Building project..."
cd backend
mvn clean package -DskipTests

echo "✅ Deployment ready!"
echo "📦 JAR file: target/*.jar"
echo "🌐 Run with: java -jar target/*.jar"
