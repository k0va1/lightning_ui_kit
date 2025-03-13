# frozen_string_literal: true

class LightningUi::TextareaComponent < LightningUi::BaseComponent
  def initialize(name:, value: nil, autofocus: false, label: nil, form: nil, type: :text, description: nil, disabled: false, multiple: false, rows: 3, cols: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @autofocus = autofocus
    @rows = rows
    @multiple = multiple
    @cols = cols
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
    @options[:input_data] || {}
  end

  def label_data
    { slot: "label" }.merge(@options[:label_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def description_data
    { slot: "description" }.merge(@options[:description_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end
end
