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
import CollapsibleController from './controllers/collapsible_controller'
import PopoverController from './controllers/popover_controller'
import SheetController from './controllers/sheet_controller'
import AlertDialogController from './controllers/alert_dialog_controller'
import ToggleController from './controllers/toggle_controller'
import ToggleGroupController from './controllers/toggle_group_controller'
import SliderController from './controllers/slider_controller'
import HoverCardController from './controllers/hover_card_controller'
import ContextMenuController from './controllers/context_menu_controller'
import CommandController from './controllers/command_controller'
import OtpController from './controllers/otp_controller'
import NavigationMenuController from './controllers/navigation_menu_controller'
import MenubarController from './controllers/menubar_controller'
import CalendarController from './controllers/calendar_controller'
import DatePickerController from './controllers/date_picker_controller'
import CarouselController from './controllers/carousel_controller'
import ResizableController from './controllers/resizable_controller'

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
  application.register(`${namespace}-collapsible`, CollapsibleController)
  application.register(`${namespace}-popover`, PopoverController)
  application.register(`${namespace}-sheet`, SheetController)
  application.register(`${namespace}-alert-dialog`, AlertDialogController)
  application.register(`${namespace}-toggle`, ToggleController)
  application.register(`${namespace}-toggle-group`, ToggleGroupController)
  application.register(`${namespace}-slider`, SliderController)
  application.register(`${namespace}-hover-card`, HoverCardController)
  application.register(`${namespace}-context-menu`, ContextMenuController)
  application.register(`${namespace}-command`, CommandController)
  application.register(`${namespace}-otp`, OtpController)
  application.register(`${namespace}-navigation-menu`, NavigationMenuController)
  application.register(`${namespace}-menubar`, MenubarController)
  application.register(`${namespace}-calendar`, CalendarController)
  application.register(`${namespace}-date-picker`, DatePickerController)
  application.register(`${namespace}-carousel`, CarouselController)
  application.register(`${namespace}-resizable`, ResizableController)
}
registerLuiControllers(application)

export { application }
