require "test_helper"

class LightningUiKit::BadgeComponentTest < ViewComponent::TestCase
  def test_renders_with_content
    result = render_inline(LightningUiKit::BadgeComponent.new) { "Active" }

    assert_includes result.to_html, "Active"
  end

  def test_renders_with_default_status
    result = render_inline(LightningUiKit::BadgeComponent.new) { "Status" }

    assert_includes result.to_html, "lui:bg-foreground-faint/20"
  end

  def test_renders_with_success_status
    result = render_inline(LightningUiKit::BadgeComponent.new(status: :success)) { "Success" }

    assert_includes result.to_html, "lui:bg-success-bg"
  end

  def test_renders_with_warning_status
    result = render_inline(LightningUiKit::BadgeComponent.new(status: :warning)) { "Warning" }

    assert_includes result.to_html, "lui:bg-warning-bg"
  end

  def test_renders_with_error_status
    result = render_inline(LightningUiKit::BadgeComponent.new(status: :error)) { "Error" }

    assert_includes result.to_html, "lui:bg-destructive/15"
  end
end
