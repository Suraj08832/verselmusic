# Fix Repository Configuration Issue - Vercel

## 🚨 Problem
Vercel is trying to build from `github.com/Suraj08832/verselmusic` instead of your Harmony Music project.

## 🔧 Solution Steps

### Step 1: Check Current Vercel Project
```bash
# Check if you're in the right project
vercel ls

# Check current project settings
vercel project ls
```

### Step 2: Link to Correct Repository
```bash
# Remove current link (if any)
vercel unlink

# Link to your correct repository
vercel link
```

### Step 3: Configure Project Settings
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Find your project
3. Go to Settings → Git
4. Update the repository URL to your correct GitHub repository
5. Set the correct branch (main/master)

### Step 4: Manual Deployment
```bash
# Build locally first
flutter clean
flutter pub get
flutter build web --release --web-renderer html

# Deploy to Vercel
vercel --prod
```

## 🛠️ Alternative: Create New Project

If the above doesn't work, create a new Vercel project:

### Method 1: Via Vercel Dashboard
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your GitHub repository
4. Configure build settings:
   - Framework Preset: Other
   - Build Command: `flutter build web --release --web-renderer html`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

### Method 2: Via CLI
```bash
# Create new project
vercel

# Follow the prompts:
# - Link to existing project: No
# - Project name: harmony-music
# - Directory: ./
# - Override settings: Yes
# - Build Command: flutter build web --release --web-renderer html
# - Output Directory: build/web
# - Install Command: flutter pub get
```

## 📋 Correct Configuration

Make sure your `vercel.json` looks like this:
```json
{
  "version": 2,
  "buildCommand": "flutter build web --release --web-renderer html",
  "outputDirectory": "build/web",
  "installCommand": "flutter pub get",
  "framework": null,
  "functions": {},
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

## 🔍 Verify Setup

### Check Repository Link
```bash
# Verify the linked repository
vercel project ls
```

### Test Local Build
```bash
# Test if build works locally
flutter build web --release --web-renderer html
ls build/web/
```

### Deploy Test
```bash
# Deploy to test environment first
vercel

# If successful, deploy to production
vercel --prod
```

## 🆘 Still Having Issues?

1. **Check GitHub Repository**:
   - Make sure your repository is public or Vercel has access
   - Verify the repository URL is correct

2. **Check Vercel Permissions**:
   - Go to Vercel Dashboard → Settings → Git
   - Ensure Vercel has access to your repository

3. **Clear Vercel Cache**:
   ```bash
   vercel --clear-cache
   ```

4. **Check Build Logs**:
   - Go to Vercel Dashboard
   - Click on your project
   - Check "Deployments" tab
   - View build logs for errors

## 📝 Important Notes

- Make sure your GitHub repository contains the Flutter project
- The repository should have the `vercel.json` file in the root
- Ensure Flutter web is enabled: `flutter config --enable-web`
- The build command should match your Flutter version

## 🚀 Quick Fix Commands

```bash
# Complete reset and redeploy
vercel unlink
vercel link
flutter clean
flutter pub get
flutter build web --release --web-renderer html
vercel --prod
```
