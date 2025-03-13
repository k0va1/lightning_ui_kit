# frozen_string_literal: true

class LightningUi::DescriptionListComponent < LightningUi::BaseComponent
  renders_many :items, LightningUi::DescriptionList::ItemComponent
end
