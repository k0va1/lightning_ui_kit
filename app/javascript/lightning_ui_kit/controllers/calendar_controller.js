import { Controller } from "@hotwired/stimulus"

const WEEKDAYS = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
const MONTHS = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
]

export default class extends Controller {
  static targets = ["label", "grid", "input"]
  static values = { selected: String, month: String }

  connect() {
    const monthStr = this.monthValue || (this.selectedValue ? this.selectedValue.slice(0, 7) : null)
    if (monthStr) {
      const [year, month] = monthStr.split("-").map(Number)
      this.viewYear = year
      this.viewMonth = month - 1
    } else {
      const now = new Date()
      this.viewYear = now.getFullYear()
      this.viewMonth = now.getMonth()
    }
    this.selected = this.selectedValue || null
    this.render()
  }

  prevMonth() {
    this.shiftMonth(-1)
  }

  nextMonth() {
    this.shiftMonth(1)
  }

  shiftMonth(delta) {
    this.viewMonth += delta
    if (this.viewMonth < 0) {
      this.viewMonth = 11
      this.viewYear -= 1
    } else if (this.viewMonth > 11) {
      this.viewMonth = 0
      this.viewYear += 1
    }
    this.render()
  }

  selectDate(iso) {
    this.selected = iso
    if (this.hasInputTarget) this.inputTarget.value = iso
    this.render()
    this.dispatch("select", { detail: { date: iso } })
  }

  render() {
    this.labelTarget.textContent = `${MONTHS[this.viewMonth]} ${this.viewYear}`
    this.gridTarget.innerHTML = ""

    WEEKDAYS.forEach((weekday) => {
      const cell = document.createElement("div")
      cell.className = "lui:flex lui:h-8 lui:w-8 lui:items-center lui:justify-center lui:text-xs lui:font-normal lui:text-foreground-muted"
      cell.textContent = weekday
      this.gridTarget.appendChild(cell)
    })

    const firstDay = new Date(this.viewYear, this.viewMonth, 1).getDay()
    const daysInMonth = new Date(this.viewYear, this.viewMonth + 1, 0).getDate()
    const todayIso = this.toIso(new Date())

    for (let i = 0; i < firstDay; i++) {
      const blank = document.createElement("div")
      blank.className = "lui:h-8 lui:w-8"
      this.gridTarget.appendChild(blank)
    }

    for (let day = 1; day <= daysInMonth; day++) {
      const iso = `${this.viewYear}-${String(this.viewMonth + 1).padStart(2, "0")}-${String(day).padStart(2, "0")}`
      const button = document.createElement("button")
      button.type = "button"
      button.dataset.date = iso
      button.textContent = day
      button.className = this.dayClasses(iso, todayIso)
      button.addEventListener("click", () => this.selectDate(iso))
      this.gridTarget.appendChild(button)
    }
  }

  dayClasses(iso, todayIso) {
    let classes = "lui:flex lui:h-8 lui:w-8 lui:items-center lui:justify-center lui:rounded-md lui:text-sm lui:text-foreground lui:transition-colors lui:cursor-pointer lui:hover:bg-surface-hover"
    if (iso === this.selected) {
      classes += " lui:bg-interactive lui:text-foreground-invert lui:hover:bg-interactive"
    } else if (iso === todayIso) {
      classes += " lui:border lui:border-border lui:font-medium"
    }
    return classes
  }

  toIso(date) {
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`
  }
}
