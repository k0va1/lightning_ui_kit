import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = { open: Boolean }

  toggle() {
    this.openValue = !this.openValue
  }

  openValueChanged() {
    if (!this.hasContentTarget) return

    if (this.openValue) {
      this.contentTarget.classList.remove("lui:grid-rows-[0fr]")
      this.contentTarget.classList.add("lui:grid-rows-[1fr]")
    } else {
      this.contentTarget.classList.remove("lui:grid-rows-[1fr]")
      this.contentTarget.classList.add("lui:grid-rows-[0fr]")
    }

    this.element.setAttribute("data-state", this.openValue ? "open" : "closed")
  }
}
