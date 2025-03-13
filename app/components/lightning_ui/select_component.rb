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
    {
      slot: "control",
      action: "click->switch#toggle"
    }.tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end
end
