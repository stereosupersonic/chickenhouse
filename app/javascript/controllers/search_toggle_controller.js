import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  toggle() {
    this.formTarget.classList.toggle("d-none")
    if (!this.formTarget.classList.contains("d-none")) {
      this.inputTarget.focus()
    }
  }
}
