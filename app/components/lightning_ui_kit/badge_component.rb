# frozen_string_literal: true

class LightningUiKit::BadgeComponent < LightningUiKit::BaseComponent
  def initialize(status: :default, progress: nil)
    @status = status
    @progress = progress
  end

  def classes
    status_classes = case @status
    when :success
      "bg-green-200 text-zinc-500"
    when :warning
      "bg-yellow-200 text-zinc-500"
    when :error
      "bg-red-600/80 text-white"
    else
      "bg-zinc-400/20 text-zinc-500"
    end
    [defalt_classes, status_classes].join(" ")
  end

  def progress_classes
    progress_classes = case @progress
    when :complete
      case @status
      when :success
        "bg-green-600 border-green-600"
      when :warning
        "bg-yellow-400 border-yellow-400"
      when :error
        "bg-red-700 border-red-700"
      else
        "bg-zinc-400 border-zinc-400"
      end
    when :incomplete
      case @status
      when :error
        "bg-transparent border-white"
      else
        "bg-transparent border-zinc-400"
      end
    when :partialy_complete
      partialy_complete_classes = "relative after:w-[3.75px] after:h-[8.2px]\
       after:border-transparent after:border-[1px] after:-rotate-45 after:absolute after:-top-[1px]\
       after:left-[1px] after:margin-0 after-margin-y-[1px]"
      case @status
      when :success
        "#{partialy_complete_classes} border-green-600 after:border-l-green-600 after:border-r-green-600"
      when :warning
        "#{partialy_complete_classes} border-yellow-400 after:border-l-yellow-400 after:border-r-yellow-400"
      when :error
        "#{partialy_complete_classes} border-white after:border-l-white after:border-r-white"
      else
        "#{partialy_complete_classes} border-zinc-400 after:border-l-zinc-400 after:border-r-zinc-400"
      end
    end
    [default_progress_classes, progress_classes].join(" ")
  end

  def default_progress_classes
    "h-2 w-2 rounded-[3px] border-[1px]"
  end

  def defalt_classes
    "relative inline-flex items-center relative gap-x-1.5 rounded-[10px] px-2.5 py-1 text-sm font-medium sm:text-xs forced-colors:outline"
  end
end
