import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    autodismiss: Boolean,
    dismissAfter: { type: Number, default: 5000 }
  }

  connect() {
    this.scheduleDismiss()
  }

  disconnect() {
    this.cancelDismiss()
  }

  pause() {
    this.cancelDismiss()
  }

  resume() {
    this.scheduleDismiss()
  }

  scheduleDismiss() {
    if (!this.autodismissValue) return
    this.cancelDismiss()
    this.timeout = setTimeout(() => this.close(), this.dismissAfterValue)
  }

  cancelDismiss() {
    if (this.timeout) clearTimeout(this.timeout)
    this.timeout = null
  }

  close() {
    this.cancelDismiss()
    this.element.classList.remove("lui:opacity-100");
    this.element.classList.add("lui:opacity-0");
    setTimeout(() => {
      this.element.classList.add("lui:hidden");
    }, 300);
  }
}
