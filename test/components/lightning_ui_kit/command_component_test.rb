require "test_helper"

class LightningUiKit::CommandComponentTest < ViewComponent::TestCase
  def test_renders_input_and_items
    result = render_inline(LightningUiKit::CommandComponent.new) do |command|
      command.with_item(value: "a") { "Calendar" }
      command.with_item(value: "b") { "Settings" }
    end

    assert_includes result.to_html, 'data-controller="lui-command"'
    assert_includes result.to_html, "Calendar"
    assert_includes result.to_html, "Settings"
    assert_includes result.to_html, 'data-value="a"'
  end

  def test_custom_placeholder_and_empty_text
    result = render_inline(LightningUiKit::CommandComponent.new(placeholder: "Find...", empty_text: "Nothing here")) do |command|
      command.with_item(value: "a") { "One" }
    end

    assert_includes result.to_html, 'placeholder="Find..."'
    assert_includes result.to_html, "Nothing here"
  end

  def test_filter_action_wired
    result = render_inline(LightningUiKit::CommandComponent.new) do |command|
      command.with_item(value: "a") { "One" }
    end

    assert_includes result.to_html, "input->lui-command#filter"
  end
end
