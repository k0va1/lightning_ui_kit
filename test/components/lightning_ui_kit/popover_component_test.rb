require "test_helper"

class LightningUiKit::PopoverComponentTest < ViewComponent::TestCase
  def test_renders_trigger_and_body
    result = render_inline(LightningUiKit::PopoverComponent.new) do |popover|
      popover.with_trigger { "Open" }
      popover.with_body { "Popover content" }
    end

    assert_includes result.to_html, "Open"
    assert_includes result.to_html, "Popover content"
  end

  def test_wires_stimulus_controller
    result = render_inline(LightningUiKit::PopoverComponent.new) do |popover|
      popover.with_trigger { "t" }
      popover.with_body { "b" }
    end

    assert_includes result.to_html, 'data-controller="lui-popover"'
    assert_includes result.to_html, "click->lui-popover#toggle"
  end

  def test_content_hidden_by_default
    result = render_inline(LightningUiKit::PopoverComponent.new) do |popover|
      popover.with_trigger { "t" }
      popover.with_body { "b" }
    end

    assert_includes result.to_html, "lui:hidden"
  end

  def test_position_value
    result = render_inline(LightningUiKit::PopoverComponent.new(position: :right)) do |popover|
      popover.with_trigger { "t" }
      popover.with_body { "b" }
    end

    assert_includes result.to_html, 'data-lui-popover-position-value="right"'
  end

  def test_invalid_position_falls_back_to_bottom
    result = render_inline(LightningUiKit::PopoverComponent.new(position: :nonsense)) do |popover|
      popover.with_trigger { "t" }
      popover.with_body { "b" }
    end

    assert_includes result.to_html, 'data-lui-popover-position-value="bottom"'
  end
end
