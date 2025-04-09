import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "item"];
  static values = {
    openFirst: { type: Boolean, default: true }
  };

  connect() {
    if (this.openFirstValue) {
      this.openItem(this.itemTargets[0]);
    }
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
    const content = item.querySelector("[data-lui-accordion-target=content]");
    content.classList.remove("lui:grid-rows-[0fr]");
    content.classList.add("lui:grid-rows-[1fr]");
    content.classList.remove("lui:opacity-0");
    content.classList.add("lui:opacity-100");
    const arrow = item.querySelector("[data-lui-accordion-target=arrow]");
    arrow.classList.add("lui:rotate-180");
  }

  closeItem(item) {
    const content = item.querySelector("[data-lui-accordion-target=content]");
    content.classList.remove("lui:grid-rows-[1fr]");
    content.classList.add("lui:grid-rows-[0fr]");
    content.classList.remove("lui:opacity-100");
    content.classList.add("lui:opacity-0");
    const arrow = item.querySelector("[data-lui-accordion-target=arrow]");
    arrow.classList.remove("lui:rotate-180");
  }

  isOpen(item) {
    const content = item.querySelector("[data-lui-accordion-target=content]");
    return content.classList.contains("lui:grid-rows-[1fr]");
  }
}

