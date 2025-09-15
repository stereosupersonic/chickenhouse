// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "@fortawesome/fontawesome-free/js/all";

// Initialize Bootstrap components
document.addEventListener('DOMContentLoaded', function() {
  // Initialize all alert dismiss buttons
  const alertDismissButtons = document.querySelectorAll('[data-bs-dismiss="alert"]');
  alertDismissButtons.forEach(button => {
    button.addEventListener('click', function() {
      const alert = this.closest('.alert');
      if (alert) {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }
    });
  });
});
