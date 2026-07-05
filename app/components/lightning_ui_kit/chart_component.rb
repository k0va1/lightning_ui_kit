class LightningUiKit::ChartComponent < LightningUiKit::BaseComponent
  TYPES = %i[bar line area].freeze

  VIEW_WIDTH = 640
  PAD_RIGHT = 16
  PAD_TOP = 12
  AXIS_PAD_LEFT = 44

  def initialize(data:, type: :bar, series: nil, x_key: :label, height: 260, show_grid: true, show_legend: true, show_axis: true, **options)
    @data = Array(data).map { |row| row.respond_to?(:to_h) ? row.to_h.symbolize_keys : row }
    @type = TYPES.include?(type) ? type : :bar
    @x_key = x_key.to_sym
    @height = height.to_i
    @show_grid = show_grid
    @show_legend = show_legend
    @show_axis = show_axis
    @series = build_series(series)
    @options = options
  end

  attr_reader :type, :series, :height

  def bar?
    @type == :bar
  end

  def area?
    @type == :area
  end

  def empty?
    @data.empty? || @series.empty?
  end

  def show_grid?
    @show_grid
  end

  def show_axis?
    @show_axis
  end

  def show_legend?
    @show_legend && @series.any?
  end

  def classes
    merge_classes([
      "lui:relative lui:w-full lui:text-foreground",
      @options[:class]
    ].compact.join(" "))
  end

  def chart_id
    @chart_id ||= "lui-chart-#{object_id}"
  end

  def gradient_id(index)
    "#{chart_id}-grad-#{index}"
  end

  def stimulus_data
    {controller: "lui-chart"}.merge(data_attrs)
  end

  def data_attrs
    @options[:data] || {}
  end

  # --- geometry ---

  def view_width = VIEW_WIDTH

  def view_height = @height

  def plot_left = @show_axis ? AXIS_PAD_LEFT : 8

  def plot_right = VIEW_WIDTH - PAD_RIGHT

  def plot_top = PAD_TOP

  def plot_bottom = @height - (@show_axis ? 28 : 8)

  def plot_width = plot_right - plot_left

  def plot_height = plot_bottom - plot_top

  def count = @data.size

  def x_label(row) = row[@x_key]

  def value_for(row, series) = row[series[:key]].to_f

  def y_for(value)
    return plot_bottom if chart_max.zero?

    plot_bottom - (value.to_f / chart_max) * plot_height
  end

  def point_x(index)
    return plot_left + plot_width / 2.0 if count <= 1

    plot_left + (index.to_f / (count - 1)) * plot_width
  end

  def y_ticks(steps = 4)
    (0..steps).map do |i|
      value = chart_max * i / steps
      {label: format_number(value), y: y_for(value)}
    end
  end

  def x_positions
    @data.each_with_index.map do |row, i|
      x = bar? ? plot_left + i * bar_group_width + bar_group_width / 2.0 : point_x(i)
      {x: x, label: x_label(row)}
    end
  end

  def bars
    group_width = bar_group_width
    inner = group_width * 0.2
    band = group_width - inner
    bar_width = @series.empty? ? band : band / @series.size

    @data.each_with_index.flat_map do |row, i|
      group_x = plot_left + i * group_width + inner / 2.0
      @series.each_with_index.map do |s, si|
        value = value_for(row, s)
        y = y_for(value)
        {
          x: group_x + si * bar_width,
          y: y,
          width: bar_width * 0.9,
          height: [plot_bottom - y, 0].max,
          color: s[:color],
          label: x_label(row),
          series_label: s[:label],
          value: format_number(value)
        }
      end
    end
  end

  def line_points(series)
    @data.each_with_index.map do |row, i|
      [point_x(i), y_for(value_for(row, series))]
    end
  end

  def polyline(points)
    points.map { |x, y| "#{x.round(2)},#{y.round(2)}" }.join(" ")
  end

  def area_path(points)
    return "" if points.empty?

    segments = ["M #{points.first[0].round(2)} #{plot_bottom.round(2)}"]
    points.each { |x, y| segments << "L #{x.round(2)} #{y.round(2)}" }
    segments << "L #{points.last[0].round(2)} #{plot_bottom.round(2)} Z"
    segments.join(" ")
  end

  # Path for a bar with rounded top corners and a square base.
  def bar_path(bar)
    x = bar[:x]
    y = bar[:y]
    w = bar[:width]
    h = bar[:height]
    return "" if h <= 0 || w <= 0

    r = [6.0, w / 2.0, h].min
    x2 = x + w
    bottom = y + h
    [
      "M #{r2(x)} #{r2(bottom)}",
      "L #{r2(x)} #{r2(y + r)}",
      "Q #{r2(x)} #{r2(y)} #{r2(x + r)} #{r2(y)}",
      "L #{r2(x2 - r)} #{r2(y)}",
      "Q #{r2(x2)} #{r2(y)} #{r2(x2)} #{r2(y + r)}",
      "L #{r2(x2)} #{r2(bottom)}",
      "Z"
    ].join(" ")
  end

  # Invisible full-height bands (one per category) that drive the hover tooltip.
  def hover_columns
    step = (count > 1) ? plot_width.to_f / (count - 1) : plot_width.to_f

    @data.each_with_index.map do |row, i|
      if bar?
        x = plot_left + i * bar_group_width
        w = bar_group_width
      else
        x = point_x(i) - step / 2.0
        w = step
      end
      left = [x, plot_left].max
      right = [x + w, plot_right].min
      {x: left, width: [right - left, 0].max, label: x_label(row), payload: payload_for(i)}
    end
  end

  def payload_for(index)
    row = @data[index]
    @series.map do |s|
      {label: s[:label], value: format_number(value_for(row, s)), color: s[:color]}
    end.to_json
  end

  private

  def r2(number)
    number.round(2)
  end

  def chart_max
    @chart_max ||= begin
      values = @data.flat_map { |row| @series.map { |s| value_for(row, s) } }
      max = values.max || 0
      (max <= 0) ? 1.0 : max.to_f
    end
  end

  def bar_group_width
    return plot_width if count.zero?

    plot_width.to_f / count
  end

  def build_series(series)
    definitions =
      if series
        Array(series).map { |s| s.to_h.symbolize_keys }
      else
        numeric_keys.map { |key| {key: key} }
      end

    definitions.each_with_index.map do |definition, i|
      key = definition[:key].to_sym
      {
        key: key,
        label: definition[:label] || key.to_s.humanize,
        color: definition[:color] || "var(--lui-theme-chart-#{(i % 5) + 1})"
      }
    end
  end

  def numeric_keys
    return [] if @data.empty?

    candidates = @data.first.keys - [@x_key]
    numeric = candidates.select { |key| @data.all? { |row| row[key].is_a?(Numeric) } }
    return numeric unless numeric.empty?

    @data.first.key?(:value) ? [:value] : []
  end

  def format_number(value)
    rounded = value.to_f.round(2)
    (rounded % 1).zero? ? rounded.to_i.to_s : rounded.to_s
  end
end
