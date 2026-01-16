# frozen_string_literal: true

require "test_helper"

class LightningUiKit::SelectComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::SelectComponent.new(name: "country"))

    assert_includes result.to_html, "country"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::SelectComponent.new(name: "role", label: "Select role"))

    assert_includes result.to_html, "Select role"
  end

  def test_renders_with_options
    options = [["USA", "us"], ["Canada", "ca"]]
    result = render_inline(LightningUiKit::SelectComponent.new(name: "country", options_for_select: options))

    assert_includes result.to_html, "USA"
    assert_includes result.to_html, "Canada"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::SelectComponent.new(name: "plan", description: "Choose your plan"))

    assert_includes result.to_html, "Choose your plan"
  end

  def test_renders_select_controller
    result = render_inline(LightningUiKit::SelectComponent.new(name: "type"))

    assert_includes result.to_html, "select"
  end
end
