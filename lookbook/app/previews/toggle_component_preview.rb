class ToggleComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::ToggleComponent.new do
      "Bold"
    end
  end

  def pressed
    render LightningUiKit::ToggleComponent.new(pressed: true) do
      "Italic"
    end
  end

  def outline
    render LightningUiKit::ToggleComponent.new(variant: :outline) do
      "Underline"
    end
  end

  def disabled
    render LightningUiKit::ToggleComponent.new(disabled: true) do
      "Disabled"
    end
  end
end
