@echo off
echo 🚀 Starting Harmony Music deployment to Vercel...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutter is not installed. Please install Flutter first.
    pause
    exit /b 1
)

REM Check if Vercel CLI is installed
vercel --version >nul 2>&1
if errorlevel 1 (
    echo 📦 Installing Vercel CLI...
    npm install -g vercel
)

echo 🔧 Getting Flutter dependencies...
flutter pub get

echo 🏗️ Building Flutter web app...
flutter build web --release

if errorlevel 1 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo ✅ Build successful!
echo 🚀 Deploying to Vercel...
vercel --prod

pause
