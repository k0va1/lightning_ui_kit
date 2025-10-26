# frozen_string_literal: true

class LightningUiKit::TooltipComponent < LightningUiKit::BaseComponent
  POSITION_OPTIONS = [:top, :bottom, :left, :right]
  DEFAULT_POSITION = :bottom

  def initialize(text: nil, position: DEFAULT_POSITION, active: true, **options)
    @text = text
    @position = position || DEFAULT_POSITION
    @active = active
    @options = options
  end

  def classes
    merge_classes(["lui:w-full lui:flex lui:justify-center lui:fixed lui:bottom-5", @options[:class]].compact.join(" "))
  end

  def data
    default_data = {
      controller: "lui-tooltip",
      action: "mouseenter->lui-tooltip#show mouseleave->lui-tooltip#hide focus->lui-tooltip#show blur->lui-tooltip#hide"
    }

    default_data.merge(@options[:data] || {})
  end
end
