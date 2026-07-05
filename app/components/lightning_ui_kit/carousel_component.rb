class LightningUiKit::CarouselComponent < LightningUiKit::BaseComponent
  renders_many :slides

  def initialize(loop: false, show_dots: true, show_arrows: true, **options)
    @loop = loop
    @show_dots = show_dots
    @show_arrows = show_arrows
    @options = options
  end

  attr_reader :show_dots, :show_arrows

  def classes
    merge_classes([
      "lui:relative lui:w-full",
      @options[:class]
    ].compact.join(" "))
  end

  def arrow_classes(side)
    position = (side == :prev) ? "lui:left-2" : "lui:right-2"
    "lui:absolute #{position} lui:top-1/2 lui:z-10 lui:inline-flex lui:size-8 lui:-translate-y-1/2 lui:items-center lui:justify-center lui:rounded-full lui:border lui:border-border lui:bg-surface lui:text-foreground lui:shadow-sm lui:transition-colors lui:hover:bg-surface-hover lui:disabled:pointer-events-none lui:disabled:opacity-40 lui:cursor-pointer"
  end

  def data
    {
      controller: "lui-carousel",
      lui_carousel_loop_value: @loop
    }.merge(@options[:data] || {})
  end
end
