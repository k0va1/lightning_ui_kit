class AlertComponentPreview < Lookbook::Preview
  def default
    render(LightningUi::AlertComponent.new) do
      "Hello, world!"
    end
  end
end
