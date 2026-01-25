require "test_helper"

class LightningUiKit::CheckboxComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "terms"))

    assert_includes result.to_html, "terms"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "agree", label: "I agree"))

    assert_includes result.to_html, "I agree"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "newsletter", description: "Subscribe to updates"))

    assert_includes result.to_html, "Subscribe to updates"
  end

  def test_renders_checked_state
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "active", checked: true))

    assert_includes result.to_html, "checked"
  end

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "accept_terms"))

    assert_includes result.to_html, "Accept terms"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "accept_terms", label: "I Accept"))

    assert_includes result.to_html, "I Accept"
    refute_includes result.to_html, "Accept terms"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::CheckboxComponent.new(name: "accept_terms", label: false))

    refute_includes result.to_html, "Accept terms"
  end
end
