class InputComponentPreview < Lookbook::Preview
  def default
    render LightningUi::InputComponent.new(
      name: :text,
      label: "Text",
      description: "Enter some text"
    )
  end
end
