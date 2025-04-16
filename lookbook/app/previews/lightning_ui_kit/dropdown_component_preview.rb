class LightningUiKit::DropdownComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::DropdownComponent.new do |dropdown|
      dropdown.with_trigger do
        "Open dropdown"
      end
      dropdown.with_item do
        "Item 1"
      end
      dropdown.with_item do
        "Item 2"
      end
      dropdown.with_item do
        "Item 3"
      end
    end
  end
end
