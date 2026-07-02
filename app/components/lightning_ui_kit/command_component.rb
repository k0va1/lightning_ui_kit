class LightningUiKit::CommandComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::Command::ItemComponent

  def initialize(placeholder: "Type a command or search...", empty_text: "No results found.", **options)
    @placeholder = placeholder
    @empty_text = empty_text
    @options = options
  end

  attr_reader :placeholder, :empty_text

  def classes
    merge_classes([
      "lui:flex lui:w-full lui:flex-col lui:overflow-hidden lui:rounded-lg lui:border lui:border-border lui:bg-surface lui:text-foreground lui:shadow-md",
      @options[:class]
    ].compact.join(" "))
  end

  def item_classes
    "lui:flex lui:cursor-pointer lui:items-center lui:gap-2 lui:rounded-sm lui:px-2 lui:py-1.5 lui:text-sm lui:text-foreground lui:outline-none lui:data-[active]:bg-surface-hover lui:hover:bg-surface-hover"
  end

  def data
    {controller: "lui-command"}.merge(@options[:data] || {})
  end
end
