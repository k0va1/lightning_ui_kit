# frozen_string_literal: true

require "test_helper"

class LightningUiKit::SidebarSectionComponentTest < ViewComponent::TestCase
  def test_renders_without_title
    result = render_inline(LightningUiKit::SidebarSectionComponent.new)

    assert_includes result.to_html, "lui:space-y-1"
  end

  def test_renders_with_title
    result = render_inline(LightningUiKit::SidebarSectionComponent.new(title: "Upcoming Events"))

    assert_includes result.to_html, "Upcoming Events"
    assert_includes result.to_html, "lui:uppercase"
  end

  def test_renders_links
    result = render_inline(LightningUiKit::SidebarSectionComponent.new) do |section|
      section.with_link(title: "Home", url: "/")
      section.with_link(title: "Settings", url: "/settings")
    end

    assert_includes result.to_html, "Home"
    assert_includes result.to_html, "Settings"
  end

  def test_renders_section_with_title_and_links
    result = render_inline(LightningUiKit::SidebarSectionComponent.new(title: "Navigation")) do |section|
      section.with_link(title: "Dashboard", url: "/dashboard", icon: "home")
    end

    assert_includes result.to_html, "Navigation"
    assert_includes result.to_html, "Dashboard"
  end
end
