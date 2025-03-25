require "tailwind_merge"

class LightningUiKit::BaseComponent < ViewComponent::Base
  include LightningUiKit::HeroiconHelper

  def merge_classes(classes)
    TailwindMerge::Merger.new.merge(classes)
  end
end
