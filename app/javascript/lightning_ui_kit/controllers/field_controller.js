import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field"]

  fieldTargetConnected(element) {
    element.addEventListener("mouseenter", this.handleMouseEnter)
    element.addEventListener("mouseleave", this.handleMouseLeave)
  }

  fieldTargetDisconnected(element) {
    element.removeEventListener("mouseenter", this.handleMouseEnter)
    element.removeEventListener("mouseleave", this.handleMouseLeave)
  }

  handleMouseEnter = (event) => {
    event.target.dataset.hover = ""
  }

  handleMouseLeave = (event) => {
    delete event.target.dataset.hover
  }
}
