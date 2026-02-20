class LightningUiKit::RadioGroupComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

  renders_many :options, LightningUiKit::RadioGroup::OptionComponent

  def initialize(name:, label: nil, form: nil, error: nil, description: nil, selected: nil, disabled: false, **options)
    @name = name
    @label = label
    @form = form
    @error = error
    @description = description
    @selected = selected
    @disabled = disabled
    @options = options
  end

  def classes
    merge_classes([
      "lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=label]+[data-slot=options]]:mt-3 lui:[&>[data-slot=description]+[data-slot=options]]:mt-3 lui:[&>[data-slot=options]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-radio-group"
    }.merge(@options[:data] || {})
  end

  def label_data
    {slot: "label"}.tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def description_data
    {slot: "description"}.tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def error_data
    {slot: "error"}.tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def render_label
    return unless render_label?

    tag.label(
      effective_label,
      class: "lui:text-base/6 lui:text-foreground lui:select-none lui:data-disabled:opacity-50 lui:sm:text-sm/6",
      data: label_data
    )
  end

  def render_hidden_field
    if @form
      @form.hidden_field(@name, value: @selected, data: {lui_radio_group_target: "field"})
    else
      helpers.hidden_field_tag(@name, @selected, data: {lui_radio_group_target: "field"})
    end
  end

  def selected?(value)
    @selected.to_s == value.to_s
  end
end
