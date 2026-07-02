class LightningUiKit::SliderComponent < LightningUiKit::BaseComponent
  def initialize(name: nil, min: 0, max: 100, step: 1, value: nil, disabled: false, form: nil, **options)
    @name = name
    @min = min
    @max = max
    @step = step
    @value = value.nil? ? min : value
    @disabled = disabled
    @form = form
    @options = options
  end

  attr_reader :min, :max, :step, :value, :disabled

  def percent
    range = (@max - @min).to_f
    return 0 if range <= 0

    (((@value - @min) / range) * 100).clamp(0, 100)
  end

  def input_name
    return @name unless @form && @name

    "#{@form.object_name}[#{@name}]"
  end

  def classes
    merge_classes([
      "lui:relative lui:flex lui:h-5 lui:w-full lui:touch-none lui:select-none lui:items-center",
      @options[:class]
    ].compact.join(" "))
  end

  def fill_style
    "width: #{formatted_percent}%;"
  end

  def thumb_style
    "left: #{formatted_percent}%;"
  end

  def data
    {
      controller: "lui-slider",
      action: "input->lui-slider#update"
    }.merge(@options[:data] || {})
  end

  private

  def formatted_percent
    p = percent
    (p % 1).zero? ? p.to_i : p.round(2)
  end
end
