const namespace = 'lui'

import { Application } from "@hotwired/stimulus"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

const application = Application.start()
window.Stimulus = application

import ClipboardController from './controllers/clipboard_controller'
import CheckboxController from './controllers/checkbox_controller'
import AlertController from './controllers/alert_controller'
import LayoutController from './controllers/layout_controller'
import MainController from './controllers/main_controller'
import AccordionController from './controllers/accordion_controller'
import ModalController from './controllers/modal_controller'
import RevealController from './controllers/reveal_controller'
import SwitchController from './controllers/switch_controller'
import DropdownController from './controllers/dropdown_controller'
import DropzoneController from './controllers/dropzone_controller'
import ToastController from './controllers/toast_controller'
import TooltipController from './controllers/tooltip_controller'
import ComboboxController from './controllers/combobox_controller'
import FieldController from './controllers/field_controller'
import TabsController from './controllers/tabs_controller'
import RadioGroupController from './controllers/radio_group_controller'

export function registerLuiControllers(application) {
  application.register(`${namespace}-clipboard`, ClipboardController)
  application.register(`${namespace}-checkbox`, CheckboxController)
  application.register(`${namespace}-alert`, AlertController)
  application.register(`${namespace}-layout`, LayoutController)
  application.register(`${namespace}-main`, MainController)
  application.register(`${namespace}-accordion`, AccordionController)
  application.register(`${namespace}-modal`, ModalController)
  application.register(`${namespace}-reveal`, RevealController)
  application.register(`${namespace}-switch`, SwitchController)
  application.register(`${namespace}-dropdown`, DropdownController)
  application.register(`${namespace}-dropzone`, DropzoneController)
  application.register(`${namespace}-toast`, ToastController)
  application.register(`${namespace}-tooltip`, TooltipController)
  application.register(`${namespace}-combobox`, ComboboxController)
  application.register(`${namespace}-field`, FieldController)
  application.register(`${namespace}-tabs`, TabsController)
  application.register(`${namespace}-radio-group`, RadioGroupController)
}
registerLuiControllers(application)

export { application }
