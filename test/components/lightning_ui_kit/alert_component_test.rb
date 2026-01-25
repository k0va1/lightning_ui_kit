require "test_helper"

class LightningUiKit::AlertComponentTest < ViewComponent::TestCase
  def test_renders_alert_with_content
    result = render_inline(LightningUiKit::AlertComponent.new) { "This is an alert message" }

    assert_includes result.to_html, "This is an alert message"
  end

  def test_renders_with_default_classes
    result = render_inline(LightningUiKit::AlertComponent.new) { "Alert" }

    assert_includes result.to_html, "lui:flex"
    assert_includes result.to_html, "lui:rounded-lg"
  end

  def test_renders_with_custom_classes
    result = render_inline(LightningUiKit::AlertComponent.new(class: "lui:mt-4")) { "Alert" }

    assert_includes result.to_html, "lui:mt-4"
  end
end
