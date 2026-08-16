class LightningUiKit::DescriptionListComponent < LightningUiKit::BaseComponent
  renders_many :items, ->(label:, value: nil, body: nil, **options) do
    LightningUiKit::DescriptionList::ItemComponent.new(label: label, value: value, body: body, **options)
  end

  # ViewComponent funnels slot blocks through Rails' `capture`, which discards
  # non-String return values (Integers, Dates, ...), rendering blank values.
  # Route the block around that wrapper via the body: argument so the item can
  # evaluate it instead.
  alias_method :__with_item_slot, :with_item
  def with_item(label:, value: nil, **options, &block)
    __with_item_slot(label: label, value: value, body: block, **options)
  end

  def initialize(**options)
    @options = options
  end

  def classes
    merge_classes([
      "lui:grid lui:grid-cols-1 lui:text-base/6 lui:sm:grid-cols-[min(50%,--spacing(80))_minmax(0,auto)] lui:sm:text-sm/6",
      @options[:class]
    ].compact.join(" "))
  end

  def data
    @options[:data] || {}
  end
end
