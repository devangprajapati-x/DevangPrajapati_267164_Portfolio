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

  // Close menu when a link is clicked (so the page scrolls smoothly)
  var navItems = navLinks.querySelectorAll('a');
  for (var i = 0; i < navItems.length; i++) {
    navItems[i].addEventListener('click', function () {
      hamburger.classList.remove('active');
      navLinks.classList.remove('open');
    });
  }


  // ===== 3. SCROLL REVEAL ANIMATION =====
  // Check if user prefers reduced motion
  var prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  if (!prefersReduced) {
    var revealSections = document.querySelectorAll('.reveal');

    // IntersectionObserver watches when sections enter the viewport
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target); // stop watching once visible
        }
      });
    }, {
      threshold: 0.15  // trigger when 15% of section is visible
    });

    // Observe each section that has the .reveal class
    revealSections.forEach(function (section) {
      observer.observe(section);
    });
  } else {
    // If reduced motion, just show everything immediately
    var allReveal = document.querySelectorAll('.reveal');
    allReveal.forEach(function (el) {
      el.classList.add('visible');
    });
  }


  // ===== 4. CONTACT FORM VALIDATION =====
  var contactForm = document.getElementById('contactForm');
  var nameInput = document.getElementById('userName');
  var emailInput = document.getElementById('userEmail');
  var messageInput = document.getElementById('userMessage');
  var nameError = document.getElementById('nameError');
  var emailError = document.getElementById('emailError');
  var messageError = document.getElementById('messageError');
  var formSuccess = document.getElementById('formSuccess');

  // Simple email pattern check
  function isValidEmail(email) {
    var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return pattern.test(email);
  }

  // Validate when the form is submitted
  contactForm.addEventListener('submit', function (e) {
    e.preventDefault(); // stop the page from reloading

    var isValid = true;

    // Clear old messages
    nameError.textContent = '';
    emailError.textContent = '';
    messageError.textContent = '';
    formSuccess.textContent = '';

    // Check name is not empty
    if (nameInput.value.trim() === '') {
      nameError.textContent = 'Please enter your name.';
      isValid = false;
    }

    // Check email is valid
    if (emailInput.value.trim() === '') {
      emailError.textContent = 'Please enter your email.';
      isValid = false;
    } else if (!isValidEmail(emailInput.value.trim())) {
      emailError.textContent = 'Please enter a valid email address.';
      isValid = false;
    }

    // Check message is at least 10 characters
    if (messageInput.value.trim().length < 10) {
      messageError.textContent = 'Message must be at least 10 characters.';
      isValid = false;
    }

    // If everything is valid, show success
    if (isValid) {
      formSuccess.textContent = 'Thank you! Your message has been received.';
      contactForm.reset(); // clear the form
    }
  });

});
