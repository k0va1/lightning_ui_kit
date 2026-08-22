class LightningUiKit::AlertComponent < LightningUiKit::BaseComponent
  DISMISS_AFTER_MS = 5000

  renders_one :footer

  def initialize(title: nil, type: :info, dismissible: false, autodismiss: false, dismiss_after: DISMISS_AFTER_MS, **options)
    @title = title
    @type = type
    @dismissible = dismissible
    @autodismiss = autodismiss
    @dismiss_after = dismiss_after
    @options = options
  end

  def dismissible? = @dismissible

  def autodismiss? = @autodismiss

  def stimulus_data
    data = {type: @type}
    data[:controller] = "lui-alert" if @title || dismissible? || autodismiss?
    if autodismiss?
      data[:lui_alert_autodismiss_value] = "true"
      data[:lui_alert_dismiss_after_value] = @dismiss_after
      # Hovering or focusing the alert holds it open so it can be read.
      data[:action] = "mouseenter->lui-alert#pause mouseleave->lui-alert#resume focusin->lui-alert#pause focusout->lui-alert#resume"
    end
    data
  end

  def dismiss_button_classes
    base = "lui:cursor-pointer lui:rounded-md lui:p-1 lui:text-foreground-muted lui:transition-colors lui:hover:text-foreground"
    @title ? "lui:absolute lui:right-3 lui:top-3 #{base}" : "lui:ms-auto lui:-my-1 lui:-me-1.5 lui:shrink-0 #{base}"
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
    shared = "lui:text-sm lui:text-foreground lui:rounded-lg lui:border"
    if @title
      "lui:relative lui:w-full #{shared} lui:py-4 lui:pl-11 #{dismissible? ? "lui:pr-10" : "lui:pr-4"}"
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
