require "test_helper"

class LightningUiKit::TextareaComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "bio"))

    assert_includes result.to_html, "bio"
    assert_includes result.to_html, "<textarea"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "description", label: "Description"))

    assert_includes result.to_html, "Description"
  end

  def test_renders_with_value
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "content", value: "Initial text"))

    assert_includes result.to_html, "Initial text"
  end

  def test_renders_with_rows
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "notes", rows: 5))

    assert_includes result.to_html, "rows=\"5\""
  end

  def test_renders_with_error
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "comment", error: "Required"))

    assert_includes result.to_html, "Required"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "message", description: "Max 500 chars"))

    assert_includes result.to_html, "Max 500 chars"
  end

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "user_bio"))

    assert_includes result.to_html, "User bio"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "user_bio", label: "Your Bio"))

    assert_includes result.to_html, "Your Bio"
    refute_includes result.to_html, "User bio"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::TextareaComponent.new(name: "user_bio", label: false))

    refute_includes result.to_html, "User bio"
  end
end
