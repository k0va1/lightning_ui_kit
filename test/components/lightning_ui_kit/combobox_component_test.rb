require "test_helper"

class LightningUiKit::ComboboxComponentTest < ViewComponent::TestCase
  def test_renders_with_name
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, "country"
  end

  def test_renders_with_label
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", label: "Select Country"))

    assert_includes result.to_html, "Select Country"
  end

  def test_renders_with_placeholder
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", placeholder: "Search countries..."))

    assert_includes result.to_html, "Search countries..."
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", description: "Choose your country"))

    assert_includes result.to_html, "Choose your country"
  end

  def test_renders_with_error
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", error: "Country is required"))

    assert_includes result.to_html, "Country is required"
  end

  def test_renders_combobox_controller
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, "lui-combobox"
  end

  def test_renders_with_options
    options = [
      {value: "us", label: "United States"},
      {value: "ca", label: "Canada"}
    ]
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", options: options))

    assert_includes result.to_html, "United States"
    assert_includes result.to_html, "Canada"
  end

  def test_renders_combobox_role
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, 'role="combobox"'
  end

  def test_renders_listbox_role
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, 'role="listbox"'
  end

  def test_renders_with_selected_value_single
    options = [
      {value: "us", label: "United States"},
      {value: "ca", label: "Canada"}
    ]
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", options: options, selected: "us"))

    assert result.css("[data-lui-combobox-selected-value]").first["data-lui-combobox-selected-value"] == '["us"]'
  end

  def test_renders_with_selected_values_multiple
    options = [
      {value: "ruby", label: "Ruby"},
      {value: "python", label: "Python"}
    ]
    result = render_inline(LightningUiKit::ComboboxComponent.new(
      name: "languages",
      options: options,
      multiple: true,
      selected: ["ruby", "python"]
    ))

    assert result.css("[data-lui-combobox-selected-value]").first["data-lui-combobox-selected-value"] == '["ruby","python"]'
  end

  def test_renders_multiple_mode
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "tags", multiple: true))

    assert_includes result.to_html, "lui-combobox-multiple-value"
    assert_includes result.to_html, "true"
  end

  class ReflectiveTagReflection
    def foreign_key
      "label_id"
    end
  end

  class ReflectivePostTag
    def self.reflect_on_association(name)
      ReflectiveTagReflection.new if name == :tag
    end
  end

  class ReflectiveJoinReflection
    def klass
      ReflectivePostTag
    end
  end

  class ReflectivePost
    def self.reflect_on_association(name)
      ReflectiveJoinReflection.new if name == :post_tags
    end

    def errors
      ActiveModel::Errors.new(self)
    end
  end

  FakeForm = Struct.new(:object, :object_name)

  def test_derives_foreign_key_from_nested_model_convention
    result = render_inline(LightningUiKit::ComboboxComponent.new(
      name: :post_tags_attributes,
      nested_model: :tag,
      options: [{value: 1, label: "Ruby"}]
    ))

    root = result.css("[data-lui-combobox-foreign-key-value]").first
    assert_equal "tag_id", root["data-lui-combobox-foreign-key-value"]
    assert_equal "true", root["data-lui-combobox-multiple-value"]
  end

  def test_derives_foreign_key_from_association_reflection
    form = FakeForm.new(ReflectivePost.new, "post")
    result = render_inline(LightningUiKit::ComboboxComponent.new(
      form: form,
      association: :post_tags,
      nested_model: :tag,
      label: "Tags",
      options: [{value: 1, label: "Ruby"}]
    ))

    root = result.css("[data-lui-combobox-foreign-key-value]").first
    assert_equal "label_id", root["data-lui-combobox-foreign-key-value"]
    assert_includes result.to_html, 'data-name="post[post_tags_attributes]"'
  end

  def test_foreign_key_without_association_enters_nested_mode
    result = render_inline(LightningUiKit::ComboboxComponent.new(
      name: :post_tags_attributes,
      foreign_key: :tag_id,
      nested_model: :tag,
      options: [{value: 1, label: "Ruby"}, {value: 3, label: "JavaScript"}],
      selected: [{join_id: 1, value: 1}, {join_id: 2, value: 3}]
    ))

    root = result.css("[data-lui-combobox-multiple-value]").first
    assert_equal "true", root["data-lui-combobox-multiple-value"]
    assert_equal "tag_id", root["data-lui-combobox-foreign-key-value"]
    assert_equal "tag", root["data-lui-combobox-nested-model-value"]
    assert_equal '[{"join_id":1,"value":1},{"join_id":2,"value":3}]', root["data-lui-combobox-selected-value"]
    assert_includes result.to_html, 'data-name="post_tags_attributes"'
  end

  def test_renders_single_mode_hidden_field
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, 'type="hidden"'
    assert_includes result.to_html, 'name="country"'
  end

  def test_renders_multiple_mode_hidden_fields_container
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "tags", multiple: true))

    assert_includes result.to_html, 'data-name="tags[]"'
  end

  def test_renders_allow_custom_option
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "category", allow_custom: true))

    assert_includes result.to_html, "lui-combobox-allow-custom-value"
    assert_includes result.to_html, 'Create "'
  end

  def test_does_not_render_create_option_when_allow_custom_false
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "category", allow_custom: false))

    refute_includes result.to_html, 'Create "'
  end

  def test_renders_with_url_for_async
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "user", url: "/api/users/search"))

    assert_includes result.to_html, "/api/users/search"
  end

  def test_renders_with_min_chars
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "user", url: "/api/users", min_chars: 3))

    assert_includes result.to_html, "lui-combobox-min-chars-value"
    assert_includes result.to_html, "3"
  end

  def test_renders_with_debounce
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "user", url: "/api/users", debounce: 500))

    assert_includes result.to_html, "lui-combobox-debounce-value"
    assert_includes result.to_html, "500"
  end

  def test_renders_disabled_state
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country", disabled: true))

    assert_includes result.to_html, "disabled"
  end

  def test_renders_aria_attributes
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, 'aria-autocomplete="list"'
    assert_includes result.to_html, 'aria-expanded="false"'
    assert_includes result.to_html, 'aria-haspopup="listbox"'
  end

  def test_renders_loading_indicator
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "user", url: "/api/users"))

    assert_includes result.to_html, "Loading..."
  end

  def test_renders_no_results_message
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, "No results found"
  end

  def test_renders_option_template
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    assert_includes result.to_html, 'role="option"'
    assert_includes result.to_html, "data-label"
    assert_includes result.to_html, "data-checkmark"
  end

  def test_multiple_mode_uses_different_input_wrapper
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "tags", multiple: true))

    assert_includes result.to_html, "inputWrapper"
  end

  def test_single_mode_uses_standard_input_styling
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "country"))

    # Single mode should have the before/after pseudo-element styling wrapper
    assert_includes result.to_html, "lui:before:absolute"
  end

  def test_renders_default_label_from_name
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "favorite_color"))

    assert_includes result.to_html, "Favorite color"
  end

  def test_renders_custom_label_over_default
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "favorite_color", label: "Pick a Color"))

    assert_includes result.to_html, "Pick a Color"
    refute_includes result.to_html, "Favorite color"
  end

  def test_does_not_render_label_when_false
    result = render_inline(LightningUiKit::ComboboxComponent.new(name: "favorite_color", label: false))

    refute_includes result.to_html, "Favorite color"
  end
end
