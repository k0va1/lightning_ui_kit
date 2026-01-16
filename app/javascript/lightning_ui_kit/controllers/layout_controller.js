import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay"]

  openSidebar() {
    this.overlayTarget.dataset.open = ""
    document.body.style.overflow = "hidden"
  }

  closeSidebar() {
    delete this.overlayTarget.dataset.open
    document.body.style.overflow = ""
  }

  disconnect() {
    document.body.style.overflow = ""
  }
}
