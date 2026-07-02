class SliderComponentPreview < Lookbook::Preview
  # @param value number
  # @param min number
  # @param max number
  # @param step number
  def default(value: 50, min: 0, max: 100, step: 1)
    render LightningUiKit::SliderComponent.new(value: value, min: min, max: max, step: step, class: "lui:max-w-sm")
  end

  def stepped
    render LightningUiKit::SliderComponent.new(value: 40, min: 0, max: 100, step: 10, class: "lui:max-w-sm")
  end

  def disabled
    render LightningUiKit::SliderComponent.new(value: 30, disabled: true, class: "lui:max-w-sm")
  end
end
