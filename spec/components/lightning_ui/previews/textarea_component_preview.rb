class TextareaComponentPreview < ViewComponent::Preview
  def default
    render LightningUi::TextareaComponent.new(
      name: "bio",
      value: "I am a Ruby on Rails developer 💎",
      description: "Tell us about yourself",
      label: "Biography",
      rows: 5
    )
  end
end
