# frozen_string_literal: true

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
end
