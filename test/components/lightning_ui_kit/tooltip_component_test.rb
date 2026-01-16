# frozen_string_literal: true

require "test_helper"

class LightningUiKit::TooltipComponentTest < ViewComponent::TestCase
  def test_renders_with_text
    result = render_inline(LightningUiKit::TooltipComponent.new(text: "Helpful tip")) { "Hover me" }

    assert_includes result.to_html, "Helpful tip"
    assert_includes result.to_html, "Hover me"
  end

  def test_renders_tooltip_controller
    result = render_inline(LightningUiKit::TooltipComponent.new(text: "Info")) { "?" }

    assert_includes result.to_html, "lui-tooltip"
  end

  def test_renders_with_content
    result = render_inline(LightningUiKit::TooltipComponent.new(text: "Tooltip text")) { "Trigger element" }

    assert_includes result.to_html, "Trigger element"
  end
end
