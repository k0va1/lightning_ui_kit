import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { pressed: Boolean }

  toggle() {
    if (this.element.disabled) return
    this.pressedValue = !this.pressedValue
  }

  pressedValueChanged() {
    this.element.setAttribute("data-state", this.pressedValue ? "on" : "off")
    this.element.setAttribute("aria-pressed", this.pressedValue ? "true" : "false")
    this.dispatch("change", { detail: { pressed: this.pressedValue } })
  }
}
