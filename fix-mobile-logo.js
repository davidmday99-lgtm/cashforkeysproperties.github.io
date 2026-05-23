const fs = require('fs');
const path = require('path');

const mediaQuery = `
        @media (max-width: 768px) {
            .nav-logo img {
                height: 120px;
            }

            .nav-logo {
                font-size: 16px;
            }

            .nav-links {
                gap: 14px;
                font-size: 0.9rem;
            }

            .nav-links a {
                font-size: 0.9rem;
            }
        }`;

const addMediaQuery = (filePath) => {
  let content = fs.readFileSync(filePath, 'utf8');
  
  if (content.includes('@media (max-width: 768px)')) {
    console.log('Already has media query:', path.basename(filePath));
    return;
  }
  
  // Insert before closing </style> tag
  content = content.replace('</style>', mediaQuery + '\n</style>');
  fs.writeFileSync(filePath, content);
  console.log('Updated:', path.basename(filePath));
};

// Get all HTML files
const files = fs.readdirSync('.').filter(f => f.endsWith('.html'));
files.forEach(addMediaQuery);

// Also update blog posts
const blogFiles = fs.readdirSync('blog').filter(f => f.endsWith('.html'));
blogFiles.forEach(f => addMediaQuery(path.join('blog', f)));
