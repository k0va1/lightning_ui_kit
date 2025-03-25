import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "control"]

  toggle(event) {
    event.preventDefault();

    const checkbox = this.controlTarget
    if (checkbox.dataset.checked) {
      this.fieldTarget.value = false;
      delete checkbox.dataset.checked;
    } else {
      this.fieldTarget.value = true;
      checkbox.dataset.checked = true;
    }
  }
}
