require "test_helper"

class LightningUiKit::NavigationMenuComponentTest < ViewComponent::TestCase
  def test_renders_dropdown_and_link_items
    result = render_inline(LightningUiKit::NavigationMenuComponent.new) do |nav|
      nav.with_item(title: "Products") { "Panel content" }
      nav.with_item(title: "Docs", href: "/docs")
    end

    assert_includes result.to_html, "Products"
    assert_includes result.to_html, "Panel content"
    assert_includes result.to_html, 'href="/docs"'
    assert_includes result.to_html, "Docs"
  end

  def test_wires_controller
    result = render_inline(LightningUiKit::NavigationMenuComponent.new) do |nav|
      nav.with_item(title: "Products") { "x" }
    end

    assert_includes result.to_html, 'data-controller="lui-navigation-menu"'
    assert_includes result.to_html, "mouseenter->lui-navigation-menu#open"
  end

  def test_link_item_has_no_dropdown_content
    result = render_inline(LightningUiKit::NavigationMenuComponent.new) do |nav|
      nav.with_item(title: "Docs", href: "/docs")
    end

    refute_includes result.to_html, 'data-lui-navigation-menu-target="content"'
  end
end
