class LightningUiKit::PopoverComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body

  POSITIONS = %w[
    top bottom left right
    top-start top-end bottom-start bottom-end
    left-start left-end right-start right-end
  ].freeze

  def initialize(position: :bottom, offset: 8, **options)
    @position = POSITIONS.include?(position.to_s) ? position.to_s : "bottom"
    @offset = offset
    @options = options
  end

  def content_classes
    merge_classes([
      "lui:hidden lui:z-50 lui:w-72 lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-4 lui:text-foreground lui:shadow-md lui:outline-none",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-popover",
      lui_popover_position_value: @position,
      lui_popover_offset_value: @offset,
      action: "keydown.esc@window->lui-popover#hide click@window->lui-popover#hideOnClickOutside"
    }.merge(@options[:data] || {})
  end
end
