require "test_helper"

class LightningUiKit::ModalComponentTest < ViewComponent::TestCase
  def test_renders_with_id_and_title
    result = render_inline(LightningUiKit::ModalComponent.new(id: "my-modal", title: "Confirm"))

    assert_includes result.to_html, "my-modal"
    assert_includes result.to_html, "Confirm"
  end

  def test_renders_with_description
    result = render_inline(LightningUiKit::ModalComponent.new(id: "modal", title: "Delete", description: "Are you sure?"))

    assert_includes result.to_html, "Are you sure?"
  end

  def test_renders_modal_controller
    result = render_inline(LightningUiKit::ModalComponent.new(id: "dialog", title: "Title"))

    assert_includes result.to_html, "lui-modal"
  end

  def test_renders_dialog_element
    result = render_inline(LightningUiKit::ModalComponent.new(id: "test", title: "Test"))

    assert_includes result.to_html, "<dialog"
  end

  def test_default_variant_is_dismissable_without_alert_role
    result = render_inline(LightningUiKit::ModalComponent.new(id: "m", title: "t"))

    assert_includes result.to_html, 'data-lui-modal-dismissable-value="true"'
    refute_includes result.to_html, 'role="alertdialog"'
  end

  def test_renders_trigger
    result = render_inline(LightningUiKit::ModalComponent.new(title: "t")) do |modal|
      modal.with_trigger { "Open it" }
    end

    assert_includes result.to_html, "Open it"
    assert_includes result.to_html, "click->lui-modal#open"
  end

  def test_alert_variant_uses_alertdialog_role_and_blocks_dismiss
    result = render_inline(LightningUiKit::ModalComponent.new(variant: :alert, title: "Sure?", description: "No undo")) do |modal|
      modal.with_trigger { "Delete" }
    end

    assert_includes result.to_html, 'role="alertdialog"'
    assert_includes result.to_html, 'data-lui-modal-dismissable-value="false"'
    assert_includes result.to_html, "Sure?"
    assert_includes result.to_html, "No undo"
    assert_includes result.to_html, "Delete"
  end

  def test_alert_variant_renders_default_buttons
    result = render_inline(LightningUiKit::ModalComponent.new(variant: :alert, title: "t", confirm_text: "Yes do it", cancel_text: "Nope"))

    assert_includes result.to_html, "Yes do it"
    assert_includes result.to_html, "Nope"
    assert_includes result.to_html, "click->lui-modal#confirm"
    assert_includes result.to_html, "click->lui-modal#close"
  end

  def test_alert_custom_confirm_slot_replaces_default
    result = render_inline(LightningUiKit::ModalComponent.new(variant: :alert, title: "t")) do |modal|
      modal.with_confirm { "<form>custom</form>".html_safe }
    end

    assert_includes result.to_html, "custom"
    refute_includes result.to_html, "click->lui-modal#confirm"
  end

  def test_unknown_variant_falls_back_to_default
    result = render_inline(LightningUiKit::ModalComponent.new(variant: :bogus, title: "t"))

    refute_includes result.to_html, 'role="alertdialog"'
  end
end
