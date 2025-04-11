import { Controller } from '@hotwired/stimulus'
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static targets = ['toast']
  static values = {
    autodismiss: Boolean,
    dismissAfter: Number
  }

  connect () {
    if (this.autodismissValue) {
      setTimeout(() => {
        this.close()
      }, this.dismissAfterValue)
    }

    useTransition(this, {
      element: this.toastTarget,
      enterActive: 'lui:transition lui:ease-in-out lui:duration-150',
      enterFrom: 'lui:transform lui:opacity-0 lui:scale-95',
      enterTo: 'lui:transform lui:opacity-100 lui:scale-100',
      leaveActive: 'lui:transition lui:ease-in-out lui:duration-150',
      leaveFrom: 'lui:transform lui:opacity-100 lui:scale-100',
      leaveTo: 'lui:transform lui:opacity-0 lui:scale-95',
      hiddenClass: "lui:hidden",
      transitioned: true,
    });
  }

  close () {
    this.leave();
  }
}
