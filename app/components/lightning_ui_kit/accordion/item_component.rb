class LightningUiKit::Accordion::ItemComponent < LightningUiKit::BaseComponent
  def initialize(title:, **options)
    @title = title
    @options = options
  end

  def classes
    merge_classes([
      "lui:py-1",
      @options[:class]
    ].compact.join(" "))
  end
end
