class LightningUiKit::Tabs::TabComponent < LightningUiKit::BaseComponent
  attr_reader :title

  def initialize(title:, **options)
    @title = title
    @options = options
  end
end
