class SheetComponentPreview < Lookbook::Preview
  # @param side select [right, left, top, bottom]
  def default(side: "right")
    render LightningUiKit::SheetComponent.new(
      title: "Edit profile",
      description: "Make changes to your profile here. Click save when you're done.",
      side: side.to_sym
    ) do |sheet|
      sheet.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :outline).with_content("Open sheet")
      end
      sheet.with_body do
        tag.div(class: "lui:flex lui:flex-col lui:gap-4 lui:py-4") do
          render LightningUiKit::InputComponent.new(name: :name, label: "Name", value: "Lightning")
        end
      end
      sheet.with_action do
        render LightningUiKit::ButtonComponent.new(data: {action: "click->lui-sheet#close"}).with_content("Save changes")
      end
    end
  end
end
