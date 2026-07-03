import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "panel", "overlay"]
  static classes = ["panelClosed", "overlayClosed"]
  static values = {
    open: Boolean,
    dismissable: { type: Boolean, default: true }
  }

  connect() {
    this.onCancel = this.onCancel.bind(this)
    this.dialogTarget.addEventListener("cancel", this.onCancel)
    if (this.openValue) {
      this.open()
    }
  }

  disconnect() {
    this.dialogTarget.removeEventListener("cancel", this.onCancel)
  }

  open() {
    this.dialogTarget.showModal()

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

    setTimeout(() => this.dialogTarget.close(), 200)
  }

  confirm() {
    this.dispatch("confirm")
    this.close()
  }

  onCancel(event) {
    event.preventDefault()
    this.close()
  }

  closeOnBackdrop(event) {
    if (this.dismissableValue && this.hasPanelTarget && !this.panelTarget.contains(event.target)) {
      this.close()
    }
  }

  submitForm() {
    this.dialogTarget.querySelector("form").requestSubmit()
  }
}
