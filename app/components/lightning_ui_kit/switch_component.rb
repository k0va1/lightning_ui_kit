# frozen_string_literal: true

class LightningUiKit::SwitchComponent < LightningUiKit::BaseComponent
  def initialize(name:, form: nil, label: nil, error: nil, description: nil, enabled: false, disabled: false, **options)
    @name = name
    @form = form
    @label = label
    @error = error
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

  def error_data
    {slot: "error"}.merge(@options[:error_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end
end
