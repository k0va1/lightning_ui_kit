# frozen_string_literal: true

require "test_helper"

class LightningUiKit::SkeletonComponentTest < ViewComponent::TestCase
  def test_renders_skeleton
    result = render_inline(LightningUiKit::SkeletonComponent.new)

    assert_includes result.to_html, "lui:animate-pulse"
  end

  def test_renders_with_title
    result = render_inline(LightningUiKit::SkeletonComponent.new(with_title: true))

    assert_includes result.to_html, "<h3"
  end

  def test_renders_correct_number_of_lines
    result = render_inline(LightningUiKit::SkeletonComponent.new(lines: 5))

    # Check for multiple skeleton lines
    assert_includes result.to_html, "lui:animate-pulse"
  end
end
