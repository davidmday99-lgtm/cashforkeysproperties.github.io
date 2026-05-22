#!/usr/bin/env pwsh
# Generate Blog Post Script for Cash For Keys Properties
# This script generates a new blog post daily with real estate/cash buying related content

$repoPath = $PSScriptRoot
$blogPostsDir = Join-Path $repoPath "blog"
$postsIndexFile = Join-Path $blogPostsDir "posts\index.json"

# Ensure blog directories exist
if (!(Test-Path $blogPostsDir)) {
    New-Item -ItemType Directory -Path $blogPostsDir | Out-Null
}
if (!(Test-Path "$blogPostsDir\posts")) {
    New-Item -ItemType Directory -Path "$blogPostsDir\posts" | Out-Null
}

# Topics for blog posts (rotate through these)
$topics = @(
    @{
        title = "The Top 5 Reasons to Sell Your Home for Cash Today"
        excerpt = "Discover why more homeowners are choosing cash sales over traditional real estate transactions."
        content = "
            <h2>Speed and Simplicity</h2>
            <p>Cash sales close in days, not months. No financing contingencies, no appraisal delays, no surprise inspection issues. Just a straightforward, fast transaction.</p>

            <h2>Keep More Money</h2>
            <p>Eliminate realtor commissions (typically 5-6%), inspection costs, and endless repairs. More of your money stays in your pocket.</p>

            <h2>Less Stress</h2>
            <p>No showings, no staging, no negotiations. Sell your home exactly as it is and move forward with your life.</p>

            <h2>Certainty</h2>
            <p>Cash offers do not fall through. When we make an offer, it is guaranteed. No uncertainty, no anxiety about closing day.</p>

            <h2>Perfect for Any Situation</h2>
            <p>Inherited property? Foreclosure? Divorce? Job loss? Cash buyers understand difficult situations and provide solutions traditional buyers cannot.</p>
        "
    },
    @{
        title = "Cash Home Buyers: Breaking Down the Process"
        excerpt = "Understand exactly how the cash home buying process works from start to finish."
        content = "
            <h2>Step 1: Initial Consultation</h2>
            <p>Tell us about your property and your situation. This initial conversation is free, no-obligation, and helps us understand your needs.</p>

            <h2>Step 2: Property Evaluation</h2>
            <p>We evaluate your property honestly based on current market conditions, condition, and location. No inflated offers, no false hope - just realistic assessment.</p>

            <h2>Step 3: Cash Offer</h2>
            <p>Within 24 hours, we provide a fair cash offer. You have time to think it over with no pressure.</p>

            <h2>Step 4: Acceptance and Paperwork</h2>
            <p>Accept our offer and we handle all the paperwork. Our team manages the legal details so you do not have to.</p>

            <h2>Step 5: Fast Closing</h2>
            <p>Close in as little as 7 days. We coordinate with title companies and ensure everything moves smoothly to the finish line.</p>
        "
    },
    @{
        title = "Why Homeowners Choose Cash Over Traditional Sales"
        excerpt = "Real reasons why cash sales are becoming the preferred option for selling homes."
        content = "
            <h2>The Traditional Sale Problem</h2>
            <p>Traditional sales involve realtor commissions, inspections, appraisals, and mortgage contingencies. Any one of these can delay or derail your sale.</p>

            <h2>Hidden Costs Add Up</h2>
            <p>Between realtor commissions, title insurance, inspection repairs, and closing costs, sellers often lose 8-10 percent of their home value.</p>

            <h2>Uncertainty is Stressful</h2>
            <p>Traditional sales can take 60 plus days with no guarantee they will close. Financing can fall through, inspections can reveal issues, appraisals can come in low.</p>

            <h2>Cash Sales Fix These Problems</h2>
            <p>No commissions. No delays. No contingencies. Just a fair offer, fast closing, and money in your pocket - typically within a week.</p>

            <h2>Peace of Mind</h2>
            <p>When you sell for cash, you know exactly what is happening and when it will happen. That certainty is worth its weight in gold.</p>
        "
    }
)

# Get today's date
$today = Get-Date -Format "yyyy-MM-dd"
$todayFormatted = Get-Date -Format "MMMM dd, yyyy"

# Pick a topic based on the day (consistent daily)
$dayOfYear = (Get-Date).DayOfYear
$topicIndex = $dayOfYear % $topics.Count
$topic = $topics[$topicIndex]

# Generate slug
$slug = $topic.title.ToLower() -replace '[^a-z0-9\s-]', '' -replace '\s+', '-'
$postDate = "$today-$slug"

# HTML template for blog post
$htmlTemplate = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($topic.title) | Cash For Keys Properties</title>
    <meta name="description" content="$($topic.excerpt)">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #333; }
        .navbar { position: sticky; top: 0; z-index: 1000; background: #ff6700; padding: 12px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .nav-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 24px; font-weight: 800; color: white; text-decoration: none; display: flex; align-items: center; }
        .nav-logo img { max-height: 40px; width: auto; }
        .nav-links { display: flex; gap: 30px; list-style: none; }
        .nav-links a { color: white; text-decoration: none; font-weight: 600; font-size: 15px; transition: opacity 0.3s; }
        .nav-links a:hover { opacity: 0.8; }
        .container { max-width: 900px; margin: 0 auto; padding: 40px 20px; }
        .blog-header { margin-bottom: 40px; border-bottom: 2px solid #ff6700; padding-bottom: 20px; }
        .blog-header h1 { font-size: 42px; color: #333; margin-bottom: 15px; font-weight: 900; }
        .blog-meta { display: flex; gap: 20px; color: #666; font-size: 14px; }
        .blog-content { font-size: 16px; line-height: 1.8; color: #444; }
        .blog-content h2 { font-size: 28px; color: #ff6700; margin-top: 30px; margin-bottom: 15px; font-weight: 800; }
        .blog-content p { margin-bottom: 15px; }
        .cta-box { background: linear-gradient(135deg, #ff6700 0%, #ff8533 100%); color: white; padding: 30px; border-radius: 8px; margin-top: 40px; text-align: center; }
        .cta-box h3 { font-size: 24px; margin-bottom: 15px; font-weight: 800; }
        .cta-buttons { display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; }
        .btn { padding: 12px 28px; font-size: 14px; font-weight: 700; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; transition: all 0.3s; background: white; color: #ff6700; display: inline-block; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        footer { background: #333; color: white; padding: 30px 20px; text-align: center; margin-top: 60px; }
        @media (max-width: 768px) { .blog-header h1 { font-size: 28px; } .nav-links { gap: 15px; font-size: 13px; } }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="/" class="nav-logo"><img src="../logo-mini.png" alt="Cash For Keys Logo"></a>
            <ul class="nav-links">
                <li><a href="/">Home</a></li>
                <li><a href="/#process">How It Works</a></li>
                <li><a href="/#why">Why Us</a></li>
                <li><a href="/blog">Blog</a></li>
                <li><a href="/dday">Apply with DDAY</a></li>
                <li><a href="/evad">Apply with Eva</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="blog-header">
            <h1>$($topic.title)</h1>
            <div class="blog-meta">
                <span>Published: $todayFormatted</span>
                <span>By: Cash For Keys Properties</span>
            </div>
        </div>

        <article class="blog-content">
            <p>$($topic.excerpt)</p>
            $($topic.content)
            <div class="cta-box">
                <h3>Ready to Sell Your Home for Cash?</h3>
                <p>Contact Cash For Keys Properties today for a free, no-obligation offer.</p>
                <div class="cta-buttons">
                    <a href="/dday" class="btn">Apply with DDAY</a>
                    <a href="/evad" class="btn">Apply with Eva</a>
                </div>
            </div>
        </article>
    </div>

    <footer>
        <p>&copy; 2026 Cash For Keys Properties. All rights reserved.</p>
        <p>Email: cashforkeysproperties99@gmail.com</p>
    </footer>
</body>
</html>
"@

# Check if post already exists
$htmlFilePath = Join-Path $blogPostsDir "$postDate.html"
if (Test-Path $htmlFilePath) {
    Write-Output "Blog post for today already exists: $htmlFilePath"
    exit 0
}

# Create HTML file
Set-Content -Path $htmlFilePath -Value $htmlTemplate -Encoding UTF8
Write-Output "Created blog post: $htmlFilePath"

# Update posts index
$indexData = @()
if (Test-Path $postsIndexFile) {
    try {
        $indexData = Get-Content $postsIndexFile | ConvertFrom-Json
    } catch {
        $indexData = @()
    }
}

# Add new post to the beginning of the list
$newPost = @{
    id = $slug
    title = $topic.title
    date = $today
    slug = $postDate
    excerpt = $topic.excerpt
    author = "Cash For Keys Properties"
}

$indexData = @($newPost) + $indexData

# Save updated index (keep only last 30 posts)
$indexData | Select-Object -First 30 | ConvertTo-Json -Depth 10 | Set-Content -Path $postsIndexFile -Encoding UTF8
Write-Output "Updated blog index: $postsIndexFile"

# Git commit and push
try {
    Push-Location $repoPath
    
    # Stage changes
    & git add "blog/$postDate.html" "blog/posts/index.json"
    
    # Commit
    & git commit -m "Add daily blog post: $($topic.title)"
    
    # Push
    & git push origin main
    
    Write-Output "Pushed to GitHub"
    Pop-Location
} catch {
    Write-Warning "Git operations failed. You may need to push manually."
    Write-Warning $_.Exception.Message
    if ((Get-Location).Path -ne $repoPath) { Pop-Location }
}

Write-Output "Blog post generation complete!"
