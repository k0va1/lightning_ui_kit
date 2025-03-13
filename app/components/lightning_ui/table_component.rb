# frozen_string_literal: true

class LightningUi::TableComponent < LightningUi::BaseComponent
  renders_many :columns, ->(title, &block) do
    LightningUi::Table::ColumnComponent.new(title, &block)
  end
  renders_many :actions, ->(&block) do
    LightningUi::Table::ActionComponent.new(&block)
  end

  def initialize(data:, actions_title: "Actions", empty_message: "No data available")
    @data = data
    @actions_title = actions_title
    @empty_message = empty_message
  end
end
