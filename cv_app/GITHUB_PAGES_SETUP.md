# GitHub Pages Deployment Guide

This CV application is ready to be deployed to GitHub Pages. Follow these steps to get your site live.

## Prerequisites

- A GitHub account
- Git installed on your computer
- The CV application code

## Step 1: Create a GitHub Repository

1. Go to [GitHub](https://github.com/new) and create a new repository
2. Name it `{your-username}.github.io` (for a user/organization site) or `{repository-name}` (for a project site)
3. Initialize it with a README (optional)
4. Copy the repository URL

## Step 2: Build the Application

Run the build command to generate the static files:

```bash
pnpm build
```

This will create a `dist/public` directory containing all the static files needed for deployment.

## Step 3: Deploy to GitHub Pages

### Option A: Using GitHub CLI (Recommended)

```bash
# Initialize git if not already done
git init

# Add the remote repository
git remote add origin https://github.com/{your-username}/{repository-name}.git

# Add all files
git add .

# Commit the changes
git commit -m "Initial commit: CV application"

# Push to GitHub
git push -u origin main

# Enable GitHub Pages in repository settings
# Go to Settings > Pages > Source > Deploy from a branch
# Select 'main' branch and '/root' folder (or '/docs' if you prefer)
```

### Option B: Manual Upload

1. Build the application: `pnpm build`
2. Go to your GitHub repository
3. Click "Add file" > "Upload files"
4. Drag and drop the contents of `dist/public` folder
5. Commit the changes

## Step 4: Configure GitHub Pages

1. Go to your repository settings
2. Navigate to "Pages" section
3. Under "Build and deployment", select:
   - Source: Deploy from a branch
   - Branch: main (or your preferred branch)
   - Folder: / (root) or /docs if you moved files there

4. Click "Save"

## Step 5: Access Your Site

Your site will be available at:
- `https://{your-username}.github.io` (if using `{username}.github.io` repository)
- `https://{your-username}.github.io/{repository-name}` (if using a project repository)

## Updating Your Site

To update your CV with new content:

1. Edit the files in the `client/src` directory
2. Run `pnpm build` to generate new static files
3. Commit and push the changes to GitHub
4. GitHub Pages will automatically rebuild and deploy

## Customization Tips

### Update Personal Information

Edit `client/src/pages/Home.tsx` and update:
- Your name
- Professional title
- Bio and description
- Contact information
- Education details
- Experience entries
- Skills
- Projects

### Change Colors and Fonts

The design system is defined in `client/src/index.css`. You can customize:
- Color palette (currently using teal accents on deep charcoal)
- Typography (currently using IBM Plex fonts)
- Spacing and sizing

### Add Your Profile Picture

Replace the profile image URL in the hero section with your own image URL or upload an image to your repository.

### Add Social Links

Update the social media links in the navigation and footer sections to point to your actual profiles.

## Troubleshooting

### Site not showing up

- Wait 5-10 minutes after pushing to GitHub
- Check that GitHub Pages is enabled in repository settings
- Verify the branch and folder settings are correct

### Styles not loading

- Make sure you ran `pnpm build` before pushing
- Check that all files in `dist/public` were pushed to GitHub
- Clear your browser cache (Ctrl+Shift+Delete)

### Images not displaying

- Use absolute URLs for external images (from Unsplash, etc.)
- Or upload images to your repository and reference them with relative paths

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [React Documentation](https://react.dev)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

---

For more help, refer to the main README.md in the project root.
