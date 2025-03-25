import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "item"];

  connect() {
    this.openItem(this.itemTargets[0])
  }

  toggle(e) {
    e.preventDefault();

    this.itemTargets.forEach(item => {
      if (item.contains(e.target)) {
        if (this.isOpen(item)) {
          this.closeItem(item);
        } else {
          this.openItem(item);
        }
      } else {
        this.closeItem(item);
      }
    });
  }

  openItem(item) {
    const content = item.querySelector("[data-accordion-target=content]");
    content.classList.remove("grid-rows-[0fr]");
    content.classList.add("grid-rows-[1fr]");
    content.classList.remove("opacity-0");
    content.classList.add("opacity-100");
    const arrow = item.querySelector("[data-accordion-target=arrow]");
    arrow.classList.add("rotate-180");
  }

  closeItem(item) {
    const content = item.querySelector("[data-accordion-target=content]");
    content.classList.remove("grid-rows-[1fr]");
    content.classList.add("grid-rows-[0fr]");
    content.classList.remove("opacity-100");
    content.classList.add("opacity-0");
    const arrow = item.querySelector("[data-accordion-target=arrow]");
    arrow.classList.remove("rotate-180");
  }

  isOpen(item) {
    const content = item.querySelector("[data-accordion-target=content]");
    return content.classList.contains("grid-rows-[1fr]");
  }
}

