// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import 'preline'

document.addEventListener("turbo:load", () => {
  window.HSOverlay?.init();
});