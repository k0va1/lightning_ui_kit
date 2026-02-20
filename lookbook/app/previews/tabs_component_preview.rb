class TabsComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::TabsComponent.new do |tabs|
      tabs.with_tab(title: "Overview") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Project Overview", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("This is the overview content for your project. It provides a high-level summary of the key details.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
      tabs.with_tab(title: "Settings") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Settings", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("Configure your project settings here. Adjust preferences, notifications, and more.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
      tabs.with_tab(title: "Members") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Team Members", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("Manage team members and their roles within the project.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
    end
  end

  def line_variant
    render LightningUiKit::TabsComponent.new(variant: :line) do |tabs|
      tabs.with_tab(title: "Overview") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Project Overview", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("Line-style tabs with an underline indicator on the active tab.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
      tabs.with_tab(title: "Settings") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Settings", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("Configure your project settings here.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
      tabs.with_tab(title: "Members") do
        tag.div(class: "lui:space-y-2 lui:pt-2") do
          safe_join([
            tag.h3("Team Members", class: "lui:text-lg lui:font-semibold lui:text-foreground"),
            tag.p("Manage team members and their roles.", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
    end
  end

  def second_tab_active
    render LightningUiKit::TabsComponent.new(default_tab: 1) do |tabs|
      tabs.with_tab(title: "Tab 1") do
        tag.p("First tab content", class: "lui:text-sm lui:text-foreground-muted lui:pt-2")
      end
      tabs.with_tab(title: "Tab 2") do
        tag.p("Second tab content — this one is active by default.", class: "lui:text-sm lui:text-foreground-muted lui:pt-2")
      end
      tabs.with_tab(title: "Tab 3") do
        tag.p("Third tab content", class: "lui:text-sm lui:text-foreground-muted lui:pt-2")
      end
    end
  end
end
