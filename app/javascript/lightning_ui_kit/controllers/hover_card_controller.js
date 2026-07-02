import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["trigger", "content"]
  static values = {
    position: { type: String, default: "bottom" },
    offset: { type: Number, default: 8 },
    openDelay: { type: Number, default: 300 },
    closeDelay: { type: Number, default: 150 }
  }

  connect() {
    this.cleanup = null
    this.openTimeout = null
    this.closeTimeout = null
  }

  disconnect() {
    this.clearTimers()
    this.stopAutoUpdate()
  }

  open() {
    this.clearTimers()
    this.openTimeout = setTimeout(() => this.show(), this.openDelayValue)
  }

  scheduleClose() {
    this.clearTimers()
    this.closeTimeout = setTimeout(() => this.hide(), this.closeDelayValue)
  }

  cancelClose() {
    if (this.closeTimeout) {
      clearTimeout(this.closeTimeout)
      this.closeTimeout = null
    }
  }

  show() {
    this.contentTarget.classList.remove("lui:hidden")
    this.element.setAttribute("data-state", "open")
    this.cleanup = autoUpdate(this.triggerTarget, this.contentTarget, () => this.reposition())
  }

  hide() {
    this.contentTarget.classList.add("lui:hidden")
    this.element.setAttribute("data-state", "closed")
    this.stopAutoUpdate()
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

  clearTimers() {
    if (this.openTimeout) {
      clearTimeout(this.openTimeout)
      this.openTimeout = null
    }
    if (this.closeTimeout) {
      clearTimeout(this.closeTimeout)
      this.closeTimeout = null
    }
  }

  stopAutoUpdate() {
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }
  }
}
