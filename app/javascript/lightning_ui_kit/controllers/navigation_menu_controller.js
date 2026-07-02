import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "content"]
  static values = {
    openDelay: { type: Number, default: 100 },
    closeDelay: { type: Number, default: 150 }
  }

  connect() {
    this.openTimeout = null
    this.closeTimeout = null
  }

  disconnect() {
    this.clearTimers()
  }

  open(event) {
    this.clearTimers()
    const item = event.currentTarget
    const content = this.contentFor(item)
    if (!content) {
      this.closeAll()
      return
    }
    this.openTimeout = setTimeout(() => this.show(item, content), this.openDelayValue)
  }

  toggle(event) {
    event.preventDefault()
    const item = event.currentTarget.closest('[data-lui-navigation-menu-target="item"]')
    const content = this.contentFor(item)
    if (!content) return

    if (content.classList.contains("lui:hidden")) {
      this.show(item, content)
    } else {
      this.hide(item, content)
    }
  }

  show(item, content) {
    this.closeAll()
    content.classList.remove("lui:hidden")
    this.setState(item, true)
  }

  hide(item, content) {
    content.classList.add("lui:hidden")
    this.setState(item, false)
  }

  closeAll() {
    this.contentTargets.forEach((content) => content.classList.add("lui:hidden"))
    this.itemTargets.forEach((item) => this.setState(item, false))
  }

  scheduleClose() {
    this.clearTimers()
    this.closeTimeout = setTimeout(() => this.closeAll(), this.closeDelayValue)
  }

  cancelClose() {
    if (this.closeTimeout) {
      clearTimeout(this.closeTimeout)
      this.closeTimeout = null
    }
  }

  setState(item, open) {
    const trigger = item.querySelector("button")
    if (!trigger) return
    trigger.setAttribute("aria-expanded", open ? "true" : "false")
    if (open) {
      trigger.setAttribute("data-state", "open")
    } else {
      trigger.removeAttribute("data-state")
    }
  }

  contentFor(item) {
    return item.querySelector('[data-lui-navigation-menu-target="content"]')
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
}
