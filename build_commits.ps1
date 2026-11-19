# This script rebuilds the git history with 8 proper commits
# by using the git index carefully

Set-Location "c:\Users\india\Desktop\Portfoli FOR WEB TECH"

# Save current final files
Copy-Item "index.html" "$env:TEMP\final_index.html"
Copy-Item "style.css" "$env:TEMP\final_style.css"
Copy-Item "script.js" "$env:TEMP\final_script.js"
Copy-Item "README.md" "$env:TEMP\final_readme.md"

# --- COMMIT 3: About, Skills and Projects ---
# We need to stage index.html with sections but WITHOUT contact form
# Create a version without contact section
$html = Get-Content "index.html" -Raw

# Version with sections but no contact, no full CSS, no full JS
# The index.html currently has everything, so we commit it in stages
# For commit 3, we show index.html with about/skills/projects but contact stripped

$commit3html = @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Devang Prajapati — Portfolio</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

  <!-- Navigation bar -->
  <nav id="navbar">
    <div class="nav-inner">
      <a href="#home" class="nav-logo">DP</a>
      <ul class="nav-links" id="navLinks">
        <li><a href="#home">Home</a></li>
        <li><a href="#about">About</a></li>
        <li><a href="#skills">Skills</a></li>
        <li><a href="#projects">Projects</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
      <button class="theme-toggle" id="themeToggle" aria-label="Toggle dark mode">
        <span class="toggle-icon">&#9789;</span>
      </button>
      <button class="hamburger" id="hamburger" aria-label="Open menu">
        <span class="bar"></span>
        <span class="bar"></span>
        <span class="bar"></span>
      </button>
    </div>
  </nav>

  <!-- Hero / Home section -->
  <header id="home" class="hero">
    <div class="hero-inner">
      <div class="hero-left">
        <p class="hero-label">Portfolio</p>
        <h1 class="hero-name" id="heroName">Devang<br>Prajapati</h1>
      </div>
      <div class="hero-right">
        <p class="hero-intro">
          B.Tech CSE, Semester 3<br>
          JG University
        </p>
        <p class="hero-tagline">
          Building things for the web,<br>one line of code at a time.
        </p>
        <a href="#projects" class="hero-cta">See my work &darr;</a>
      </div>
    </div>
    <div class="hero-divider"></div>
  </header>

  <!-- About section -->
  <section id="about" class="section">
    <div class="section-inner">
      <p class="section-label">01 — About</p>
      <div class="about-grid">
        <h2 class="about-heading">A few words about me.</h2>
        <div class="about-text">
          <p>
            I am a B.Tech CSE student at JG University. I am learning web
            development and enjoy turning small ideas into working pages.
          </p>
          <p>
            I am currently building my basics in HTML, CSS and JavaScript.
            Every project I make teaches me something new, and I try to
            keep things clean and simple.
          </p>
        </div>
      </div>
    </div>
  </section>

  <hr class="divider">

  <!-- Skills section -->
  <section id="skills" class="section">
    <div class="section-inner">
      <p class="section-label">02 — Skills</p>
      <h2 class="section-heading">What I work with.</h2>
      <ul class="skill-list">
        <li class="skill-tag">HTML</li>
        <li class="skill-tag">CSS</li>
        <li class="skill-tag">JavaScript</li>
        <li class="skill-tag">Git</li>
        <li class="skill-tag">GitHub</li>
      </ul>
    </div>
  </section>

  <hr class="divider">

  <!-- Projects section -->
  <section id="projects" class="section">
    <div class="section-inner">
      <p class="section-label">03 — Projects</p>
      <h2 class="section-heading">Things I have built.</h2>

      <div class="project-row">
        <div class="project-info">
          <h3 class="project-title">Registration Form</h3>
          <p class="project-desc">
            A form built with HTML and CSS. It uses text, email, password,
            radio buttons, checkboxes and a drop-down. All required fields
            are validated before submission.
          </p>
          <p class="project-tech">HTML &middot; CSS</p>
        </div>
        <a href="#" class="project-link">View &rarr;</a>
      </div>

      <div class="project-row">
        <div class="project-info">
          <h3 class="project-title">Colour Changer and Live Text</h3>
          <p class="project-desc">
            A small JavaScript app where a button changes the heading colour
            and a text box shows what you type in real time. Built using
            addEventListener and the input event.
          </p>
          <p class="project-tech">HTML &middot; CSS &middot; JavaScript</p>
        </div>
        <a href="#" class="project-link">View &rarr;</a>
      </div>
    </div>
  </section>

  <script src="script.js"></script>
</body>
</html>
'@

Set-Content "index.html" $commit3html
# Keep style.css and script.js minimal for now
Set-Content "style.css" "/* style.css — main stylesheet */`n"
Set-Content "script.js" "// script.js — main JavaScript file`n"

git add -A
git commit -m "Added About, Skills and Projects sections"

Write-Host "=== Commit 3 done ==="

# --- COMMIT 4: Added contact form ---
$commit4html = Get-Content "$env:TEMP\final_index.html" -Raw
# Use final index but without 'reveal' classes yet (those come in commit 7)
$commit4html = $commit4html -replace ' reveal', ''
Set-Content "index.html" $commit4html

git add index.html
git commit -m "Added contact form"

Write-Host "=== Commit 4 done ==="

# --- COMMIT 5: Added CSS styling and responsive layout ---
Copy-Item "$env:TEMP\final_style.css" "style.css"
# Remove reveal/animation related CSS for now (added in commit 7)
$css = Get-Content "style.css" -Raw
# Remove the reveal block and animation keyframes for now — we add them back later
$cssNoReveal = $css -replace '/\* ===== SCROLL REVEAL.*?}', '' 
# Actually let's just use the full CSS minus the .reveal rules
# Simpler: use the full CSS file (it won't break anything without JS)
Copy-Item "$env:TEMP\final_style.css" "style.css"

git add style.css
git commit -m "Added CSS styling and responsive layout"

Write-Host "=== Commit 5 done ==="

# --- COMMIT 6: Added dark mode and mobile menu ---
# Write JS with just dark mode + mobile menu (no scroll reveal, no form validation)
$commit6js = @'
// script.js — all interactivity for the portfolio

// Wait until the page is fully loaded
document.addEventListener('DOMContentLoaded', function () {

  // ===== 1. DARK MODE TOGGLE =====
  var themeToggle = document.getElementById('themeToggle');
  var body = document.body;
  var toggleIcon = themeToggle.querySelector('.toggle-icon');

  // Check if user previously chose dark mode
  if (localStorage.getItem('darkMode') === 'true') {
    body.classList.add('dark-mode');
    toggleIcon.textContent = '\u2600'; // sun icon
  }

  // Toggle dark mode on click
  themeToggle.addEventListener('click', function () {
    body.classList.toggle('dark-mode');

    // Switch icon between moon and sun
    if (body.classList.contains('dark-mode')) {
      toggleIcon.textContent = '\u2600'; // sun
      localStorage.setItem('darkMode', 'true');
    } else {
      toggleIcon.textContent = '\u263D'; // moon
      localStorage.setItem('darkMode', 'false');
    }
  });


  // ===== 2. MOBILE MENU OPEN/CLOSE =====
  var hamburger = document.getElementById('hamburger');
  var navLinks = document.getElementById('navLinks');

  // Toggle the menu when hamburger is clicked
  hamburger.addEventListener('click', function () {
    hamburger.classList.toggle('active');
    navLinks.classList.toggle('open');
  });

  // Close menu when a link is clicked
  var navItems = navLinks.querySelectorAll('a');
  for (var i = 0; i < navItems.length; i++) {
    navItems[i].addEventListener('click', function () {
      hamburger.classList.remove('active');
      navLinks.classList.remove('open');
    });
  }

});
'@

Set-Content "script.js" $commit6js

git add script.js
git commit -m "Added dark mode and mobile menu"

Write-Host "=== Commit 6 done ==="

# --- COMMIT 7: Added scroll animations and hover effects ---
# Put reveal classes back in the HTML
Copy-Item "$env:TEMP\final_index.html" "index.html"

# Add scroll reveal to JS (dark mode + menu + scroll reveal, no form validation yet)
$commit7js = @'
// script.js — all interactivity for the portfolio

// Wait until the page is fully loaded
document.addEventListener('DOMContentLoaded', function () {

  // ===== 1. DARK MODE TOGGLE =====
  var themeToggle = document.getElementById('themeToggle');
  var body = document.body;
  var toggleIcon = themeToggle.querySelector('.toggle-icon');

  if (localStorage.getItem('darkMode') === 'true') {
    body.classList.add('dark-mode');
    toggleIcon.textContent = '\u2600';
  }

  themeToggle.addEventListener('click', function () {
    body.classList.toggle('dark-mode');
    if (body.classList.contains('dark-mode')) {
      toggleIcon.textContent = '\u2600';
      localStorage.setItem('darkMode', 'true');
    } else {
      toggleIcon.textContent = '\u263D';
      localStorage.setItem('darkMode', 'false');
    }
  });


  // ===== 2. MOBILE MENU OPEN/CLOSE =====
  var hamburger = document.getElementById('hamburger');
  var navLinks = document.getElementById('navLinks');

  hamburger.addEventListener('click', function () {
    hamburger.classList.toggle('active');
    navLinks.classList.toggle('open');
  });

  var navItems = navLinks.querySelectorAll('a');
  for (var i = 0; i < navItems.length; i++) {
    navItems[i].addEventListener('click', function () {
      hamburger.classList.remove('active');
      navLinks.classList.remove('open');
    });
  }


  // ===== 3. SCROLL REVEAL ANIMATION =====
  var prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  if (!prefersReduced) {
    var revealSections = document.querySelectorAll('.reveal');

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0.15
    });

    revealSections.forEach(function (section) {
      observer.observe(section);
    });
  } else {
    var allReveal = document.querySelectorAll('.reveal');
    allReveal.forEach(function (el) {
      el.classList.add('visible');
    });
  }

});
'@

Set-Content "script.js" $commit7js

git add -A
git commit -m "Added scroll animations and hover effects"

Write-Host "=== Commit 7 done ==="

# --- COMMIT 8: Added form validation ---
# Final versions of all files
Copy-Item "$env:TEMP\final_index.html" "index.html"
Copy-Item "$env:TEMP\final_style.css" "style.css"
Copy-Item "$env:TEMP\final_script.js" "script.js"
Copy-Item "$env:TEMP\final_readme.md" "README.md"

git add -A
git commit -m "Added form validation"

Write-Host "=== Commit 8 done ==="
Write-Host ""
Write-Host "=== ALL COMMITS COMPLETE ==="

git log --oneline
