# Cash For Keys Properties - Blog System Setup

## Overview
The blog system automatically generates a new blog post daily based on rotating topics related to real estate investing and cash home buying.

## Files Created

### Blog Structure
- `blog/index.html` - Main blog page that lists all posts dynamically
- `blog/posts/index.json` - Post metadata and index
- `blog/2026-05-22-why-cash-buyers-are-best.html` - Sample blog post
- `blog/2026-05-22-cash-home-buyers-breaking-down-the-process.html` - Auto-generated post
- `generate-blog-post.ps1` - PowerShell script to generate daily posts

### Logo Files
- `logo.png` - Full logo (main)
- `logo-mini.png` - Mini logo (navbar)

## How It Works

### Manual Blog Post Generation
To generate a new blog post manually, run:
```powershell
cd C:\Users\David PC\.openclaw\workspace\cashforkeysproperties.com
powershell.exe -File generate-blog-post.ps1
```

### Automated Daily Posts
To automate this process, set up a Windows Task Scheduler task:

1. Open Task Scheduler (taskschd.msc)
2. Create Basic Task:
   - Name: "Cash For Keys Daily Blog Post"
   - Trigger: Daily at 6:00 AM
   - Action: Start a program
     - Program: `powershell.exe`
     - Arguments: `-File "C:\Users\David PC\.openclaw\workspace\cashforkeysproperties.com\generate-blog-post.ps1"`
     - Start in: `C:\Users\David PC\.openclaw\workspace\cashforkeysproperties.com`

## Formspree Integration

### Forms Created
Both dday.html and evad.html now use Formspree for form submissions.

**Formspree Form ID:** `mzzyqvkl`  
**Email Destination:** `cashforkeysproperties99@gmail.com`  
**Form Endpoint:** `https://formspree.io/f/mzzyqvkl`

### Testing the Forms
1. Visit https://cashforkeysproperties.com/dday or /evad
2. Fill out and submit the form
3. Check cashforkeysproperties99@gmail.com for submission

## Design Updates

### Colors (Beach Theme)
- Primary Coral: `#f36f4f`
- Coastal Blue: `#0d6e91`
- Navy: `#072f4f`
- Sand: `#f8f4ec`
- White: `#ffffff`

### Logo Implementation
- Logos appear in navbar on all pages
- Navbar logos are clickable (link to home)
- Responsive sizing on mobile

### Navigation Updates
All pages now include Blog link in navbar:
- index.html ✓
- dday.html ✓
- evad.html ✓
- blog/index.html ✓
- blog/*.html (all posts) ✓

## Blog Post Topics (Auto-Rotating)

1. The Top 5 Reasons to Sell Your Home for Cash Today
2. Cash Home Buyers: Breaking Down the Process
3. Why Homeowners Choose Cash Over Traditional Sales
4. How to Get the Best Cash Offer for Your Home
5. What Happens to Your Foreclosed Home With a Cash Buyer (Future)
6. Inherited Property? Sell It Fast for Cash (Future)
7. Real Estate Investing 101: Cash Home Buying Basics (Future)
8. Divorce and Property Division: A Cash Buyer's Guide (Future)

Posts rotate based on day of year, ensuring consistent topic assignment.

## File Structure
```
cashforkeysproperties.com/
├── index.html              (Updated with logos and blog link)
├── dday.html              (Updated with Formspree + logos)
├── evad.html              (Updated with Formspree + logos)
├── logo.png               (Full logo)
├── logo-mini.png          (Navbar logo)
├── generate-blog-post.ps1 (Daily post generator)
├── CNAME                  (Domain config)
└── blog/
    ├── index.html          (Blog listing page)
    ├── 2026-05-22-why-cash-buyers-are-best.html
    ├── 2026-05-22-cash-home-buyers-breaking-down-the-process.html
    └── posts/
        └── index.json      (Post metadata)
```

## Deployment Status

✅ Site live at: https://cashforkeysproperties.com  
✅ All pages accessible and loading correctly  
✅ Forms integrated with Formspree  
✅ Blog system operational  
✅ All changes committed to GitHub  

## Next Steps

1. **Set up Windows Task Scheduler** for automatic 6 AM blog posts
2. **Test Formspree submissions** on both dday and evad pages
3. **Monitor blog posts** and verify they auto-publish to GitHub daily
4. **Customize blog post topics** by editing the `$topics` array in generate-blog-post.ps1

## Notes

- Blog posts use a rotating topic system for consistent daily content
- Topics are determined by day of year, so same topic repeats every ~365 days
- Each post includes CTAs to apply with DDAY or Eva
- Blog index loads posts dynamically from index.json
- All changes are auto-committed and pushed to GitHub with the script
