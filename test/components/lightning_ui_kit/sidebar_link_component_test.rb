require "test_helper"

class LightningUiKit::SidebarLinkComponentTest < ViewComponent::TestCase
  def test_renders_with_title_and_url
    result = render_inline(LightningUiKit::SidebarLinkComponent.new(title: "Home", url: "/"))

    assert_includes result.to_html, "Home"
    assert_includes result.to_html, 'href="/"'
  end

  def test_renders_with_icon
    result = render_inline(LightningUiKit::SidebarLinkComponent.new(title: "Settings", url: "/settings", icon: "cog-6-tooth"))

    assert_includes result.to_html, "Settings"
    assert_includes result.to_html, "svg"
  end

  def test_renders_without_icon
    result = render_inline(LightningUiKit::SidebarLinkComponent.new(title: "Event Name", url: "/events/1"))

    assert_includes result.to_html, "Event Name"
  end

  def test_current_state_applies_active_classes
    result = render_inline(LightningUiKit::SidebarLinkComponent.new(title: "Home", url: "/", current: true))

    assert_includes result.to_html, "lui:bg-surface-hover"
    assert_includes result.to_html, "lui:font-semibold"
  end

  def test_non_current_state_applies_default_classes
    result = render_inline(LightningUiKit::SidebarLinkComponent.new(title: "Home", url: "/", current: false))

    assert_includes result.to_html, "lui:text-foreground-secondary"
    assert_includes result.to_html, "lui:hover:bg-surface-hover"
  end
end
