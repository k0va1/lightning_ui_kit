class LightningUiKit::BannerComponent < LightningUiKit::BaseComponent
  renders_one :footer

  def initialize(title:, type: :info, **options)
    @type = type
    @title = title
    @options = options
  end

  def classes
    type_classes = case @type
    when :error
      "lui:*:data-[slot=header]:bg-destructive/80 lui:*:data-[slot=header]:text-foreground-invert"
    else
      "lui:*:data-[slot=header]:bg-neutral-bg"
    end

    merge_classes([default_classes, type_classes, @options[:class]].compact.join(" "))
  end

  def icon
    case @type
    when :error
      "exclamation-triangle"
    else
      "info-circle"
    end
  end

  def default_classes
    "lui:border lui:border-border lui:rounded-lg lui:overflow-hidden lui:transition-opacity lui:duration-300 lui:ease-out lui:opacity-100"
  end
end
