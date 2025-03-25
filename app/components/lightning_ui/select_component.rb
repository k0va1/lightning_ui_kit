# frozen_string_literal: true

class LightningUi::SelectComponent < LightningUi::BaseComponent
  def initialize(name:, form: nil, label: nil, description: nil, disabled: false, options_for_select: [], multiple: false, **options)
    @name = name
    @form = form
    @label = label
    @multiple = multiple
    @description = description
    @disabled = disabled
    @options_for_select = options_for_select
    @options = options
  end

  def data
    default_data = {
      slot: "field",
      action: "click->switch#toggle",
      controller: "select",
      disabled: @disabled
    }

    default_data.merge(@options[:data] || {})
  end
end
