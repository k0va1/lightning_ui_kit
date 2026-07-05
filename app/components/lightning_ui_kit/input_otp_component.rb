class LightningUiKit::InputOtpComponent < LightningUiKit::BaseComponent
  def initialize(name:, length: 6, value: "", form: nil, numeric: true, **options)
    @name = name
    @length = length
    @value = value.to_s
    @form = form
    @numeric = numeric
    @options = options
  end

  attr_reader :length, :numeric

  def input_name
    return @name unless @form

    "#{@form.object_name}[#{@name}]"
  end

  def digit_at(index)
    @value[index]
  end

  def classes
    merge_classes([
      "lui:flex lui:items-center lui:gap-2",
      @options[:class]
    ].compact.join(" "))
  end

  def slot_classes
    "lui:size-10 lui:rounded-md lui:border lui:border-border lui:bg-surface-input lui:text-center lui:text-base lui:font-medium lui:text-foreground lui:outline-none lui:transition-colors lui:focus:border-interactive lui:focus:ring-2 lui:focus:ring-focus/40"
  end

  def data
    {
      controller: "lui-otp",
      lui_otp_length_value: @length
    }.merge(@options[:data] || {})
  end
end
