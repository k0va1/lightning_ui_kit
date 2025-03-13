require "tailwind_merge"

class LightningUi::BaseComponent < ViewComponent::Base
  include LightningUi::HeroiconHelper

  def merge_classes(classes)
    TailwindMerge::Merger.new.merge(classes)
  end
end
