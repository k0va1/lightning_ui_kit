require "test_helper"

class LightningUiKit::RadioGroupComponentTest < ViewComponent::TestCase
  def test_renders_radio_group
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan, label: "Plan")) do |group|
      group.with_option(value: "free", label: "Free")
      group.with_option(value: "pro", label: "Pro")
    end

    assert_includes result.to_html, "lui-radio-group"
    assert_includes result.to_html, "Plan"
    assert_includes result.to_html, 'role="radiogroup"'
  end

  def test_renders_options
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan)) do |group|
      group.with_option(value: "free", label: "Free")
      group.with_option(value: "pro", label: "Pro")
    end

    assert_includes result.to_html, "Free"
    assert_includes result.to_html, "Pro"
    assert_includes result.to_html, 'role="radio"'
  end

  def test_renders_selected_option
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan, selected: "pro")) do |group|
      group.with_option(value: "free", label: "Free")
      group.with_option(value: "pro", label: "Pro")
    end

    assert_includes result.to_html, 'data-checked'
    assert_includes result.to_html, 'aria-checked="true"'
  end

  def test_renders_option_description
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan)) do |group|
      group.with_option(value: "pro", label: "Pro", description: "Best value")
    end

    assert_includes result.to_html, "Best value"
  end

  def test_renders_hidden_field
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan, selected: "pro")) do |group|
      group.with_option(value: "pro", label: "Pro")
    end

    assert_includes result.to_html, 'type="hidden"'
    assert_includes result.to_html, 'value="pro"'
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::RadioGroupComponent.new(name: :plan, label: "Plan", description: "Choose your plan")) do |group|
      group.with_option(value: "free", label: "Free")
    end

    assert_includes result.to_html, "Choose your plan"
  end
end
