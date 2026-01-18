# frozen_string_literal: true

class LightningUiKit::InputComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  INPUT_TYPES = {
    text: :text_field,
    email: :email_field,
    password: :password_field,
    number: :number_field,
    date: :date_field,
    datetime: :datetime_local_field,
    datetime_local: :datetime_local_field,
    month: :month_field,
    week: :week_field,
    time: :time_field,
    url: :url_field,
    search: :search_field,
    telephone: :telephone_field,
    phone: :telephone_field
  }.freeze

  STANDARD_INPUT_TYPES = INPUT_TYPES.keys.freeze

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

  def input_data
    (@options[:input_data] || {}).dup.tap do |data|
      data[:invalid] = "true" if has_errors?
    end
  end

  def label_data
    {slot: "label"}.merge(@options[:label_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def description_data
    {slot: "description"}.merge(@options[:description_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def error_data
    {slot: "error"}.merge(@options[:error_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
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

    # Add type-specific options from **options (Rails convention)
    case @type
    when :number
      base_options[:min] = @options[:min]
      base_options[:max] = @options[:max]
      base_options[:step] = @options[:step]
    when :date, :datetime, :datetime_local, :month, :week, :time
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

  def color_html_options
    {
      data: input_data,
      class: color_classes,
      disabled: @disabled
    }.merge(@input_options).compact
  end

  def color_classes
    "lui:h-10 lui:w-14 lui:cursor-pointer lui:appearance-none lui:rounded-lg lui:border lui:border-zinc-950/10 lui:bg-transparent lui:p-1 " \
    "lui:hover:border-zinc-950/20 lui:focus:outline-none lui:focus:ring-2 lui:focus:ring-blue-500 " \
    "[&::-webkit-color-swatch-wrapper]:lui:p-0 [&::-webkit-color-swatch]:lui:rounded-md [&::-webkit-color-swatch]:lui:border-0 " \
    "[&::-moz-color-swatch]:lui:rounded-md [&::-moz-color-swatch]:lui:border-0 " \
    "lui:disabled:opacity-50 lui:disabled:cursor-not-allowed"
  end

  def range_classes
    "lui:w-full lui:h-2 lui:appearance-none lui:cursor-pointer lui:bg-zinc-200 lui:rounded-full lui:focus:outline-none " \
    "[&::-webkit-slider-thumb]:lui:appearance-none [&::-webkit-slider-thumb]:lui:w-4 [&::-webkit-slider-thumb]:lui:h-4 [&::-webkit-slider-thumb]:lui:bg-blue-600 [&::-webkit-slider-thumb]:lui:rounded-full [&::-webkit-slider-thumb]:lui:cursor-pointer [&::-webkit-slider-thumb]:lui:shadow-sm [&::-webkit-slider-thumb]:lui:transition-transform [&::-webkit-slider-thumb]:hover:lui:scale-110 " \
    "[&::-moz-range-thumb]:lui:appearance-none [&::-moz-range-thumb]:lui:w-4 [&::-moz-range-thumb]:lui:h-4 [&::-moz-range-thumb]:lui:bg-blue-600 [&::-moz-range-thumb]:lui:rounded-full [&::-moz-range-thumb]:lui:border-0 [&::-moz-range-thumb]:lui:cursor-pointer [&::-moz-range-thumb]:lui:shadow-sm [&::-moz-range-thumb]:lui:transition-transform [&::-moz-range-thumb]:hover:lui:scale-110 " \
    "[&::-moz-range-track]:lui:bg-zinc-200 [&::-moz-range-track]:lui:rounded-full " \
    "lui:disabled:opacity-50 lui:disabled:cursor-not-allowed"
  end

  def label_html_options
    {
      class: "lui:text-base/6 lui:text-zinc-950 lui:select-none lui:data-disabled:opacity-50 lui:sm:text-sm/6",
      data: label_data
    }
  end

  def render_label
    return unless @label

    if @form
      @form.label(@name, @label, **label_html_options)
    else
      helpers.label_tag(@name, @label, **label_html_options)
    end
  end

  def control_classes
    "lui:relative lui:block lui:w-full lui:before:absolute lui:before:inset-px lui:before:rounded-[calc(var(--radius-lg)-1px)] lui:before:bg-white lui:before:shadow-sm lui:after:pointer-events-none lui:after:absolute lui:after:inset-0 lui:after:rounded-lg lui:after:ring-transparent lui:after:ring-inset lui:sm:focus-within:after:ring-2 lui:sm:focus-within:after:ring-blue-500 lui:has-data-disabled:opacity-50 lui:has-data-disabled:before:bg-zinc-950/5 lui:has-data-disabled:before:shadow-none lui:has-data-invalid:before:shadow-red-500/10"
  end

  def standard_input_type?
    STANDARD_INPUT_TYPES.include?(@type)
  end

  def render_input
    method_name = INPUT_TYPES[@type]
    if @form
      @form.public_send(method_name, @name, **input_html_options)
    else
      tag_method = "#{method_name}_tag"
      helpers.public_send(tag_method, @name, @value, **input_html_options)
    end
  end

  def render_range_input
    if @form
      @form.range_field(@name, **range_html_options)
    else
      helpers.range_field_tag(@name, @value, **range_html_options)
    end
  end

  def render_color_input
    if @form
      @form.color_field(@name, **color_html_options)
    else
      helpers.color_field_tag(@name, @value, **color_html_options)
    end
  end

  def render_hidden_input
    if @form
      @form.hidden_field(@name, **hidden_html_options)
    else
      helpers.hidden_field_tag(@name, @value, **hidden_html_options)
    end
  end
end
