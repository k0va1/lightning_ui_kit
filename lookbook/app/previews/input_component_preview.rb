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

  def datetime
    render LightningUiKit::InputComponent.new(
      name: :scheduled_at,
      type: :datetime,
      label: "Scheduled At",
      description: "Select date and time"
    )
  end
end
