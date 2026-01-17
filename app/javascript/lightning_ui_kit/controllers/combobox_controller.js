import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift, size } from "@floating-ui/dom"

export default class extends Controller {
  static targets = [
    "input",
    "inputWrapper",
    "listbox",
    "optionsContainer",
    "optionTemplate",
    "option",
    "selectedTags",
    "hiddenField",
    "hiddenFields",
    "loading",
    "noResults",
    "createOption",
    "createOptionText"
  ]

  static values = {
    multiple: { type: Boolean, default: false },
    allowCustom: { type: Boolean, default: false },
    url: String,
    minChars: { type: Number, default: 0 },
    debounce: { type: Number, default: 300 },
    options: { type: Array, default: [] },
    selected: { type: Array, default: [] },
    foreignKey: String,
    nestedModel: String
  }

  connect() {
    this.isOpen = false
    this.highlightedIndex = -1
    this.filteredOptions = []
    this.cleanup = null
    this.debounceTimer = null

    // Store original selected for detecting removals in association mode
    this.originalSelected = this.deepClone(this.selectedValue)

    this.initializeSelected()

    if (!this.hasUrlValue) {
      this.filteredOptions = this.optionsValue
    }
  }

  get isAssociationMode() {
    return this.hasForeignKeyValue
  }

  disconnect() {
    this.destroyFloating()
    this.clearDebounce()
  }

  // Event Handlers

  onInput(event) {
    const query = event.target.value.trim()

    if (this.hasUrlValue) {
      this.clearDebounce()
      if (query.length >= this.minCharsValue) {
        this.debounceTimer = setTimeout(() => {
          this.fetchOptions(query)
        }, this.debounceValue)
      } else {
        this.filteredOptions = []
        this.renderOptions()
      }
    } else {
      this.filterClientSide(query)
    }

    this.open()
    this.updateCreateOption(query)
  }

  onFocus() {
    if (!this.hasUrlValue || this.inputTarget.value.length >= this.minCharsValue) {
      if (!this.hasUrlValue) {
        this.filteredOptions = this.optionsValue
        this.filterClientSide(this.inputTarget.value.trim())
      }
      this.open()
    }
  }

  onKeydown(event) {
    // Handle Ctrl+N and Ctrl+P for navigation
    if (event.ctrlKey) {
      if (event.key === "n") {
        event.preventDefault()
        if (!this.isOpen) {
          this.open()
        } else {
          this.highlightNext()
        }
        return
      }
      if (event.key === "p") {
        event.preventDefault()
        if (!this.isOpen) {
          this.open()
        } else {
          this.highlightPrevious()
        }
        return
      }
    }

    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()
        if (!this.isOpen) {
          this.open()
        } else {
          this.highlightNext()
        }
        break
      case "ArrowUp":
        event.preventDefault()
        if (!this.isOpen) {
          this.open()
        } else {
          this.highlightPrevious()
        }
        break
      case "Enter":
        event.preventDefault()
        this.selectHighlighted()
        break
      case "Escape":
        this.close()
        this.inputTarget.value = ""
        break
      case "Backspace":
        if (this.multipleValue && this.inputTarget.value === "") {
          this.removeLastSelected()
        }
        break
      case "Tab":
        this.close()
        break
    }
  }

  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  // Selection Management

  selectOption(event) {
    event.stopPropagation() // Prevent clickOutside from firing

    const optionEl = event.currentTarget
    if (optionEl.dataset.disabled === "true") return

    const value = optionEl.dataset.value
    const label = optionEl.dataset.label

    if (this.multipleValue) {
      this.toggleSelection(value, label)
    } else {
      this.setSingleSelection(value, label)
      this.close()
    }
  }

  toggleSelection(value, _label, isCustom = false) {
    const selectedIdx = this.findSelectedIndex(value)

    if (selectedIdx > -1) {
      // Remove from selection
      this.selectedValue = this.selectedValue.filter((_, i) => i !== selectedIdx)
    } else {
      // Add to selection
      if (this.isAssociationMode) {
        // In association mode, store as object
        const newItem = { value: value }
        if (isCustom) {
          newItem.custom = true
        }
        this.selectedValue = [...this.selectedValue, newItem]
      } else {
        this.selectedValue = [...this.selectedValue, value]
      }
    }

    this.updateSelectedTags()
    this.updateHiddenFields()
    this.renderOptions()
    this.inputTarget.value = ""
    this.inputTarget.focus()
  }

  findSelectedIndex(value) {
    return this.selectedValue.findIndex(item => {
      const itemValue = typeof item === 'object' ? item.value : item
      return String(itemValue) === String(value)
    })
  }

  setSingleSelection(value, label) {
    this.selectedValue = [value]
    this.inputTarget.value = label
    this.updateHiddenField(value)
  }

  removeLastSelected() {
    if (this.selectedValue.length > 0) {
      this.selectedValue = this.selectedValue.slice(0, -1)
      this.updateSelectedTags()
      this.updateHiddenFields()
      this.renderOptions()
    }
  }

  removeTag(event) {
    event.preventDefault()
    event.stopPropagation()
    const value = event.currentTarget.dataset.value
    const selectedIdx = this.findSelectedIndex(value)
    if (selectedIdx > -1) {
      this.selectedValue = this.selectedValue.filter((_, i) => i !== selectedIdx)
    }
    this.updateSelectedTags()
    this.updateHiddenFields()
    this.renderOptions()
    this.inputTarget.focus()
  }

  createCustomOption() {
    const value = this.inputTarget.value.trim()
    if (value && this.allowCustomValue) {
      if (this.multipleValue) {
        this.toggleSelection(value, value, true) // isCustom = true
      } else {
        this.setSingleSelection(value, value)
      }
      this.close()
    }
  }

  // Filtering

  filterClientSide(query) {
    if (!query) {
      this.filteredOptions = this.optionsValue
    } else {
      const lowerQuery = query.toLowerCase()
      this.filteredOptions = this.optionsValue.filter(opt =>
        opt.label.toLowerCase().includes(lowerQuery)
      )
    }
    this.highlightedIndex = this.filteredOptions.length > 0 ? 0 : -1
    this.renderOptions()
  }

  async fetchOptions(query) {
    this.showLoading()

    try {
      const url = new URL(this.urlValue, window.location.origin)
      url.searchParams.set("q", query)

      const response = await fetch(url, {
        headers: {
          "Accept": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        }
      })

      if (!response.ok) throw new Error("Network error")

      const data = await response.json()
      this.filteredOptions = data
      this.highlightedIndex = data.length > 0 ? 0 : -1
      this.renderOptions()
    } catch (error) {
      console.error("Combobox fetch error:", error)
      this.filteredOptions = []
      this.renderOptions()
    } finally {
      this.hideLoading()
    }
  }

  // Rendering

  renderOptions() {
    const container = this.optionsContainerTarget
    container.innerHTML = ""

    if (this.filteredOptions.length === 0) {
      this.showNoResults()
      return
    }

    this.hideNoResults()

    this.filteredOptions.forEach((opt, index) => {
      const template = this.optionTemplateTarget.content.cloneNode(true)
      const optionEl = template.querySelector("[role='option']")

      optionEl.dataset.value = opt.value
      optionEl.dataset.label = opt.label
      optionEl.dataset.index = index
      optionEl.querySelector("[data-label]").textContent = opt.label

      const isSelected = this.isValueSelected(opt.value)
      if (isSelected) {
        optionEl.dataset.selected = "true"
        optionEl.setAttribute("aria-selected", "true")
        optionEl.querySelector("[data-checkmark]").classList.remove("lui:hidden")
      }

      if (index === this.highlightedIndex) {
        optionEl.dataset.highlighted = "true"
      }

      if (opt.disabled) {
        optionEl.dataset.disabled = "true"
        optionEl.setAttribute("aria-disabled", "true")
      }

      container.appendChild(template)
    })
  }

  updateSelectedTags() {
    if (!this.multipleValue || !this.hasSelectedTagsTarget) return

    // Remove existing tags (but keep input and chevron)
    const existingTags = this.selectedTagsTarget.querySelectorAll("[data-combobox-tag]")
    existingTags.forEach(tag => tag.remove())

    // Insert new tags before the input
    this.selectedValue.forEach(item => {
      const value = this.getItemValue(item)
      const opt = this.findOptionByValue(value)
      const label = opt ? opt.label : value

      const tag = document.createElement("span")
      tag.setAttribute("data-combobox-tag", "true")
      tag.className = "lui:inline-flex lui:items-center lui:gap-1 lui:rounded-md lui:bg-zinc-100 lui:px-2 lui:py-0.5 lui:text-sm lui:text-zinc-700"
      tag.innerHTML = `
        <span class="lui:truncate lui:max-w-[150px]">${this.escapeHtml(label)}</span>
        <button type="button" data-value="${this.escapeHtml(String(value))}" data-action="click->lui-combobox#removeTag" class="lui:text-zinc-500 lui:hover:text-zinc-700 lui:flex-shrink-0 lui:ml-0.5">
          <svg class="lui:h-3.5 lui:w-3.5" viewBox="0 0 16 16" fill="currentColor">
            <path d="M5.28 4.22a.75.75 0 00-1.06 1.06L6.94 8l-2.72 2.72a.75.75 0 101.06 1.06L8 9.06l2.72 2.72a.75.75 0 101.06-1.06L9.06 8l2.72-2.72a.75.75 0 00-1.06-1.06L8 6.94 5.28 4.22z"/>
          </svg>
        </button>
      `
      this.inputTarget.insertAdjacentElement("beforebegin", tag)
    })
  }

  // Hidden Field Management

  updateHiddenField(value) {
    if (this.hasHiddenFieldTarget) {
      this.hiddenFieldTarget.value = value
    }
  }

  updateHiddenFields() {
    if (!this.hasHiddenFieldsTarget) return

    if (this.isAssociationMode) {
      this.updateNestedHiddenFields()
    } else {
      this.updateSimpleHiddenFields()
    }
  }

  updateSimpleHiddenFields() {
    const container = this.hiddenFieldsTarget
    const name = container.dataset.name

    container.innerHTML = ""

    this.selectedValue.forEach(item => {
      const value = this.getItemValue(item)
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = name
      input.value = value
      container.appendChild(input)
    })
  }

  updateNestedHiddenFields() {
    const container = this.hiddenFieldsTarget
    const baseName = container.dataset.name
    const fk = this.foreignKeyValue
    const nestedModel = this.hasNestedModelValue ? this.nestedModelValue : null

    container.innerHTML = ""
    let idx = 0

    // Current selections (preserved existing + new)
    this.selectedValue.forEach(item => {
      const isObject = typeof item === 'object'
      const joinId = isObject ? item.join_id : null
      const value = isObject ? item.value : item
      const isCustom = isObject ? item.custom : !this.isExistingOption(value)

      if (joinId) {
        // Existing record - include join table id
        this.addHiddenInput(container, `${baseName}[${idx}][id]`, joinId)
      }

      if (isCustom && nestedModel) {
        // New record via nested attributes (e.g., tag_attributes[name])
        this.addHiddenInput(container, `${baseName}[${idx}][${nestedModel}_attributes][name]`, value)
      } else {
        // Existing record by foreign key (e.g., tag_id)
        this.addHiddenInput(container, `${baseName}[${idx}][${fk}]`, value)
      }
      idx++
    })

    // Removed records - mark for destruction
    this.originalSelected.forEach(orig => {
      const origValue = typeof orig === 'object' ? orig.value : orig
      const origJoinId = typeof orig === 'object' ? orig.join_id : null

      const stillSelected = this.selectedValue.some(sel => {
        const selValue = typeof sel === 'object' ? sel.value : sel
        return String(selValue) === String(origValue)
      })

      if (!stillSelected && origJoinId) {
        this.addHiddenInput(container, `${baseName}[${idx}][id]`, origJoinId)
        this.addHiddenInput(container, `${baseName}[${idx}][_destroy]`, 'true')
        idx++
      }
    })
  }

  addHiddenInput(container, name, value) {
    const input = document.createElement("input")
    input.type = "hidden"
    input.name = name
    input.value = value
    container.appendChild(input)
  }

  // Dropdown Positioning (Floating UI)

  open() {
    if (this.isOpen) return

    this.isOpen = true
    this.listboxTarget.classList.remove("lui:hidden")
    this.inputTarget.setAttribute("aria-expanded", "true")

    // Use inputWrapper for positioning in multiple mode, otherwise use input
    const referenceEl = this.hasInputWrapperTarget ? this.inputWrapperTarget : this.inputTarget

    this.cleanup = autoUpdate(
      referenceEl,
      this.listboxTarget,
      () => this.updatePosition()
    )
  }

  close() {
    if (!this.isOpen) return

    this.isOpen = false
    this.listboxTarget.classList.add("lui:hidden")
    this.inputTarget.setAttribute("aria-expanded", "false")
    this.highlightedIndex = -1
    this.destroyFloating()
  }

  updatePosition() {
    const referenceEl = this.hasInputWrapperTarget ? this.inputWrapperTarget : this.inputTarget

    computePosition(referenceEl, this.listboxTarget, {
      placement: "bottom-start",
      middleware: [
        offset(4),
        flip({ padding: 8 }),
        shift({ padding: 8 }),
        size({
          apply({ availableHeight, rects, elements }) {
            elements.floating.style.maxHeight = `${Math.min(240, availableHeight)}px`
            elements.floating.style.width = `${rects.reference.width}px`
          }
        })
      ]
    }).then(({ x, y }) => {
      Object.assign(this.listboxTarget.style, {
        position: "absolute",
        left: `${x}px`,
        top: `${y}px`
      })
    })
  }

  destroyFloating() {
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }
  }

  // Keyboard Navigation

  highlightNext() {
    if (this.filteredOptions.length === 0) return
    this.highlightedIndex = (this.highlightedIndex + 1) % this.filteredOptions.length
    this.updateHighlight()
  }

  highlightPrevious() {
    if (this.filteredOptions.length === 0) return
    this.highlightedIndex = this.highlightedIndex <= 0
      ? this.filteredOptions.length - 1
      : this.highlightedIndex - 1
    this.updateHighlight()
  }

  updateHighlight() {
    this.optionTargets.forEach((el, index) => {
      if (index === this.highlightedIndex) {
        el.dataset.highlighted = "true"
        el.scrollIntoView({ block: "nearest" })
      } else {
        delete el.dataset.highlighted
      }
    })
  }

  selectHighlighted() {
    if (this.highlightedIndex >= 0 && this.highlightedIndex < this.filteredOptions.length) {
      const opt = this.filteredOptions[this.highlightedIndex]
      if (opt.disabled) return

      if (this.multipleValue) {
        this.toggleSelection(String(opt.value), opt.label)
      } else {
        this.setSingleSelection(String(opt.value), opt.label)
        this.close()
      }
    } else if (this.allowCustomValue && this.inputTarget.value.trim()) {
      this.createCustomOption()
    }
  }

  highlightOption(event) {
    const index = parseInt(event.currentTarget.dataset.index, 10)
    if (!isNaN(index)) {
      this.highlightedIndex = index
      this.updateHighlight()
    }
  }

  // Utility Methods

  findOptionByValue(value) {
    return this.optionsValue.find(opt => String(opt.value) === String(value)) ||
           this.filteredOptions.find(opt => String(opt.value) === String(value))
  }

  initializeSelected() {
    if (this.multipleValue) {
      this.updateSelectedTags()
      this.updateHiddenFields()
    } else if (this.selectedValue.length > 0) {
      const opt = this.findOptionByValue(this.selectedValue[0])
      if (opt) {
        this.inputTarget.value = opt.label
      } else {
        this.inputTarget.value = this.selectedValue[0]
      }
    }
  }

  updateCreateOption(query) {
    if (!this.allowCustomValue || !this.hasCreateOptionTarget) return

    const valueExists = this.filteredOptions.some(opt =>
      String(opt.value).toLowerCase() === query.toLowerCase() ||
      opt.label.toLowerCase() === query.toLowerCase()
    )

    if (query && !valueExists) {
      this.createOptionTarget.classList.remove("lui:hidden")
      this.createOptionTextTarget.textContent = query
    } else {
      this.createOptionTarget.classList.add("lui:hidden")
    }
  }

  showLoading() {
    if (this.hasLoadingTarget) {
      this.loadingTarget.classList.remove("lui:hidden")
      this.hideNoResults()
    }
  }

  hideLoading() {
    if (this.hasLoadingTarget) {
      this.loadingTarget.classList.add("lui:hidden")
    }
  }

  showNoResults() {
    if (this.hasNoResultsTarget) {
      this.noResultsTarget.classList.remove("lui:hidden")
    }
  }

  hideNoResults() {
    if (this.hasNoResultsTarget) {
      this.noResultsTarget.classList.add("lui:hidden")
    }
  }

  clearDebounce() {
    if (this.debounceTimer) {
      clearTimeout(this.debounceTimer)
      this.debounceTimer = null
    }
  }

  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text
    return div.innerHTML
  }

  // Helper to get the value from an item (handles both simple values and objects)
  getItemValue(item) {
    return typeof item === 'object' ? item.value : item
  }

  // Check if a value is currently selected
  isValueSelected(value) {
    return this.findSelectedIndex(value) > -1
  }

  // Check if a value exists in the options (not a custom value)
  isExistingOption(value) {
    return this.optionsValue.some(opt => String(opt.value) === String(value))
  }

  // Deep clone for storing original selected state
  deepClone(obj) {
    return JSON.parse(JSON.stringify(obj))
  }
}
