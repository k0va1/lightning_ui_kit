# frozen_string_literal: true

class LightningUiKit::DescriptionListComponent < LightningUiKit::BaseComponent
  renders_many :items, LightningUiKit::DescriptionList::ItemComponent
end
