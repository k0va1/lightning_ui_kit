require "test_helper"

class LightningUiKit::ButtonComponentTest < ViewComponent::TestCase
  def test_renders_with_content
    result = render_inline(LightningUiKit::ButtonComponent.new) { "Click me" }

    assert_includes result.to_html, "Click me"
    assert_includes result.to_html, "<button"
  end

  def test_renders_as_link_when_url_provided
    result = render_inline(LightningUiKit::ButtonComponent.new(url: "/path")) { "Go" }

    assert_includes result.to_html, "<a"
    assert_includes result.to_html, "/path"
  end

  def test_renders_outline_style
    result = render_inline(LightningUiKit::ButtonComponent.new(style: :outline)) { "Outline" }

    assert_includes result.to_html, "lui:border-border"
  end

  def test_renders_destructive_style
    result = render_inline(LightningUiKit::ButtonComponent.new(style: :destructive)) { "Delete" }

    assert_includes result.to_html, "lui:border-destructive-border"
  end

  def test_renders_small_size
    result = render_inline(LightningUiKit::ButtonComponent.new(size: :small)) { "Small" }

    assert_includes result.to_html, "lui:text-xs"
  end

  def test_renders_disabled
    result = render_inline(LightningUiKit::ButtonComponent.new(disabled: true)) { "Disabled" }

    assert_includes result.to_html, "disabled"
  end
end
