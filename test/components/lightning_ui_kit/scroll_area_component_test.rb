require "test_helper"

class LightningUiKit::ScrollAreaComponentTest < ViewComponent::TestCase
  def test_renders_content
    result = render_inline(LightningUiKit::ScrollAreaComponent.new) { "Scrollable" }

    assert_includes result.to_html, "Scrollable"
  end

  def test_vertical_by_default
    result = render_inline(LightningUiKit::ScrollAreaComponent.new) { "x" }

    assert_includes result.to_html, "lui:overflow-y-auto"
  end

  def test_horizontal_orientation
    result = render_inline(LightningUiKit::ScrollAreaComponent.new(orientation: :horizontal)) { "x" }

    assert_includes result.to_html, "lui:overflow-x-auto"
  end

  def test_accepts_custom_class
    result = render_inline(LightningUiKit::ScrollAreaComponent.new(class: "lui:h-48")) { "x" }

    assert_includes result.to_html, "lui:h-48"
  end
end
