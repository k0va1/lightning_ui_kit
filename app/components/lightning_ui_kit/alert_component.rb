class LightningUiKit::AlertComponent < LightningUiKit::BaseComponent
  def initialize(type: :info, **options)
    @type = type
    @options = options
  end

  def default_classes
    "lui:flex lui:items-center lui:p-4 lui:text-sm lui:text-neutral-text lui:rounded-lg lui:bg-neutral-bg"
  end

  def classes
    [default_classes, @options[:class]].compact.join(" ")
  end
end
