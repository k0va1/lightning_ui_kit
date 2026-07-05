import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panelOne", "handle"]
  static values = {
    direction: { type: String, default: "horizontal" },
    min: { type: Number, default: 10 },
    max: { type: Number, default: 90 }
  }

  connect() {
    this.onMove = this.move.bind(this)
    this.onUp = this.stop.bind(this)
    this.dragging = false
  }

  disconnect() {
    this.stop()
  }

  start(event) {
    event.preventDefault()
    this.dragging = true
    document.addEventListener("pointermove", this.onMove)
    document.addEventListener("pointerup", this.onUp)
    document.body.style.userSelect = "none"
  }

  move(event) {
    if (!this.dragging) return

    const rect = this.element.getBoundingClientRect()
    let percent
    if (this.directionValue === "vertical") {
      percent = ((event.clientY - rect.top) / rect.height) * 100
    } else {
      percent = ((event.clientX - rect.left) / rect.width) * 100
    }

    percent = Math.max(this.minValue, Math.min(this.maxValue, percent))
    this.panelOneTarget.style.flexBasis = `${percent}%`
  }

  stop() {
    if (!this.dragging) return
    this.dragging = false
    document.removeEventListener("pointermove", this.onMove)
    document.removeEventListener("pointerup", this.onUp)
    document.body.style.userSelect = ""
  }
}
