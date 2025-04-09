import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    this.element.classList.remove("lui:opacity-100");
    this.element.classList.add("lui:opacity-0");
    setTimeout(() => {
      this.element.classList.add("lui:hidden");
    }, 300);
  }
}
