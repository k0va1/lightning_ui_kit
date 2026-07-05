require "test_helper"

class LightningUiKit::ContextMenuComponentTest < ViewComponent::TestCase
  def test_renders_trigger_and_items
    result = render_inline(LightningUiKit::ContextMenuComponent.new) do |menu|
      menu.with_trigger { "Right-click" }
      menu.with_item { "Back" }
      menu.with_item { "Reload" }
    end

    assert_includes result.to_html, "Right-click"
    assert_includes result.to_html, "Back"
    assert_includes result.to_html, "Reload"
  end

  def test_wires_controller_and_contextmenu_action
    result = render_inline(LightningUiKit::ContextMenuComponent.new) do |menu|
      menu.with_trigger { "t" }
      menu.with_item { "i" }
    end

    assert_includes result.to_html, 'data-controller="lui-context-menu"'
    assert_includes result.to_html, "contextmenu->lui-context-menu#open"
  end

  def test_content_hidden_by_default
    result = render_inline(LightningUiKit::ContextMenuComponent.new) do |menu|
      menu.with_trigger { "t" }
      menu.with_item { "i" }
    end

    assert_includes result.to_html, "lui:hidden"
  end
end
