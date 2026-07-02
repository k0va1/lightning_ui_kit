class NavigationMenuComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::NavigationMenuComponent.new do |nav|
      nav.with_item(title: "Getting started") do
        tag.div(class: "lui:flex lui:w-64 lui:flex-col lui:gap-1") do
          safe_join([
            link_row("Introduction", "What the kit is and how to install it."),
            link_row("Installation", "Add the gem and mount the assets.")
          ])
        end
      end
      nav.with_item(title: "Components") do
        tag.div(class: "lui:flex lui:w-64 lui:flex-col lui:gap-1") do
          safe_join([
            link_row("Overview", "Browse every component."),
            link_row("Theming", "Customize tokens and dark mode.")
          ])
        end
      end
      nav.with_item(title: "Docs", href: "#")
    end
  end

  private

  def link_row(title, description)
    tag.a(href: "#", class: "lui:block lui:rounded-md lui:p-2 lui:hover:bg-surface-hover") do
      safe_join([
        tag.div(title, class: "lui:text-sm lui:font-medium lui:text-foreground"),
        tag.div(description, class: "lui:text-sm lui:text-foreground-muted")
      ])
    end
  end
end
