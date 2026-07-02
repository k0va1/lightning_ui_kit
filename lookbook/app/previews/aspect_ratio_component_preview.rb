class AspectRatioComponentPreview < Lookbook::Preview
  # @param ratio text
  def default(ratio: "16 / 9")
    render LightningUiKit::AspectRatioComponent.new(ratio: ratio, class: "lui:max-w-md lui:rounded-lg lui:bg-surface-tertiary") do
      tag.div(ratio, class: "lui:flex lui:size-full lui:items-center lui:justify-center lui:text-sm lui:text-foreground-muted")
    end
  end

  def square
    render LightningUiKit::AspectRatioComponent.new(ratio: "1 / 1", class: "lui:max-w-xs lui:rounded-lg lui:bg-surface-tertiary") do
      tag.div("1 / 1", class: "lui:flex lui:size-full lui:items-center lui:justify-center lui:text-sm lui:text-foreground-muted")
    end
  end
end
