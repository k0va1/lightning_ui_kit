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

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "profile_picture"))

    assert_includes result.to_html, "Profile picture"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "profile_picture", label: "Upload Photo"))

    assert_includes result.to_html, "Upload Photo"
    refute_includes result.to_html, "Profile picture"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::FileInputComponent.new(name: "profile_picture", label: false))

    refute_includes result.to_html, "Profile picture"
  end
end
