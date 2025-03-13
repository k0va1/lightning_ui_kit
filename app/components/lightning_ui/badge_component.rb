# frozen_string_literal: true

class LightningUi::BadgeComponent < LightningUi::BaseComponent
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
      "bg-red-200 text-white"
    else
      "bg-zinc-400/20 text-zinc-500"
    end
    [defalt_classes, status_classes].join(" ")
  end

  def progress_classes
    progress_classes = case @progress
    when :complete
      "bg-zinc-400 border-zinc-400"
    when :incomplete
      "bg-yellow-300 border-zinc-400"
    when :partialy_complete
      "relative border-yellow-600 after:w-[3.75px] after:h-[8.2px] after:border-transparent after:border-l-yellow-600 after:border-r-yellow-600 after:border-[1px] after:-rotate-45 after:absolute after:-top-[1px] after:left-[1px] after:margin-0 after-margin-y-[1px]"
    end
    [default_progress_classes, progress_classes].join(" ")
  end

  def default_progress_classes
    "h-2 w-2 rounded-[3px] border-[1px]"
  end

  #   hover:bg-zinc-400/30
  def defalt_classes
    "relative inline-flex items-center relative gap-x-1.5 rounded-[10px] px-2.5 py-1 text-sm font-medium sm:text-xs forced-colors:outline"
  end
end
