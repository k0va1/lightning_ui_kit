import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "item", "empty", "list"]

  connect() {
    this.activeIndex = -1
    this.filter()
  }

  filter() {
    const query = this.inputTarget.value.trim().toLowerCase()
    let visibleCount = 0

    this.itemTargets.forEach((item) => {
      const match = item.textContent.toLowerCase().includes(query)
      item.classList.toggle("lui:hidden", !match)
      if (match) visibleCount++
    })

    this.emptyTarget.classList.toggle("lui:hidden", visibleCount > 0)
    this.activeIndex = -1
    this.setActive(this.visibleItems[0])
  }

  onKeydown(event) {
    const items = this.visibleItems
    if (items.length === 0) return

    if (event.key === "ArrowDown") {
      event.preventDefault()
      this.activeIndex = Math.min(this.activeIndex + 1, items.length - 1)
      this.setActive(items[this.activeIndex])
    } else if (event.key === "ArrowUp") {
      event.preventDefault()
      this.activeIndex = Math.max(this.activeIndex - 1, 0)
      this.setActive(items[this.activeIndex])
    } else if (event.key === "Enter") {
      event.preventDefault()
      const active = items[this.activeIndex] || items[0]
      if (active) this.commit(active)
    }
  }

  activate(event) {
    const items = this.visibleItems
    this.activeIndex = items.indexOf(event.currentTarget)
    this.setActive(event.currentTarget)
  }

  select(event) {
    this.commit(event.currentTarget)
  }

  commit(item) {
    this.dispatch("select", { detail: { value: item.getAttribute("data-value") } })
  }

  setActive(item) {
    this.itemTargets.forEach((el) => el.removeAttribute("data-active"))
    if (item) {
      item.setAttribute("data-active", "")
      this.activeIndex = this.visibleItems.indexOf(item)
      item.scrollIntoView({ block: "nearest" })
    }
  }

  get visibleItems() {
    return this.itemTargets.filter((item) => !item.classList.contains("lui:hidden"))
  }
}
