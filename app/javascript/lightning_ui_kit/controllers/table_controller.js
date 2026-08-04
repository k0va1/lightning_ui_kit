import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectAll", "rowCheckbox", "bulkBar", "count"]

  connect() {
    this.update()
  }

  toggleAll(event) {
    const checked = event.currentTarget.checked
    this.rowCheckboxTargets.forEach((checkbox) => {
      if (!checkbox.disabled) checkbox.checked = checked
    })
    this.update()
  }

  toggleCell(event) {
    if (event.target.closest("a, button, input, label")) return
    event.stopPropagation()

    this.toggleCheckboxIn(event.currentTarget)
  }

  toggleRow(event) {
    if (event.target.closest("a, button, input, label")) return
    if (window.getSelection()?.toString()) return

    this.toggleCheckboxIn(event.currentTarget)
  }

  toggleCheckboxIn(container) {
    const checkbox = container.querySelector("input[type=checkbox]")
    if (!checkbox || checkbox.disabled) return

    checkbox.checked = !checkbox.checked
    this.update()
  }

  update() {
    const total = this.rowCheckboxTargets.length
    const selected = this.rowCheckboxTargets.filter((checkbox) => checkbox.checked).length

    this.selectAllTargets.forEach((checkbox) => {
      checkbox.checked = total > 0 && selected === total
      checkbox.indeterminate = selected > 0 && selected < total
    })

    this.rowCheckboxTargets.forEach((checkbox) => {
      const row = checkbox.closest("tr")
      if (!row) return

      if (checkbox.checked) {
        row.dataset.selected = ""
      } else {
        delete row.dataset.selected
      }
    })

    if (this.hasCountTarget) {
      this.countTarget.textContent = selected
    }

    if (this.hasBulkBarTarget) {
      this.bulkBarTarget.classList.toggle("lui:hidden", selected === 0)
      this.bulkBarTarget.classList.toggle("lui:flex", selected > 0)
    }
  }

  visitRow(event) {
    if (event.target.closest("a, button, input, label")) return

    const url = event.currentTarget.dataset.url
    if (!url) return

    if (window.Turbo) {
      window.Turbo.visit(url)
    } else {
      window.location.assign(url)
    }
  }
}
