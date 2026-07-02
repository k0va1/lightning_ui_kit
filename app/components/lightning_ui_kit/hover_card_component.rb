class LightningUiKit::HoverCardComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body

  POSITIONS = %w[
    top bottom left right
    top-start top-end bottom-start bottom-end
    left-start left-end right-start right-end
  ].freeze

  def initialize(position: :bottom, offset: 8, open_delay: 300, close_delay: 150, **options)
    @position = POSITIONS.include?(position.to_s) ? position.to_s : "bottom"
    @offset = offset
    @open_delay = open_delay
    @close_delay = close_delay
    @options = options
  end

  def content_classes
    merge_classes([
      "lui:hidden lui:z-50 lui:w-64 lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-4 lui:text-foreground lui:shadow-md lui:outline-none",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-hover-card",
      lui_hover_card_position_value: @position,
      lui_hover_card_offset_value: @offset,
      lui_hover_card_open_delay_value: @open_delay,
      lui_hover_card_close_delay_value: @close_delay
    }.merge(@options[:data] || {})
  end
end
