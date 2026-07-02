import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slot", "hidden"]
  static values = { length: Number }

  onInput(event) {
    const slot = event.target
    // Keep only the last character typed.
    slot.value = slot.value.slice(-1)
    if (slot.value) this.focusSlot(this.indexOf(slot) + 1)
    this.sync()
  }

  onKeydown(event) {
    const slot = event.target
    const index = this.indexOf(slot)

    if (event.key === "Backspace" && !slot.value && index > 0) {
      event.preventDefault()
      const prev = this.slotTargets[index - 1]
      prev.value = ""
      prev.focus()
      this.sync()
    } else if (event.key === "ArrowLeft") {
      event.preventDefault()
      this.focusSlot(index - 1)
    } else if (event.key === "ArrowRight") {
      event.preventDefault()
      this.focusSlot(index + 1)
    }
  }

  onPaste(event) {
    event.preventDefault()
    const text = event.clipboardData.getData("text").trim()
    if (!text) return

    const chars = text.split("").slice(0, this.slotTargets.length)
    chars.forEach((char, i) => {
      this.slotTargets[i].value = char
    })
    this.focusSlot(Math.min(chars.length, this.slotTargets.length - 1))
    this.sync()
  }

  onFocus(event) {
    event.target.select()
  }

  sync() {
    const value = this.slotTargets.map((slot) => slot.value).join("")
    if (this.hasHiddenTarget) this.hiddenTarget.value = value
    this.dispatch("change", { detail: { value, complete: value.length === this.slotTargets.length } })
  }

  focusSlot(index) {
    const slot = this.slotTargets[index]
    if (slot) slot.focus()
  }

  indexOf(slot) {
    return this.slotTargets.indexOf(slot)
  }
}
