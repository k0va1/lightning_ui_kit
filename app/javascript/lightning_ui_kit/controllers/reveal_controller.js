import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = { initialShow: Boolean }

  connect() {
    if (!this.initialShowValue) {
      this.itemTargets.forEach(item => {
        item.classList.add("hidden");
      });
    }
  }

  toggle(event) {
    event.preventDefault();

    this.itemTargets.forEach(item => {
      item.classList.toggle("hidden");
    });
  }
}
