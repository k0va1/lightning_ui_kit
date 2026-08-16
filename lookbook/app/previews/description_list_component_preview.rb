class DescriptionListComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::DescriptionListComponent.new do |dl|
      dl.with_item(label: "Balance", value: "$100.00")
      dl.with_item(label: "Status", value: "Active")
      dl.with_item(label: "Type", value: "User")
      dl.with_item(label: "Created at", value: Time.now)
      dl.with_item(label: "Admin", value: true)
    end
  end

  # Long, unbreakable values (IDs, tokens, URLs) wrap instead of pushing the
  # list out of its container.
  def long_values
    render LightningUiKit::DescriptionListComponent.new do |dl|
      dl.with_item(label: "Plan", value: "Indie")
      dl.with_item(label: "Trial ends", value: "August 27, 2026 14:59")
      dl.with_item(label: "Paddle customer", value: "ctm_01m02bkaayj8qwjjtm4jzabcdef0123456789")
      dl.with_item(label: "Webhook endpoint", value: "https://app.example.com/webhooks/paddle/01m02bkaayj8qwjjtm4jzab")
      dl.with_item(
        label: "Notes",
        value: "A much longer free-form value that spans several lines so the label stays aligned with the first line of the value instead of floating in the middle of the row."
      )
    end
  end

  def in_card
  end

  def with_content
  end
end
