# frozen_string_literal: true

class LightningUiKit::InputComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, label: nil, form: nil, type: :text, description: nil, disabled: false, placeholder: nil, error: nil, input_options: {}, **options)
    @name = name
    @value = value
    @disabled = disabled
    @error = error
    @label = label
    @form = form
    @type = type
    @description = description
    @placeholder = placeholder
    @input_options = input_options
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

  def input_classes
    "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:text-base/6 lui:text-zinc-950 lui:placeholder:text-zinc-500 lui:sm:text-sm/6 lui:border lui:border-zinc-950/10 lui:hover:border-zinc-950/20 lui:bg-transparent lui:focus:outline-hidden lui:data-invalid:border-red-500 lui:data-invalid:hover:border-red-500/60 lui:data-disabled:border-zinc-950/20"
  end

  def input_html_options
    base_options = {
      data: input_data,
      class: input_classes,
      disabled: @disabled,
      placeholder: @placeholder
    }

    # Add type-specific options
    case @type
    when :number
      base_options[:min] = @options[:min]
      base_options[:max] = @options[:max]
      base_options[:step] = @options[:step]
    when :date, :datetime, :month, :week, :time
      base_options[:min] = @options[:min]
      base_options[:max] = @options[:max]
    end

    base_options.merge(@input_options).compact
  end

  def range_html_options
    {
      data: input_data,
      class: range_classes,
      disabled: @disabled,
      min: @options[:min],
      max: @options[:max],
      step: @options[:step]
    }.merge(@input_options).compact
  end

  def hidden_html_options
    {data: input_data}.merge(@input_options).compact
  end

  def range_classes
    "lui:w-full lui:h-2 lui:appearance-none lui:cursor-pointer lui:bg-zinc-200 lui:rounded-full lui:focus:outline-none " \
    "[&::-webkit-slider-thumb]:lui:appearance-none [&::-webkit-slider-thumb]:lui:w-4 [&::-webkit-slider-thumb]:lui:h-4 [&::-webkit-slider-thumb]:lui:bg-blue-600 [&::-webkit-slider-thumb]:lui:rounded-full [&::-webkit-slider-thumb]:lui:cursor-pointer [&::-webkit-slider-thumb]:lui:shadow-sm [&::-webkit-slider-thumb]:lui:transition-transform [&::-webkit-slider-thumb]:hover:lui:scale-110 " \
    "[&::-moz-range-thumb]:lui:appearance-none [&::-moz-range-thumb]:lui:w-4 [&::-moz-range-thumb]:lui:h-4 [&::-moz-range-thumb]:lui:bg-blue-600 [&::-moz-range-thumb]:lui:rounded-full [&::-moz-range-thumb]:lui:border-0 [&::-moz-range-thumb]:lui:cursor-pointer [&::-moz-range-thumb]:lui:shadow-sm [&::-moz-range-thumb]:lui:transition-transform [&::-moz-range-thumb]:hover:lui:scale-110 " \
    "[&::-moz-range-track]:lui:bg-zinc-200 [&::-moz-range-track]:lui:rounded-full " \
    "lui:disabled:opacity-50 lui:disabled:cursor-not-allowed"
  end
end
