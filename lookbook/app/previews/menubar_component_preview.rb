class MenubarComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::MenubarComponent.new do |menubar|
      menubar.with_menu(title: "File") do |menu|
        menu.with_item { "New Tab" }
        menu.with_item { "New Window" }
        menu.with_item { "Print" }
      end
      menubar.with_menu(title: "Edit") do |menu|
        menu.with_item { "Undo" }
        menu.with_item { "Redo" }
        menu.with_item { "Cut" }
      end
      menubar.with_menu(title: "View") do |menu|
        menu.with_item { "Reload" }
        menu.with_item { "Toggle Fullscreen" }
      end
    end
  end
end
