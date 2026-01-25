require "test_helper"

class LightningUiKit::InputComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::InputComponent.new(name: "email"))

    assert_includes result.to_html, "email"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::InputComponent.new(name: "username", label: "Username"))

    assert_includes result.to_html, "Username"
  end

  def test_renders_with_placeholder
    result = render_inline(LightningUiKit::InputComponent.new(name: "search", placeholder: "Search..."))

    assert_includes result.to_html, "Search..."
  end

  def test_renders_with_value
    result = render_inline(LightningUiKit::InputComponent.new(name: "name", value: "John"))

    assert_includes result.to_html, "John"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::InputComponent.new(name: "password", description: "Must be 8 characters"))

    assert_includes result.to_html, "Must be 8 characters"
  end

  def test_renders_with_error
    result = render_inline(LightningUiKit::InputComponent.new(name: "email", error: "Invalid email"))

    assert_includes result.to_html, "Invalid email"
  end

  def test_renders_different_types
    result = render_inline(LightningUiKit::InputComponent.new(name: "pass", type: :password))

    assert_includes result.to_html, "password"
  end

  def test_renders_datetime_type
    result = render_inline(LightningUiKit::InputComponent.new(name: "scheduled_at", type: :datetime))

    assert_includes result.to_html, "datetime-local"
  end

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::InputComponent.new(name: "first_name"))

    assert_includes result.to_html, "First name"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::InputComponent.new(name: "first_name", label: "Your Name"))

    assert_includes result.to_html, "Your Name"
    refute_includes result.to_html, "First name"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::InputComponent.new(name: "first_name", label: false))

    refute_includes result.to_html, "First name"
    refute_includes result.to_html, "<label"
  end
end
