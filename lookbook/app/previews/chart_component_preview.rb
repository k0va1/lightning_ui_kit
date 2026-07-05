class ChartComponentPreview < Lookbook::Preview
  SINGLE = [
    {label: "Jan", value: 186},
    {label: "Feb", value: 305},
    {label: "Mar", value: 237},
    {label: "Apr", value: 173},
    {label: "May", value: 209},
    {label: "Jun", value: 264}
  ].freeze

  MULTI = [
    {label: "Jan", desktop: 186, mobile: 80},
    {label: "Feb", desktop: 305, mobile: 200},
    {label: "Mar", desktop: 237, mobile: 120},
    {label: "Apr", desktop: 173, mobile: 190},
    {label: "May", desktop: 209, mobile: 130},
    {label: "Jun", desktop: 264, mobile: 140}
  ].freeze

  def bar
    render LightningUiKit::ChartComponent.new(type: :bar, data: SINGLE, class: "lui:max-w-xl")
  end

  def grouped_bar
    render LightningUiKit::ChartComponent.new(
      type: :bar,
      data: MULTI,
      series: [{key: :desktop, label: "Desktop"}, {key: :mobile, label: "Mobile"}],
      class: "lui:max-w-xl"
    )
  end

  def line
    render LightningUiKit::ChartComponent.new(
      type: :line,
      data: MULTI,
      series: [{key: :desktop, label: "Desktop"}, {key: :mobile, label: "Mobile"}],
      class: "lui:max-w-xl"
    )
  end

  def area
    render LightningUiKit::ChartComponent.new(type: :area, data: SINGLE, class: "lui:max-w-xl")
  end
end
