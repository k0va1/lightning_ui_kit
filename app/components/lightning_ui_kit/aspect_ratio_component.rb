class LightningUiKit::AspectRatioComponent < LightningUiKit::BaseComponent
  def initialize(ratio: "1 / 1", **options)
    @ratio = normalize_ratio(ratio)
    @options = options
  end

  def classes
    merge_classes([
      "lui:relative lui:w-full lui:overflow-hidden",
      "lui:[&>img]:size-full lui:[&>img]:object-cover lui:[&>video]:size-full lui:[&>video]:object-cover",
      @options[:class]
    ].compact.join(" "))
  end

  def style
    "aspect-ratio: #{@ratio};"
  end

  def data
    @options[:data] || {}
  end

  private

  # Accepts "16/9", "16 / 9", "1.7", or a Numeric and returns a valid CSS ratio.
  def normalize_ratio(ratio)
    str = ratio.to_s.strip
    if str.include?("/")
      num, den = str.split("/", 2).map(&:strip)
      "#{num} / #{den}"
    else
      str
    end
  end
end
