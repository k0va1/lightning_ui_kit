import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "icon", "successIcon", "showIcon", "hideIcon"]
  static values = { duration: { type: Number, default: 2000 } }

  connect() {
    if (this.hasInputTarget) {
      this.inputTarget.readOnly = true
    }
  }

  copy(e) {
    e.preventDefault()
    if (!this.hasInputTarget) {
      return
    }

    const text = this.inputTarget.innerHTML || this.inputTarget.value
    navigator.clipboard.writeText(text).then(() => {
      this.#showSuccess()
    })
  }

  toggle(e) {
    e.preventDefault()
    if (!this.hasInputTarget) {
      return
    }

    const isPassword = this.inputTarget.type === "password"
    this.inputTarget.type = isPassword ? "text" : "password"

    if (this.hasShowIconTarget && this.hasHideIconTarget) {
      this.showIconTarget.classList.toggle("lui:hidden", isPassword)
      this.hideIconTarget.classList.toggle("lui:hidden", !isPassword)
    }
  }

  #showSuccess() {
    if (!this.hasIconTarget || !this.hasSuccessIconTarget) {
      return
    }

    this.iconTarget.classList.add("lui:hidden")
    this.successIconTarget.classList.remove("lui:hidden")

    clearTimeout(this.resetTimeout)
    this.resetTimeout = setTimeout(() => {
      this.iconTarget.classList.remove("lui:hidden")
      this.successIconTarget.classList.add("lui:hidden")
    }, this.durationValue)
  }

  disconnect() {
    clearTimeout(this.resetTimeout)
  }
}
