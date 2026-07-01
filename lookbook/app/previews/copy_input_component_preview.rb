class CopyInputComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CopyInputComponent.new(
      value: "sk_live_abc123xyz789"
    )
  end

  def with_label
    render LightningUiKit::CopyInputComponent.new(
      value: "sk_live_abc123xyz789",
      label: "API Key"
    )
  end

  def with_label_and_description
    render LightningUiKit::CopyInputComponent.new(
      value: "https://api.example.com/webhooks/abc123",
      label: "Webhook URL",
      description: "Use this URL to receive webhook events"
    )
  end

  def secret
    render LightningUiKit::CopyInputComponent.new(
      value: "sk_live_abc123xyz789",
      label: "API Key",
      description: "Keep this key secret",
      secret: true
    )
  end
end
