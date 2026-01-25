require "test_helper"

class LightningUiKit::SpinnerComponentTest < ViewComponent::TestCase
  def test_renders_spinner
    result = render_inline(LightningUiKit::SpinnerComponent.new)

    assert_includes result.to_html, "lui:animate-spin"
  end

  def test_renders_svg
    result = render_inline(LightningUiKit::SpinnerComponent.new)

    assert_includes result.to_html, "<svg"
  end
end
