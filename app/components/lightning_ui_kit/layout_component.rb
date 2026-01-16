# frozen_string_literal: true

class LightningUiKit::LayoutComponent < LightningUiKit::BaseComponent
  renders_one :sidebar
  renders_one :footer
  renders_one :mobile_header

  def initialize(sidebar_width: "w-64", **options)
    @sidebar_width = sidebar_width
    @options = options
  end

  def sidebar_width_class
    "lui:#{@sidebar_width}"
  end

  def main_padding_class
    "lui:lg:pl-64"
  end
end
