class LightningUiKit::ToggleGroup::ItemComponent < LightningUiKit::BaseComponent
  attr_reader :value

  def initialize(value:, **options)
    @value = value
    @options = options
  end
end
