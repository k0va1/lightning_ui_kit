# frozen_string_literal: true

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
end
