class LightningUiKit::DescriptionList::ItemComponent < LightningUiKit::BaseComponent
  def initialize(label:, value: nil, **options)
    @label = label
    @value = value
    @options = options
  end
end
