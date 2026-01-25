class LightningUiKit::SkeletonComponent < LightningUiKit::BaseComponent
  def initialize(with_title: false, lines: 3)
    @with_title = with_title
    @lines = lines
  end
end
