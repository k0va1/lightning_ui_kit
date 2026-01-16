# frozen_string_literal: true

require "test_helper"

class LightningUiKit::DropdownComponentTest < ViewComponent::TestCase
  def test_renders_component
    result = render_inline(LightningUiKit::DropdownComponent.new)

    assert_includes result.to_html, "lui-dropdown"
  end

  def test_renders_with_trigger_text
    result = render_inline(LightningUiKit::DropdownComponent.new(trigger_text: "Options"))

    assert_includes result.to_html, "Options"
  end

  def test_renders_bottom_position_by_default
    result = render_inline(LightningUiKit::DropdownComponent.new)

    assert_includes result.to_html, "lui:mt-2"
  end

  def test_renders_top_position
    result = render_inline(LightningUiKit::DropdownComponent.new(position: :top))

    assert_includes result.to_html, "lui:bottom-full"
  end
end
