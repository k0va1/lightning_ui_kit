class LightningUiKit::SelectComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

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

  def classes
    "lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium"
  end

  def data
    {controller: "lui-field"}.merge(@options[:data] || {})
  end

  def select_data
    {lui_field_target: "field"}.merge(@options[:select_data] || {}).tap do |data|
      data[:invalid] = "true" if has_errors?
    end
  end

  def control_data
    {slot: "control"}.merge(@options[:control_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
      data[:invalid] = "true" if has_errors?
    end
  end

  def error_data
    {slot: "error"}.merge(@options[:error_data] || {}).dup.tap do |data|
      data[:disabled] = "true" if @disabled
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

  def select_classes
    "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg lui:py-[calc(--spacing(2.5)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:pr-[calc(--spacing(10)-1px)] lui:pl-[calc(--spacing(3.5)-1px)] lui:sm:pr-[calc(--spacing(9)-1px)] lui:sm:pl-[calc(--spacing(3)-1px)] lui:[&_optgroup]:font-semibold lui:text-base/6 lui:text-zinc-950 lui:placeholder:text-zinc-500 lui:sm:text-sm/6 lui:border lui:border-zinc-950/10 lui:data-[hover]:border-zinc-950/20 lui:bg-transparent lui:focus:outline-hidden lui:data-invalid:border-red-500 lui:data-invalid:data-[hover]:border-red-500 lui:data-disabled:border-zinc-950/20 lui:data-disabled:opacity-100"
  end

  def control_classes
    "lui:relative lui:block lui:w-full lui:before:pointer-events-none lui:before:absolute lui:before:inset-px lui:before:rounded-[7px] lui:before:bg-white lui:before:shadow-sm lui:after:pointer-events-none lui:after:absolute lui:after:inset-0 lui:after:rounded-lg lui:after:ring-inset lui:focus-within:after:ring-2 lui:focus-within:after:ring-blue-500 lui:has-data-disabled:opacity-50 lui:has-data-disabled:before:bg-zinc-950/5 lui:has-data-disabled:before:shadow-none"
  end

  def select_html_options
    {
      multiple: @multiple,
      class: select_classes,
      data: select_data
    }
  end

  def render_select
    if @form
      @form.select(@name, @options_for_select, {}, select_html_options)
    else
      helpers.select_tag(@name, helpers.options_for_select(@options_for_select), select_html_options)
    end
  end
end
