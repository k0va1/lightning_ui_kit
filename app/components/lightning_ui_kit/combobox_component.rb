class LightningUiKit::ComboboxComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

  def initialize(
    name: nil,
    form: nil,
    label: nil,
    description: nil,
    placeholder: nil,
    disabled: false,
    error: nil,
    multiple: false,
    allow_custom: false,
    options: [],
    selected: nil,
    url: nil,
    min_chars: 0,
    debounce: 300,
    association: nil,
    foreign_key: nil,
    nested_model: nil,
    collection: nil,
    label_method: :to_s,
    value_method: :id,
    **options_hash
  )
    @form = form
    @label = label
    @description = description
    @placeholder = placeholder
    @disabled = disabled
    @error = error
    @allow_custom = allow_custom
    @url = url
    @min_chars = min_chars
    @debounce = debounce
    @options_hash = options_hash

    @association = association
    @foreign_key = foreign_key
    @nested_model = nested_model
    @collection = collection
    @label_method = label_method
    @value_method = value_method

    if association_mode?
      @name = nested_attributes_name
      @multiple = true
      @options = derive_options_from_collection if @collection
      @selected = derive_selected_from_association if @form&.object
    else
      @name = name
      @multiple = multiple
      @options = options
      @selected = selected
    end
  end

  def classes
    merge_classes([
      "lui:[&>[data-slot=label]+[data-slot=control]]:mt-3",
      "lui:[&>[data-slot=label]+[data-slot=description]]:mt-1",
      "lui:[&>[data-slot=description]+[data-slot=control]]:mt-3",
      "lui:[&>[data-slot=control]+[data-slot=description]]:mt-3",
      "lui:[&>[data-slot=control]+[data-slot=error]]:mt-3",
      "lui:*:data-[slot=label]:font-medium",
      @options_hash[:class]
    ].compact.join(" "))
  end

  def data
    default_data = {
      controller: "lui-combobox",
      action: "click@window->lui-combobox#clickOutside"
    }
    default_data.merge(@options_hash[:data] || {}).merge(combobox_values)
  end

  def combobox_values
    base = {
      "lui-combobox-multiple-value" => @multiple,
      "lui-combobox-allow-custom-value" => @allow_custom,
      "lui-combobox-url-value" => @url,
      "lui-combobox-min-chars-value" => @min_chars,
      "lui-combobox-debounce-value" => @debounce,
      "lui-combobox-options-value" => options_json,
      "lui-combobox-selected-value" => selected_json
    }

    if association_mode?
      base["lui-combobox-foreign-key-value"] = @foreign_key.to_s
      base["lui-combobox-nested-model-value"] = @nested_model.to_s if @nested_model
    end

    base.compact
  end

  def association_mode?
    @association.present? && @foreign_key.present?
  end

  def input_data
    {
      "lui-combobox-target" => "input",
      :action => "input->lui-combobox#onInput focus->lui-combobox#onFocus keydown->lui-combobox#onKeydown"
    }.tap do |d|
      d[:invalid] = "true" if has_errors?
    end
  end

  def input_classes
    merge_classes([
      "lui:relative lui:block lui:w-full lui:appearance-none lui:rounded-lg",
      "lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)]",
      "lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)]",
      "lui:text-base/6 lui:text-zinc-950 lui:placeholder:text-zinc-500 lui:sm:text-sm/6",
      "lui:border lui:border-zinc-950/10 lui:data-[hover]:border-zinc-950/20",
      "lui:bg-transparent lui:focus:outline-hidden",
      "lui:data-invalid:border-red-500 lui:data-invalid:data-[hover]:border-red-500/60",
      "lui:data-disabled:border-zinc-950/20",
      "lui:pr-10"
    ].join(" "))
  end

  def label_data
    {slot: "label"}.merge(@options_hash[:label_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def description_data
    {slot: "description"}.merge(@options_hash[:description_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def error_data
    {slot: "error"}.merge(@options_hash[:error_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def hidden_field_name
    base_name = scoped_field_name

    if association_mode?
      base_name
    elsif @multiple
      "#{base_name}[]"
    else
      base_name
    end
  end

  def scoped_field_name
    if @form
      "#{@form.object_name}[#{@name}]"
    else
      @name.to_s
    end
  end

  private

  def nested_attributes_name
    "#{@association}_attributes"
  end

  def derive_options_from_collection
    return [] unless @collection

    @collection.map do |item|
      {value: item.public_send(@value_method), label: item.public_send(@label_method)}
    end
  end

  def derive_selected_from_association
    return [] unless @form&.object&.respond_to?(@association)

    @form.object.public_send(@association).map do |join_record|
      {
        join_id: join_record.id,
        value: join_record.public_send(@foreign_key)
      }
    end
  end

  def options_json
    @options.to_json
  end

  def selected_json
    return [].to_json if @selected.nil?

    if association_mode?
      @selected.to_json
    elsif @selected.is_a?(Array)
      @selected.to_json
    else
      [@selected].to_json
    end
  end
end
