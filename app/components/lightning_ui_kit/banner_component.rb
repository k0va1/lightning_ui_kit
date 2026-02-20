class LightningUiKit::BannerComponent < LightningUiKit::BaseComponent
  renders_one :footer

  def initialize(title:, type: :info, **options)
    @type = type
    @title = title
    @options = options
  end

  def classes
    merge_classes([base_classes, type_classes, @options[:class]].compact.join(" "))
  end

  def icon
    case @type
    when :error
      "exclamation-triangle"
    else
      "information-circle"
    end
  end

  def icon_classes
    base = "lui:absolute lui:left-4 lui:top-4 lui:size-4"
    case @type
    when :error
      "#{base} lui:text-destructive-text"
    else
      "#{base} lui:text-foreground"
    end
  end

  private

  def base_classes
    "lui:relative lui:w-full lui:rounded-lg lui:border lui:py-4 lui:pl-11 lui:pr-4 lui:text-sm lui:text-foreground lui:transition-opacity lui:duration-300 lui:ease-out lui:opacity-100"
  end

  def type_classes
    case @type
    when :error
      "lui:border-destructive-border/50"
    else
      "lui:border-border"
    end
  end

  def title_classes
    base = "lui:mb-1 lui:font-medium lui:leading-none lui:tracking-tight"
    case @type
    when :error
      "#{base} lui:text-destructive-text"
    else
      base
    end
  end
end
