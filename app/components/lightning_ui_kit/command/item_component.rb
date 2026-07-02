class LightningUiKit::Command::ItemComponent < LightningUiKit::BaseComponent
  attr_reader :value

  def initialize(value: nil, **options)
    @value = value
    @options = options
  end
end
