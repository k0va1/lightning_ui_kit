class ToggleGroupComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::ToggleGroupComponent.new(value: "center") do |group|
      group.with_item(value: "left") { "Left" }
      group.with_item(value: "center") { "Center" }
      group.with_item(value: "right") { "Right" }
    end
  end

  def multiple
    render LightningUiKit::ToggleGroupComponent.new(type: :multiple, variant: :outline, value: ["bold", "italic"]) do |group|
      group.with_item(value: "bold") { "B" }
      group.with_item(value: "italic") { "I" }
      group.with_item(value: "underline") { "U" }
    end
  end
end
