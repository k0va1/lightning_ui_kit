import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "panel"];
  static values = {
    defaultTab: { type: Number, default: 0 }
  };

  connect() {
    this.activate(this.defaultTabValue);
  }

  select(event) {
    event.preventDefault();
    const index = this.tabTargets.indexOf(event.currentTarget);
    if (index !== -1) {
      this.activate(index);
    }
  }

  activate(index) {
    this.tabTargets.forEach((tab, i) => {
      if (i === index) {
        tab.dataset.active = "";
        tab.setAttribute("aria-selected", "true");
        tab.setAttribute("tabindex", "0");
      } else {
        delete tab.dataset.active;
        tab.setAttribute("aria-selected", "false");
        tab.setAttribute("tabindex", "-1");
      }
    });

    this.panelTargets.forEach((panel, i) => {
      if (i === index) {
        panel.classList.remove("lui:hidden");
      } else {
        panel.classList.add("lui:hidden");
      }
    });
  }

  tabTargetConnected() {
    this.tabTargets.forEach((tab) => {
      tab.addEventListener("keydown", this.handleKeydown.bind(this));
    });
  }

  handleKeydown(event) {
    const currentIndex = this.tabTargets.indexOf(event.currentTarget);
    let newIndex;

    switch (event.key) {
      case "ArrowLeft":
        event.preventDefault();
        newIndex = currentIndex === 0 ? this.tabTargets.length - 1 : currentIndex - 1;
        break;
      case "ArrowRight":
        event.preventDefault();
        newIndex = currentIndex === this.tabTargets.length - 1 ? 0 : currentIndex + 1;
        break;
      case "Home":
        event.preventDefault();
        newIndex = 0;
        break;
      case "End":
        event.preventDefault();
        newIndex = this.tabTargets.length - 1;
        break;
      default:
        return;
    }

    this.activate(newIndex);
    this.tabTargets[newIndex].focus();
  }
}
