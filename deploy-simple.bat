@echo off
echo ========================================
echo Harmony Music - Vercel Deployment
echo ========================================

echo.
echo Step 1: Checking Flutter installation...
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutter is not installed or not in PATH
    echo Please install Flutter from: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)
echo ✅ Flutter found

echo.
echo Step 2: Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed
    echo Please install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)
echo ✅ Node.js found

echo.
echo Step 3: Installing/Updating Vercel CLI...
npm install -g vercel
echo ✅ Vercel CLI ready

echo.
echo Step 4: Getting Flutter dependencies...
flutter pub get
if errorlevel 1 (
    echo ❌ Failed to get dependencies
    pause
    exit /b 1
)
echo ✅ Dependencies installed

echo.
echo Step 5: Building Flutter web app...
flutter build web --release --web-renderer html
if errorlevel 1 (
    echo ❌ Build failed
    pause
    exit /b 1
)
echo ✅ Build successful

echo.
echo Step 6: Checking build output...
if not exist "build\web\index.html" (
    echo ❌ Build output not found
    echo Expected: build\web\index.html
    pause
    exit /b 1
)
echo ✅ Build output verified

echo.
echo Step 7: Deploying to Vercel...
echo This will open Vercel in your browser for configuration
vercel --prod

echo.
echo ========================================
echo Deployment completed!
echo ========================================
pause
