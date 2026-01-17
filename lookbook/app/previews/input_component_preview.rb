class InputComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::InputComponent.new(
      name: :text,
      label: "Text",
      description: "Enter some text"
    )
  end

  def date
    render LightningUiKit::InputComponent.new(
      name: :birthday,
      type: :date,
      label: "Birthday",
      description: "Select your date of birth"
    )
  end
end
