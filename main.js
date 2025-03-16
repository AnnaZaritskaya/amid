import "./src/scss/style.scss";
import { loadRouteModule } from "./src/js/modules/router.js";

document.addEventListener("DOMContentLoaded", initRoute);
window.addEventListener("popstate", initRoute);

function initRoute() {
  loadRouteModule()
    .then((module) => {
      if (module && typeof module.init === "function") {
        module.init();
      }
    })
    .catch((error) => console.error("Error loading the module", error));
}
