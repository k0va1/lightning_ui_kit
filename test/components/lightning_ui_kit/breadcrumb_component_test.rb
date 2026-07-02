require "test_helper"

class LightningUiKit::BreadcrumbComponentTest < ViewComponent::TestCase
  def test_renders_items
    result = render_inline(LightningUiKit::BreadcrumbComponent.new) do |breadcrumb|
      breadcrumb.with_item(href: "/") { "Home" }
      breadcrumb.with_item(current: true) { "Current" }
    end

    assert_includes result.to_html, "Home"
    assert_includes result.to_html, "Current"
    assert_includes result.to_html, 'href="/"'
  end

  def test_current_item_marked
    result = render_inline(LightningUiKit::BreadcrumbComponent.new) do |breadcrumb|
      breadcrumb.with_item(current: true) { "Here" }
    end

    assert_includes result.to_html, 'aria-current="page"'
  end

  def test_renders_separator_between_items
    result = render_inline(LightningUiKit::BreadcrumbComponent.new) do |breadcrumb|
      breadcrumb.with_item(href: "/") { "Home" }
      breadcrumb.with_item(current: true) { "Docs" }
    end

    # One separator between two items.
    assert_equal 1, result.css("li[aria-hidden='true']").size
  end

  def test_has_nav_landmark
    result = render_inline(LightningUiKit::BreadcrumbComponent.new) do |breadcrumb|
      breadcrumb.with_item(current: true) { "Home" }
    end

    assert_includes result.to_html, 'aria-label="breadcrumb"'
  end
end
