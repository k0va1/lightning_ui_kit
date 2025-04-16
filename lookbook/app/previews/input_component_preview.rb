class InputComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::InputComponent.new(
      name: :text,
      label: "Text",
      description: "Enter some text"
    )
  end
end
