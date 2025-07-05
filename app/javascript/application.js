import "@hotwired/turbo-rails"
import "./controllers"
import 'preline'

document.addEventListener("turbo:load", () => {
  // Preline UI の全コンポーネントを初期化
  window.HSStaticMethods?.autoInit();
});