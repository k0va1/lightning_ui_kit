# frozen_string_literal: true

class LightningUiKit::TextareaComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, autofocus: false, label: nil, form: nil, type: :text, error: nil, description: nil, disabled: false, multiple: false, rows: 3, cols: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @autofocus = autofocus
    @rows = rows
    @multiple = multiple
    @cols = cols
    @error = error
    @label = label
    @form = form
    @type = type
    @description = description
    @options = options
  end

  def data
    @options[:data] || {}
  end

  def input_data
    (@options[:input_data] || {}).tap do |data|
      if has_errors?
        data[:invalid] = "true"
      end
    end
  end

  def label_data
    {slot: "label"}.merge(@options[:label_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def description_data
    {slot: "description"}.merge(@options[:description_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
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
