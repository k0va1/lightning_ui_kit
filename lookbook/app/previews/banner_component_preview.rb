class BannerComponentPreview < Lookbook::Preview
  def default
  end

  def error
    render(LightningUiKit::BannerComponent.new(type: :error, title: "Default")) { "Error" }
  end
end
