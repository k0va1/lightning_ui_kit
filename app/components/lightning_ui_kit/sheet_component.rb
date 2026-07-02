class LightningUiKit::SheetComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body
  renders_many :actions

  SIDES = %i[top right bottom left].freeze

  def initialize(id: nil, title: nil, description: nil, side: :right, **options)
    @id = id
    @title = title
    @description = description
    @side = SIDES.include?(side) ? side : :right
    @options = options
  end

  def panel_classes
    merge_classes([
      "lui:fixed lui:z-50 lui:flex lui:flex-col lui:gap-4 lui:bg-surface lui:p-6 lui:text-foreground lui:shadow-lg lui:transition-transform lui:duration-300 lui:ease-in-out",
      side_classes,
      @options[:class]
    ].compact.join(" "))
  end

  # Class(es) applied to the panel while the sheet is closed (offscreen).
  def panel_closed_class
    case @side
    when :left then "lui:-translate-x-full"
    when :top then "lui:-translate-y-full"
    when :bottom then "lui:translate-y-full"
    else "lui:translate-x-full"
    end
  end

  def overlay_closed_class
    "lui:opacity-0"
  end

  def data
    {controller: "lui-sheet"}.merge(@options[:data] || {})
  end

  private

  def side_classes
    case @side
    when :left
      "lui:inset-y-0 lui:left-0 lui:h-full lui:w-3/4 lui:max-w-sm lui:border-r lui:border-border"
    when :top
      "lui:inset-x-0 lui:top-0 lui:w-full lui:border-b lui:border-border"
    when :bottom
      "lui:inset-x-0 lui:bottom-0 lui:w-full lui:border-t lui:border-border"
    else
      "lui:inset-y-0 lui:right-0 lui:h-full lui:w-3/4 lui:max-w-sm lui:border-l lui:border-border"
    end
  end
end
