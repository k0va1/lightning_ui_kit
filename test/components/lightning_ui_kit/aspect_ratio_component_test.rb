require "test_helper"

class LightningUiKit::AspectRatioComponentTest < ViewComponent::TestCase
  def test_renders_content
    result = render_inline(LightningUiKit::AspectRatioComponent.new) { "Inner" }

    assert_includes result.to_html, "Inner"
  end

  def test_default_ratio
    result = render_inline(LightningUiKit::AspectRatioComponent.new) { "x" }

    assert_includes result.to_html, "aspect-ratio: 1 / 1;"
  end

  def test_normalizes_slash_ratio
    result = render_inline(LightningUiKit::AspectRatioComponent.new(ratio: "16/9")) { "x" }

    assert_includes result.to_html, "aspect-ratio: 16 / 9;"
  end

  def test_accepts_custom_class
    result = render_inline(LightningUiKit::AspectRatioComponent.new(class: "lui:rounded-lg")) { "x" }

    assert_includes result.to_html, "lui:rounded-lg"
  end
end
