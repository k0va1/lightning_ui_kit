require "test_helper"

class LightningUiKit::SwitchComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "notifications"))

    assert_includes result.to_html, "notifications"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "dark_mode", label: "Dark mode"))

    assert_includes result.to_html, "Dark mode"
  end

  def test_renders_enabled_state
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "active", enabled: true))

    assert_includes result.to_html, "checked"
  end

  def test_renders_disabled_state
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "feature", disabled: true))

    assert_includes result.to_html, "disabled"
  end

  def test_renders_switch_controller
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "toggle"))

    assert_includes result.to_html, "lui-switch"
  end

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "email_notifications"))

    assert_includes result.to_html, "Email notifications"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "email_notifications", label: "Notify me"))

    assert_includes result.to_html, "Notify me"
    refute_includes result.to_html, "Email notifications"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::SwitchComponent.new(name: "email_notifications", label: false))

    refute_includes result.to_html, "Email notifications"
  end
end
