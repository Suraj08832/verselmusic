#!/bin/bash

echo "🚀 Starting Harmony Music deployment to Vercel..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
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
flutter build web --release

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "🚀 Deploying to Vercel..."
    vercel --prod
else
    echo "❌ Build failed!"
    exit 1
fi
