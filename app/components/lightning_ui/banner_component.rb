# frozen_string_literal: true

class LightningUi::BannerComponent < LightningUi::BaseComponent
  renders_one :footer

  def initialize(title:, type: :info, **options)
    @type = type
    @title = title
    @options = options
  end

  def classes
    type_classes = case @type
    when :error
      "*:data-[slot=header]:bg-red-600/90 *:data-[slot=header]:text-white"
    else
      "*:data-[slot=header]:bg-gray-50"
    end

    merge_classes([default_classes, type_classes, @options[:class]].compact.join(" "))
  end

  def icon
    case @type
    when :error
      "exclamation-triangle"
    else
      "info-circle"
    end
  end

  def default_classes
    "border border-zinc-950/10 rounded-lg overflow-hidden transition-opacity duration-300 ease-out opacity-100"
  end
end
