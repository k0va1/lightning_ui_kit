class LightningUiKit::SidebarLinkComponent < LightningUiKit::BaseComponent
  def initialize(title:, url:, icon: nil, current: false, **options)
    @title = title
    @url = url
    @icon = icon
    @current = current
    @options = options
  end

  def classes
    base_classes = "lui:flex lui:items-center lui:gap-3 lui:rounded-lg lui:px-3 lui:py-2 lui:text-sm lui:transition-colors"

    if @current
      merge_classes([base_classes, "lui:bg-surface-hover lui:text-foreground lui:font-semibold", @options[:class]].compact.join(" "))
    else
      merge_classes([base_classes, "lui:text-foreground-secondary lui:hover:bg-surface-hover lui:hover:text-foreground", @options[:class]].compact.join(" "))
    end
  end

  def icon_classes
    if @current
      "lui:size-5 lui:shrink-0 lui:text-foreground-secondary"
    else
      "lui:size-5 lui:shrink-0 lui:text-foreground-faint"
    end
  end

  def data
    @options[:data] || {}
  end
end
