class LightningUiKit::ToggleGroupComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::ToggleGroup::ItemComponent

  TYPES = %i[single multiple].freeze
  VARIANTS = %i[default outline].freeze
  SIZES = %i[default sm lg].freeze

  def initialize(type: :single, variant: :default, size: :default, value: nil, **options)
    @type = TYPES.include?(type) ? type : :single
    @variant = VARIANTS.include?(variant) ? variant : :default
    @size = SIZES.include?(size) ? size : :default
    @value = Array(value).map(&:to_s)
    @options = options
  end

  def selected?(item_value)
    @value.include?(item_value.to_s)
  end

  def state(item_value)
    selected?(item_value) ? "on" : "off"
  end

  def classes
    merge_classes(["lui:inline-flex lui:items-center lui:gap-1", @options[:class]].compact.join(" "))
  end

  def item_classes
    base = "lui:inline-flex lui:items-center lui:justify-center lui:gap-2 lui:rounded-md lui:text-sm lui:font-medium lui:whitespace-nowrap lui:cursor-pointer lui:select-none lui:transition-colors " \
      "lui:text-foreground-muted lui:hover:bg-surface-hover lui:hover:text-foreground " \
      "lui:data-[state=on]:bg-surface-hover lui:data-[state=on]:text-foreground " \
      "lui:focus-visible:outline-2 lui:focus-visible:outline-offset-2 lui:focus-visible:outline-focus " \
      "lui:disabled:pointer-events-none lui:disabled:opacity-50"
    [base, variant_classes, size_classes].join(" ")
  end

  def data
    {
      controller: "lui-toggle-group",
      lui_toggle_group_type_value: @type.to_s
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
