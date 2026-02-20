class LightningUiKit::AlertComponent < LightningUiKit::BaseComponent
  renders_one :footer

  def initialize(title: nil, type: :info, **options)
    @title = title
    @type = type
    @options = options
  end

  def classes
    merge_classes([base_classes, type_classes, @options[:class]].compact.join(" "))
  end

  def icon
    case @type
    when :error then "exclamation-triangle"
    when :success then "check-circle"
    when :warning then "exclamation-triangle"
    else "information-circle"
    end
  end

  def icon_classes
    base = if @title
      "lui:absolute lui:left-4 lui:top-4 lui:size-4"
    else
      "lui:size-4 lui:me-3 lui:shrink-0"
    end

    case @type
    when :error then "#{base} lui:text-destructive-text"
    when :success then "#{base} lui:text-success-text"
    when :warning then "#{base} lui:text-warning-text"
    else "#{base} lui:text-foreground"
    end
  end

  def title_classes
    base = "lui:mb-1 lui:font-medium lui:leading-none lui:tracking-tight"
    case @type
    when :error then "#{base} lui:text-destructive-text"
    when :success then "#{base} lui:text-success-text"
    when :warning then "#{base} lui:text-warning-text"
    else base
    end
  end

  private

  def base_classes
    shared = "lui:text-sm lui:text-foreground lui:rounded-lg lui:border lui:transition-opacity lui:duration-300 lui:ease-out lui:opacity-100"
    if @title
      "lui:relative lui:w-full #{shared} lui:py-4 lui:pl-11 lui:pr-4"
    else
      "lui:flex lui:items-center #{shared} lui:p-4"
    end
  end

  def type_classes
    case @type
    when :error then "lui:border-destructive-border/50"
    when :success then "lui:border-success-indicator/50"
    when :warning then "lui:border-warning-indicator/50"
    else "lui:border-border"
    end
  end
end
