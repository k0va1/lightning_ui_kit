import { Controller } from "@hotwired/stimulus";
import { useTransition } from "stimulus-use";

export default class Dropdown extends Controller {
  static targets = ["menu"];

  connect() {
    useTransition(this, {
      element: this.menuTarget,
      hiddenClass: "lui:hidden"
    });
  }

  toggle() {
    this.toggleTransition();
  }

  hide(event) {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains("lui:hidden")) {
      this.leave();
    }
  }
}
