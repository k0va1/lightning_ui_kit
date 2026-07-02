require "test_helper"

class LightningUiKit::ProgressComponentTest < ViewComponent::TestCase
  def test_renders_progressbar_role
    result = render_inline(LightningUiKit::ProgressComponent.new(value: 40))

    assert_includes result.to_html, 'role="progressbar"'
    assert_includes result.to_html, 'aria-valuenow="40"'
  end

  def test_indicator_width_matches_percentage
    result = render_inline(LightningUiKit::ProgressComponent.new(value: 25, max: 100))

    assert_includes result.to_html, "width: 25%;"
  end

  def test_clamps_value_above_max
    result = render_inline(LightningUiKit::ProgressComponent.new(value: 150, max: 100))

    assert_includes result.to_html, "width: 100%;"
  end

  def test_handles_custom_max
    result = render_inline(LightningUiKit::ProgressComponent.new(value: 1, max: 4))

    assert_includes result.to_html, "width: 25%;"
    assert_includes result.to_html, 'aria-valuemax="4"'
  end
end
