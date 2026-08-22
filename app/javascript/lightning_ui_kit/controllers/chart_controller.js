import { Controller } from "@hotwired/stimulus"

const TICK_GAP = 8

export default class extends Controller {
  static targets = ["tooltip", "cursor", "markers", "xTick"]

  connect() {
    this.scheduleTickCull()
    this.resizeObserver = new ResizeObserver(() => this.scheduleTickCull())
    this.resizeObserver.observe(this.element)
  }

  disconnect() {
    this.resizeObserver?.disconnect()
    if (this.cullFrame) cancelAnimationFrame(this.cullFrame)
  }

  // Fires for each label Turbo morphs in, so refreshed charts re-cull.
  xTickTargetConnected() {
    this.scheduleTickCull()
  }

  scheduleTickCull() {
    this.cullFrame ||= requestAnimationFrame(() => {
      this.cullFrame = null
      this.cullXTicks()
    })
  }

  // The server thins x labels without knowing the rendered width, so labels
  // can still collide on narrow containers or with long date formats. Hide
  // any label that would overlap the previous visible one, always keeping
  // the first and last.
  cullXTicks() {
    const ticks = this.xTickTargets
    if (ticks.length < 2) return

    ticks.forEach((tick) => (tick.style.visibility = ""))
    const rects = ticks.map((tick) => tick.getBoundingClientRect())

    let kept = 0
    for (let i = 1; i < ticks.length; i++) {
      if (rects[i].left < rects[kept].right + TICK_GAP) {
        ticks[i].style.visibility = "hidden"
      } else {
        kept = i
      }
    }

    const last = ticks.length - 1
    if (ticks[last].style.visibility === "hidden") {
      ticks[last].style.visibility = ""
      for (let i = last - 1; i > 0 && rects[i].right + TICK_GAP > rects[last].left; i--) {
        ticks[i].style.visibility = "hidden"
      }
    }
  }

  show(event) {
    const el = event.currentTarget
    this.trackCursor(el)
    if (!this.hasTooltipTarget) return

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
          <span class="lui:size-2.5 lui:shrink-0 lui:rounded-[2px]" style="background-color:${this.escapeHtml(item.color)}"></span>${this.escapeHtml(item.label)}
        </span>
        <span class="lui:font-medium lui:text-foreground lui:tabular-nums">${this.escapeHtml(item.value)}</span>
      </div>`).join("")

    this.tooltipTarget.innerHTML = `<div class="lui:font-medium lui:text-foreground">${this.escapeHtml(label)}</div>${rows}`
    this.tooltipTarget.classList.remove("lui:hidden")
    this.position(event)
  }

  move(event) {
    this.position(event)
  }

  hide() {
    if (this.hasTooltipTarget) this.tooltipTarget.classList.add("lui:hidden")
    if (this.hasCursorTarget) this.cursorTarget.style.display = "none"
    if (this.hasMarkersTarget) this.markersTarget.style.display = "none"
  }

  // Moves the vertical cursor (or bar band) and one active dot per series onto
  // the hovered column.
  trackCursor(el) {
    const x = el.dataset.cursorX

    if (this.hasCursorTarget) {
      const line = this.cursorTarget.querySelector('[data-role="cursor-line"]')
      if (line) {
        line.setAttribute("x1", x)
        line.setAttribute("x2", x)
      }

      const band = this.cursorTarget.querySelector('[data-role="cursor-band"]')
      if (band) {
        band.setAttribute("x", el.getAttribute("x"))
        band.setAttribute("width", el.getAttribute("width"))
      }

      this.cursorTarget.style.display = ""
    }

    if (!this.hasMarkersTarget) return

    let markers = []
    try {
      markers = JSON.parse(el.dataset.markers || "[]")
    } catch (_) {
      markers = []
    }

    this.markersTarget.querySelectorAll('[data-role="active-dot"]').forEach((dot, i) => {
      const y = markers[i]
      if (y === null || y === undefined) {
        dot.style.display = "none"
        return
      }
      dot.setAttribute("transform", `translate(${x} ${y})`)
      dot.style.display = ""
    })
    this.markersTarget.style.display = ""
  }

  // Labels, series names and y_format: output are caller-supplied, so they are
  // escaped before going into innerHTML.
  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text ?? ""
    return div.innerHTML
  }

  position(event) {
    if (!this.hasTooltipTarget) return

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
