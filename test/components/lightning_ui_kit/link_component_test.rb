# frozen_string_literal: true

require "test_helper"

class LightningUiKit::LinkComponentTest < ViewComponent::TestCase
  def test_renders_with_title_and_url
    result = render_inline(LightningUiKit::LinkComponent.new(title: "Home", url: "/home"))

    assert_includes result.to_html, "Home"
    assert_includes result.to_html, "/home"
    assert_includes result.to_html, "<a"
  end

  def test_renders_link_styling
    result = render_inline(LightningUiKit::LinkComponent.new(title: "About", url: "/about"))

    assert_includes result.to_html, "lui:hover:underline"
  end
end
