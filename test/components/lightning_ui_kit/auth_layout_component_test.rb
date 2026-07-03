require "test_helper"

class LightningUiKit::AuthLayoutComponentTest < ViewComponent::TestCase
  def test_renders_content_centered_in_main
    result = render_inline(LightningUiKit::AuthLayoutComponent.new) { "Sign in form" }

    assert_includes result.to_html, "Sign in form"
    assert result.css("main").any?
    assert_includes result.to_html, "lui:items-center lui:justify-center"
  end

  def test_uses_page_surface_and_gradient
    result = render_inline(LightningUiKit::AuthLayoutComponent.new) { "x" }

    assert_includes result.to_html, "lui:bg-surface-page"
    assert_includes result.to_html, "lui-page-gradient"
  end

  def test_accepts_custom_class
    result = render_inline(LightningUiKit::AuthLayoutComponent.new(class: "lui:min-h-screen")) { "x" }

    assert_includes result.to_html, "lui:min-h-screen"
  end
end
