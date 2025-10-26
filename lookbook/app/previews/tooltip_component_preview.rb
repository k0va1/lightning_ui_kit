class TooltipComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::TooltipComponent.new(text: "This is a tooltip") do
      "Hover over me"
    end
  end

  def long_text
    render LightningUiKit::TooltipComponent.new(text: "This is a much longer tooltip text that demonstrates how the tooltip handles longer content with proper wrapping and maximum width constraints. It should display nicely within the configured width limits.") do
      "Hover for long tooltip"
    end
  end

  # @group Positions
  def bottom
    render LightningUiKit::TooltipComponent.new(text: "This tooltip appears at the bottom", position: :bottom) do
      "Hover over me"
    end
  end

  def top
    render LightningUiKit::TooltipComponent.new(text: "This tooltip appears at the top", position: :top) do
      "Hover over me"
    end
  end

  def right
    render LightningUiKit::TooltipComponent.new(text: "This tooltip appears to the right", position: :right) do
      "Hover over me"
    end
  end

  def left
    render LightningUiKit::TooltipComponent.new(text: "This tooltip appears to the left", position: :left) do
      "Hover over me"
    end
  end
  # @endgroup

  # @group Advanced
  def with_delay
    render LightningUiKit::TooltipComponent.new(
      text: "This tooltip has a 500ms delay before showing",
      data: {"lui-tooltip-delay-value" => 500}
    ) do
      "Hover with delay"
    end
  end

  def custom_offset
    render LightningUiKit::TooltipComponent.new(
      text: "This tooltip has custom spacing from the trigger element",
      data: {"lui-tooltip-offset-value" => 16}
    ) do
      "Hover with custom offset"
    end
  end

  def inline_text
  end

  def multiple_inline
  end
  # @endgroup
end
