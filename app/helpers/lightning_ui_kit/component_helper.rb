module LightningUiKit
  module ComponentHelper
    def lui
      @lui_builder ||= LightningUiKit::Builder.new(self)
    end
  end
end
