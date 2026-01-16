# frozen_string_literal: true

require "test_helper"

class LightningUiKit::ToastComponentTest < ViewComponent::TestCase
  def test_renders_with_content
    result = render_inline(LightningUiKit::ToastComponent.new) { "Success!" }

    assert_includes result.to_html, "Success!"
  end

  def test_renders_fixed_position
    result = render_inline(LightningUiKit::ToastComponent.new) { "Toast" }

    assert_includes result.to_html, "lui:fixed"
    assert_includes result.to_html, "lui:bottom-5"
  end

  def test_renders_with_custom_classes
    result = render_inline(LightningUiKit::ToastComponent.new(class: "lui:top-5")) { "Top toast" }

    assert_includes result.to_html, "lui:top-5"
  end
end
