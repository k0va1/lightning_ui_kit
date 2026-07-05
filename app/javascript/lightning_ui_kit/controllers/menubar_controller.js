import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "trigger", "content"]

  connect() {
    this.openMenu = null
  }

  toggle(event) {
    event.stopPropagation()
    const menu = event.currentTarget.closest('[data-lui-menubar-target="menu"]')
    if (this.isOpen(menu)) {
      this.closeAll()
    } else {
      this.open(menu)
    }
  }

  // Desktop menubar behaviour: once a menu is open, hovering a sibling switches to it.
  onHover(event) {
    if (this.openMenu && this.openMenu !== event.currentTarget) {
      this.open(event.currentTarget)
    }
  }

  open(menu) {
    this.closeAll()
    this.contentIn(menu).classList.remove("lui:hidden")
    this.triggerIn(menu).setAttribute("data-state", "open")
    this.openMenu = menu
  }

  closeAll() {
    this.contentTargets.forEach((content) => content.classList.add("lui:hidden"))
    this.triggerTargets.forEach((trigger) => trigger.removeAttribute("data-state"))
    this.openMenu = null
  }

  closeOnOutside(event) {
    if (this.openMenu && !this.element.contains(event.target)) this.closeAll()
  }

  isOpen(menu) {
    return !this.contentIn(menu).classList.contains("lui:hidden")
  }

  contentIn(menu) {
    return menu.querySelector('[data-lui-menubar-target="content"]')
  }

  triggerIn(menu) {
    return menu.querySelector('[data-lui-menubar-target="trigger"]')
  }
}
