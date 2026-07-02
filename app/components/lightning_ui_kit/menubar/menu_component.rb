class LightningUiKit::Menubar::MenuComponent < LightningUiKit::BaseComponent
  renders_many :items

  attr_reader :title

  def initialize(title:, **options)
    @title = title
    @options = options
  end

  def trigger_classes
    "lui:flex lui:cursor-pointer lui:select-none lui:items-center lui:rounded-sm lui:px-3 lui:py-1 lui:text-sm lui:font-medium lui:text-foreground lui:outline-none lui:hover:bg-surface-hover lui:data-[state=open]:bg-surface-hover"
  end

  def content_classes
    "lui:hidden lui:absolute lui:left-0 lui:top-full lui:z-50 lui:mt-1 lui:min-w-[12rem] lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-1 lui:text-foreground lui:shadow-lg"
  end

  def item_classes
    "lui:flex lui:cursor-pointer lui:items-center lui:gap-2 lui:rounded-sm lui:px-2 lui:py-1.5 lui:text-sm lui:text-foreground lui:outline-none lui:hover:bg-surface-hover"
  end
end
