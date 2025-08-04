# frozen_string_literal: true

class LightningUiKit::CheckboxComponent < LightningUiKit::BaseComponent
  def initialize(name:, value: nil, label: nil, description: nil, form: nil, checked: false, disabled: false, **options)
    @form = form
    @name = name
    @value = value
    @description = description
    @label = label
    @checked = checked
    @disabled = disabled
    @options = options
  end

  private

  def control_data
    data = {
      slot: "control",
      lui_checkbox_target: "control",
      action: "click->lui-checkbox#toggle"
    }

    data[:checked] = true if !!@value
    data.merge(@options[:control_data] || {})
  end
end
