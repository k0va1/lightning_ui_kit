import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "fill", "thumb"]

  connect() {
    this.update()
  }

  update() {
    const input = this.inputTarget
    const min = parseFloat(input.min || "0")
    const max = parseFloat(input.max || "100")
    const value = parseFloat(input.value || "0")
    const range = max - min
    const percent = range <= 0 ? 0 : ((value - min) / range) * 100

    if (this.hasFillTarget) this.fillTarget.style.width = `${percent}%`
    if (this.hasThumbTarget) this.thumbTarget.style.left = `${percent}%`
    input.setAttribute("aria-valuenow", value)
    this.dispatch("change", { detail: { value } })
  }
}
