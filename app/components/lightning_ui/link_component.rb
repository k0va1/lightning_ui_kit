# frozen_string_literal: true

class LightningUi::LinkComponent < LightningUi::BaseComponent
  def initialize(title:, url:)
    @title = title
    @url = url
  end
end
