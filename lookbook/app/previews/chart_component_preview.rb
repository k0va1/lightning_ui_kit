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

  # 96 buckets of five-minute samples over eight hours.
  MEMORY_SERIES = (0...96).map do |i|
    minutes = i * 5
    {
      label: format("%02d:%02d", 6 + minutes / 60, minutes % 60),
      used: (2.1 + 0.9 * Math.sin(i / 9.0)) * (1024**3),
      cached: (0.6 + 0.25 * Math.cos(i / 6.0)) * (1024**3)
    }
  end.freeze

  CPU_SERIES = (0...60).map do |i|
    {label: "#{i}m", cpu: (18 + 14 * Math.sin(i / 7.0)).round(1)}
  end.freeze

  # A short outage between 04 and 06 leaves three buckets without a sample.
  GAPPY = (0...12).map do |i|
    {label: "%02d" % i, load: (4..6).cover?(i) ? nil : (0.8 + 0.5 * Math.sin(i / 3.0)).round(2)}
  end.freeze

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

  # Dense host-memory series: 96 five-minute buckets, byte-formatted axis and
  # tooltip, with the x-axis thinned down to 8 labels.
  def memory_time_series
    render LightningUiKit::ChartComponent.new(
      type: :area,
      data: MEMORY_SERIES,
      series: [{key: :used, label: "Used"}, {key: :cached, label: "Cached"}],
      unit: :bytes,
      max_x_labels: 8,
      height: 220,
      class: "lui:max-w-2xl"
    )
  end

  # CPU pinned to a 0-100 domain so the line keeps its scale when load is low.
  def cpu_percent
    render LightningUiKit::ChartComponent.new(
      type: :line,
      data: CPU_SERIES,
      series: [{key: :cpu, label: "CPU"}],
      unit: :percent,
      y_min: 0,
      y_max: 100,
      max_x_labels: 6,
      height: 200,
      class: "lui:max-w-2xl"
    )
  end

  # Missing buckets (agent gaps) break the line instead of dipping to zero.
  def gaps
    render LightningUiKit::ChartComponent.new(
      type: :line,
      data: GAPPY,
      series: [{key: :load, label: "Load average"}],
      max_x_labels: 6,
      class: "lui:max-w-xl"
    )
  end

  # The same data with span_gaps:, which bridges the missing buckets.
  def span_gaps
    render LightningUiKit::ChartComponent.new(
      type: :line,
      data: GAPPY,
      series: [{key: :load, label: "Load average"}],
      span_gaps: true,
      max_x_labels: 6,
      class: "lui:max-w-xl"
    )
  end

  # curve: :linear opts out of the default monotone-cubic smoothing.
  def linear_curve
    render LightningUiKit::ChartComponent.new(
      type: :line,
      data: MULTI,
      series: [{key: :desktop, label: "Desktop"}, {key: :mobile, label: "Mobile"}],
      curve: :linear,
      class: "lui:max-w-xl"
    )
  end

  # Bars are measured from zero, so negatives hang below the baseline.
  def diverging_bar
    render LightningUiKit::ChartComponent.new(
      type: :bar,
      data: [
        {label: "Jan", delta: 186},
        {label: "Feb", delta: -92},
        {label: "Mar", delta: 237},
        {label: "Apr", delta: -140},
        {label: "May", delta: 64},
        {label: "Jun", delta: 209}
      ],
      series: [{key: :delta, label: "Net change"}],
      class: "lui:max-w-xl"
    )
  end

  # Escape hatch: any callable formats both ticks and tooltip values.
  def custom_format
    render LightningUiKit::ChartComponent.new(
      type: :bar,
      data: SINGLE,
      y_format: ->(value) { "$#{value.round}" },
      class: "lui:max-w-xl"
    )
  end
end
