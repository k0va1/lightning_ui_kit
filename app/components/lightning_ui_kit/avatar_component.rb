# frozen_string_literal: true

class LightningUiKit::AvatarComponent < LightningUiKit::BaseComponent
  SIZE_CLASSES = {
    sm: "lui:size-6",
    md: "lui:size-8",
    lg: "lui:size-10"
  }

  def initialize(url: nil, size: :md, initials: nil, square: false, alt: nil, **options)
    raise ArgumentError, "url or initials must be provided" if url.nil? && initials.nil?

    @url = url
    @size = size
    @initials = initials
    @square = square
    @alt = alt
    @options = options
  end
end
