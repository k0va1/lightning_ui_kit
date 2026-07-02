import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tooltip"]

  show(event) {
    if (!this.hasTooltipTarget) return

    const el = event.currentTarget
    const label = el.dataset.label || ""
    let items = []
    try {
      items = JSON.parse(el.dataset.payload || "[]")
    } catch (_) {
      items = []
    }

    const rows = items.map((item) => `
      <div class="lui:flex lui:items-center lui:justify-between lui:gap-4">
        <span class="lui:flex lui:items-center lui:gap-1.5 lui:text-foreground-muted">
          <span class="lui:size-2 lui:shrink-0 lui:rounded-[2px]" style="background-color:${item.color}"></span>${item.label}
        </span>
        <span class="lui:font-medium lui:text-foreground lui:tabular-nums">${item.value}</span>
      </div>`).join("")

    this.tooltipTarget.innerHTML = `<div class="lui:mb-1 lui:font-medium lui:text-foreground">${label}</div>${rows}`
    this.tooltipTarget.classList.remove("lui:hidden")
    this.position(event)
  }

  move(event) {
    this.position(event)
  }

  hide() {
    if (this.hasTooltipTarget) this.tooltipTarget.classList.add("lui:hidden")
  }

  position(event) {
    const rect = this.element.getBoundingClientRect()
    const tip = this.tooltipTarget
    const x = event.clientX - rect.left
    const y = event.clientY - rect.top

    let left = x + 12
    let top = y + 12
    if (left + tip.offsetWidth > rect.width) left = x - tip.offsetWidth - 12
    if (top + tip.offsetHeight > rect.height) top = y - tip.offsetHeight - 12

    tip.style.left = `${Math.max(0, left)}px`
    tip.style.top = `${Math.max(0, top)}px`
  }
}
