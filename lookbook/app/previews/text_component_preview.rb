class TextComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::TextComponent.new.with_content("Hello, world!")
  end

  # @group Sizes
  def extra_small
    render LightningUiKit::TextComponent.new(size: :xs).with_content("Hello, world!")
  end

  def small
    render LightningUiKit::TextComponent.new(size: :sm).with_content("Hello, world!")
  end

  def default_size
    render LightningUiKit::TextComponent.new.with_content("Hello, world!")
  end

  def xl
    render LightningUiKit::TextComponent.new(size: :xl).with_content("Hello, world!")
  end
  # @endgroup
end
