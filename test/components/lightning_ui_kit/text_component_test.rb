# frozen_string_literal: true

require "test_helper"

class LightningUiKit::TextComponentTest < ViewComponent::TestCase
  def test_renders_with_content
    result = render_inline(LightningUiKit::TextComponent.new) { "Hello world" }

    assert_includes result.to_html, "Hello world"
  end

  def test_renders_with_default_size
    result = render_inline(LightningUiKit::TextComponent.new) { "Text" }

    assert_includes result.to_html, "lui:text-md"
  end

  def test_renders_with_custom_size
    result = render_inline(LightningUiKit::TextComponent.new(size: :lg)) { "Large text" }

    assert_includes result.to_html, "lui:text-lg"
  end

  def test_renders_text_color
    result = render_inline(LightningUiKit::TextComponent.new) { "Styled" }

    assert_includes result.to_html, "lui:text-zinc-600"
  end
end
