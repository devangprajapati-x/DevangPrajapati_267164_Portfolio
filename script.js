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
