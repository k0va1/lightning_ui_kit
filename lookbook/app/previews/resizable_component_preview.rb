class ResizableComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::ResizableComponent.new(class: "lui:h-48 lui:max-w-2xl") do |resizable|
      resizable.with_panel_one do
        tag.div("One", class: "lui:flex lui:h-full lui:items-center lui:justify-center lui:p-6 lui:text-sm lui:font-medium lui:text-foreground")
      end
      resizable.with_panel_two do
        tag.div("Two", class: "lui:flex lui:h-full lui:items-center lui:justify-center lui:p-6 lui:text-sm lui:font-medium lui:text-foreground")
      end
    end
  end

  def vertical
    render LightningUiKit::ResizableComponent.new(direction: :vertical, class: "lui:h-72 lui:max-w-md") do |resizable|
      resizable.with_panel_one do
        tag.div("Header", class: "lui:flex lui:h-full lui:items-center lui:justify-center lui:p-6 lui:text-sm lui:font-medium lui:text-foreground")
      end
      resizable.with_panel_two do
        tag.div("Content", class: "lui:flex lui:h-full lui:items-center lui:justify-center lui:p-6 lui:text-sm lui:font-medium lui:text-foreground")
      end
    end
  end
end
