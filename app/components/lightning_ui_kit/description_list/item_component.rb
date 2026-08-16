class LightningUiKit::DescriptionList::ItemComponent < LightningUiKit::BaseComponent
  LABEL_CLASSES = "lui:col-start-1 lui:min-w-0 lui:break-words lui:border-t lui:border-border-subtle lui:pt-3 lui:text-foreground-muted lui:first:border-none lui:sm:border-t lui:sm:border-border-subtle lui:sm:py-3"
  VALUE_CLASSES = "lui:min-w-0 lui:break-words lui:pt-1 lui:pb-3 lui:text-foreground lui:sm:border-t lui:sm:border-border-subtle lui:sm:py-3 lui:sm:first-of-type:border-none"

  def initialize(label:, value: nil, body: nil, **options)
    @label = label
    @value = value
    @body = body
    @options = options
  end

  def label_classes
    merge_classes([LABEL_CLASSES, @options[:label_class]].compact.join(" "))
  end

  def value_classes
    merge_classes([VALUE_CLASSES, @options[:class]].compact.join(" "))
  end

  def data
    @options[:data] || {}
  end

  def value
    return @value unless @value.nil?
    return content if @body.nil?

    # Blocks that build markup write to the output buffer; blocks that just
    # return a value (an Integer, a Date, ...) leave it empty — keep both.
    returned = nil
    buffer = view_context.with_output_buffer { returned = @body.call }
    buffer.presence || returned
  end
end
