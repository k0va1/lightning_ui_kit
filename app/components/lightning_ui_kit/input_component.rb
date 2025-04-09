# frozen_string_literal: true

class LightningUiKit::InputComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, autofocus: false, label: nil, form: nil, type: :text, description: nil, disabled: false, placeholder: nil, error: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @autofocus = autofocus
    @error = error
    @label = label
    @form = form
    @type = type
    @description = description
    @placeholder = placeholder
    @options = options
  end

  def classes
    merge_classes(["lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
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
