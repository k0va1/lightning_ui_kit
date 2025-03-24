class SkeletonComponentPreview < Lookbook::Preview
  def default
    render LightningUi::SkeletonComponent.new(
      with_title: true,
      lines: 10
    )
  end
end
