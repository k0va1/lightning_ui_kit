class LightningUiKit::SidebarSectionComponent < LightningUiKit::BaseComponent
  renders_many :links, LightningUiKit::SidebarLinkComponent

  def initialize(title: nil, **options)
    @title = title
    @options = options
  end

  def classes
    merge_classes(["lui:space-y-1", @options[:class]].compact.join(" "))
  end

  def title_classes
    "lui:px-3 lui:py-2 lui:text-xs lui:font-medium lui:text-zinc-400 lui:uppercase lui:tracking-wider"
  end
end
