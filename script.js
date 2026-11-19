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
