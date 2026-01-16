# frozen_string_literal: true

require "test_helper"

class LightningUiKit::CheckboxComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "terms"))

    assert_includes result.to_html, "terms"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "agree", label: "I agree"))

    assert_includes result.to_html, "I agree"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "newsletter", description: "Subscribe to updates"))

    assert_includes result.to_html, "Subscribe to updates"
  end

  def test_renders_checked_state
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "active", checked: true))

    assert_includes result.to_html, "checked"
  end
end
