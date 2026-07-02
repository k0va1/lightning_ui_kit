require "test_helper"

class LightningUiKit::SeparatorComponentTest < ViewComponent::TestCase
  def test_renders_horizontal_by_default
    result = render_inline(LightningUiKit::SeparatorComponent.new)

    assert_includes result.to_html, "lui:h-px"
    assert_includes result.to_html, "lui:w-full"
    assert_includes result.to_html, "lui:bg-border"
  end

  def test_renders_vertical
    result = render_inline(LightningUiKit::SeparatorComponent.new(orientation: :vertical))

    assert_includes result.to_html, "lui:h-full"
    assert_includes result.to_html, "lui:w-px"
  end

  def test_decorative_uses_role_none
    result = render_inline(LightningUiKit::SeparatorComponent.new)

    assert_includes result.to_html, 'role="none"'
  end

  def test_non_decorative_uses_role_separator
    result = render_inline(LightningUiKit::SeparatorComponent.new(decorative: false, orientation: :vertical))

    assert_includes result.to_html, 'role="separator"'
    assert_includes result.to_html, 'aria-orientation="vertical"'
  end

  def test_accepts_custom_class
    result = render_inline(LightningUiKit::SeparatorComponent.new(class: "lui:my-4"))

    assert_includes result.to_html, "lui:my-4"
  end
end
