class AlertComponentPreview < Lookbook::Preview
  def default
    render(LightningUiKit::AlertComponent.new) do
      "Hello, world!"
    end
  end

  def with_title
  end

  def dismissible
    render(LightningUiKit::AlertComponent.new(type: :success, dismissible: true)) do
      "Signed in."
    end
  end

  # Fades out after dismiss_after: ms (default 5000). Hovering or focusing the
  # alert holds it open.
  def autodismiss
    render(LightningUiKit::AlertComponent.new(type: :success, dismissible: true, autodismiss: true, dismiss_after: 4000)) do
      "Saved. This alert dismisses itself in four seconds."
    end
  end
end
