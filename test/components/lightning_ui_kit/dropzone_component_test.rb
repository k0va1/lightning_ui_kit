# frozen_string_literal: true

require "test_helper"

class LightningUiKit::DropzoneComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::DropzoneComponent.new(name: "files"))

    assert_includes result.to_html, "files"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::DropzoneComponent.new(name: "upload", label: "Upload files"))

    assert_includes result.to_html, "Upload files"
  end

  def test_renders_dropzone_controller
    result = render_inline(LightningUiKit::DropzoneComponent.new(name: "docs"))

    assert_includes result.to_html, "lui-dropzone"
  end

  def test_renders_with_multiple
    result = render_inline(LightningUiKit::DropzoneComponent.new(name: "images", multiple: true))

    assert_includes result.to_html, "multiple"
  end
end
