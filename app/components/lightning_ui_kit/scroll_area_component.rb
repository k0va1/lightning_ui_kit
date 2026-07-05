class LightningUiKit::ScrollAreaComponent < LightningUiKit::BaseComponent
  ORIENTATIONS = %i[vertical horizontal both].freeze

  def initialize(orientation: :vertical, **options)
    @orientation = ORIENTATIONS.include?(orientation) ? orientation : :vertical
    @options = options
  end

  def classes
    scrollbar = "lui:[scrollbar-width:thin] " \
      "lui:[&::-webkit-scrollbar]:h-2 lui:[&::-webkit-scrollbar]:w-2 " \
      "lui:[&::-webkit-scrollbar-track]:bg-transparent " \
      "lui:[&::-webkit-scrollbar-thumb]:rounded-full lui:[&::-webkit-scrollbar-thumb]:bg-border-hover " \
      "lui:[&::-webkit-scrollbar-thumb:hover]:bg-foreground-faint"

    merge_classes(["lui:relative", overflow_classes, scrollbar, @options[:class]].compact.join(" "))
  end

  def data
    @options[:data] || {}
  end

  private

  def overflow_classes
    case @orientation
    when :horizontal then "lui:overflow-x-auto lui:overflow-y-hidden"
    when :both then "lui:overflow-auto"
    else "lui:overflow-y-auto lui:overflow-x-hidden"
    end
  end
end
