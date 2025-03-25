class LinkComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::LinkComponent.new(title: "Link", url: "https://www.google.com")
  end
end
