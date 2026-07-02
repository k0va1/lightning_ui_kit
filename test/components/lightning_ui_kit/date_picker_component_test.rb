require "test_helper"

class LightningUiKit::DatePickerComponentTest < ViewComponent::TestCase
  def test_renders_trigger_and_calendar
    result = render_inline(LightningUiKit::DatePickerComponent.new(name: :due_on))

    assert_includes result.to_html, 'data-controller="lui-date-picker"'
    assert_includes result.to_html, 'data-controller="lui-calendar"'
    assert_includes result.to_html, "click->lui-date-picker#toggle"
  end

  def test_placeholder_when_empty
    result = render_inline(LightningUiKit::DatePickerComponent.new(name: :due_on, placeholder: "Choose day"))

    assert_includes result.to_html, "Choose day"
  end

  def test_formats_selected_date_in_label
    result = render_inline(LightningUiKit::DatePickerComponent.new(name: :due_on, selected: "2026-07-04"))

    assert_includes result.to_html, "July 4, 2026"
  end

  def test_hidden_input_holds_iso_value
    result = render_inline(LightningUiKit::DatePickerComponent.new(name: :due_on, selected: "2026-07-04"))

    assert_includes result.to_html, 'data-lui-date-picker-target="input"'
    assert_includes result.to_html, 'value="2026-07-04"'
  end

  def test_listens_for_calendar_select
    result = render_inline(LightningUiKit::DatePickerComponent.new(name: :due_on))

    assert_includes result.to_html, "lui-calendar:select->lui-date-picker#onSelect"
  end
end
