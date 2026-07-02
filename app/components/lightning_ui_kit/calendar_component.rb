class LightningUiKit::CalendarComponent < LightningUiKit::BaseComponent
  def initialize(name: nil, selected: nil, month: nil, form: nil, **options)
    @name = name
    @selected = selected
    @month = month
    @form = form
    @options = options
  end

  def selected_iso
    return nil if @selected.nil? || @selected == ""

    @selected.respond_to?(:strftime) ? @selected.strftime("%Y-%m-%d") : @selected.to_s
  end

  def initial_month
    return @month if @month

    iso = selected_iso
    iso ? iso[0, 7] : nil
  end

  def input_name
    return @name unless @form && @name

    "#{@form.object_name}[#{@name}]"
  end

  def classes
    merge_classes([
      "lui:inline-block lui:w-fit lui:rounded-lg lui:border lui:border-border lui:bg-surface lui:p-3 lui:text-foreground",
      @options[:class]
    ].compact.join(" "))
  end

  def nav_button_classes
    "lui:inline-flex lui:size-7 lui:items-center lui:justify-center lui:rounded-md lui:text-foreground-muted lui:transition-colors lui:hover:bg-surface-hover lui:hover:text-foreground lui:cursor-pointer"
  end

  def data
    {
      controller: "lui-calendar",
      lui_calendar_selected_value: selected_iso,
      lui_calendar_month_value: initial_month
    }.compact.merge(@options[:data] || {})
  end
end
