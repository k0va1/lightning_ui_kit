import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openModal() {
    this.findElement("lui-modal").open()
  }

  closeModal() {
    this.findElement("lui-modal").close()
  }

  findElement(type) {
    const targetId = this.element.dataset.target.replace("#", "")
    const target = document.getElementById(targetId)
    return this.application.getControllerForElementAndIdentifier(target, type)
  }
}
