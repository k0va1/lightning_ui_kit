class LightningUiKit::NavigationMenu::ItemComponent < LightningUiKit::BaseComponent
  attr_reader :title, :href

  def initialize(title:, href: nil, **options)
    @title = title
    @href = href
    @options = options
  end

  def link?
    @href.present?
  end
end
