require "test_helper"

class LightningUiKit::TabsComponentTest < ViewComponent::TestCase
  def test_renders_tabs
    result = render_inline(LightningUiKit::TabsComponent.new) do |tabs|
      tabs.with_tab(title: "Tab 1") { "Content 1" }
      tabs.with_tab(title: "Tab 2") { "Content 2" }
    end

    assert_includes result.to_html, "lui-tabs"
    assert_includes result.to_html, "Tab 1"
    assert_includes result.to_html, "Tab 2"
  end

  def test_renders_tab_panels
    result = render_inline(LightningUiKit::TabsComponent.new) do |tabs|
      tabs.with_tab(title: "First") { "Panel content" }
    end

    assert_includes result.to_html, "Panel content"
    assert_includes result.to_html, 'role="tabpanel"'
  end

  def test_renders_tablist_role
    result = render_inline(LightningUiKit::TabsComponent.new) do |tabs|
      tabs.with_tab(title: "Tab") { "Content" }
    end

    assert_includes result.to_html, 'role="tablist"'
    assert_includes result.to_html, 'role="tab"'
  end

  def test_renders_aria_attributes
    result = render_inline(LightningUiKit::TabsComponent.new) do |tabs|
      tabs.with_tab(title: "Tab") { "Content" }
    end

    assert_includes result.to_html, "aria-controls"
    assert_includes result.to_html, "aria-labelledby"
    assert_includes result.to_html, "aria-selected"
  end

  def test_renders_with_custom_default_tab
    result = render_inline(LightningUiKit::TabsComponent.new(default_tab: 1)) do |tabs|
      tabs.with_tab(title: "Tab 1") { "Content 1" }
      tabs.with_tab(title: "Tab 2") { "Content 2" }
    end

    assert_includes result.to_html, 'data-lui-tabs-default-tab-value="1"'
  end
end
