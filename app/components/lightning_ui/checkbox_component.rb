# frozen_string_literal: true

class LightningUi::CheckboxComponent < LightningUi::BaseComponent
  def initialize(name:, value: nil, label: nil, form: nil, checked: false, disabled: false, **options)
    @form = form
    @name = name
    @value = value
    @label = label
    @checked = checked
    @disabled = disabled
    @options = options
  end
end
