class CalendarComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CalendarComponent.new
  end

  def with_selected_date
    render LightningUiKit::CalendarComponent.new(selected: "2026-07-15")
  end

  def bound_to_field
    render LightningUiKit::CalendarComponent.new(name: :starts_on, selected: "2026-07-04")
  end
end
