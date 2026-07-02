import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = { type: { type: String, default: "single" } }

  toggle(event) {
    const button = event.currentTarget
    const isOn = button.getAttribute("data-state") === "on"

    if (this.typeValue === "single") {
      this.itemTargets.forEach((item) => this.setState(item, item === button ? !isOn : false))
    } else {
      this.setState(button, !isOn)
    }

    this.dispatch("change", { detail: { value: this.value } })
  }

  setState(item, on) {
    item.setAttribute("data-state", on ? "on" : "off")
    item.setAttribute("aria-pressed", on ? "true" : "false")
  }

  get value() {
    const selected = this.itemTargets
      .filter((item) => item.getAttribute("data-state") === "on")
      .map((item) => item.getAttribute("data-value"))
    return this.typeValue === "single" ? (selected[0] ?? null) : selected
  }
}
