class LightningUiKit::Table::ColumnComponent < LightningUiKit::BaseComponent
  attr_reader :title

  def initialize(title, &block)
    @title = title
    @block = block
  end

  def call(row)
    @block.call(row)
  end
end
