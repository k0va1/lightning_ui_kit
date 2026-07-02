class CollapsibleComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::CollapsibleComponent.new(class: "lui:max-w-sm") do |collapsible|
      collapsible.with_trigger do
        tag.div(class: "lui:flex lui:items-center lui:justify-between lui:gap-4 lui:rounded-md lui:px-1") do
          safe_join([
            tag.span("@lightning starred 3 repositories", class: "lui:text-sm lui:font-semibold lui:text-foreground"),
            tag.span("Toggle", class: "lui:text-sm lui:text-foreground-muted")
          ])
        end
      end
      collapsible.with_body do
        tag.div(class: "lui:mt-2 lui:flex lui:flex-col lui:gap-2") do
          safe_join([
            tag.div("@lightning/ui-kit", class: "lui:rounded-md lui:border lui:border-border lui:px-4 lui:py-2 lui:text-sm lui:text-foreground"),
            tag.div("@lightning/stimulus", class: "lui:rounded-md lui:border lui:border-border lui:px-4 lui:py-2 lui:text-sm lui:text-foreground")
          ])
        end
      end
    end
  end

  def open_by_default
    render LightningUiKit::CollapsibleComponent.new(open: true, class: "lui:max-w-sm") do |collapsible|
      collapsible.with_trigger do
        tag.span("Click to collapse", class: "lui:text-sm lui:font-semibold lui:text-foreground")
      end
      collapsible.with_body do
        tag.p("This content is visible on load because `open: true` was passed.", class: "lui:mt-2 lui:text-sm lui:text-foreground-muted")
      end
    end
  end
end
