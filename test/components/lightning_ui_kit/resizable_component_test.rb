require "test_helper"

class LightningUiKit::ResizableComponentTest < ViewComponent::TestCase
  def test_renders_both_panels_and_handle
    result = render_inline(LightningUiKit::ResizableComponent.new) do |resizable|
      resizable.with_panel_one { "One" }
      resizable.with_panel_two { "Two" }
    end

    assert_includes result.to_html, "One"
    assert_includes result.to_html, "Two"
    assert_includes result.to_html, 'data-lui-resizable-target="handle"'
  end

  def test_wires_controller
    result = render_inline(LightningUiKit::ResizableComponent.new) do |resizable|
      resizable.with_panel_one { "a" }
      resizable.with_panel_two { "b" }
    end

    assert_includes result.to_html, 'data-controller="lui-resizable"'
    assert_includes result.to_html, "pointerdown->lui-resizable#start"
  end

  def test_horizontal_by_default
    result = render_inline(LightningUiKit::ResizableComponent.new) do |resizable|
      resizable.with_panel_one { "a" }
      resizable.with_panel_two { "b" }
    end

    assert_includes result.to_html, 'data-lui-resizable-direction-value="horizontal"'
    assert_includes result.to_html, "lui:cursor-col-resize"
  end

  def test_vertical_direction
    result = render_inline(LightningUiKit::ResizableComponent.new(direction: :vertical)) do |resizable|
      resizable.with_panel_one { "a" }
      resizable.with_panel_two { "b" }
    end

    assert_includes result.to_html, 'data-lui-resizable-direction-value="vertical"'
    assert_includes result.to_html, "lui:cursor-row-resize"
  end

  def test_initial_basis
    result = render_inline(LightningUiKit::ResizableComponent.new(initial: 30)) do |resizable|
      resizable.with_panel_one { "a" }
      resizable.with_panel_two { "b" }
    end

    assert_includes result.to_html, "flex-basis: 30%;"
  end
end
