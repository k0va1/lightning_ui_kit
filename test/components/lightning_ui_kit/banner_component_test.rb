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
  end

  def test_renders_error_type
    result = render_inline(LightningUiKit::BannerComponent.new(title: "Error", type: :error)) { "Error content" }

    assert_includes result.to_html, "lui:*:data-[slot=header]:bg-red-600/80"
  end
end
