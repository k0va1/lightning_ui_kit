import { Controller } from "@hotwired/stimulus"
import { computePosition, flip, shift, offset } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    this.onDocPointer = this.onDocPointer.bind(this)
    this.onKeydown = this.onKeydown.bind(this)
  }

  disconnect() {
    this.close()
  }

  open(event) {
    event.preventDefault()

    const virtual = {
      getBoundingClientRect: () => ({
        width: 0,
        height: 0,
        x: event.clientX,
        y: event.clientY,
        top: event.clientY,
        left: event.clientX,
        right: event.clientX,
        bottom: event.clientY
      })
    }

    this.contentTarget.classList.remove("lui:hidden")

    computePosition(virtual, this.contentTarget, {
      strategy: "fixed",
      placement: "right-start",
      middleware: [offset(2), flip(), shift({ padding: 8 })]
    }).then(({ x, y }) => {
      Object.assign(this.contentTarget.style, { position: "fixed", left: `${x}px`, top: `${y}px` })
    })

    document.addEventListener("pointerdown", this.onDocPointer, true)
    document.addEventListener("keydown", this.onKeydown)
  }

  close() {
    if (this.hasContentTarget) this.contentTarget.classList.add("lui:hidden")
    document.removeEventListener("pointerdown", this.onDocPointer, true)
    document.removeEventListener("keydown", this.onKeydown)
  }

  onDocPointer(event) {
    if (!this.contentTarget.contains(event.target)) this.close()
  }

  onKeydown(event) {
    if (event.key === "Escape") this.close()
  }
}
