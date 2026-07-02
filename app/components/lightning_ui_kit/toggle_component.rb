class LightningUiKit::ToggleComponent < LightningUiKit::BaseComponent
  VARIANTS = %i[default outline].freeze
  SIZES = %i[default sm lg].freeze

  def initialize(pressed: false, variant: :default, size: :default, disabled: false, **options)
    @pressed = pressed
    @variant = VARIANTS.include?(variant) ? variant : :default
    @size = SIZES.include?(size) ? size : :default
    @disabled = disabled
    @options = options
  end

  def classes
    base = "lui:inline-flex lui:items-center lui:justify-center lui:gap-2 lui:rounded-md lui:text-sm lui:font-medium lui:whitespace-nowrap lui:cursor-pointer lui:select-none lui:transition-colors " \
      "lui:text-foreground-muted lui:hover:bg-surface-hover lui:hover:text-foreground " \
      "lui:data-[state=on]:bg-surface-hover lui:data-[state=on]:text-foreground " \
      "lui:focus-visible:outline-2 lui:focus-visible:outline-offset-2 lui:focus-visible:outline-focus " \
      "lui:disabled:pointer-events-none lui:disabled:opacity-50"
    merge_classes([base, variant_classes, size_classes, @options[:class]].compact.join(" "))
  end

  def state
    @pressed ? "on" : "off"
  end

  def disabled?
    @disabled
  end

  attr_reader :pressed

  def data
    {
      controller: "lui-toggle",
      lui_toggle_pressed_value: @pressed,
      action: "click->lui-toggle#toggle"
    }.merge(@options[:data] || {})
  end

  private

  def variant_classes
    (@variant == :outline) ? "lui:border lui:border-border lui:bg-transparent" : "lui:bg-transparent"
  end

  def size_classes
    case @size
    when :sm then "lui:h-8 lui:min-w-8 lui:px-1.5"
    when :lg then "lui:h-10 lui:min-w-10 lui:px-2.5"
    else "lui:h-9 lui:min-w-9 lui:px-2"
    end
  end
end
