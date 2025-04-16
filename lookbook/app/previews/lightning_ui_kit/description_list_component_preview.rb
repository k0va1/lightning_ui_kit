class LightningUiKit::DescriptionListComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::DescriptionListComponent.new do |dl|
      dl.with_item(label: "Balance", value: "$100.00")
      dl.with_item(label: "Status", value: "Active")
      dl.with_item(label: "Type", value: "User")
      dl.with_item(label: "Created at", value: Time.now)
      dl.with_item(label: "Admin", value: true)
    end
  end
end
