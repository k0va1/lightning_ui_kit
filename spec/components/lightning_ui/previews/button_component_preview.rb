class ButtonComponentPreview < Lookbook::Preview
  def default
    render(LightningUi::ButtonComponent.new) do
      "Press me"
    end
  end
end
