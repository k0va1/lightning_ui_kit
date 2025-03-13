class LightningUi::Table::ActionComponent < LightningUi::BaseComponent
  def initialize(&block)
    @block = block
  end

  def call(row)
    @block.call(row)
  end
end

