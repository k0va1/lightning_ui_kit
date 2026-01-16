# frozen_string_literal: true

require "test_helper"

class LightningUiKit::PaginationComponentTest < ViewComponent::TestCase
  def test_renders_pagination
    result = render_inline(LightningUiKit::PaginationComponent.new(current_page: 1, total_pages: 5, path: "/items"))

    assert_includes result.to_html, "<div"
  end

  def test_renders_page_links
    result = render_inline(LightningUiKit::PaginationComponent.new(current_page: 3, total_pages: 5, path: "/items"))

    assert_includes result.to_html, "/items?page=1"
    assert_includes result.to_html, "/items?page=5"
  end

  def test_renders_current_page_as_active
    result = render_inline(LightningUiKit::PaginationComponent.new(current_page: 2, total_pages: 5, path: "/items"))

    assert_includes result.to_html, "data-active"
  end

  def test_renders_with_custom_page_param
    result = render_inline(LightningUiKit::PaginationComponent.new(current_page: 1, total_pages: 3, path: "/list", page_param: "p"))

    assert_includes result.to_html, "?p="
  end

  def test_pages_with_gaps_for_many_pages
    component = LightningUiKit::PaginationComponent.new(current_page: 5, total_pages: 10, path: "/items")
    pages = component.pages_with_gaps

    assert_includes pages, :gap
    assert_includes pages, 1
    assert_includes pages, 10
    assert_includes pages, 5
  end
end
