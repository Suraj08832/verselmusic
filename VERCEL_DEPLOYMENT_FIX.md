# Fixing Vercel 404 Error for Harmony Music

If you're getting a 404 error when deploying to Vercel, follow these steps:

## Quick Fix Steps

### 1. Install Prerequisites
```bash
# Install Node.js (if not already installed)
# Download from: https://nodejs.org/

# Install Vercel CLI
npm install -g vercel
```

### 2. Build and Deploy
```bash
# Get dependencies
flutter pub get

# Build for web
flutter build web --release --web-renderer html

# Deploy to Vercel
vercel --prod
```

## Alternative: Use Deployment Scripts

### Windows:
```bash
deploy.bat
```

### Linux/Mac:
```bash
chmod +x deploy.sh
./deploy.sh
```

## Manual Deployment Steps

1. **Open Terminal/Command Prompt**
2. **Navigate to your project directory**
3. **Run these commands**:
   ```bash
   flutter pub get
   flutter build web --release --web-renderer html
   vercel --prod
   ```

## If Still Getting 404 Error

### Check these things:

1. **Verify Flutter Web Support**:
   ```bash
   flutter config --enable-web
   flutter doctor
   ```

2. **Check Build Output**:
   ```bash
   # After building, check if files exist
   ls build/web/
   # Should show: index.html, main.dart.js, etc.
   ```

3. **Test Locally First**:
   ```bash
   flutter run -d chrome
   # Make sure the app works locally
   ```

4. **Clear Vercel Cache**:
   ```bash
   vercel --clear-cache
   vercel --prod
   ```

## Common Issues and Solutions

### Issue: "flutter: command not found"
**Solution**: Install Flutter and add to PATH

### Issue: "vercel: command not found"
**Solution**: Install Vercel CLI with `npm install -g vercel`

### Issue: Build fails
**Solution**: 
- Check Flutter version: `flutter --version`
- Update Flutter: `flutter upgrade`
- Check dependencies: `flutter pub outdated`

### Issue: App loads but shows blank page
**Solution**: 
- Check browser console for errors
- Try different web renderer: `flutter build web --release --web-renderer canvaskit`

## Vercel Configuration

The updated `vercel.json` now includes:
- Proper build commands
- Correct routing for SPA
- Security headers
- Caching configuration

## Support

If you're still having issues:
1. Check Vercel deployment logs in dashboard
2. Verify your Flutter web build works locally
3. Make sure all dependencies are compatible with web

## Notes

- The web version uses HTML renderer for better compatibility
- Some native features may not work in web browsers
- Audio playback might be restricted by browser policies
