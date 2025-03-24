class LinkComponentPreview < Lookbook::Preview
  def default
    render LightningUi::LinkComponent.new(title: "Link", url: "https://www.google.com")
  end
end
