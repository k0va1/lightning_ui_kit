class CommandComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CommandComponent.new(class: "lui:max-w-md") do |command|
      command.with_item(value: "calendar") { "📅 Calendar" }
      command.with_item(value: "search") { "🔍 Search Emoji" }
      command.with_item(value: "calculator") { "🧮 Calculator" }
      command.with_item(value: "profile") { "👤 Profile" }
      command.with_item(value: "settings") { "⚙️ Settings" }
    end
  end
end
