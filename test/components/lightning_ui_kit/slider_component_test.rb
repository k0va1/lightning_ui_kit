require "test_helper"
require "ostruct"

class LightningUiKit::SliderComponentTest < ViewComponent::TestCase
  def test_renders_range_input
    result = render_inline(LightningUiKit::SliderComponent.new(value: 50))

    assert_includes result.to_html, 'type="range"'
    assert_includes result.to_html, 'data-controller="lui-slider"'
  end

  def test_fill_and_thumb_reflect_value
    result = render_inline(LightningUiKit::SliderComponent.new(value: 25, min: 0, max: 100))

    assert_includes result.to_html, "width: 25%;"
    assert_includes result.to_html, "left: 25%;"
  end

  def test_respects_min_max
    result = render_inline(LightningUiKit::SliderComponent.new(value: 5, min: 0, max: 10))

    assert_includes result.to_html, "width: 50%;"
    assert_includes result.to_html, 'max="10"'
  end

  def test_form_prefixes_name
    form = OpenStruct.new(object_name: "settings")
    result = render_inline(LightningUiKit::SliderComponent.new(name: :volume, form: form, value: 10))

    assert_includes result.to_html, 'name="settings[volume]"'
  end

  def test_disabled
    result = render_inline(LightningUiKit::SliderComponent.new(disabled: true))

    assert_includes result.to_html, "disabled"
  end
end
