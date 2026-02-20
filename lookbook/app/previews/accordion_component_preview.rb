class AccordionComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::AccordionComponent.new do |accordion|
      accordion.with_item(title: "What is LightningUiKit?") do
        "LightningUiKit is a production-ready component library for Rails applications, built on ViewComponent with Tailwind CSS styling."
      end
      accordion.with_item(title: "How do I install it?") do
        "Add the gem to your Gemfile and run bundle install. Then include the stylesheet and JavaScript tags in your layout."
      end
      accordion.with_item(title: "Does it support dark mode?") do
        "Yes! Add the lui-theme-dark class to any container element to enable dark mode. All components use semantic design tokens that adapt automatically."
      end
    end
  end

  def all_closed
    render LightningUiKit::AccordionComponent.new(open_first: false) do |accordion|
      accordion.with_item(title: "Section 1") do
        "Content for the first section."
      end
      accordion.with_item(title: "Section 2") do
        "Content for the second section."
      end
      accordion.with_item(title: "Section 3") do
        "Content for the third section."
      end
    end
  end
end
