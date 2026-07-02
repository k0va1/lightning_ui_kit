import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["trigger", "panel", "label", "input"]

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
    this.panelTarget.classList.remove("lui:hidden")
    this.cleanup = autoUpdate(this.triggerTarget, this.panelTarget, () => this.reposition())
  }

  close() {
    if (!this.hasPanelTarget) return
    this.panelTarget.classList.add("lui:hidden")
    this.stopAutoUpdate()
  }

  closeOnOutside(event) {
    if (this.isOpen && !this.element.contains(event.target)) this.close()
  }

  onSelect(event) {
    const iso = event.detail.date
    if (this.hasInputTarget) this.inputTarget.value = iso
    this.labelTarget.textContent = this.format(iso)
    this.labelTarget.classList.remove("lui:text-foreground-muted")
    this.close()
  }

  format(iso) {
    const date = new Date(`${iso}T00:00:00`)
    return date.toLocaleDateString(undefined, { year: "numeric", month: "long", day: "numeric" })
  }

  reposition() {
    computePosition(this.triggerTarget, this.panelTarget, {
      strategy: "absolute",
      placement: "bottom-start",
      middleware: [offset(6), flip(), shift({ padding: 8 })]
    }).then(({ x, y }) => {
      Object.assign(this.panelTarget.style, { position: "absolute", left: `${x}px`, top: `${y}px` })
    })
  }

  stopAutoUpdate() {
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }
  }

  get isOpen() {
    return this.hasPanelTarget && !this.panelTarget.classList.contains("lui:hidden")
  }
}
