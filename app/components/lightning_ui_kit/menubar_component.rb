class LightningUiKit::MenubarComponent < LightningUiKit::BaseComponent
  renders_many :menus, LightningUiKit::Menubar::MenuComponent

  def initialize(**options)
    @options = options
  end

  def classes
    merge_classes([
      "lui:flex lui:h-9 lui:items-center lui:gap-1 lui:rounded-md lui:border lui:border-border lui:bg-surface lui:p-1",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    {
      controller: "lui-menubar",
      action: "keydown.esc@window->lui-menubar#closeAll click@window->lui-menubar#closeOnOutside"
    }.merge(@options[:data] || {})
  end
end
