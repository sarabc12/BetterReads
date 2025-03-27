// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("turbo:load", function () {
  const menuToggle = document.getElementById("menu-toggle");
  const navbarMenu = document.getElementById("navbar-menu");

  if (menuToggle && navbarMenu) {
    menuToggle.addEventListener("click", function () {
      navbarMenu.classList.toggle("show");
    });
  }
});
