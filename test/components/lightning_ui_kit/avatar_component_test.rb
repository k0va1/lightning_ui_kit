require "test_helper"

class LightningUiKit::AvatarComponentTest < ViewComponent::TestCase
  def test_renders_with_url
    result = render_inline(LightningUiKit::AvatarComponent.new(url: "https://example.com/avatar.jpg"))

    assert_includes result.to_html, "https://example.com/avatar.jpg"
  end

  def test_renders_with_initials
    result = render_inline(LightningUiKit::AvatarComponent.new(initials: "JD"))

    assert_includes result.to_html, "JD"
  end

  def test_raises_error_without_url_or_initials
    assert_raises(ArgumentError) do
      render_inline(LightningUiKit::AvatarComponent.new)
    end
  end

  def test_renders_with_different_sizes
    result = render_inline(LightningUiKit::AvatarComponent.new(initials: "AB", size: :lg))

    assert_includes result.to_html, "lui:size-10"
  end

  def test_renders_with_alt_text
    result = render_inline(LightningUiKit::AvatarComponent.new(url: "https://example.com/avatar.jpg", alt: "User avatar"))

    assert_includes result.to_html, "User avatar"
  end
end
