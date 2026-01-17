import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hiddenField", "rowsContainer", "row"]

  static values = {
    mode: { type: String, default: "object" },
    pairs: { type: Array, default: [] },
    disabled: { type: Boolean, default: false },
    keyPlaceholder: { type: String, default: "Key" },
    valuePlaceholder: { type: String, default: "Value" }
  }

  connect() {
    this.initializeFromHiddenField()
    this.renderRows()
  }

  initializeFromHiddenField() {
    const value = this.hiddenFieldTarget.value
    if (!value || value === "") {
      this.pairsValue = []
      return
    }

    try {
      const parsed = JSON.parse(value)
      if (Array.isArray(parsed)) {
        this.modeValue = "array"
        this.pairsValue = parsed.map(v => ({ value: String(v) }))
      } else if (typeof parsed === "object" && parsed !== null) {
        this.modeValue = "object"
        this.pairsValue = Object.entries(parsed).map(([key, value]) => ({
          key,
          value: String(value)
        }))
      }
    } catch (e) {
      this.pairsValue = []
    }
  }

  addRow(event) {
    event.preventDefault()
    if (this.disabledValue) return

    if (this.modeValue === "array") {
      this.pairsValue = [...this.pairsValue, { value: "" }]
    } else {
      this.pairsValue = [...this.pairsValue, { key: "", value: "" }]
    }
    this.renderRows()
    this.focusLastRow()
  }

  removeRow(event) {
    event.preventDefault()
    if (this.disabledValue) return

    const row = event.target.closest("[data-lui-jsonb-target='row']")
    const index = parseInt(row.dataset.index, 10)
    this.pairsValue = this.pairsValue.filter((_, i) => i !== index)
    this.renderRows()
    this.updateHiddenField()
  }

  onInputChange(event) {
    const row = event.target.closest("[data-lui-jsonb-target='row']")
    const index = parseInt(row.dataset.index, 10)
    const field = event.target.dataset.field

    const newPairs = [...this.pairsValue]
    newPairs[index] = { ...newPairs[index], [field]: event.target.value }
    this.pairsValue = newPairs

    this.updateHiddenField()
  }

  updateHiddenField() {
    let result
    if (this.modeValue === "array") {
      result = this.pairsValue.map(p => p.value)
    } else {
      result = {}
      this.pairsValue.forEach(p => {
        if (p.key !== undefined) {
          result[p.key] = p.value
        }
      })
    }
    this.hiddenFieldTarget.value = JSON.stringify(result)
  }

  renderRows() {
    this.rowsContainerTarget.innerHTML = ""

    this.pairsValue.forEach((pair, index) => {
      const row = this.createRow(pair, index)
      this.rowsContainerTarget.appendChild(row)
    })

    this.updateHiddenField()
  }

  createRow(pair, index) {
    const row = document.createElement("div")
    row.dataset.luiJsonbTarget = "row"
    row.dataset.index = index
    row.className = "lui:flex lui:items-center lui:gap-2 lui:mb-2"

    if (this.modeValue === "object") {
      const keyInput = this.createInput(pair.key || "", "key", this.keyPlaceholderValue)
      keyInput.className += " lui:flex-1"
      row.appendChild(keyInput)
    }

    const valueInput = this.createInput(pair.value || "", "value", this.valuePlaceholderValue)
    valueInput.className += " lui:flex-[2]"
    row.appendChild(valueInput)

    const removeButton = this.createRemoveButton()
    if (removeButton) {
      row.appendChild(removeButton)
    }

    return row
  }

  createInput(value, field, placeholder) {
    const wrapper = document.createElement("span")
    let wrapperClasses = "lui:relative lui:block lui:before:absolute lui:before:inset-px lui:before:rounded-[calc(var(--radius-lg)-1px)] lui:before:bg-white lui:before:shadow-sm lui:after:pointer-events-none lui:after:absolute lui:after:inset-0 lui:after:rounded-lg lui:after:ring-transparent lui:after:ring-inset lui:sm:focus-within:after:ring-2 lui:sm:focus-within:after:ring-blue-500"

    if (this.disabledValue) {
      wrapperClasses += " lui:opacity-50 lui:before:bg-zinc-950/5 lui:before:shadow-none"
    }

    wrapper.className = wrapperClasses

    const input = document.createElement("input")
    input.type = "text"
    input.value = value
    input.placeholder = placeholder
    input.dataset.field = field
    input.dataset.action = "input->lui-jsonb#onInputChange"
    input.disabled = this.disabledValue
    input.className = "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:text-base/6 lui:text-zinc-950 lui:placeholder:text-zinc-500 lui:sm:text-sm/6 lui:border lui:border-zinc-950/10 lui:hover:border-zinc-950/20 lui:bg-transparent lui:focus:outline-hidden"

    wrapper.appendChild(input)
    return wrapper
  }

  createRemoveButton() {
    if (this.disabledValue) {
      return null
    }

    const button = document.createElement("button")
    button.type = "button"
    button.dataset.action = "click->lui-jsonb#removeRow"
    button.className = "lui:flex lui:items-center lui:justify-center lui:size-9 lui:rounded-lg lui:text-zinc-500 lui:hover:text-zinc-700 lui:hover:bg-zinc-100 lui:transition-colors"
    button.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="lui:size-5"><path d="M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z" /></svg>`
    return button
  }

  focusLastRow() {
    const rows = this.rowTargets
    if (rows.length > 0) {
      const lastRow = rows[rows.length - 1]
      const firstInput = lastRow.querySelector("input")
      if (firstInput) {
        firstInput.focus()
      }
    }
  }
}
