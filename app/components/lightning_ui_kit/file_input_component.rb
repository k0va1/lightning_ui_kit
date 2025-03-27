# frozen_string_literal: true

class LightningUiKit::FileInputComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, autofocus: false, label: nil, form: nil, description: nil, multiple: false, accept: nil, disabled: false, error: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @autofocus = autofocus
    @accept = accept
    @multiple = multiple
    @error = error
    @label = label
    @form = form
    @description = description
    @options = options
  end

  def classes
    merge_classes(["[&>[data-slot=label]+[data-slot=control]]:mt-3 [&>[data-slot=label]+[data-slot=description]]:mt-1 [&>[data-slot=description]+[data-slot=control]]:mt-3 [&>[data-slot=control]+[data-slot=description]]:mt-3 [&>[data-slot=control]+[data-slot=error]]:mt-3 *:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    @options[:data] || {}
  end

  def input_data
    (@options[:input_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
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
