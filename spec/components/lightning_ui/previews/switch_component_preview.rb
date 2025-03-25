class SwitchComponentPreview < Lookbook::Preview
  def default
    render LightningUi::SwitchComponent.new(
      name: "enable_notifications",
      value: "true",
      enabled: false,
      label: "Enable notifications",
      description: "Enable notifications for this user"
    )
  end
end
