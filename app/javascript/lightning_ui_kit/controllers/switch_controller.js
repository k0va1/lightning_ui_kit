import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  toggle(event) {
    event.preventDefault();

    const button = event.currentTarget;
    if (button.dataset.checked) {
      this.fieldTarget.value = false;
      delete button.dataset.checked;
    } else {
      this.fieldTarget.value = true;
      button.dataset.checked = true;
    }
  }
}
