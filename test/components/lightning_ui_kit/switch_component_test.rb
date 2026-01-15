# frozen_string_literal: true

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
end
