import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["trigger", "content"]
  static values = {
    position: { type: String, default: "bottom" },
    offset: { type: Number, default: 8 }
  }

  connect() {
    this.cleanup = null
  }

  disconnect() {
    this.stopAutoUpdate()
  }

  toggle(event) {
    event.stopPropagation()
    this.isOpen ? this.close() : this.open()
  }

  open() {
    if (this.isOpen) return

    this.contentTarget.classList.remove("lui:hidden")
    this.element.setAttribute("data-state", "open")

    this.cleanup = autoUpdate(this.triggerTarget, this.contentTarget, () => this.reposition())
  }

  close() {
    if (!this.hasContentTarget) return

    this.contentTarget.classList.add("lui:hidden")
    this.element.setAttribute("data-state", "closed")
    this.stopAutoUpdate()
  }

  hide() {
    this.close()
  }

  hideOnClickOutside(event) {
    if (this.isOpen && !this.element.contains(event.target)) {
      this.close()
    }
  }

  reposition() {
    computePosition(this.triggerTarget, this.contentTarget, {
      strategy: "absolute",
      placement: this.positionValue,
      middleware: [offset(this.offsetValue), flip(), shift({ padding: 8 })]
    }).then(({ x, y }) => {
      Object.assign(this.contentTarget.style, {
        position: "absolute",
        left: `${x}px`,
        top: `${y}px`
      })
    })
  }

  stopAutoUpdate() {
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }
  }

  get isOpen() {
    return this.hasContentTarget && !this.contentTarget.classList.contains("lui:hidden")
  }
}
