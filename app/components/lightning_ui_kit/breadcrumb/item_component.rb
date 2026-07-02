class LightningUiKit::Breadcrumb::ItemComponent < LightningUiKit::BaseComponent
  def initialize(href: nil, current: false, **options)
    @href = href
    @current = current
    @options = options
  end

  def link?
    !@current && @href.present?
  end

  def link_classes
    merge_classes([
      "lui:transition-colors lui:hover:text-foreground",
      @options[:class]
    ].compact.join(" "))
  end

  def current_classes
    merge_classes([
      "lui:font-normal lui:text-foreground",
      @options[:class]
    ].compact.join(" "))
  end

  attr_reader :href
end
