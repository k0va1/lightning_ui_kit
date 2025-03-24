class AvatarComponentPreview < Lookbook::Preview
  def default
    render LightningUi::AvatarComponent.new(url: "https://picsum.photos/100/100")
  end

  # @group Sizes
  #
  def sm
    render LightningUi::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :sm)
  end

  def md
    render LightningUi::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :md)
  end

  def lg
    render LightningUi::AvatarComponent.new(url: "https://picsum.photos/100/100", size: :lg)
  end

  # @endgroup

  def square
    render LightningUi::AvatarComponent.new(url: "https://picsum.photos/100/100", square: true)
  end

  def initials
    render LightningUi::AvatarComponent.new(initials: "AB")
  end
end
