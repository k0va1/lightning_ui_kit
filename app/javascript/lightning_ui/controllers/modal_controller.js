import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]
  static values = {
    open: Boolean
  }

  connect() {
    this.dialogTarget.addEventListener('click', this.onClick.bind(this))
    if (this.openValue) {
      this.open()
    }
  }

  disconnect() {
    this.dialogTarget.removeEventListener('click', this.onClick.bind(this))
  }

  open() {
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.setAttribute("closing", "")

    Promise.all(
      this.dialogTarget.getAnimations().map((animation) => animation.finished),
    ).then(() => {
      this.dialogTarget.removeAttribute("closing")
      this.dialogTarget.close()
    })
  }

  onClick(event) {
    if (event.target === this.dialogTarget) {
      this.dialogTarget.close()
    }
  }

  submitForm() {
    this.dialogTarget.querySelector("form").requestSubmit()
  }
}
