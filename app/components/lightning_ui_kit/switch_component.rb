# frozen_string_literal: true

class LightningUiKit::SwitchComponent < LightningUiKit::BaseComponent
  def initialize(name:, form: nil, label: nil, description: nil, enabled: false, disabled: false, **options)
    @name = name
    @form = form
    @label = label
    @description = description
    @enabled = enabled
    @disabled = disabled
    @options = options
  end

  def data
    default_data.merge(@options[:data] || {})
  end

  def default_data
    {
      slot: "control",
      action: "click->lui-switch#toggle"
    }.tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
      if @enabled
        data[:checked] = "true"
      end
    end
  end
end
