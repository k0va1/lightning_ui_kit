# frozen_string_literal: true

class LightningUi::AlertComponent < LightningUi::BaseComponent
  def initialize(type: :info, **options)
    @type = type
    @options = options
  end

  def default_classes
    "flex items-center p-4 text-sm text-gray-800 rounded-lg bg-gray-50"
  end

  def classes
    [default_classes, @options[:class]].compact.join(" ")
  end
end
