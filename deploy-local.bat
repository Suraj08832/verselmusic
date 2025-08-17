@echo off
echo ========================================
echo Harmony Music - Local Build + Vercel Deploy
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
echo Step 4: Enabling Flutter web...
flutter config --enable-web
echo ✅ Flutter web enabled

echo.
echo Step 5: Cleaning previous builds...
flutter clean
echo ✅ Clean completed

echo.
echo Step 6: Getting Flutter dependencies...
flutter pub get
if errorlevel 1 (
    echo ❌ Failed to get dependencies
    pause
    exit /b 1
)
echo ✅ Dependencies installed

echo.
echo Step 7: Building Flutter web app locally...
flutter build web --release --web-renderer html
if errorlevel 1 (
    echo ❌ Build failed
    pause
    exit /b 1
)
echo ✅ Build successful

echo.
echo Step 8: Checking build output...
if not exist "build\web\index.html" (
    echo ❌ Build output not found
    echo Expected: build\web\index.html
    pause
    exit /b 1
)
echo ✅ Build output verified

echo.
echo Step 9: Listing build files...
dir build\web
echo ✅ Build files listed

echo.
echo Step 10: Testing local build...
echo Starting local server to test build...
start /B python -m http.server 8000 --directory build\web
timeout /t 3 /nobreak >nul
echo ✅ Local test server started at http://localhost:8000

echo.
echo Step 11: Deploying to Vercel...
echo This will deploy the locally built files
vercel --prod

echo.
echo Step 12: Stopping local server...
taskkill /f /im python.exe >nul 2>&1
echo ✅ Local server stopped

echo.
echo ========================================
echo Deployment completed!
echo ========================================
pause
