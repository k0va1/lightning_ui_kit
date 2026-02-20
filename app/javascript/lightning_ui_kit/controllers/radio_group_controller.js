import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field", "option"];

  select(event) {
    const option = event.currentTarget;
    if (option.dataset.disabled !== undefined) return;

    this.activate(option);
  }

  keydown(event) {
    const currentIndex = this.optionTargets.indexOf(event.currentTarget);
    let newIndex;

    switch (event.key) {
      case "ArrowDown":
      case "ArrowRight":
        event.preventDefault();
        newIndex = this.nextEnabledIndex(currentIndex, 1);
        break;
      case "ArrowUp":
      case "ArrowLeft":
        event.preventDefault();
        newIndex = this.nextEnabledIndex(currentIndex, -1);
        break;
      case " ":
      case "Enter":
        event.preventDefault();
        this.activate(event.currentTarget);
        return;
      default:
        return;
    }

    if (newIndex !== -1) {
      this.activate(this.optionTargets[newIndex]);
      this.optionTargets[newIndex].focus();
    }
  }

  activate(option) {
    const value = option.dataset.value;

    this.optionTargets.forEach((opt) => {
      if (opt === option) {
        opt.dataset.checked = "";
        opt.setAttribute("aria-checked", "true");
        opt.setAttribute("tabindex", "0");
      } else {
        delete opt.dataset.checked;
        opt.setAttribute("aria-checked", "false");
        opt.setAttribute("tabindex", "-1");
      }
    });

    this.fieldTarget.value = value;
  }

  nextEnabledIndex(currentIndex, direction) {
    const length = this.optionTargets.length;
    let index = currentIndex;

    for (let i = 0; i < length; i++) {
      index = (index + direction + length) % length;
      if (this.optionTargets[index].dataset.disabled === undefined) {
        return index;
      }
    }

    return -1;
  }
}
