require "test_helper"

class LightningUiKit::MenubarComponentTest < ViewComponent::TestCase
  def test_renders_menus_and_items
    result = render_inline(LightningUiKit::MenubarComponent.new) do |menubar|
      menubar.with_menu(title: "File") do |menu|
        menu.with_item { "New Tab" }
        menu.with_item { "Print" }
      end
      menubar.with_menu(title: "Edit") do |menu|
        menu.with_item { "Undo" }
      end
    end

    assert_includes result.to_html, "File"
    assert_includes result.to_html, "Edit"
    assert_includes result.to_html, "New Tab"
    assert_includes result.to_html, "Undo"
  end

  def test_wires_controller
    result = render_inline(LightningUiKit::MenubarComponent.new) do |menubar|
      menubar.with_menu(title: "File") do |menu|
        menu.with_item { "New Tab" }
      end
    end

    assert_includes result.to_html, 'data-controller="lui-menubar"'
    assert_includes result.to_html, "click->lui-menubar#toggle"
  end

  def test_menu_content_hidden_by_default
    result = render_inline(LightningUiKit::MenubarComponent.new) do |menubar|
      menubar.with_menu(title: "File") do |menu|
        menu.with_item { "New Tab" }
      end
    end

    assert_includes result.to_html, "lui:hidden"
    assert_equal 1, result.css('[data-lui-menubar-target="menu"]').size
  end
end
