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

    assert_equal 1, result.css('path[data-role="line"]').size
    assert_equal 2, result.css('path[data-role="point"]').size
  end

  def test_renders_area_chart_with_gradient
    result = render_inline(LightningUiKit::ChartComponent.new(type: :area, data: SINGLE))

    assert_equal 1, result.css('path[data-role="area"]').size
    assert_equal 1, result.css('path[data-role="line"]').size
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

  # --- value formatting ---

  def test_percent_unit_formats_ticks_and_tooltip
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 42.14}], unit: :percent, y_max: 100)

    assert_equal ["0%", "25%", "50%", "75%", "100%"], chart.y_ticks.map { |t| t[:label] }
    assert_equal "42.1%", JSON.parse(chart.payload_for(0)).first["value"]
  end

  def test_bytes_unit_uses_binary_units
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 1.24 * 1024**3}], unit: :bytes)

    assert_equal "1.24 GiB", JSON.parse(chart.payload_for(0)).first["value"]
    assert_equal "0 B", chart.format_value(0)
    assert_equal "512 B", chart.format_value(512)
    assert_equal "1.5 KiB", chart.format_value(1536)
  end

  def test_count_unit_delimits_thousands
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: [{label: "a", value: 1_234_567.8}], unit: :count)

    assert_equal "1,234,568", JSON.parse(chart.payload_for(0)).first["value"]
  end

  def test_duration_ms_unit_switches_scale
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, unit: :duration_ms)

    assert_equal "340 ms", chart.format_value(340)
    assert_equal "1.25 s", chart.format_value(1250)
    assert_equal "2 min", chart.format_value(120_000)
  end

  def test_decimal_unit_is_the_default
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE)

    assert_equal "12.35", chart.format_value(12.345)
    assert_equal "12", chart.format_value(12.0)
  end

  def test_y_format_callable_wins_over_unit
    chart = LightningUiKit::ChartComponent.new(
      type: :line,
      data: [{label: "a", value: 5}],
      unit: :bytes,
      y_format: ->(v) { "#{v.to_i} req" }
    )

    assert_equal "5 req", JSON.parse(chart.payload_for(0)).first["value"]
    # Ticks use the callable too, not the :bytes preset.
    assert_equal ["0 req", "2 req", "4 req", "6 req", "8 req"], chart.y_ticks.map { |t| t[:label] }
  end

  def test_unknown_unit_falls_back_to_decimal
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, unit: :parsecs)

    assert_equal "1.5", chart.format_value(1.5)
  end

  # --- x-axis label thinning ---

  def test_x_labels_are_thinned_keeping_first_and_last
    data = (0...100).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, max_x_labels: 8)
    labels = chart.x_axis_labels.map { |pos| pos[:label] }

    assert_equal 8, labels.size
    assert_equal "t0", labels.first
    assert_equal "t99", labels.last
    # All rows still render as data points and hover columns.
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data, max_x_labels: 8, dots: true))
    assert_equal 100, result.css('path[data-role="point"]').size
    assert_equal 100, result.css('rect[data-role="column"]').size
    assert_equal 8, result.css('[data-role="x-tick"]').size
  end

  def test_x_labels_untouched_when_under_the_limit
    data = (0...6).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: data, max_x_labels: 8)

    assert_equal 6, chart.x_axis_labels.size
  end

  def test_x_labels_at_exactly_the_limit_are_untouched
    data = (0...8).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: data, max_x_labels: 8)

    assert_equal 8, chart.x_axis_labels.size
  end

  def test_x_labels_thinning_can_be_disabled
    data = (0...40).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, max_x_labels: nil)

    assert_equal 40, chart.x_axis_labels.size
  end

  def test_max_x_labels_of_one_renders_one_label
    data = (0...20).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, max_x_labels: 1)

    assert_equal ["t0"], chart.x_axis_labels.map { |pos| pos[:label] }
  end

  def test_x_labels_minimum_keeps_first_and_last
    data = (0...40).map { |i| {label: "t#{i}", value: i} }
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, max_x_labels: 2)

    assert_equal ["t0", "t39"], chart.x_axis_labels.map { |pos| pos[:label] }
  end

  # --- y domain ---

  def test_y_max_pins_the_top_of_the_domain
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 42}], unit: :percent, y_max: 100)

    assert_equal 100.0, chart.domain_max
    assert_equal 0.0, chart.domain_min
  end

  def test_y_min_lifts_the_baseline
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 1.2}, {label: "b", value: 1.9}], y_min: 1)

    assert_equal 1.0, chart.domain_min
    assert_in_delta chart.plot_bottom, chart.y_for(1.0), 0.01
  end

  def test_bytes_domain_rounds_up_to_binary_ticks
    chart = LightningUiKit::ChartComponent.new(type: :area, data: [{label: "a", value: 3.0 * 1024**3}], unit: :bytes)

    assert_equal ["0 B", "1 GiB", "2 GiB", "3 GiB", "4 GiB"], chart.y_ticks.map { |t| t[:label] }
  end

  def test_unset_domain_rounds_up_to_nice_ticks
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: [{label: "a", value: 73.25}])

    assert_equal 80.0, chart.domain_max
    assert_equal ["0", "20", "40", "60", "80"], chart.y_ticks.map { |t| t[:label] }
  end

  def test_values_outside_an_explicit_domain_are_clamped
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 250}], y_min: 0, y_max: 100)

    assert_in_delta chart.plot_top, chart.y_for(250), 0.01
    assert_in_delta chart.plot_bottom, chart.y_for(-50), 0.01
  end

  def test_flat_zero_series_still_has_a_usable_domain
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 0}, {label: "b", value: 0}])

    assert_equal 0.0, chart.domain_min
    assert_equal 1.0, chart.domain_max
  end

  def test_negative_values_extend_the_domain_below_zero
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: -3}, {label: "b", value: 8}])

    assert chart.domain_min < 0
    assert chart.domain_max >= 8
  end

  def test_bars_hang_below_the_baseline_for_negative_values
    data = [{label: "loss", value: -3}, {label: "flat", value: 0}, {label: "gain", value: 8}]
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: data)
    baseline = chart.y_for(chart.bar_baseline)
    loss, flat, gain = chart.bars

    # Every bar starts at zero: the loss grows down, the gain up.
    assert_in_delta baseline, loss[:y], 0.01
    assert loss[:negative]
    assert_in_delta baseline, gain[:y] + gain[:height], 0.01
    refute gain[:negative]
    assert_in_delta 0, flat[:height], 0.01
    # ...and magnitude is proportional, not measured from the domain floor.
    assert_in_delta 3.0 / 8.0, loss[:height] / gain[:height], 0.01
  end

  def test_negative_bars_round_their_lower_corners
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: [{label: "a", value: -5}, {label: "b", value: 5}])
    bar = chart.bars.first
    path = chart.bar_path(bar)

    # The rounded corners sit at the free end, which is below the baseline.
    assert_operator path.scan(/Q [\d.]+ ([\d.]+)/).flatten.map(&:to_f).min, :>, bar[:y]
  end

  def test_bar_baseline_clamps_into_an_all_positive_domain
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: [{label: "a", value: 5}], y_min: 2, y_max: 10)

    assert_equal 2.0, chart.bar_baseline
    assert_in_delta chart.plot_bottom, chart.y_for(chart.bar_baseline), 0.01
  end

  # --- nil values ---

  def test_line_breaks_at_nil_values
    data = [{label: "a", value: 1}, {label: "b", value: 2}, {label: "c", value: nil}, {label: "d", value: 4}, {label: "e", value: 5}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))

    # Two strokes: a..b and d..e, with a gap where the value is missing.
    assert_equal 2, result.css('path[data-role="line"]').size
    assert_equal 4, result.css('path[data-role="point"]').size
  end

  def test_span_gaps_connects_across_nil_values
    data = [{label: "a", value: 1}, {label: "b", value: nil}, {label: "c", value: 3}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data, span_gaps: true))

    assert_equal 1, result.css('path[data-role="line"]').size
    assert_equal 2, result.css('path[data-role="point"]').size
  end

  def test_area_breaks_at_nil_values
    data = [{label: "a", value: 1}, {label: "b", value: 2}, {label: "c", value: nil}, {label: "d", value: 4}, {label: "e", value: 5}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :area, data: data))

    assert_equal 2, result.css('path[data-role="area"]').size
  end

  def test_isolated_point_between_gaps_renders_without_a_stroke
    data = [{label: "a", value: nil}, {label: "b", value: 2}, {label: "c", value: nil}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))

    assert_equal 0, result.css('path[data-role="line"]').size
    assert_equal 1, result.css('path[data-role="point"]').size
  end

  def test_nil_bars_are_skipped
    data = [{label: "a", value: 1}, {label: "b", value: nil}, {label: "c", value: 3}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: data))

    assert_equal 2, result.css('path[data-role="bar"]').size
  end

  def test_nil_does_not_pull_the_domain_to_zero
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: nil}, {label: "b", value: 40}])

    assert_equal 40.0, chart.domain_max
  end

  def test_unparseable_values_are_gaps_not_zeros
    data = [{label: "a", load: "n/a"}, {label: "b", load: "3.5"}, {label: "c", load: "-"}]
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, series: [{key: :load}])

    assert_nil chart.value_for(data[0], chart.series.first)
    assert_in_delta 3.5, chart.value_for(data[1], chart.series.first), 0.001
    assert_nil chart.value_for(data[2], chart.series.first)
    # Only the parseable sample is plotted, and it is not dragged to the baseline.
    assert_equal [1], chart.line_segments(chart.series.first).map(&:size)
    assert_equal LightningUiKit::ChartComponent::NIL_LABEL, JSON.parse(chart.payload_for(0)).first["value"]
  end

  def test_count_unit_never_repeats_integer_ticks
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: [{label: "a", value: 0}, {label: "b", value: 1}], unit: :count)
    labels = chart.y_ticks.map { |t| t[:label] }

    assert_equal labels.uniq, labels
  end

  def test_percent_unit_keeps_small_ticks_distinct
    data = [{label: "a", value: 0.02}, {label: "b", value: 0.05}]
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data, unit: :percent)
    labels = chart.y_ticks.map { |t| t[:label] }

    assert_equal labels.uniq, labels
  end

  def test_tooltip_shows_a_dash_for_nil_values
    data = [{label: "a", value: nil}, {label: "b", value: 3}]
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data)

    assert_equal LightningUiKit::ChartComponent::NIL_LABEL, JSON.parse(chart.payload_for(0)).first["value"]
    assert_equal "3", JSON.parse(chart.payload_for(1)).first["value"]
  end

  # --- curve and dots ---

  def test_lines_use_monotone_cubic_curves_by_default
    chart = LightningUiKit::ChartComponent.new(type: :line, data: [{label: "a", value: 1}, {label: "b", value: 5}, {label: "c", value: 3}])
    path = chart.line_path(chart.line_segments(chart.series.first).first)

    assert path.start_with?("M ")
    assert_includes path, "C "
    refute_includes path, "L "
  end

  def test_linear_curve_emits_straight_segments
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, curve: :linear)
    path = chart.line_path(chart.line_segments(chart.series.first).first)

    assert_includes path, "L "
    refute_includes path, "C "
  end

  def test_nil_curve_falls_back_to_the_default
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, curve: nil)

    assert chart.smooth?
  end

  def test_natural_is_an_alias_for_monotone
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, curve: :natural)

    assert chart.smooth?
  end

  def test_monotone_curve_does_not_overshoot_the_plot_area
    data = [{label: "a", value: 0}, {label: "b", value: 100}, {label: "c", value: 0}, {label: "d", value: 100}]
    chart = LightningUiKit::ChartComponent.new(type: :line, data: data)
    path = chart.line_path(chart.line_segments(chart.series.first).first)
    ys = path.scan(/-?\d+\.?\d*/).map(&:to_f).each_slice(2).map(&:last)

    assert_operator ys.min, :>=, chart.plot_top - 0.01
    assert_operator ys.max, :<=, chart.plot_bottom + 0.01
  end

  def test_dense_series_drops_per_point_dots
    data = (0...40).map { |i| {label: "t#{i}", value: i} }
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))

    assert_equal 0, result.css('path[data-role="point"]').size
    assert_equal 1, result.css('path[data-role="line"]').size
  end

  def test_sparse_series_keeps_dots
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))

    assert_equal 2, result.css('path[data-role="point"]').size
  end

  def test_dots_can_be_forced_off_on_a_sparse_series
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, dots: false))

    assert_equal 0, result.css('path[data-role="point"]').size
  end

  def test_dotless_series_still_marks_isolated_points
    data = (0...40).map { |i| {label: "t#{i}", value: (i == 20) ? 5 : nil} }
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))

    # Nothing to stroke, so the lone sample would be invisible without a dot.
    assert_equal 0, result.css('path[data-role="line"]').size
    assert_equal 1, result.css('path[data-role="point"]').size
  end

  # --- hover cursor and active dots ---

  def test_hover_columns_carry_cursor_and_marker_geometry
    data = [{label: "a", value: 1}, {label: "b", value: nil}, {label: "c", value: 3}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))
    columns = result.css('rect[data-role="column"]')

    assert_equal 1, JSON.parse(columns[0]["data-markers"]).size
    assert_nil JSON.parse(columns[1]["data-markers"]).first
    assert_in_delta columns[0]["data-cursor-x"].to_f, 0.0, 0.01
  end

  def test_line_charts_render_a_cursor_line_and_active_dots
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))

    assert_equal 1, result.css('line[data-role="cursor-line"]').size
    assert_equal 0, result.css('rect[data-role="cursor-band"]').size
    assert_equal 1, result.css('g[data-role="active-dot"]').size
    assert_includes result.to_html, 'data-lui-chart-target="markers"'
  end

  def test_bars_are_centred_in_their_category_band
    [1, 2, 3].each do |series_count|
      keys = (1...(series_count + 1)).map { |i| :"s#{i}" }
      data = [:Jan, :Feb].map { |label| {label: label.to_s}.merge(keys.to_h { |k| [k, 100] }) }
      chart = LightningUiKit::ChartComponent.new(type: :bar, data: data)

      column = chart.hover_columns.last
      bars = chart.bars.select { |bar| bar[:label] == "Feb" }
      cluster_centre = (bars.map { |b| b[:x] }.min + bars.map { |b| b[:x] + b[:width] }.max) / 2.0

      # The bars, the hover band, the cursor and the tick label all share a centre.
      assert_in_delta column[:x] + column[:width] / 2.0, cluster_centre, 0.01, "#{series_count} series"
      assert_in_delta column[:cursor_x], cluster_centre, 0.01, "#{series_count} series"
      assert_in_delta chart.x_positions.last[:x], cluster_centre, 0.01, "#{series_count} series"
    end
  end

  def test_bars_stay_inside_their_category_band
    data = [{label: "Jan", value: 1}, {label: "Feb", value: 2}]
    chart = LightningUiKit::ChartComponent.new(type: :bar, data: data)
    column = chart.hover_columns.first
    bar = chart.bars.first

    assert_operator bar[:x], :>=, column[:x]
    assert_operator bar[:x] + bar[:width], :<=, column[:x] + column[:width]
  end

  def test_bar_charts_render_a_cursor_band_instead
    result = render_inline(LightningUiKit::ChartComponent.new(type: :bar, data: SINGLE))

    assert_equal 1, result.css('rect[data-role="cursor-band"]').size
    assert_equal 0, result.css('line[data-role="cursor-line"]').size
    assert_equal 0, result.css('g[data-role="active-dot"]').size
  end

  def test_one_active_dot_per_series
    data = [{label: "Jan", desktop: 10, mobile: 5}, {label: "Feb", desktop: 20, mobile: 8}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :area, data: data))

    assert_equal 2, result.css('g[data-role="active-dot"]').size
  end

  def test_hover_columns_still_cover_nil_rows
    data = [{label: "a", value: 1}, {label: "b", value: nil}, {label: "c", value: 3}]
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: data))

    assert_equal 3, result.css('rect[data-role="column"]').size
  end

  # --- responsive full-width rendering ---

  def test_svg_stretches_to_the_container
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))
    svg = result.css("svg").first

    assert_equal "none", svg["preserveAspectRatio"]
    assert_equal "0 0 100 260", svg["viewBox"]
  end

  def test_strokes_and_dots_opt_out_of_scaling
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))

    assert_equal "non-scaling-stroke", result.css('path[data-role="line"]').first["vector-effect"]
    assert_equal "non-scaling-stroke", result.css('path[data-role="point"]').first["vector-effect"]
    assert_equal "non-scaling-stroke", result.css('line[data-role="cursor-line"]').first["vector-effect"]
  end

  def test_axis_labels_are_html_not_svg_text
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))

    assert_equal 0, result.css("svg text").size
    # y labels are pinned in pixels, x labels in percentages of the plot width.
    assert_match(/top: [\d.]+px/, result.css('[data-role="y-tick"]').first["style"])
    assert_match(/left: [\d.]+%/, result.css('[data-role="x-tick"]').first["style"])
    assert_equal ["0.0%", "100.0%"], result.css('[data-role="x-tick"]').map { |t| t["style"][/left: ([\d.]+%)/, 1] }
  end

  def test_show_axis_false_drops_the_label_markup
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE, show_axis: false))

    assert_equal 0, result.css('[data-role="y-tick"]').size
    assert_equal 0, result.css('[data-role="x-tick"]').size
  end

  def test_grid_lines_are_html_so_dashes_do_not_stretch
    chart = LightningUiKit::ChartComponent.new(type: :line, data: SINGLE)
    result = render_inline(chart)

    assert_equal chart.y_ticks.size, result.css('[data-role="grid-line"]').size
    assert_equal 0, result.css("svg line:not([data-role])").size
  end

  def test_dots_render_as_round_capped_zero_length_paths
    result = render_inline(LightningUiKit::ChartComponent.new(type: :line, data: SINGLE))
    dot = result.css('path[data-role="point"]').first

    assert_equal "round", dot["stroke-linecap"]
    assert_match(/\AM [\d.]+ [\d.]+ l 0\.001 0\z/, dot["d"])
    # Each dot gets a surface-colored core so it reads as a ring over the line.
    assert_equal result.css('path[data-role="point"]').size, result.css('path[data-role="point-core"]').size
  end
end
