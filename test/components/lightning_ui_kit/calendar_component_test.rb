require "test_helper"
require "ostruct"

class LightningUiKit::CalendarComponentTest < ViewComponent::TestCase
  def test_wires_controller
    result = render_inline(LightningUiKit::CalendarComponent.new)

    assert_includes result.to_html, 'data-controller="lui-calendar"'
    assert_includes result.to_html, 'data-lui-calendar-target="grid"'
    assert_includes result.to_html, 'data-lui-calendar-target="label"'
  end

  def test_selected_value_passed
    result = render_inline(LightningUiKit::CalendarComponent.new(selected: "2026-07-15"))

    assert_includes result.to_html, 'data-lui-calendar-selected-value="2026-07-15"'
    assert_includes result.to_html, 'data-lui-calendar-month-value="2026-07"'
  end

  def test_accepts_date_object
    result = render_inline(LightningUiKit::CalendarComponent.new(selected: Date.new(2026, 1, 2)))

    assert_includes result.to_html, 'data-lui-calendar-selected-value="2026-01-02"'
  end

  def test_hidden_input_when_named
    result = render_inline(LightningUiKit::CalendarComponent.new(name: :day, selected: "2026-07-15"))

    assert_includes result.to_html, 'data-lui-calendar-target="input"'
    assert_includes result.to_html, 'name="day"'
  end

  def test_no_hidden_input_without_name
    result = render_inline(LightningUiKit::CalendarComponent.new)

    refute_includes result.to_html, 'data-lui-calendar-target="input"'
  end

  def test_form_prefixes_name
    form = OpenStruct.new(object_name: "event")
    result = render_inline(LightningUiKit::CalendarComponent.new(name: :starts_on, form: form))

    assert_includes result.to_html, 'name="event[starts_on]"'
  end
end
