class LightningUiKit::ResizableComponent < LightningUiKit::BaseComponent
  renders_one :panel_one
  renders_one :panel_two

  DIRECTIONS = %i[horizontal vertical].freeze

  def initialize(direction: :horizontal, initial: 50, **options)
    @direction = DIRECTIONS.include?(direction) ? direction : :horizontal
    @initial = initial
    @options = options
  end

  def horizontal?
    @direction == :horizontal
  end

  def classes
    layout = horizontal? ? "lui:flex-row" : "lui:flex-col"
    merge_classes([
      "lui:flex lui:h-full lui:w-full lui:overflow-hidden lui:rounded-lg lui:border lui:border-border",
      layout,
      @options[:class]
    ].compact.join(" "))
  end

  def panel_one_style
    "flex-basis: #{@initial}%;"
  end

  def handle_classes
    if horizontal?
      "lui:relative lui:flex lui:w-px lui:shrink-0 lui:cursor-col-resize lui:items-center lui:justify-center lui:bg-border lui:transition-colors lui:hover:bg-interactive"
    else
      "lui:relative lui:flex lui:h-px lui:shrink-0 lui:cursor-row-resize lui:items-center lui:justify-center lui:bg-border lui:transition-colors lui:hover:bg-interactive"
    end
  end

  def grip_classes
    if horizontal?
      "lui:absolute lui:h-8 lui:w-1 lui:rounded-full lui:bg-border-hover"
    else
      "lui:absolute lui:h-1 lui:w-8 lui:rounded-full lui:bg-border-hover"
    end
  end

  def data
    {
      controller: "lui-resizable",
      lui_resizable_direction_value: @direction.to_s
    }.merge(@options[:data] || {})
  end
end
