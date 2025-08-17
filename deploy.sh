#!/bin/bash

echo "🚀 Starting Harmony Music deployment to Vercel..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

echo "🔧 Getting Flutter dependencies..."
flutter pub get

echo "🏗️ Building Flutter web app..."
flutter build web --release --web-renderer html

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "🚀 Deploying to Vercel..."
    
    # Deploy to Vercel with proper configuration
    vercel --prod --yes
else
    echo "❌ Build failed!"
    exit 1
fi
