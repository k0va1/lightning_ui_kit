class CheckboxComponentPreview < Lookbook::Preview
  def default
    render LightningUi::CheckboxComponent.new(name: :enabled, value: true) do
    end
  end

  def with_description
    render LightningUi::CheckboxComponent.new(
      name: :enabled,
      label: "Send messages",
      value: true,
      description: "Check this box to enable the feature"
    )
  end
end
