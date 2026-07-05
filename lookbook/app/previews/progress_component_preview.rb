class ProgressComponentPreview < Lookbook::Preview
  # @param value number
  # @param max number
  def default(value: 60, max: 100)
    render LightningUiKit::ProgressComponent.new(value: value, max: max, class: "lui:max-w-sm")
  end

  def empty
    render LightningUiKit::ProgressComponent.new(value: 0, class: "lui:max-w-sm")
  end

  def complete
    render LightningUiKit::ProgressComponent.new(value: 100, class: "lui:max-w-sm")
  end
end
