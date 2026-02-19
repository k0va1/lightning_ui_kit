class LightningUiKit::DropzoneComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

  def initialize(name:, value: nil, label: nil, form: nil, description: nil, multiple: false, accept: nil, disabled: false, placeholder: nil, error: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @accept = accept
    @multiple = multiple
    @error = error
    @label = label
    @form = form
    @description = description
    @placeholder = placeholder
    @options = options
  end

  def classes
    merge_classes(["lui:space-y-4 lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    {controller: "lui-dropzone"}.merge(@options[:data] || {})
  end

  def input_data
    (@options[:input_data] || {}).dup.tap do |data|
      data[:lui_dropzone_target] = "input"
      data[:action] = "dragover->lui-dropzone#activate drop->lui-dropzone#uploadFiles change->lui-dropzone#uploadFiles"
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

  def file_input_html_options
    {
      multiple: @multiple,
      class: "lui:hidden",
      direct_upload: true,
      data: input_data,
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
end
