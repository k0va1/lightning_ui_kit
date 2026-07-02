class PopoverComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::PopoverComponent.new do |popover|
      popover.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :outline).with_content("Open popover")
      end
      popover.with_body do
        tag.div(class: "lui:flex lui:flex-col lui:gap-2") do
          safe_join([
            tag.h4("Dimensions", class: "lui:text-sm lui:font-semibold lui:text-foreground"),
            tag.p("Set the dimensions for the layer.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
    end
  end

  # @param position select [top, bottom, left, right]
  def positioned(position: "right")
    render LightningUiKit::PopoverComponent.new(position: position) do |popover|
      popover.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :outline).with_content("Open #{position}")
      end
      popover.with_body do
        tag.p("Placed on the #{position}.", class: "lui:text-sm lui:text-foreground")
      end
    end
  end
end
