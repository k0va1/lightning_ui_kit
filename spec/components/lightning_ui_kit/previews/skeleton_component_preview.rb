class SkeletonComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::SkeletonComponent.new(
      with_title: true,
      lines: 10
    )
  end
end
