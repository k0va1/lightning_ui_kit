class ContextMenuComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::ContextMenuComponent.new do |menu|
      menu.with_trigger { "Right-click here" }
      menu.with_item { "Back" }
      menu.with_item { "Forward" }
      menu.with_item { "Reload" }
    end
  end
end
