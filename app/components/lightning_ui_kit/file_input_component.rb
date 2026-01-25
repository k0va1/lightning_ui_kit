class LightningUiKit::FileInputComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

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
    merge_classes(["lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    {controller: "lui-field"}.merge(@options[:data] || {})
  end

  def input_data
    {lui_field_target: "field"}.merge(@options[:input_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
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
      class: "lui:text-base/6 lui:text-zinc-950 lui:select-none lui:data-disabled:opacity-50 lui:sm:text-sm/6",
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

  def file_input_classes
    "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg lui:text-base/6 lui:text-zinc-950 lui:placeholder:text-zinc-500 lui:sm:text-sm/6 lui:border lui:border-zinc-950/10 lui:data-[hover]:border-zinc-950/20 lui:bg-transparent lui:focus:outline-hidden lui:data-invalid:border-red-500 lui:data-invalid:data-[hover]:border-red-500 lui:data-disabled:cursor-not-allowed lui:data-disabled:border-zinc-950/20 lui:data-disabled:file:cursor-not-allowed lui:file:cursor-pointer lui:cursor-pointer lui:file:border-0 lui:file:px-[calc(--spacing(3.5)-1px)] lui:file:py-[calc(--spacing(2.5)-1px)] lui:file:sm:px-[calc(--spacing(3)-1px)] lui:file:sm:py-[calc(--spacing(1.5)-1px)] lui:file:mr-4 lui:file:bg-zinc-100 lui:file:rounded-l-[calc(var(--radius-lg)-1px)]"
  end

  def file_input_html_options
    {
      data: input_data,
      class: file_input_classes,
      disabled: @disabled,
      autofocus: @autofocus,
      multiple: @multiple,
      accept: @accept
    }
  end

  def render_file_input
    if @form
      @form.file_field(@name, **file_input_html_options)
    else
      helpers.file_field_tag(@name, value: @value, **file_input_html_options)
    end
  end

  def control_classes
    "lui:relative lui:block lui:w-full lui:after:pointer-events-none lui:after:absolute lui:after:inset-0 lui:after:rounded-lg lui:after:ring-transparent lui:after:ring-inset lui:sm:focus-within:after:ring-2 lui:sm:focus-within:after:ring-blue-500 lui:has-data-disabled:opacity-50"
  end
end
