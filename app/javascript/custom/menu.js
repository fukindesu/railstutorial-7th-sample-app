document.addEventListener("turbo:load", () => {
  addToggleListener("hamburger", "navbar-menu", "collapse");
  addToggleListener("account", "dropdown-menu", "active")
});

function addToggleListener(selectedId, menuId, toggleClass) {
  const selectedElement = document.querySelector(`#${selectedId}`);

  selectedElement.addEventListener("click", (event) => {
    event.preventDefault();
    const menu = document.querySelector(`#${menuId}`);
    menu.classList.toggle(toggleClass);
  });
}
