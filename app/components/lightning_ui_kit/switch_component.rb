class LightningUiKit::SwitchComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors
  include LightningUiKit::Labelable

  def initialize(name:, form: nil, label: nil, error: nil, description: nil, enabled: false, disabled: false, **options)
    @name = name
    @form = form
    @label = label
    @error = error
    @description = description
    @enabled = enabled
    @disabled = disabled
    @options = options
  end

  def classes
    merge_classes([
      "lui:grid lui:grid-cols-[1fr_auto] lui:items-center lui:gap-x-8 lui:gap-y-1 lui:sm:grid-cols-[1fr_auto]",
      "lui:*:data-[slot=control]:col-start-2 lui:*:data-[slot=control]:self-center lui:*:data-[slot=label]:col-start-1",
      "lui:*:data-[slot=label]:row-start-1 lui:*:data-[slot=label]:justify-self-start lui:*:data-[slot=description]:col-start-1",
      "lui:*:data-[slot=description]:row-start-2 lui:has-data-[slot=description]:**:data-[slot=label]:font-medium",
      "lui:*:data-[slot=error]:col-start-1 lui:*:data-[slot=error]:row-start-3",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {slot: "field", controller: "lui-switch"}.merge(@options[:data] || {})
  end

  def label_id
    "#{@name}_label"
  end

  def label_data
    {slot: "label"}.merge(@options[:label_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def description_data
    {slot: "description"}.merge(@options[:description_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def error_data
    {slot: "error"}.merge(@options[:error_data] || {}).tap do |data|
      data[:disabled] = "true" if @disabled
    end
  end

  def button_classes
    "lui:group lui:relative lui:isolate lui:inline-flex lui:h-6 lui:w-10 lui:cursor-default lui:rounded-full " \
    "lui:p-[3px] lui:sm:h-5 lui:sm:w-8 lui:transition lui:duration-200 lui:ease-in-out " \
    "lui:forced-colors:outline lui:forced-colors:[--switch-bg:Highlight] lui:bg-zinc-200 lui:ring-1 lui:ring-black/5 lui:ring-inset " \
    "lui:data-checked:bg-(--switch-bg) lui:data-checked:ring-(--switch-bg-ring) lui:focus:outline-hidden lui:data-focus:outline-2 " \
    "lui:data-focus:outline-offset-2 lui:data-focus:outline-blue-500 lui:hover:ring-black/15 lui:hover:data-checked:ring-(--switch-bg-ring) " \
    "lui:data-disabled:bg-zinc-200 lui:data-disabled:opacity-50 lui:data-disabled:data-checked:bg-zinc-200 lui:data-disabled:data-checked:ring-black/5 " \
    "lui:[--switch-bg-ring:var(--lui-color-zinc-950)]/90 " \
    "lui:[--switch-bg:var(--lui-color-zinc-900)] " \
    "lui:[--switch-ring:var(--lui-color-zinc-950)]/90 " \
    "lui:[--switch-shadow:var(--lui-color-black)]/10 " \
    "lui:[--switch:white]"
  end

  def button_data
    {
      slot: "control",
      action: "click->lui-switch#toggle"
    }.tap do |data|
      data[:disabled] = "true" if @disabled
      data[:checked] = "true" if @enabled
    end
  end

  def button_aria
    {
      checked: @enabled,
      labelledby: (label_id if render_label?)
    }.compact
  end

  def knob_classes
    "lui:pointer-events-none lui:relative lui:inline-block lui:size-[1.125rem] lui:rounded-full lui:sm:size-3.5 " \
    "lui:translate-x-0 lui:transition lui:duration-200 lui:ease-in-out lui:border lui:border-transparent lui:bg-white " \
    "lui:ring-1 lui:shadow-sm lui:ring-black/5 lui:group-data-checked:bg-(--switch) lui:group-data-checked:shadow-(--switch-shadow) " \
    "lui:group-data-checked:ring-(--switch-ring) lui:group-data-checked:translate-x-4 lui:sm:group-data-checked:translate-x-3 " \
    "lui:group-data-checked:group-data-disabled:bg-white lui:group-data-checked:group-data-disabled:shadow-sm " \
    "lui:group-data-checked:group-data-disabled:ring-black/5"
  end

  def hidden_field_data
    {lui_switch_target: "field"}
  end

  def render_label
    return unless render_label?

    tag.label(effective_label, id: label_id, class: "lui:text-base/6 lui:text-zinc-950 lui:select-none lui:data-disabled:opacity-50 lui:sm:text-sm/6", data: label_data)
  end

  def render_hidden_field
    if @form
      @form.hidden_field(@name, value: @enabled, data: hidden_field_data)
    else
      hidden_field_tag(@name, @enabled, data: hidden_field_data)
    end
  end
end
