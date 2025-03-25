# frozen_string_literal: true

class LightningUiKit::LinkComponent < LightningUiKit::BaseComponent
  def initialize(title:, url:)
    @title = title
    @url = url
  end
end
