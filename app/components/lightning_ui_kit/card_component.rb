class LightningUiKit::CardComponent < LightningUiKit::BaseComponent
  renders_one :header
  renders_one :title
  renders_one :description
  renders_one :footer
  renders_one :action

  def initialize(**options)
    @options = options
  end

  def classes
    merge_classes([
      "lui:flex lui:flex-col lui:gap-6 lui:rounded-xl lui:border lui:border-border lui:bg-surface lui:py-6 lui:text-foreground lui:shadow-sm",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    @options[:data] || {}
  end
end
