class LightningUiKit::CollapsibleComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body

  def initialize(open: false, **options)
    @open = open
    @options = options
  end

  def classes
    merge_classes([
      "lui:flex lui:flex-col lui:gap-2",
      @options[:class]
    ].compact.join(" "))
  end

  def content_classes
    rows = @open ? "lui:grid-rows-[1fr]" : "lui:grid-rows-[0fr]"
    "lui:grid lui:transition-all lui:duration-200 lui:ease-out #{rows}"
  end

  def data
    {
      controller: "lui-collapsible",
      lui_collapsible_open_value: @open
    }.merge(@options[:data] || {})
  end
end
