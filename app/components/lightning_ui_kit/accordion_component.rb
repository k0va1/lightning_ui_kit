class LightningUiKit::AccordionComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::Accordion::ItemComponent

  def initialize(open_first: true, **options)
    @open_first = open_first
    @options = options
  end

  def classes
    merge_classes([
      "lui:divide-y lui:divide-border",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-accordion",
      lui_accordion_open_first_value: @open_first
    }.merge(@options[:data] || {})
  end
end
