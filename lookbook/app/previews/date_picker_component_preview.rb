class DatePickerComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::DatePickerComponent.new(name: :due_on)
  end

  def with_value
    render LightningUiKit::DatePickerComponent.new(name: :due_on, selected: "2026-07-15")
  end
end
