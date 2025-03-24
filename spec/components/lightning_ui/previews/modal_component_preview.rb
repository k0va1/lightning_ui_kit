class ModalComponentPreview < Lookbook::Preview
  def default
    render LightningUi::ModalComponent.new(
      id: "payment",
      title: "Payment"
    ) do |modal|
      modal.with_body do
        render LightningUi::InputComponent.new(
          name: :card_number,
          label: "Card number",
          description: "Enter your card number"
        )
      end
      modal.with_action do
        render LightningUi::ButtonComponent.new(style: :outline, data: { action: "click->modal#close" }).with_content("Cancel")
      end
      modal.with_action do
        render LightningUi::ButtonComponent.new(type: :submit, data: { action: "click->modal#submitForm" }).with_content("Pay")
      end
    end
  end
end
