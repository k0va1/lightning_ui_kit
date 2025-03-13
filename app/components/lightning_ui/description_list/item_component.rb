class LightningUi::DescriptionList::ItemComponent < LightningUi::BaseComponent
  def initialize(label:, value: nil, **options)
    @label = label
    @value = value
    @options = options
  end
end
