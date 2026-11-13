// The one enquiry route: ?service= pre-selects the service and shows its prompt, and
// ?from= fills the hidden field. In a preview build the form cannot send.
(() => {
  const select = document.querySelector("[data-service-select]");
  if (!select) return;
  const params = new URLSearchParams(location.search);
  const service = params.get("service");
  if (service && select.querySelector(`option[value="${CSS.escape(service)}"]`)) select.value = service;
  const from = document.querySelector('input[name="from"]');
  if (from) from.value = params.get("from") || "";
  const line = document.querySelector("[data-service-line]"), none = document.querySelector("[data-service-none]"), name = document.querySelector("[data-service-name]");
  const sync = () => {
    document.querySelectorAll("[data-service-prompt]").forEach((p) => { p.hidden = p.dataset.servicePrompt !== select.value; });
    const chosen = select.value !== "something-else";
    line.hidden = !chosen; none.hidden = chosen;
    name.textContent = chosen ? select.options[select.selectedIndex].textContent : "";
  };
  select.addEventListener("change", sync);
  sync();
  const form = document.querySelector("[data-enquiry][data-preview]");
  if (form) form.addEventListener("submit", (e) => e.preventDefault());
})();
