class LightningUiKit::BadgeComponent < LightningUiKit::BaseComponent
  def initialize(status: :default, progress: nil)
    @status = status
    @progress = progress
  end

  def classes
    status_classes = case @status
    when :success
      "lui:bg-green-200 lui:text-zinc-500"
    when :warning
      "lui:bg-yellow-200 lui:text-zinc-500"
    when :error
      "lui:bg-red-600/80 lui:text-white"
    else
      "lui:bg-zinc-400/20 lui:text-zinc-500"
    end
    [defalt_classes, status_classes].join(" ")
  end

  def progress_classes
    progress_classes = case @progress
    when :complete
      case @status
      when :success
        "lui:bg-green-600 lui:border-green-600"
      when :warning
        "lui:bg-yellow-400 lui:border-yellow-400"
      when :error
        "lui:bg-red-700 lui:border-red-700"
      else
        "lui:bg-zinc-400 lui:border-zinc-400"
      end
    when :incomplete
      case @status
      when :error
        "lui:bg-transparent lui:border-white"
      else
        "lui:bg-transparent lui:border-zinc-400"
      end
    when :partialy_complete
      partialy_complete_classes = "lui:relative lui:after:w-[3.75px] lui:after:h-[8.2px]\
       lui:after:border-transparent lui:after:border-[1px] lui:after:-rotate-45 lui:after:absolute lui:after:-top-[1px]\
       lui:after:left-[1px] lui:after:margin-0 lui:after-margin-y-[1px]"
      case @status
      when :success
        "#{partialy_complete_classes} lui:border-green-600 lui:after:border-l-green-600 lui:after:border-r-green-600"
      when :warning
        "#{partialy_complete_classes} lui:border-yellow-400 lui:after:border-l-yellow-400 lui:after:border-r-yellow-400"
      when :error
        "#{partialy_complete_classes} lui:border-white lui:after:border-l-white lui:after:border-r-white"
      else
        "#{partialy_complete_classes} lui:border-zinc-400 lui:after:border-l-zinc-400 lui:after:border-r-zinc-400"
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
