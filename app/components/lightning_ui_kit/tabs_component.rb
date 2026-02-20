class LightningUiKit::TabsComponent < LightningUiKit::BaseComponent
  renders_many :tabs, LightningUiKit::Tabs::TabComponent

  VARIANTS = %i[default line].freeze

  def initialize(default_tab: 0, variant: :default, **options)
    @default_tab = default_tab
    @variant = VARIANTS.include?(variant) ? variant : :default
    @options = options
  end

  def classes
    merge_classes([
      "lui:flex lui:flex-col lui:gap-2 lui:w-full",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-tabs",
      lui_tabs_default_tab_value: @default_tab
    }.merge(@options[:data] || {})
  end

  def list_classes
    base = "lui:inline-flex lui:w-fit lui:items-center lui:justify-center lui:text-foreground-muted"
    case @variant
    when :line
      "#{base} lui:gap-1 lui:rounded-none lui:bg-transparent"
    else
      "#{base} lui:h-9 lui:rounded-lg lui:bg-surface-tertiary lui:p-[3px]"
    end
  end

  def tab_classes
    base = "lui:relative lui:inline-flex lui:items-center lui:justify-center lui:gap-1.5 lui:rounded-md lui:px-3 lui:py-1 lui:text-sm lui:font-medium lui:whitespace-nowrap lui:cursor-pointer " \
           "lui:transition-all lui:duration-150 " \
           "lui:text-foreground-muted lui:hover:text-foreground " \
           "lui:focus:outline-hidden lui:focus-visible:outline lui:focus-visible:outline-2 lui:focus-visible:outline-offset-[-2px] lui:focus-visible:outline-focus " \
           "lui:disabled:pointer-events-none lui:disabled:opacity-50"

    case @variant
    when :line
      "#{base} lui:bg-transparent lui:data-[active]:bg-transparent " \
      "lui:data-[active]:text-foreground " \
      "lui:after:absolute lui:after:inset-x-0 lui:after:bottom-[-5px] lui:after:h-0.5 lui:after:bg-foreground lui:after:opacity-0 lui:after:transition-opacity lui:data-[active]:after:opacity-100"
    else
      "#{base} lui:h-[calc(100%-1px)] lui:border lui:border-transparent " \
      "lui:data-[active]:bg-surface lui:data-[active]:text-foreground lui:data-[active]:border-border lui:data-[active]:shadow-sm"
    end
  end

  def line_variant?
    @variant == :line
  end

  def tab_id(index)
    "tab-#{object_id}-#{index}"
  end

  def panel_id(index)
    "panel-#{object_id}-#{index}"
  end
end
