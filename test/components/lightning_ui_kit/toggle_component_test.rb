require "test_helper"

class LightningUiKit::ToggleComponentTest < ViewComponent::TestCase
  def test_renders_content
    result = render_inline(LightningUiKit::ToggleComponent.new) { "Bold" }

    assert_includes result.to_html, "Bold"
    assert_includes result.to_html, 'data-controller="lui-toggle"'
  end

  def test_off_by_default
    result = render_inline(LightningUiKit::ToggleComponent.new) { "x" }

    assert_includes result.to_html, 'data-state="off"'
    assert_includes result.to_html, 'aria-pressed="false"'
  end

  def test_pressed
    result = render_inline(LightningUiKit::ToggleComponent.new(pressed: true)) { "x" }

    assert_includes result.to_html, 'data-state="on"'
    assert_includes result.to_html, 'aria-pressed="true"'
  end

  def test_disabled
    result = render_inline(LightningUiKit::ToggleComponent.new(disabled: true)) { "x" }

    assert_includes result.to_html, "disabled"
  end

  def test_outline_variant
    result = render_inline(LightningUiKit::ToggleComponent.new(variant: :outline)) { "x" }

    assert_includes result.to_html, "lui:border"
  end
end
