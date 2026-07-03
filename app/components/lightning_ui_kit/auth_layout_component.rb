class LightningUiKit::AuthLayoutComponent < LightningUiKit::BaseComponent
  def initialize(**options)
    @options = options
  end

  def classes
    merge_classes(["lui-page-gradient lui:flex lui:min-h-dvh lui:flex-col lui:bg-surface-page lui:p-2", @options[:class]].compact.join(" "))
  end
end
