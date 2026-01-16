# frozen_string_literal: true

require "test_helper"

class LightningUiKit::FileInputComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "document"))

    assert_includes result.to_html, "document"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "file", label: "Choose file"))

    assert_includes result.to_html, "Choose file"
  end

  def test_renders_with_multiple
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "files", multiple: true))

    assert_includes result.to_html, "multiple"
  end

  def test_renders_with_accept
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "image", accept: "image/*"))

    assert_includes result.to_html, "image/*"
  end
end
