# frozen_string_literal: true

class LightningUiKit::ComboboxComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(
    name:,
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
    **options_hash
  )
    @name = name
    @form = form
    @label = label
    @description = description
    @placeholder = placeholder
    @disabled = disabled
    @error = error
    @multiple = multiple
    @allow_custom = allow_custom
    @options = options
    @selected = selected
    @url = url
    @min_chars = min_chars
    @debounce = debounce
    @options_hash = options_hash
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
    {
      "lui-combobox-multiple-value" => @multiple,
      "lui-combobox-allow-custom-value" => @allow_custom,
      "lui-combobox-url-value" => @url,
      "lui-combobox-min-chars-value" => @min_chars,
      "lui-combobox-debounce-value" => @debounce,
      "lui-combobox-options-value" => @options.to_json,
      "lui-combobox-selected-value" => selected_json
    }.compact
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
      "lui:border lui:border-zinc-950/10 lui:hover:border-zinc-950/20",
      "lui:bg-transparent lui:focus:outline-hidden",
      "lui:data-invalid:border-red-500 lui:data-invalid:hover:border-red-500/60",
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
    @multiple ? "#{@name}[]" : @name
  end

  private

  def selected_json
    return @selected.to_json if @selected.is_a?(Array)
    @selected ? [@selected].to_json : [].to_json
  end
end
