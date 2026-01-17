# frozen_string_literal: true

class LightningUiKit::JsonbComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, label: nil, form: nil, description: nil, disabled: false, error: nil, key_placeholder: "Key", value_placeholder: "Value", **options)
    @name = name
    @value = value
    @label = label
    @form = form
    @description = description
    @disabled = disabled
    @error = error
    @key_placeholder = key_placeholder
    @value_placeholder = value_placeholder
    @options = options
  end

  def classes
    merge_classes(["lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    {
      controller: "lui-jsonb",
      "lui-jsonb-mode-value" => mode,
      "lui-jsonb-disabled-value" => @disabled,
      "lui-jsonb-key-placeholder-value" => @key_placeholder,
      "lui-jsonb-value-placeholder-value" => @value_placeholder
    }.merge(@options[:data] || {})
  end

  def label_data
    {slot: "label"}.tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def description_data
    {slot: "description"}.tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def error_data
    {slot: "error"}.tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def initial_value
    return @value unless @value.nil?
    return nil unless @form.present?

    @form.object.try(@name)
  end

  def mode
    val = initial_value
    return "object" if val.nil?
    return "array" if val.is_a?(Array)

    "object"
  end

  def serialized_value
    val = initial_value
    return "" if val.nil?

    val.to_json
  end

  def hidden_field_name
    if @form.present?
      "#{@form.object_name}[#{@name}]"
    else
      @name.to_s
    end
  end

  def add_button_text
    mode == "array" ? "Add Item" : "Add Field"
  end
end
