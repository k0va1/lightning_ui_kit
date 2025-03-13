# frozen_string_literal: true

class LightningUi::AvatarComponent < LightningUi::BaseComponent
  SIZE_CLASSES = {
    sm: "size-6",
    md: "size-8",
    lg: "size-10"
  }

  def initialize(url:, size: :md, initials: nil, square: false, alt: nil, **options)
    @url = url
    @size = size
    @initials = initials
    @square = square
    @alt = alt
    @options = options
  end
end
