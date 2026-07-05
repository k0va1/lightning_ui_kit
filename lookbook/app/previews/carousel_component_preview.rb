class CarouselComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CarouselComponent.new(class: "lui:max-w-md") do |carousel|
      (1..5).each do |i|
        carousel.with_slide do
          tag.div(class: "lui:flex lui:aspect-video lui:items-center lui:justify-center lui:bg-surface-tertiary lui:text-4xl lui:font-semibold lui:text-foreground") do
            i.to_s
          end
        end
      end
    end
  end

  def looping
    render LightningUiKit::CarouselComponent.new(loop: true, class: "lui:max-w-md") do |carousel|
      %w[Red Green Blue].each do |color|
        carousel.with_slide do
          tag.div(color, class: "lui:flex lui:aspect-video lui:items-center lui:justify-center lui:bg-surface-tertiary lui:text-2xl lui:font-medium lui:text-foreground")
        end
      end
    end
  end
end
