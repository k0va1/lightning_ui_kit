class LightningUiKit::TableComponent < LightningUiKit::BaseComponent
  renders_many :columns, ->(title, &block) do
    LightningUiKit::Table::ColumnComponent.new(title, &block)
  end
  renders_many :actions, ->(&block) do
    LightningUiKit::Table::ActionComponent.new(&block)
  end

  def initialize(data:, actions_title: "Actions", empty_message: "No data available")
    @data = data
    @actions_title = actions_title
    @empty_message = empty_message
  end
end
