require "test_helper"

class LightningUiKit::SheetComponentTest < ViewComponent::TestCase
  def test_renders_trigger_body_and_title
    result = render_inline(LightningUiKit::SheetComponent.new(title: "Edit", description: "Desc")) do |sheet|
      sheet.with_trigger { "Open" }
      sheet.with_body { "Body content" }
    end

    assert_includes result.to_html, "Open"
    assert_includes result.to_html, "Body content"
    assert_includes result.to_html, "Edit"
    assert_includes result.to_html, "Desc"
  end

  def test_wires_stimulus_controller
    result = render_inline(LightningUiKit::SheetComponent.new) do |sheet|
      sheet.with_trigger { "Open" }
      sheet.with_body { "b" }
    end

    assert_includes result.to_html, 'data-controller="lui-sheet"'
    assert_includes result.to_html, "click->lui-sheet#open"
  end

  def test_right_side_by_default
    result = render_inline(LightningUiKit::SheetComponent.new) do |sheet|
      sheet.with_trigger { "Open" }
      sheet.with_body { "b" }
    end

    assert_includes result.to_html, "lui:right-0"
    assert_includes result.to_html, 'data-lui-sheet-panel-closed-class="lui:translate-x-full"'
  end

  def test_left_side
    result = render_inline(LightningUiKit::SheetComponent.new(side: :left)) do |sheet|
      sheet.with_trigger { "Open" }
      sheet.with_body { "b" }
    end

    assert_includes result.to_html, "lui:left-0"
    assert_includes result.to_html, 'data-lui-sheet-panel-closed-class="lui:-translate-x-full"'
  end

  def test_renders_actions
    result = render_inline(LightningUiKit::SheetComponent.new) do |sheet|
      sheet.with_trigger { "Open" }
      sheet.with_body { "b" }
      sheet.with_action { "Save" }
    end

    assert_includes result.to_html, "Save"
  end
end
