class LightningUiKit::SeparatorComponent < LightningUiKit::BaseComponent
  ORIENTATIONS = %i[horizontal vertical].freeze

  def initialize(orientation: :horizontal, decorative: true, **options)
    @orientation = ORIENTATIONS.include?(orientation) ? orientation : :horizontal
    @decorative = decorative
    @options = options
  end

  def classes
    orientation_classes =
      if @orientation == :vertical
        "lui:h-full lui:w-px"
      else
        "lui:h-px lui:w-full"
      end

    merge_classes([
      "lui:shrink-0 lui:bg-border",
      orientation_classes,
      @options[:class]
    ].compact.join(" "))
  end

  def aria_attributes
    if @decorative
      {role: "none"}
    else
      {role: "separator", "aria-orientation": @orientation.to_s}
    end
  end

  def data
    @options[:data] || {}
  end
end
