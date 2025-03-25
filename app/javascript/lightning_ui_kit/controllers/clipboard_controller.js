import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    if (this.hasInputTarget) {
      this.inputTarget.disabled = true
    }
  }

  copy(e) {
    e.preventDefault()
    if (!this.hasInputTarget) {
      return
    }

    const text = this.inputTarget.innerHTML || this.inputTarget.value
    navigator.clipboard.writeText(text)
  }
}
