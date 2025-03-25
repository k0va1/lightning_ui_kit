const namespace = 'lui'

import { Application } from "@hotwired/stimulus"

const application = Application.start()
window.Stimulus = application

import ClipboardController from './controllers/clipboard_controller'
import CheckboxController from './controllers/checkbox_controller'
import BannerController from './controllers/banner_controller'
import MainController from './controllers/main_controller'
import AccordionController from './controllers/accordion_controller'
import ModalController from './controllers/modal_controller'
import RevealController from './controllers/reveal_controller'
import SwitchController from './controllers/switch_controller'
import DropdownController from './controllers/dropdown_controller'

export function registerLuiControllers(application) {
  application.register(`${namespace}-clipboard`, ClipboardController)
  application.register(`${namespace}-checkbox`, CheckboxController)
  application.register(`${namespace}-banner`, BannerController)
  application.register(`${namespace}-main`, MainController)
  application.register(`${namespace}-accordion`, AccordionController)
  application.register(`${namespace}-modal`, ModalController)
  application.register(`${namespace}-reveal`, RevealController)
  application.register(`${namespace}-switch`, SwitchController)
  application.register(`${namespace}-dropdown`, DropdownController)
}
registerLuiControllers(application)

export { application }
