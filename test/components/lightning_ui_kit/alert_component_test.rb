require "test_helper"

class LightningUiKit::AlertComponentTest < ViewComponent::TestCase
  def test_renders_alert_with_content
    result = render_inline(LightningUiKit::AlertComponent.new) { "This is an alert message" }

    assert_includes result.to_html, "This is an alert message"
  end

  def test_renders_with_default_classes
    result = render_inline(LightningUiKit::AlertComponent.new) { "Alert" }

    assert_includes result.to_html, "lui:rounded-lg"
    assert_includes result.to_html, "lui:border-border"
    assert_includes result.to_html, "role=\"alert\""
  end

  def test_renders_inline_layout_without_title
    result = render_inline(LightningUiKit::AlertComponent.new) { "Alert" }

    assert_includes result.to_html, "lui:flex"
    assert_includes result.to_html, "lui:items-center"
  end

  def test_renders_with_custom_classes
    result = render_inline(LightningUiKit::AlertComponent.new(class: "lui:mt-4")) { "Alert" }

    assert_includes result.to_html, "lui:mt-4"
  end

  def test_renders_error_type
    result = render_inline(LightningUiKit::AlertComponent.new(type: :error)) { "Error" }

    assert_includes result.to_html, "lui:border-destructive-border/50"
    assert_includes result.to_html, "lui:text-destructive-text"
  end

  def test_renders_success_type
    result = render_inline(LightningUiKit::AlertComponent.new(type: :success)) { "Success" }

    assert_includes result.to_html, "lui:border-success-indicator/50"
    assert_includes result.to_html, "lui:text-success-text"
  end

  def test_renders_warning_type
    result = render_inline(LightningUiKit::AlertComponent.new(type: :warning)) { "Warning" }

    assert_includes result.to_html, "lui:border-warning-indicator/50"
    assert_includes result.to_html, "lui:text-warning-text"
  end

  def test_renders_with_title
    result = render_inline(LightningUiKit::AlertComponent.new(title: "Important Notice")) { "Alert content" }

    assert_includes result.to_html, "Important Notice"
    assert_includes result.to_html, "Alert content"
  end

  def test_renders_banner_layout_with_title
    result = render_inline(LightningUiKit::AlertComponent.new(title: "Notice")) { "Content" }

    assert_includes result.to_html, "lui:relative"
    assert_includes result.to_html, "lui:pl-11"
    assert_includes result.to_html, "lui-alert"
  end

  def test_renders_title_with_type_color
    result = render_inline(LightningUiKit::AlertComponent.new(title: "Error", type: :error)) { "Error content" }

    assert_includes result.to_html, "lui:text-destructive-text"
    assert_includes result.to_html, "lui:border-destructive-border/50"
  end

  def test_renders_footer
    result = render_inline(LightningUiKit::AlertComponent.new(title: "Notice")) do |alert|
      alert.with_footer { "Footer content" }
      "Body content"
    end

    assert_includes result.to_html, "Footer content"
  end

  def test_renders_sr_only_label
    result = render_inline(LightningUiKit::AlertComponent.new(type: :error)) { "Error" }

    assert_includes result.to_html, "lui:sr-only"
  end

  def test_not_dismissible_by_default
    result = render_inline(LightningUiKit::AlertComponent.new) { "Alert" }

    assert_equal 0, result.css("button").size
    assert_equal 0, result.css('[data-controller="lui-alert"]').size
  end

  def test_dismissible_renders_a_close_button
    result = render_inline(LightningUiKit::AlertComponent.new(dismissible: true)) { "Alert" }
    button = result.css('button[data-action="lui-alert#close"]').first

    assert button
    assert_equal "Dismiss", button["aria-label"]
    assert_includes button["class"], "lui:ms-auto"
    assert_includes button["class"], "lui:cursor-pointer"
    assert_equal 1, result.css('[data-controller="lui-alert"]').size
  end

  def test_dismissible_banner_pins_the_close_button_to_the_corner
    result = render_inline(LightningUiKit::AlertComponent.new(title: "Notice", dismissible: true)) { "Content" }
    button = result.css('button[data-action="lui-alert#close"]').first

    assert_includes button["class"], "lui:absolute"
    assert_includes result.to_html, "lui:pr-10"
  end

  def test_autodismiss_wires_the_timer_and_hover_pause
    result = render_inline(LightningUiKit::AlertComponent.new(autodismiss: true, dismiss_after: 3000)) { "Alert" }
    root = result.css('[data-controller="lui-alert"]').first

    assert_equal "true", root["data-lui-alert-autodismiss-value"]
    assert_equal "3000", root["data-lui-alert-dismiss-after-value"]
    assert_includes root["data-action"], "mouseenter->lui-alert#pause"
    assert_includes root["data-action"], "focusout->lui-alert#resume"
  end

  def test_autodismiss_defaults_to_five_seconds
    result = render_inline(LightningUiKit::AlertComponent.new(autodismiss: true)) { "Alert" }

    assert_equal "5000", result.css('[data-controller="lui-alert"]').first["data-lui-alert-dismiss-after-value"]
  end
end
