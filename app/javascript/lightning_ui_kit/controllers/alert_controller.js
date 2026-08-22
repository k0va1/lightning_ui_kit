import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    autodismiss: Boolean,
    dismissAfter: { type: Number, default: 5000 }
  }

  connect() {
    this.scheduleDismiss()
  }

  disconnect() {
    this.cancelDismiss()
  }

  pause() {
    this.cancelDismiss()
  }

  resume() {
    this.scheduleDismiss()
  }

  scheduleDismiss() {
    if (!this.autodismissValue) return
    this.cancelDismiss()
    this.timeout = setTimeout(() => this.close(), this.dismissAfterValue)
  }

  cancelDismiss() {
    if (this.timeout) clearTimeout(this.timeout)
    this.timeout = null
  }

  // Fades the alert out while collapsing the space it occupied (height,
  // margins, padding, borders), so surrounding content reflows smoothly
  // instead of jumping when it disappears.
  close() {
    this.cancelDismiss()
    const el = this.element
    if (!el.animate || window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      el.remove()
      return
    }

    const style = getComputedStyle(el)
    el.style.overflow = "hidden"
    el.style.pointerEvents = "none"
    el.animate(
      [
        {
          opacity: 1,
          height: `${el.offsetHeight}px`,
          marginTop: style.marginTop,
          marginBottom: style.marginBottom,
          paddingTop: style.paddingTop,
          paddingBottom: style.paddingBottom,
          borderTopWidth: style.borderTopWidth,
          borderBottomWidth: style.borderBottomWidth
        },
        {
          opacity: 0,
          height: "0px",
          marginTop: "0px",
          marginBottom: "0px",
          paddingTop: "0px",
          paddingBottom: "0px",
          borderTopWidth: "0px",
          borderBottomWidth: "0px"
        }
      ],
      { duration: 250, easing: "ease-in-out", fill: "forwards" }
    ).onfinish = () => el.remove()
  }
}
