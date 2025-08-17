@echo off
echo ========================================
echo Fixing Vercel Repository Configuration
echo ========================================

echo.
echo Step 1: Checking current Vercel project...
vercel ls

echo.
echo Step 2: Unlinking current project...
vercel unlink

echo.
echo Step 3: Linking to correct repository...
vercel link

echo.
echo Step 4: Building Flutter app...
flutter clean
flutter pub get
flutter build web --release --web-renderer html

if errorlevel 1 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo.
echo Step 5: Deploying to Vercel...
vercel --prod

echo.
echo ========================================
echo Repository fix completed!
echo ========================================
pause
