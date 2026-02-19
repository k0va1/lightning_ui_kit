class LightningUiKit::TextareaComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

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
    {controller: "lui-field"}.merge(@options[:data] || {})
  end

  def input_data
    {lui_field_target: "field"}.merge(@options[:input_data] || {}).dup.tap do |data|
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

  def label_html_options
    {
      class: "lui:text-base/6 lui:text-foreground lui:select-none lui:data-disabled:opacity-50 lui:sm:text-sm/6",
      data: label_data
    }
  end

  def render_label
    return unless render_label?

    label_text = effective_label
    if @form
      @form.label(@name, label_text, **label_html_options)
    else
      helpers.label_tag(@name, label_text, **label_html_options)
    end
  end

  def textarea_html_options
    {
      rows: @rows,
      cols: @cols,
      multiple: @multiple,
      data: input_data,
      class: "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:text-base/6 lui:text-foreground lui:placeholder:text-foreground-muted lui:sm:text-sm/6 lui:border lui:border-border lui:data-[hover]:border-border-hover lui:bg-transparent lui:focus:outline-hidden lui:data-invalid:border-destructive-border lui:data-invalid:data-[hover]:border-destructive-border lui:data-disabled:border-border-hover",
      disabled: @disabled,
      autofocus: @autofocus
    }
  end

  def render_textarea
    if @form
      @form.text_area(@name, **textarea_html_options)
    else
      helpers.text_area_tag(@name, @value, **textarea_html_options)
    end
  end

  def control_classes
    "lui:relative lui:block lui:w-full lui:before:absolute lui:before:inset-px lui:before:rounded-[7px] lui:before:bg-surface-input lui:before:shadow-sm lui:after:pointer-events-none lui:after:absolute lui:after:inset-0 lui:after:rounded-lg lui:after:ring-transparent lui:after:ring-inset lui:sm:focus-within:after:ring-2 lui:sm:focus-within:after:ring-focus lui:has-data-disabled:opacity-50 lui:has-data-disabled:before:bg-surface-hover lui:has-data-disabled:before:shadow-none lui:has-data-invalid:before:shadow-destructive-border/10"
  end
end
