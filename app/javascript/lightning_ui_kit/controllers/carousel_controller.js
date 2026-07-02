import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "slide", "dots", "prev", "next"]
  static values = {
    loop: Boolean,
    index: { type: Number, default: 0 }
  }

  connect() {
    this.buildDots()
    this.update()
  }

  prev() {
    this.go(this.indexValue - 1)
  }

  next() {
    this.go(this.indexValue + 1)
  }

  go(index) {
    const count = this.slideTargets.length
    if (count === 0) return

    if (this.loopValue) {
      index = (index + count) % count
    } else {
      index = Math.max(0, Math.min(index, count - 1))
    }
    this.indexValue = index
  }

  indexValueChanged() {
    this.update()
  }

  update() {
    this.trackTarget.style.transform = `translateX(-${this.indexValue * 100}%)`

    if (this.hasDotsTarget) {
      Array.from(this.dotsTarget.children).forEach((dot, i) => {
        dot.classList.toggle("lui:bg-interactive", i === this.indexValue)
        dot.classList.toggle("lui:bg-border-hover", i !== this.indexValue)
      })
    }

    if (!this.loopValue) {
      if (this.hasPrevTarget) this.prevTarget.disabled = this.indexValue === 0
      if (this.hasNextTarget) this.nextTarget.disabled = this.indexValue === this.slideTargets.length - 1
    }
  }

  buildDots() {
    if (!this.hasDotsTarget) return
    this.dotsTarget.innerHTML = ""

    this.slideTargets.forEach((_, i) => {
      const dot = document.createElement("button")
      dot.type = "button"
      dot.setAttribute("aria-label", `Go to slide ${i + 1}`)
      dot.className = "lui:size-2 lui:rounded-full lui:bg-border-hover lui:transition-colors lui:cursor-pointer"
      dot.addEventListener("click", () => this.go(i))
      this.dotsTarget.appendChild(dot)
    })
  }
}
