class LightningUiKit::SidebarLinkComponent < LightningUiKit::BaseComponent
  def initialize(title:, url:, icon: nil, current: false, animate_icon: false, **options)
    @title = title
    @url = url
    @icon = icon
    @current = current
    @animate_icon = animate_icon
    @options = options
  end

  def classes
    base_classes = "lui:relative lui:flex lui:items-center lui:gap-3 lui:rounded-lg lui:px-3 lui:py-2 lui:text-sm lui:transition-all lui:duration-150 lui:ease-out"

    if @current
      merge_classes([base_classes, "lui:bg-surface-hover lui:text-foreground lui:font-semibold", @options[:class]].compact.join(" "))
    else
      merge_classes([base_classes, "lui:text-foreground-secondary lui:hover:bg-surface-hover lui:hover:text-foreground", @options[:class]].compact.join(" "))
    end
  end

  def icon_classes
    base = if @current
      "lui:size-5 lui:shrink-0 lui:text-foreground"
    else
      "lui:size-5 lui:shrink-0 lui:text-foreground-faint lui:transition-colors lui:duration-150 lui:group-hover:text-foreground-secondary"
    end

    base += " lui:group-hover:animate-icon-bounce" if @animate_icon
    base
  end

  def data
    @options[:data] || {}
  end
end
