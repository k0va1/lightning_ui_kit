class LightningUiKit::CopyInputComponent < LightningUiKit::BaseComponent
  def initialize(value:, label: nil, description: nil, secret: false, **options)
    @value = value
    @label = label
    @description = description
    @secret = secret
    @options = options
  end

  def classes
    merge_classes(["lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    {controller: "lui-clipboard"}.merge(@options[:data] || {})
  end

  def label_data
    {slot: "label"}
  end

  def label_html_options
    {
      class: "lui:text-base/6 lui:text-foreground lui:select-none lui:sm:text-sm/6",
      data: label_data
    }
  end

  def render_label
    return unless @label

    helpers.label_tag(nil, @label, **label_html_options)
  end

  def control_classes
    "lui:relative lui:flex lui:w-full lui:rounded-lg lui:border lui:border-border lui:bg-surface-input lui:shadow-sm lui:focus-within:ring-2 lui:focus-within:ring-focus"
  end

  def input_classes
    "lui:block lui:w-full lui:min-w-0 lui:flex-1 lui:appearance-none lui:bg-transparent lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:text-base/6 lui:text-foreground lui:sm:text-sm/6 lui:border-0 lui:focus:outline-hidden lui:select-all"
  end

  def input_type
    @secret ? "password" : "text"
  end

  def action_button_classes
    "lui:flex lui:items-center lui:justify-center lui:px-3 lui:border-l lui:border-border lui:text-foreground-muted lui:hover:text-foreground lui:hover:bg-surface-hover lui:transition-colors lui:cursor-pointer lui:focus:outline-hidden"
  end

  def copy_button_classes
    classes = [action_button_classes]
    classes << "lui:rounded-r-lg" unless @secret
    classes.join(" ")
  end

  def toggle_button_classes
    "#{action_button_classes} lui:rounded-r-lg"
  end
end
