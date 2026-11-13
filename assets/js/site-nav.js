// The navigation bar's Menu, below 1024px: a plain disclosure. It says whether the list is
// open, Escape closes it and returns focus to it, and choosing a link closes it. Without this script the bar keeps the site's
// own behaviour.
(() => {
  const header = document.querySelector("[data-header]"), menu = document.querySelector("[data-menu]");
  if (!header || !menu) return;
  const list = document.getElementById(menu.getAttribute("aria-controls"));
  const set = (open) => { menu.setAttribute("aria-expanded", String(open)); header.toggleAttribute("data-open", open); list?.classList.toggle("open", open); };
  menu.addEventListener("click", () => set(menu.getAttribute("aria-expanded") !== "true"));
  document.addEventListener("keydown", (e) => { if (e.key === "Escape" && menu.getAttribute("aria-expanded") === "true") { set(false); menu.focus(); } });
  (list ?? header).querySelectorAll("a").forEach((link) => link.addEventListener("click", () => set(false)));
})();
