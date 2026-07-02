class LightningUiKit::ContextMenuComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_many :items

  def initialize(**options)
    @options = options
  end

  def trigger_classes
    merge_classes([
      "lui:flex lui:min-h-[8rem] lui:w-full lui:items-center lui:justify-center lui:rounded-md lui:border lui:border-dashed lui:border-border lui:text-sm lui:text-foreground-muted lui:select-none",
      @options[:class]
    ].compact.join(" "))
  end

  def content_classes
    "lui:hidden lui:fixed lui:z-50 lui:min-w-[8rem] lui:overflow-hidden lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-1 lui:text-foreground lui:shadow-md"
  end

  def item_classes
    "lui:flex lui:cursor-pointer lui:items-center lui:gap-2 lui:rounded-sm lui:px-2 lui:py-1.5 lui:text-sm lui:text-foreground lui:outline-none lui:hover:bg-surface-hover lui:focus:bg-surface-hover"
  end

  def data
    {controller: "lui-context-menu"}.merge(@options[:data] || {})
  end
end
