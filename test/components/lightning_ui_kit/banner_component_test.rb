require "test_helper"

class LightningUiKit::BannerComponentTest < ViewComponent::TestCase
  def test_renders_with_title
    result = render_inline(LightningUiKit::BannerComponent.new(title: "Important Notice")) { "Banner content" }

    assert_includes result.to_html, "Important Notice"
    assert_includes result.to_html, "Banner content"
  end

  def test_renders_info_type_by_default
    result = render_inline(LightningUiKit::BannerComponent.new(title: "Info")) { "Content" }

    assert_includes result.to_html, "lui:rounded-lg"
    assert_includes result.to_html, "lui:border-border"
    assert_includes result.to_html, "lui:text-foreground"
  end

  def test_renders_error_type
    result = render_inline(LightningUiKit::BannerComponent.new(title: "Error", type: :error)) { "Error content" }

    assert_includes result.to_html, "lui:border-destructive-border/50"
    assert_includes result.to_html, "lui:text-destructive-text" # title class
  end

  def test_renders_footer
    result = render_inline(LightningUiKit::BannerComponent.new(title: "Notice")) do |banner|
      banner.with_footer { "Footer content" }
      "Body content"
    end

    assert_includes result.to_html, "Footer content"
  end
end
