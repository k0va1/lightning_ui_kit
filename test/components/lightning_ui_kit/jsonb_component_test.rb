# frozen_string_literal: true

require "test_helper"

class LightningUiKit::JsonbComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "metadata"))

    assert_includes result.to_html, "metadata"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "settings", label: "Settings"))

    assert_includes result.to_html, "Settings"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "config", description: "Configure your settings"))

    assert_includes result.to_html, "Configure your settings"
  end

  def test_renders_with_error
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data", error: "Invalid JSON"))

    assert_includes result.to_html, "Invalid JSON"
  end

  def test_renders_object_mode_by_default
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data"))

    assert_includes result.to_html, "lui-jsonb-mode-value=\"object\""
  end

  def test_renders_array_mode_when_value_is_array
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "tags", value: ["a", "b"]))

    assert_includes result.to_html, "lui-jsonb-mode-value=\"array\""
  end

  def test_hidden_field_contains_serialized_object_value
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data", value: {foo: "bar"}))

    assert_includes result.to_html, '{"foo":"bar"}'
  end

  def test_hidden_field_contains_serialized_array_value
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "tags", value: ["x", "y"]))

    assert_includes result.to_html, '["x","y"]'
  end

  def test_renders_add_field_button_in_object_mode
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data"))

    assert_includes result.to_html, "Add Field"
  end

  def test_renders_add_item_button_in_array_mode
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "tags", value: []))

    assert_includes result.to_html, "Add Item"
  end

  def test_disabled_hides_add_button
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data", disabled: true))

    assert_not_includes result.to_html, "Add Field"
  end

  def test_disabled_passes_value_to_controller
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data", disabled: true))

    assert_includes result.to_html, "lui-jsonb-disabled-value=\"true\""
  end

  def test_disabled_sets_data_attribute_on_label
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data", label: "Data", disabled: true))

    assert_includes result.to_html, 'data-disabled="true"'
  end

  def test_not_disabled_by_default
    result = render_inline(LightningUiKit::JsonbComponent.new(name: "data"))

    assert_includes result.to_html, "lui-jsonb-disabled-value=\"false\""
  end

  def test_custom_placeholders
    result = render_inline(LightningUiKit::JsonbComponent.new(
      name: "data",
      key_placeholder: "Attribute",
      value_placeholder: "Content"
    ))

    assert_includes result.to_html, "lui-jsonb-key-placeholder-value=\"Attribute\""
    assert_includes result.to_html, "lui-jsonb-value-placeholder-value=\"Content\""
  end
end
