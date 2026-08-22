class LightningUiKit::ChartComponent < LightningUiKit::BaseComponent
  TYPES = %i[bar line area].freeze
  UNITS = %i[decimal percent bytes count duration_ms].freeze
  CURVES = %i[monotone linear].freeze

  PLOT_WIDTH = 100.0
  PAD_TOP = 12
  PAD_BOTTOM = 8

  DEFAULT_MAX_X_LABELS = 8
  Y_TICK_STEPS = 4
  # Above this many points a dot per value reads as a bead string, so dots:
  # :auto drops them and relies on the hover marker instead.
  AUTO_DOT_LIMIT = 12
  BAR_RADIUS = 4.0
  # BAR_RADIUS in plot units at a 640px-wide reference plot, so corners keep
  # roughly the same proportions across container sizes.
  BAR_RADIUS_X = 0.625
  # Share of the category band the bars occupy, and of each slot a bar fills.
  BAR_BAND = 0.8
  BAR_FILL = 0.9
  # Rendered in place of a value for missing (nil) data points.
  NIL_LABEL = "–".freeze
  BYTE_UNITS = %w[B KiB MiB GiB TiB PiB EiB].freeze
  DECIMAL_MULTIPLIERS = [1, 2, 5, 10].freeze
  BINARY_MULTIPLIERS = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024].freeze

  def initialize(data:, type: :bar, series: nil, x_key: :label, height: 260, show_grid: true, show_legend: true, show_axis: true,
    unit: :decimal, y_format: nil, max_x_labels: DEFAULT_MAX_X_LABELS, y_min: nil, y_max: nil, span_gaps: false,
    curve: :monotone, dots: :auto, **options)
    @data = Array(data).map { |row| row.respond_to?(:to_h) ? row.to_h.symbolize_keys : row }
    @type = TYPES.include?(type) ? type : :bar
    @x_key = x_key.to_sym
    @height = height.to_i
    @show_grid = show_grid
    @show_legend = show_legend
    @show_axis = show_axis
    @unit = UNITS.include?(unit&.to_sym) ? unit.to_sym : :decimal
    @y_format = y_format
    @max_x_labels = max_x_labels
    @y_min = y_min
    @y_max = y_max
    @span_gaps = span_gaps
    @curve = (curve&.to_sym == :linear) ? :linear : :monotone
    @dots = dots
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

  def span_gaps?
    @span_gaps
  end

  def smooth?
    @curve == :monotone
  end

  # shadcn draws line/area series without per-point dots; :auto keeps them only
  # while the series is sparse enough for them to read as markers.
  def show_dots?
    (@dots == :auto) ? count <= AUTO_DOT_LIMIT : !!@dots
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
  #
  # The x axis lives in a fixed 0..100 space that the svg stretches to the
  # container width (preserveAspectRatio="none"), so charts fill any width.
  # The y axis stays in pixels - the svg height is fixed - so vertical
  # measurements are exact. Stretch-sensitive parts opt out of scaling:
  # strokes and dots via vector-effect="non-scaling-stroke", axis labels by
  # being HTML positioned at left:% / top:px outside the svg.

  def view_height = @height

  def plot_left = 0.0

  def plot_right = PLOT_WIDTH

  def plot_top = PAD_TOP

  def plot_bottom = @height - PAD_BOTTOM

  def plot_width = PLOT_WIDTH

  def plot_height = plot_bottom - plot_top

  def count = @data.size

  def x_label(row) = row[@x_key]

  # nil for a missing data point so lines can break and bars can be skipped.
  # Anything unparseable ("n/a", "-", "") counts as missing rather than zero.
  def value_for(row, series)
    raw = row[series[:key]]
    return nil if raw.nil?
    return raw.to_f if raw.is_a?(Numeric)

    Float(raw.to_s.strip, exception: false)
  end

  # --- y domain ---

  def domain_min
    @domain_min ||= (@y_min || default_domain_min).to_f
  end

  def domain_max
    @domain_max ||= begin
      top = @y_max ? @y_max.to_f : nice_domain_max
      (top > domain_min) ? top : domain_min + 1.0
    end
  end

  def y_for(value)
    return plot_bottom if value.nil?

    span = domain_max - domain_min
    return plot_bottom if span <= 0

    ratio = ((value.to_f - domain_min) / span).clamp(0.0, 1.0)
    plot_bottom - ratio * plot_height
  end

  def point_x(index)
    return plot_left + plot_width / 2.0 if count <= 1

    plot_left + (index.to_f / (count - 1)) * plot_width
  end

  def y_ticks(steps = Y_TICK_STEPS)
    span = domain_max - domain_min

    (0..steps).map do |i|
      value = domain_min + span * i / steps
      {label: format_value(value), y: y_for(value)}
    end
  end

  def x_positions
    @data.each_with_index.map do |row, i|
      x = bar? ? plot_left + i * bar_group_width + bar_group_width / 2.0 : point_x(i)
      {x: x, label: x_label(row)}
    end
  end

  # Evenly spaced subset of x_positions (first and last always kept) so dense
  # series don't render overlapping axis text. Data points are unaffected.
  def x_axis_labels
    positions = x_positions
    label_indices(positions.size).map { |i| positions[i] }
  end

  # Bars are measured from zero (or the nearest edge of the domain when zero
  # falls outside it), so a negative value hangs below the baseline instead of
  # growing upward from the domain floor.
  def bar_baseline = 0.0.clamp(domain_min, domain_max)

  def bars
    group_width = bar_group_width
    slot = bar_slot_width
    width = slot * BAR_FILL
    # Bars are centred in their category band so they line up with the tick
    # label, the hover cursor and the grid.
    cluster = (@series.size - 1) * slot + width
    base_y = y_for(bar_baseline)

    @data.each_with_index.flat_map do |row, i|
      group_x = plot_left + i * group_width + (group_width - cluster) / 2.0
      @series.each_with_index.filter_map do |s, si|
        value = value_for(row, s)
        next if value.nil?

        y = y_for(value)
        {
          x: group_x + si * slot,
          y: [y, base_y].min,
          width: width,
          height: (y - base_y).abs,
          negative: y > base_y,
          color: s[:color],
          label: x_label(row),
          series_label: s[:label],
          value: format_value(value)
        }
      end
    end
  end

  def line_points(series)
    @data.each_with_index.map do |row, i|
      value = value_for(row, series)
      value.nil? ? nil : [point_x(i), y_for(value)]
    end
  end

  # Contiguous runs of plottable points. A nil value ends the current run so the
  # line shows a gap, unless span_gaps: was requested.
  def line_segments(series)
    points = line_points(series)
    return [points.compact].reject(&:empty?) if span_gaps?

    points.chunk_while { |a, b| !a.nil? && !b.nil? }
      .map(&:compact)
      .reject(&:empty?)
  end

  # Stroke path for one contiguous run of points.
  def line_path(points)
    return "" if points.empty?

    "M #{r2(points.first[0])} #{r2(points.first[1])} #{curve_commands(points)}".strip
  end

  # The stroke path closed down to the baseline on both ends.
  def area_path(points)
    return "" if points.empty?

    first = points.first
    last = points.last
    [
      "M #{r2(first[0])} #{r2(plot_bottom)}",
      "L #{r2(first[0])} #{r2(first[1])}",
      curve_commands(points),
      "L #{r2(last[0])} #{r2(plot_bottom)}",
      "Z"
    ].reject(&:empty?).join(" ")
  end

  # Path for a bar with a square base at the baseline and rounded corners on the
  # free end - the top for positive values, the bottom for negative ones. The
  # corner radius is split per axis: vertical in pixels, horizontal in plot
  # units, since the two spaces stretch independently.
  def bar_path(bar)
    x = bar[:x]
    w = bar[:width]
    h = bar[:height]
    return "" if h <= 0 || w <= 0

    ry = [BAR_RADIUS, h].min
    rx = [BAR_RADIUS_X, w / 2.0].min
    x2 = x + w
    base = bar[:negative] ? bar[:y] : bar[:y] + h
    tip = bar[:negative] ? bar[:y] + h : bar[:y]
    # Signed step from the tip back toward the baseline.
    inset = bar[:negative] ? -ry : ry
    [
      "M #{r2(x)} #{r2(base)}",
      "L #{r2(x)} #{r2(tip + inset)}",
      "Q #{r2(x)} #{r2(tip)} #{r2(x + rx)} #{r2(tip)}",
      "L #{r2(x2 - rx)} #{r2(tip)}",
      "Q #{r2(x2)} #{r2(tip)} #{r2(x2)} #{r2(tip + inset)}",
      "L #{r2(x2)} #{r2(base)}",
      "Z"
    ].join(" ")
  end

  # A zero-length round-capped path renders as a fixed-size dot even under the
  # svg's non-uniform stretch, where a circle would smear into an ellipse.
  def dot_path(x, y)
    "M #{r2(x)} #{r2(y)} l 0.001 0"
  end

  # Labels at the plot edges anchor inward so they don't hang outside the
  # chart into the surrounding layout; interior labels stay centred on their
  # tick.
  def x_tick_anchor(x)
    return "" if x <= 0.01
    return "lui:-translate-x-full" if x >= PLOT_WIDTH - 0.01

    "lui:-translate-x-1/2"
  end

  # Invisible full-height bands (one per category) that drive the hover tooltip,
  # cursor and active dots.
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
      {
        x: left,
        width: [right - left, 0].max,
        cursor_x: bar? ? plot_left + i * bar_group_width + bar_group_width / 2.0 : point_x(i),
        markers: markers_for(i),
        label: x_label(row),
        payload: payload_for(i)
      }
    end
  end

  # Y position of each series at the given index, or null where the value is
  # missing, so the controller can place one active dot per series on hover.
  def markers_for(index)
    row = @data[index]
    @series.map do |s|
      value = value_for(row, s)
      value.nil? ? nil : r2(y_for(value))
    end.to_json
  end

  def payload_for(index)
    row = @data[index]
    @series.map do |s|
      {label: s[:label], value: format_value(value_for(row, s)), color: s[:color]}
    end.to_json
  end

  # Applies y_format: when given, otherwise the unit: preset. Shared by axis
  # ticks and tooltip payloads so the two always agree.
  def format_value(value)
    return NIL_LABEL if value.nil?
    return @y_format.call(value).to_s if @y_format.respond_to?(:call)

    case @unit
    when :percent then format_percent(value.to_f)
    when :bytes then format_bytes(value.to_f)
    when :count then format_count(value.to_f)
    when :duration_ms then format_duration_ms(value.to_f)
    else format_decimal(value.to_f)
    end
  end

  private

  def r2(number)
    number.round(2)
  end

  # Segment commands after the opening `M`, honouring the curve: option.
  def curve_commands(points)
    return "" if points.size < 2
    return points.drop(1).map { |x, y| "L #{r2(x)} #{r2(y)}" }.join(" ") unless smooth?

    tangents = monotone_tangents(points)
    points.each_cons(2).each_with_index.map do |(from, to), i|
      dx = (to[0] - from[0]) / 3.0
      c1 = [from[0] + dx, from[1] + tangents[i] * dx]
      c2 = [to[0] - dx, to[1] - tangents[i + 1] * dx]
      "C #{r2(c1[0])} #{r2(c1[1])} #{r2(c2[0])} #{r2(c2[1])} #{r2(to[0])} #{r2(to[1])}"
    end.join(" ")
  end

  # Fritsch-Carlson slopes: a monotone cubic that never overshoots the data,
  # matching the "monotone"/"natural" curve shadcn uses for lines and areas.
  def monotone_tangents(points)
    slopes = points.each_cons(2).map do |(x1, y1), (x2, y2)|
      dx = x2 - x1
      dx.zero? ? 0.0 : (y2 - y1) / dx
    end

    tangents = [slopes.first]
    slopes.each_cons(2) do |left, right|
      tangents << ((left * right <= 0) ? 0.0 : (left + right) / 2.0)
    end
    tangents << slopes.last

    slopes.each_with_index do |slope, i|
      if slope.zero?
        tangents[i] = 0.0
        tangents[i + 1] = 0.0
        next
      end

      a = tangents[i] / slope
      b = tangents[i + 1] / slope
      magnitude = a * a + b * b
      next if magnitude <= 9

      scale = 3.0 * slope / Math.sqrt(magnitude)
      tangents[i] = scale * a
      tangents[i + 1] = scale * b
    end

    tangents
  end

  def data_values
    @data_values ||= @data.flat_map { |row| @series.map { |s| value_for(row, s) } }.compact
  end

  def default_domain_min
    min = data_values.min
    (min && min < 0) ? -nice_step(min.abs) : 0.0
  end

  # Round the data max up so that the axis lands on 1/2/5 × 10ⁿ values.
  def nice_domain_max(steps = Y_TICK_STEPS)
    max = data_values.max
    span = max ? max - domain_min : 0
    return domain_min + 1.0 if span <= 0

    domain_min + nice_step(span / steps) * steps
  end

  # Smallest "round" value >= the given magnitude: 1/2/5 × 10ⁿ normally, or
  # 1/2/4/…/1024 × 1024ⁿ for :bytes so ticks land on whole KiB/MiB/GiB.
  def nice_step(value)
    return 1.0 if value <= 0

    radix, multipliers = (@unit == :bytes) ? [1024, BINARY_MULTIPLIERS] : [10, DECIMAL_MULTIPLIERS]
    exponent = Math.log(value, radix).floor
    base = radix.to_f**exponent
    fraction = value / base

    step = (multipliers.find { |m| fraction <= m } || multipliers.last) * base
    # :count renders whole numbers, so a sub-integer step would repeat labels.
    (@unit == :count) ? [step, 1.0].max : step
  end

  def label_indices(total)
    return (0...total).to_a unless @max_x_labels

    limit = @max_x_labels.to_i
    return (0...total).to_a if limit <= 0 || total <= limit
    return [0] if limit == 1

    step = (total - 1) / (limit - 1).to_f
    (0...limit).map { |i| (i * step).round }.uniq
  end

  def bar_group_width
    return plot_width if count.zero?

    plot_width.to_f / count
  end

  # Horizontal room for one series within a category band.
  def bar_slot_width
    band = bar_group_width * BAR_BAND
    @series.empty? ? band : band / @series.size
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
    numeric = candidates.select { |key| @data.all? { |row| row[key].is_a?(Numeric) || row[key].nil? } }
    return numeric unless numeric.empty?

    @data.first.key?(:value) ? [:value] : []
  end

  def trim(number)
    (number % 1).zero? ? number.to_i.to_s : number.to_s
  end

  def format_decimal(value)
    trim(value.round(2))
  end

  def format_percent(value)
    # Sub-1% values need a second decimal or neighbouring ticks collapse.
    decimals = (!value.zero? && value.abs < 1) ? 2 : 1
    "#{trim(value.round(decimals))}%"
  end

  def format_bytes(value)
    return "0 B" if value.zero?

    sign = value.negative? ? "-" : ""
    magnitude = value.abs
    exponent = Math.log(magnitude, 1024).floor.clamp(0, BYTE_UNITS.size - 1)
    scaled = magnitude / (1024.0**exponent)

    "#{sign}#{trim(scaled.round(exponent.zero? ? 0 : 2))} #{BYTE_UNITS[exponent]}"
  end

  def format_count(value)
    ActiveSupport::NumberHelper.number_to_delimited(value.round)
  end

  def format_duration_ms(value)
    magnitude = value.abs

    if magnitude < 1
      "#{trim(value.round(2))} ms"
    elsif magnitude < 1_000
      "#{trim(value.round((magnitude < 10) ? 1 : 0))} ms"
    elsif magnitude < 60_000
      "#{trim((value / 1_000.0).round(2))} s"
    else
      "#{trim((value / 60_000.0).round(2))} min"
    end
  end
end
