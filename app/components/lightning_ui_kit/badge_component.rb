class LightningUiKit::BadgeComponent < LightningUiKit::BaseComponent
  def initialize(status: :default, progress: nil)
    @status = status
    @progress = progress
  end

  def classes
    status_classes = case @status
    when :success
      "lui:bg-success-bg lui:text-foreground-muted"
    when :warning
      "lui:bg-warning-bg lui:text-foreground-muted"
    when :error
      "lui:bg-destructive/80 lui:text-foreground-invert"
    else
      "lui:bg-foreground-faint/20 lui:text-foreground-muted"
    end
    [defalt_classes, status_classes].join(" ")
  end

  def progress_classes
    progress_classes = case @progress
    when :complete
      case @status
      when :success
        "lui:bg-success-indicator lui:border-success-indicator"
      when :warning
        "lui:bg-warning-indicator lui:border-warning-indicator"
      when :error
        "lui:bg-destructive lui:border-destructive"
      else
        "lui:bg-foreground-faint lui:border-foreground-faint"
      end
    when :incomplete
      case @status
      when :error
        "lui:bg-transparent lui:border-foreground-invert"
      else
        "lui:bg-transparent lui:border-foreground-faint"
      end
    when :partialy_complete
      partialy_complete_classes = "lui:relative lui:after:w-[3.75px] lui:after:h-[8.2px]\
       lui:after:border-transparent lui:after:border-[1px] lui:after:-rotate-45 lui:after:absolute lui:after:-top-[1px]\
       lui:after:left-[1px] lui:after:margin-0 lui:after-margin-y-[1px]"
      case @status
      when :success
        "#{partialy_complete_classes} lui:border-success-indicator lui:after:border-l-success-indicator lui:after:border-r-success-indicator"
      when :warning
        "#{partialy_complete_classes} lui:border-warning-indicator lui:after:border-l-warning-indicator lui:after:border-r-warning-indicator"
      when :error
        "#{partialy_complete_classes} lui:border-foreground-invert lui:after:border-l-foreground-invert lui:after:border-r-foreground-invert"
      else
        "#{partialy_complete_classes} lui:border-foreground-faint lui:after:border-l-foreground-faint lui:after:border-r-foreground-faint"
      end
    end
    [default_progress_classes, progress_classes].join(" ")
  end

  def default_progress_classes
    "lui:h-2 lui:w-2 lui:rounded-[3px] lui:border-[1px]"
  end

  def defalt_classes
    "lui:relative lui:inline-flex lui:items-center lui:relative lui:gap-x-1.5 lui:rounded-[10px] lui:px-2.5 lui:py-1 lui:text-sm lui:font-medium lui:sm:text-xs lui:forced-colors:outline"
  end
end
