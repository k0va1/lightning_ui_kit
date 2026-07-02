class LightningUiKit::ProgressComponent < LightningUiKit::BaseComponent
  def initialize(value: 0, max: 100, **options)
    @value = value.to_f
    @max = max.to_f
    @options = options
  end

  def percent
    return 0 if @max <= 0

    ((@value / @max) * 100).clamp(0, 100)
  end

  def classes
    merge_classes([
      "lui:relative lui:h-2 lui:w-full lui:overflow-hidden lui:rounded-full lui:bg-interactive-subtle",
      @options[:class]
    ].compact.join(" "))
  end

  def indicator_style
    value = percent
    formatted = (value % 1).zero? ? value.to_i : value.round(2)
    "width: #{formatted}%;"
  end

  def aria_attributes
    {
      role: "progressbar",
      "aria-valuemin": 0,
      "aria-valuemax": @max.to_i,
      "aria-valuenow": @value.to_i
    }
  end

  def data
    @options[:data] || {}
  end
end
