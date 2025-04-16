class LightningUiKit::AvatarComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::AvatarComponent.new(url: "https://picsum.photos/100/100")
  end

  # @group Sizes
  #
  def sm
    render LightningUiKit::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :sm)
  end

  def md
    render LightningUiKit::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :md)
  end

  def lg
    render LightningUiKit::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :lg)
  end

  # @endgroup

  def square
    render LightningUiKit::AvatarComponent.new(url: "https://picsum.photos/100/100", square: true)
  end

  def initials
    render LightningUiKit::AvatarComponent.new(initials: "AB")
  end
end
