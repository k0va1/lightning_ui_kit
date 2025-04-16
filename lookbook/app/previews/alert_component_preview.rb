class AlertComponentPreview < Lookbook::Preview
  def default
    render(LightningUiKit::AlertComponent.new) do
      "Hello, world!"
    end
  end
end
