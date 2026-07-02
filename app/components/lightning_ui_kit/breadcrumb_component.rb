class LightningUiKit::BreadcrumbComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::Breadcrumb::ItemComponent

  def initialize(separator: "chevron-right", **options)
    @separator = separator
    @options = options
  end

  def classes
    merge_classes([
      "lui:flex lui:flex-wrap lui:items-center lui:gap-1.5 lui:text-sm lui:break-words lui:text-foreground-muted lui:sm:gap-2.5",
      @options[:class]
    ].compact.join(" "))
  end

  def separator_icon
    @separator
  end

  def data
    @options[:data] || {}
  end
end
