import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift, arrow, size } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["template"]
  static values = {
    active: Boolean,
    position: String,
    delay: { type: Number, default: 0 },
    offset: { type: Number, default: 8 }
  }

  connect() {
    this.showTimeout = null
    this.hideTimeout = null
    this.cleanup = null

    // Handle ESC key to close tooltip
    this.handleKeydown = this.handleKeydown.bind(this)

    // Handle touch devices - click to toggle
    if ('ontouchstart' in window) {
      this.element.addEventListener('click', this.toggle.bind(this))
    }
  }

  disconnect() {
    this.hide()
    this.clearTimeouts()

    if ('ontouchstart' in window) {
      this.element.removeEventListener('click', this.toggle.bind(this))
    }
  }

  show(event) {
    if (!this.activeValue) return

    // Prevent multiple tooltips
    this.hideOtherTooltips()

    // Clear any pending hide
    this.clearTimeouts()

    if (this.delayValue > 0) {
      this.showTimeout = setTimeout(() => this.createTooltip(event), this.delayValue)
    } else {
      this.createTooltip(event)
    }
  }

  hide() {
    this.clearTimeouts()

    if (this.delayValue > 0) {
      this.hideTimeout = setTimeout(() => this.destroyTooltip(), this.delayValue)
    } else {
      this.destroyTooltip()
    }
  }

  toggle(event) {
    if (this.tooltip) {
      this.hide()
    } else {
      this.show(event)
    }
  }

  createTooltip(event) {
    if (this.tooltip) return

    const triggerElement = event?.currentTarget || this.element

    try {
      // Create tooltip element
      const tooltip = document.createElement("div")
      tooltip.innerHTML = this.templateTarget.innerHTML
      tooltip.style.position = "absolute"
      tooltip.style.zIndex = "9999"
      tooltip.setAttribute('role', 'tooltip')
      tooltip.setAttribute('data-lui-tooltip-instance', 'true')
      document.body.appendChild(tooltip)
      this.tooltip = tooltip

      // Find the actual tooltip content (first child)
      const tooltipContent = tooltip.firstElementChild
      const arrowElement = tooltipContent?.querySelector("[data-tooltip-arrow]")

      if (tooltipContent) {
        // Set up auto-updating position
        this.cleanup = autoUpdate(
          triggerElement,
          tooltipContent,
          () => this.updatePosition(triggerElement, tooltipContent, arrowElement)
        )

        // Trigger fade-in animation
        requestAnimationFrame(() => {
          tooltipContent.style.opacity = '1'
        })

        // Add keyboard listener
        document.addEventListener('keydown', this.handleKeydown)
      }
    } catch (error) {
      console.warn('Tooltip positioning failed:', error)
      this.destroyTooltip()
    }
  }

  destroyTooltip() {
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }

    if (this.tooltip) {
      const tooltipContent = this.tooltip.firstElementChild
      
      if (tooltipContent) {
        // Fade out animation
        tooltipContent.style.opacity = '0'
        
        // Remove after transition completes
        setTimeout(() => {
          if (this.tooltip) {
            this.tooltip.remove()
            this.tooltip = null
          }
        }, 200) // Match the transition duration
      } else {
        this.tooltip.remove()
        this.tooltip = null
      }
    }

    document.removeEventListener('keydown', this.handleKeydown)
  }

  updatePosition(triggerElement, tooltipContent, arrowElement) {
    if (!tooltipContent) return

    computePosition(triggerElement, tooltipContent, {
      placement: this.positionValue || "bottom",
      middleware: [
        offset(this.offsetValue),
        size(),
        flip(),
        shift({ padding: 5 }),
        ...(arrowElement ? [arrow({ element: arrowElement })] : [])
      ],
    }).then(({ x, y, placement, middlewareData }) => {
      Object.assign(tooltipContent.style, {
        left: `${x}px`,
        top: `${y}px`,
      })

      if (arrowElement && middlewareData.arrow) {
        this.positionArrow(arrowElement, placement, middlewareData.arrow)
      }
    }).catch(error => {
      console.warn('Tooltip positioning update failed:', error)
    })
  }

  positionArrow(arrowElement, placement, arrowData) {
    const { x: arrowX, y: arrowY } = arrowData
    const primaryPlacement = placement.split('-')[0]

    // Reset arrow styles
    Object.assign(arrowElement.style, {
      left: '',
      top: '',
      right: '',
      bottom: '',
    })

    const arrowOffset = '-4px'

    switch (primaryPlacement) {
      case 'top':
        Object.assign(arrowElement.style, {
          left: arrowX != null ? `${arrowX}px` : '',
          bottom: arrowOffset,
        })
        break
      case 'bottom':
        Object.assign(arrowElement.style, {
          left: arrowX != null ? `${arrowX}px` : '',
          top: arrowOffset,
        })
        break
      case 'left':
        Object.assign(arrowElement.style, {
          top: arrowY != null ? `${arrowY}px` : '',
          right: arrowOffset,
        })
        break
      case 'right':
        Object.assign(arrowElement.style, {
          top: arrowY != null ? `${arrowY}px` : '',
          left: arrowOffset,
        })
        break
    }
  }

  handleKeydown(event) {
    if (event.key === 'Escape' && this.tooltip) {
      this.hide()
    }
  }

  hideOtherTooltips() {
    // Hide any other active tooltips
    document.querySelectorAll('[data-lui-tooltip-instance="true"]').forEach(tooltip => {
      if (tooltip !== this.tooltip) {
        tooltip.remove()
      }
    })
  }

  clearTimeouts() {
    if (this.showTimeout) {
      clearTimeout(this.showTimeout)
      this.showTimeout = null
    }

    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout)
      this.hideTimeout = null
    }
  }
}
