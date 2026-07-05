class LightningUiKit::NavigationMenuComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::NavigationMenu::ItemComponent

  def initialize(**options)
    @options = options
  end

  def classes
    merge_classes([
      "lui:relative lui:z-10 lui:flex lui:max-w-max lui:flex-1 lui:items-center lui:justify-center",
      @options[:class]
    ].compact.join(" "))
  end

  def trigger_classes
    "lui:inline-flex lui:h-9 lui:w-max lui:items-center lui:justify-center lui:gap-1 lui:rounded-md lui:px-4 lui:py-2 lui:text-sm lui:font-medium lui:text-foreground lui:transition-colors lui:hover:bg-surface-hover lui:focus:outline-none lui:data-[state=open]:bg-surface-hover"
  end

  def content_classes
    "lui:hidden lui:absolute lui:left-0 lui:top-full lui:mt-1.5 lui:min-w-[12rem] lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-2 lui:text-foreground lui:shadow-lg"
  end

  def data
    {controller: "lui-navigation-menu"}.merge(@options[:data] || {})
  end
end
