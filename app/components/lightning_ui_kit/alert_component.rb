# frozen_string_literal: true

class LightningUiKit::AlertComponent < LightningUiKit::BaseComponent
  def initialize(type: :info, **options)
    @type = type
    @options = options
  end

  def default_classes
    "lui:flex lui:items-center lui:p-4 lui:text-sm lui:text-gray-800 lui:rounded-lg lui:bg-gray-50"
  end

  def classes
    [default_classes, @options[:class]].compact.join(" ")
  end
end
