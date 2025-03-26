document.addEventListener("turbo:load", function () {
  const menuToggle = document.getElementById("menu-toggle");
  const navbarMenu = document.getElementById("navbar-menu");

  if (menuToggle && navbarMenu) {
    menuToggle.addEventListener("click", function () {
      navbarMenu.classList.toggle("show");
    });
  }
});
