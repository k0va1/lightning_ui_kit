class ToastComponentPreview < ViewComponent::Preview
  def default
    render LightningUiKit::ToastComponent.new(autodismiss: false).with_content("Hello, world!")
  end

  def autodismiss
    render LightningUiKit::ToastComponent.new(autodismiss: true, dismiss_after: 2000).with_content("Hello, world!")
  end
end
