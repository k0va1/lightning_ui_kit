import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "panel", "overlay"]
  static classes = ["panelClosed", "overlayClosed"]

  connect() {
    this.onCancel = this.onCancel.bind(this)
    this.dialogTarget.addEventListener("cancel", this.onCancel)
  }

  disconnect() {
    this.dialogTarget.removeEventListener("cancel", this.onCancel)
  }

  open() {
    this.dialogTarget.showModal()

    // Force a reflow so the closed -> open transition animates.
    requestAnimationFrame(() => {
      this.panelTarget.classList.remove(...this.panelClosedClasses)
      if (this.hasOverlayTarget) {
        this.overlayTarget.classList.remove(...this.overlayClosedClasses)
      }
    })
  }

  close() {
    this.panelTarget.classList.add(...this.panelClosedClasses)
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.add(...this.overlayClosedClasses)
    }

    setTimeout(() => this.dialogTarget.close(), 300)
  }

  // Intercept native ESC-to-close so it animates out.
  onCancel(event) {
    event.preventDefault()
    this.close()
  }
}
