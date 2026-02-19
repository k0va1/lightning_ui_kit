class LightningUiKit::TextComponent < LightningUiKit::BaseComponent
  def initialize(size: :md, **options)
    @size = size
    @options = options
  end

  def classes
    merge_classes(["lui:text-foreground-secondary lui:text-#{@size}", @options[:class]].compact.join(" "))
  end
end
