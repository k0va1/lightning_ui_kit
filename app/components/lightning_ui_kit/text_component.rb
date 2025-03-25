# frozen_string_literal: true

class LightningUiKit::TextComponent < LightningUiKit::BaseComponent
  def initialize(size: :md, **options)
    @size = size
    @options = options
  end

  def classes
    merge_classes(["text-zinc-600 text-#{@size}", @options[:class]].compact.join(" "))
  end
end
