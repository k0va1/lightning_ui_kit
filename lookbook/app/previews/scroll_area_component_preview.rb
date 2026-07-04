class ScrollAreaComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::ScrollAreaComponent.new(class: "lui:h-48 lui:w-64 lui:rounded-md lui:border lui:border-border lui:p-4") do
      tag.div(class: "lui:flex lui:flex-col lui:gap-2") do
        safe_join(
          (1..25).map do |i|
            tag.div("Item #{i}", class: "lui:text-sm lui:text-foreground")
          end
        )
      end
    end
  end

  def horizontal
    render LightningUiKit::ScrollAreaComponent.new(orientation: :horizontal, class: "lui:w-72 lui:rounded-md lui:border lui:border-border lui:p-4") do
      tag.div(class: "lui:flex lui:gap-4") do
        safe_join(
          (1..15).map do |i|
            tag.div(i.to_s, class: "lui:flex lui:size-24 lui:shrink-0 lui:items-center lui:justify-center lui:rounded-md lui:bg-surface-tertiary lui:text-foreground")
          end
        )
      end
    end
  end
end
