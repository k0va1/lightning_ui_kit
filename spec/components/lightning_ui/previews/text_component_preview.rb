class TextComponentPreview < ViewComponent::Preview
  def default
    render LightningUi::TextComponent.new.with_content("Hello, world!")
  end

  # @group Sizes
  def extra_small
    render LightningUi::TextComponent.new(size: :xs).with_content("Hello, world!")
  end

  def small
    render LightningUi::TextComponent.new(size: :sm).with_content("Hello, world!")
  end

  def default_size
    render LightningUi::TextComponent.new.with_content("Hello, world!")
  end

  def xl
    render LightningUi::TextComponent.new(size: :xl).with_content("Hello, world!")
  end
  # @groupend
end
