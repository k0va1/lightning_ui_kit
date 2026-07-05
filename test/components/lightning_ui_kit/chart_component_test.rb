require "test_helper"

class LightningUiKit::ChartComponentTest < ViewComponent::TestCase
  SINGLE = [{label: "Jan", value: 100}, {label: "Feb", value: 200}].freeze

  def test_renders_bar_chart_svg
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: SINGLE))

    assert_equal 1, result.css("svg").size
    assert_equal 2, result.css('path[data-role="bar"]').size
    assert_includes result.to_html, "Jan"
    assert_includes result.to_html, "Feb"
  end

  def test_renders_line_chart
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))

    assert_equal 1, result.css('polyline[data-role="line"]').size
    assert_equal 2, result.css('circle[data-role="point"]').size
  end

  def test_renders_area_chart_with_gradient
    result = render_inline(LightningUiKit::ChartComponent.new(type: :area, data: SINGLE))

    assert_equal 1, result.css('path[data-role="area"]').size
    assert_equal 1, result.css('polyline[data-role="line"]').size
    assert_equal 1, result.css("linearGradient").size
  end

  def test_infers_multiple_series
    data = [{label: "Jan", desktop: 10, mobile: 5}, {label: "Feb", desktop: 20, mobile: 8}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: data))

    # 2 points x 2 series = 4 bars
    assert_equal 4, result.css('path[data-role="bar"]').size
  end

  def test_explicit_series_labels_in_legend
    data = [{label: "Jan", desktop: 10, mobile: 5}]
    result = render_inline(LightningUiKit::ChartComponent.new(
      type: :line,
      data: data,
      series: [{key: :desktop, label: "Desktop"}, {key: :mobile, label: "Mobile"}]
    ))

    assert_includes result.to_html, "Desktop"
    assert_includes result.to_html, "Mobile"
  end

  def test_empty_data_shows_placeholder
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: []))

    assert_includes result.to_html, "No data to display"
    assert_equal 0, result.css("svg").size
  end

  def test_interactive_tooltip_wiring
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: SINGLE))

    assert_includes result.to_html, 'data-controller="lui-chart"'
    assert_includes result.to_html, 'data-lui-chart-target="tooltip"'
    # One hover column per data point, each carrying a JSON payload.
    assert_equal 2, result.css('rect[data-role="column"]').size
    assert_includes result.to_html, "mouseenter->lui-chart#show"
  end

  def test_hover_column_payload_contains_series_values
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: SINGLE))

    column = result.css('rect[data-role="column"]').first
    payload = JSON.parse(column["data-payload"])
    assert_equal "100", payload.first["value"]
    assert payload.first.key?("color")
  end
end
