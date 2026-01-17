# frozen_string_literal: true

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
      merge_classes([base_classes, "lui:bg-zinc-950/5 lui:text-zinc-950 lui:font-semibold", @options[:class]].compact.join(" "))
    else
      merge_classes([base_classes, "lui:text-zinc-600 lui:hover:bg-zinc-950/5 lui:hover:text-zinc-950", @options[:class]].compact.join(" "))
    end
  end

  def icon_classes
    if @current
      "lui:size-5 lui:shrink-0 lui:text-zinc-600"
    else
      "lui:size-5 lui:shrink-0 lui:text-zinc-400"
    end
  end

  def data
    @options[:data] || {}
  end
end
