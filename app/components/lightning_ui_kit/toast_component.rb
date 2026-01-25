class LightningUiKit::ToastComponent < LightningUiKit::BaseComponent
  def initialize(autodismiss: true, dismiss_after: 3000, **options)
    @autodismiss = autodismiss
    @dismiss_after = dismiss_after
    @options = options
  end

  def classes
    merge_classes(["lui:w-full lui:flex lui:justify-center lui:fixed lui:bottom-5", @options[:class]].compact.join(" "))
  end
end
