# frozen_string_literal: true

class LightningUiKit::SelectComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, form: nil, label: nil, errors: nil, description: nil, disabled: false, options_for_select: [], multiple: false, **options)
    @name = name
    @form = form
    @label = label
    @errors = errors
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

  def select_data
    {}.tap do |data|
      if has_errors?
        data[:invalid] = "true"
      end
    end
  end

  def control_data
    {slot: "control"}.merge(@options[:control_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
      if has_errors?
        data[:invalid] = "true"
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
