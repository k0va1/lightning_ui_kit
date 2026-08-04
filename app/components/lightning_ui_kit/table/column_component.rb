class LightningUiKit::Table::ColumnComponent < LightningUiKit::BaseComponent
  attr_reader :title, :sort_key, :align

  def initialize(title, sort_key: nil, align: :left, &block)
    @title = title
    @sort_key = sort_key
    @align = align
    @block = block
  end

  def sortable?
    !@sort_key.nil?
  end

  def alignment_classes
    case @align
    when :right
      "lui:text-right"
    when :center
      "lui:text-center"
    else
      "lui:text-left"
    end
  end

  def call(row)
    @block.call(row)
  end
end
