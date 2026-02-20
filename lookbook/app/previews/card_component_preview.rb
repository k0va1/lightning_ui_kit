class CardComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CardComponent.new do |card|
      card.with_title { "Card Title" }
      card.with_description { "Card description with supporting text." }
      tag.p("This is the main card content area. Use cards to group related information together.", class: "lui:text-sm lui:text-foreground-muted")
    end
  end

  def with_header_and_footer
    render LightningUiKit::CardComponent.new do |card|
      card.with_title { "Project Details" }
      card.with_description { "Manage your project configuration." }
      card.with_footer do
        tag.div(class: "lui:flex lui:justify-end lui:gap-3 lui:w-full") do
          safe_join([
            tag.button("Cancel", class: "lui:text-sm lui:text-foreground-muted lui:hover:text-foreground"),
            tag.button("Save", class: "lui:text-sm lui:font-semibold lui:text-foreground")
          ])
        end
      end
      tag.p("Configure your project settings and preferences here.", class: "lui:text-sm lui:text-foreground-muted")
    end
  end

  def with_action
    render LightningUiKit::CardComponent.new do |card|
      card.with_title { "Notifications" }
      card.with_description { "You have 3 unread messages." }
      card.with_action do
        tag.button("View all", class: "lui:text-sm lui:font-medium lui:text-foreground-muted lui:hover:text-foreground")
      end
      tag.p("Your latest notifications will appear here.", class: "lui:text-sm lui:text-foreground-muted")
    end
  end

  def content_only
    render LightningUiKit::CardComponent.new do
      tag.p("A simple card with just content and no header or footer.", class: "lui:text-sm lui:text-foreground-muted")
    end
  end
end
