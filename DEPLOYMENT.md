# Vercel Deployment Guide for Harmony Music

This guide will help you deploy your Harmony Music Flutter app to Vercel for web access.

## Prerequisites

1. **Flutter SDK**: Make sure you have Flutter installed and configured
2. **Node.js**: Required for Vercel CLI
3. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
4. **GitHub Repository**: Your project should be on GitHub

## Quick Deployment

### Option 1: Using Deployment Scripts

#### For Windows:
```bash
deploy.bat
```

#### For Linux/Mac:
```bash
chmod +x deploy.sh
./deploy.sh
```

### Option 2: Manual Deployment

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Build Flutter Web App**:
   ```bash
   flutter pub get
   flutter build web --release
   ```

3. **Deploy to Vercel**:
   ```bash
   vercel --prod
   ```

## Automated Deployment (GitHub Actions)

### Step 1: Get Vercel Credentials

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Navigate to Settings → Tokens
3. Create a new token
4. Note down your:
   - **Vercel Token**
   - **Organization ID** (from Settings → General)
   - **Project ID** (after first deployment)

### Step 2: Set GitHub Secrets

1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Add the following secrets:
   - `VERCEL_TOKEN`: Your Vercel API token
   - `ORG_ID`: Your Vercel organization ID
   - `PROJECT_ID`: Your Vercel project ID

### Step 3: Deploy

Push your code to the `main` or `master` branch. The GitHub Action will automatically:
1. Build your Flutter web app
2. Deploy to Vercel
3. Provide you with a live URL

## Configuration Files

### vercel.json
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
  "outputDirectory": "build/web",
  "buildCommand": "flutter build web --release",
  "installCommand": "flutter pub get"
}
```

### .vercelignore
Excludes unnecessary files from deployment to reduce build time and size.

## Troubleshooting

### Common Issues

1. **Build Fails**:
   - Ensure Flutter is properly installed
   - Run `flutter doctor` to check for issues
   - Make sure all dependencies are compatible

2. **Deployment Fails**:
   - Check Vercel logs in the dashboard
   - Verify your Vercel credentials
   - Ensure your GitHub secrets are correctly set

3. **App Not Loading**:
   - Check browser console for errors
   - Verify the build output in `build/web/`
   - Check Vercel deployment logs

### Performance Optimization

1. **Enable Compression**:
   - Vercel automatically compresses static assets
   - Consider using `flutter build web --release --web-renderer html`

2. **Caching**:
   - Static assets are cached by Vercel's CDN
   - Update your app version in `pubspec.yaml` for cache busting

## Environment Variables

If your app needs environment variables, add them in Vercel dashboard:
1. Go to your project settings
2. Navigate to Environment Variables
3. Add your variables

## Custom Domain

To use a custom domain:
1. Go to Vercel dashboard
2. Navigate to Settings → Domains
3. Add your domain and follow the DNS configuration

## Support

For issues related to:
- **Flutter**: Check [Flutter documentation](https://docs.flutter.dev/)
- **Vercel**: Check [Vercel documentation](https://vercel.com/docs)
- **This Project**: Open an issue on GitHub

## Notes

- The web version may have some limitations compared to native apps
- Audio playback might be restricted by browser policies
- Some platform-specific features may not work in web browsers
