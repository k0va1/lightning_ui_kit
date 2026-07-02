class LightningUiKit::DatePickerComponent < LightningUiKit::BaseComponent
  def initialize(name:, selected: nil, form: nil, placeholder: "Pick a date", format: "%B %-d, %Y", **options)
    @name = name
    @selected = selected
    @form = form
    @placeholder = placeholder
    @format = format
    @options = options
  end

  attr_reader :placeholder

  def selected?
    !(@selected.nil? || @selected == "")
  end

  def selected_iso
    return nil unless selected?

    @selected.respond_to?(:strftime) ? @selected.strftime("%Y-%m-%d") : @selected.to_s
  end

  def label_text
    return placeholder unless selected?

    date = @selected.respond_to?(:strftime) ? @selected : Date.parse(@selected.to_s)
    date.strftime(@format)
  rescue ArgumentError, TypeError
    selected_iso
  end

  def input_name
    return @name unless @form && @name

    "#{@form.object_name}[#{@name}]"
  end

  def trigger_classes
    muted = selected? ? "" : " lui:text-foreground-muted"
    "lui:inline-flex lui:h-9 lui:w-56 lui:items-center lui:gap-2 lui:rounded-md lui:border lui:border-border lui:bg-surface-input lui:px-3 lui:text-left lui:text-sm lui:text-foreground lui:transition-colors lui:hover:bg-surface-hover lui:focus:outline-focus lui:cursor-pointer#{muted}"
  end

  def panel_classes
    "lui:hidden lui:absolute lui:left-0 lui:top-full lui:z-50 lui:mt-1.5"
  end

  def data
    {
      controller: "lui-date-picker",
      action: "keydown.esc@window->lui-date-picker#close click@window->lui-date-picker#closeOnOutside"
    }.merge(@options[:data] || {})
  end
end
