# frozen_string_literal: true

class LightningUi::SkeletonComponent < LightningUi::BaseComponent
  def initialize(with_title: false, lines: 3)
    @with_title = with_title
    @lines = lines
  end
end
