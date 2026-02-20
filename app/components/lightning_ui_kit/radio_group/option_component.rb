class LightningUiKit::RadioGroup::OptionComponent < LightningUiKit::BaseComponent
  attr_reader :value, :label, :description

  def initialize(value:, label:, description: nil, disabled: false)
    @value = value
    @label = label
    @description = description
    @disabled = disabled
  end

  def disabled?
    @disabled
  end
end
