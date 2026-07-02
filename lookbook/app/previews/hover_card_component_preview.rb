class HoverCardComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::HoverCardComponent.new do |card|
      card.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :outline).with_content("@lightning")
      end
      card.with_body do
        tag.div(class: "lui:flex lui:flex-col lui:gap-1") do
          safe_join([
            tag.h4("@lightning", class: "lui:text-sm lui:font-semibold lui:text-foreground"),
            tag.p("A Ruby UI kit built on ViewComponent, Tailwind, and Stimulus.", class: "lui:text-sm lui:text-foreground-muted"),
            tag.span("Joined December 2024", class: "lui:mt-2 lui:text-xs lui:text-foreground-faint")
          ])
        end
      end
    end
  end
end
