# Fix 404 Error - Vercel Deployment

## 🚨 Problem
Getting 404 NOT_FOUND error when deploying to Vercel.

## 🔧 Multiple Solutions

### Solution 1: Use Local Build + Deploy
```bash
# Run the local build script
deploy-local.bat
```

### Solution 2: Manual Local Build + Deploy
```bash
# 1. Build locally
flutter clean
flutter pub get
flutter build web --release --web-renderer html

# 2. Test locally
cd build/web
python -m http.server 8000
# Open http://localhost:8000 in browser

# 3. Deploy to Vercel
vercel --prod
```

### Solution 3: Fix Vercel Configuration
Make sure your `vercel.json` looks like this:
```json
{
  "version": 2,
  "builds": [
    {
      "src": "build/web/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/build/web/index.html"
    }
  ],
  "buildCommand": "flutter build web --release --web-renderer html",
  "outputDirectory": "build/web",
  "installCommand": "flutter pub get"
}
```

### Solution 4: Create New Vercel Project
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your GitHub repository
4. Configure manually:
   - Framework Preset: Other
   - Build Command: `flutter build web --release --web-renderer html`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

## 🔍 Debugging Steps

### Step 1: Check Local Build
```bash
# Verify build works locally
flutter build web --release --web-renderer html
ls build/web/
# Should show: index.html, main.dart.js, assets/, etc.
```

### Step 2: Test Local Build
```bash
# Test the build locally
cd build/web
python -m http.server 8000
# Open http://localhost:8000 in browser
```

### Step 3: Check Vercel Build Logs
1. Go to Vercel Dashboard
2. Click on your project
3. Go to "Deployments"
4. Click on latest deployment
5. Check "Build Logs"

### Step 4: Verify Repository Link
```bash
# Check if linked to correct repository
vercel ls
vercel project ls
```

## 🛠️ Alternative Configurations

### Configuration A: Simple Static
```json
{
  "version": 2,
  "builds": [
    {
      "src": "build/web/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/build/web/index.html"
    }
  ]
}
```

### Configuration B: With Build Commands
```json
{
  "version": 2,
  "buildCommand": "flutter build web --release --web-renderer html",
  "outputDirectory": "build/web",
  "installCommand": "flutter pub get",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### Configuration C: Minimal
```json
{
  "version": 2,
  "buildCommand": "flutter build web --release",
  "outputDirectory": "build/web"
}
```

## 🚀 Quick Fix Commands

### Complete Reset
```bash
# 1. Unlink and relink
vercel unlink
vercel link

# 2. Clean and build
flutter clean
flutter pub get
flutter build web --release --web-renderer html

# 3. Deploy
vercel --prod
```

### Force Deploy
```bash
# Force deploy with local build
flutter build web --release --web-renderer html
vercel --prod --force
```

## 📋 Pre-Deployment Checklist

- [ ] Flutter web is enabled: `flutter config --enable-web`
- [ ] Flutter is up to date: `flutter upgrade`
- [ ] Dependencies are installed: `flutter pub get`
- [ ] Build works locally: `flutter run -d chrome`
- [ ] Build output exists: `ls build/web/`
- [ ] Local build works: `cd build/web && python -m http.server 8000`
- [ ] Vercel CLI is installed: `vercel --version`
- [ ] Repository is linked correctly: `vercel ls`

## 🆘 Still Getting 404?

### Try These Steps:

1. **Check Flutter Doctor**:
   ```bash
   flutter doctor -v
   ```

2. **Try Different Web Renderer**:
   ```bash
   flutter build web --release --web-renderer canvaskit
   ```

3. **Check Browser Console**:
   - Open deployed site
   - Press F12 to open developer tools
   - Check Console tab for errors

4. **Clear Vercel Cache**:
   ```bash
   vercel --clear-cache
   ```

5. **Create New Project**:
   - Delete current Vercel project
   - Create new project from scratch
   - Import your repository

## 📝 Important Notes

- The web version uses HTML renderer for better compatibility
- Some native features may not work in web browsers
- Audio playback might be restricted by browser policies
- Always test locally before deploying
- Make sure build output is not empty before deploying
- The `builds` configuration in `vercel.json` is important for static files

## 🎯 Recommended Approach

1. **Use `deploy-local.bat`** - This builds locally and deploys the built files
2. **Test locally first** - Make sure the build works on your machine
3. **Check build logs** - Look for any errors in Vercel build logs
4. **Verify repository link** - Make sure Vercel is linked to the correct repository
