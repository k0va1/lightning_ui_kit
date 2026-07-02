require "test_helper"

class LightningUiKit::AlertDialogComponentTest < ViewComponent::TestCase
  def test_renders_title_and_description
    result = render_inline(LightningUiKit::AlertDialogComponent.new(title: "Sure?", description: "No undo")) do |dialog|
      dialog.with_trigger { "Delete" }
    end

    assert_includes result.to_html, "Sure?"
    assert_includes result.to_html, "No undo"
    assert_includes result.to_html, "Delete"
  end

  def test_wires_stimulus_controller
    result = render_inline(LightningUiKit::AlertDialogComponent.new(title: "t")) do |dialog|
      dialog.with_trigger { "Open" }
    end

    assert_includes result.to_html, 'data-controller="lui-alert-dialog"'
    assert_includes result.to_html, "click->lui-alert-dialog#open"
    assert_includes result.to_html, "click->lui-alert-dialog#confirm"
  end

  def test_uses_alertdialog_role
    result = render_inline(LightningUiKit::AlertDialogComponent.new(title: "t")) do |dialog|
      dialog.with_trigger { "Open" }
    end

    assert_includes result.to_html, 'role="alertdialog"'
  end

  def test_custom_button_labels
    result = render_inline(LightningUiKit::AlertDialogComponent.new(title: "t", confirm_text: "Yes do it", cancel_text: "Nope")) do |dialog|
      dialog.with_trigger { "Open" }
    end

    assert_includes result.to_html, "Yes do it"
    assert_includes result.to_html, "Nope"
  end

  def test_custom_confirm_slot_replaces_default
    result = render_inline(LightningUiKit::AlertDialogComponent.new(title: "t")) do |dialog|
      dialog.with_trigger { "Open" }
      dialog.with_confirm { "<form>custom</form>".html_safe }
    end

    assert_includes result.to_html, "custom"
    refute_includes result.to_html, "click->lui-alert-dialog#confirm"
  end
end
