require "test_helper"

class LightningUiKit::ToggleGroupComponentTest < ViewComponent::TestCase
  def test_renders_items
    result = render_inline(LightningUiKit::ToggleGroupComponent.new) do |group|
      group.with_item(value: "left") { "Left" }
      group.with_item(value: "right") { "Right" }
    end

    assert_includes result.to_html, "Left"
    assert_includes result.to_html, "Right"
    assert_includes result.to_html, 'data-controller="lui-toggle-group"'
  end

  def test_marks_selected_value
    result = render_inline(LightningUiKit::ToggleGroupComponent.new(value: "center")) do |group|
      group.with_item(value: "left") { "Left" }
      group.with_item(value: "center") { "Center" }
    end

    assert_includes result.to_html, 'data-value="center"'
    assert_includes result.to_html, 'data-state="on"'
  end

  def test_multiple_selection
    result = render_inline(LightningUiKit::ToggleGroupComponent.new(type: :multiple, value: ["a", "b"])) do |group|
      group.with_item(value: "a") { "A" }
      group.with_item(value: "b") { "B" }
      group.with_item(value: "c") { "C" }
    end

    assert_includes result.to_html, 'data-lui-toggle-group-type-value="multiple"'
    assert_equal 2, result.css('button[data-state="on"]').size
  end

  def test_type_value
    result = render_inline(LightningUiKit::ToggleGroupComponent.new) do |group|
      group.with_item(value: "a") { "A" }
    end

    assert_includes result.to_html, 'data-lui-toggle-group-type-value="single"'
  end
end
