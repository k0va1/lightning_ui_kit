require "test_helper"

class LightningUiKit::AccordionComponentTest < ViewComponent::TestCase
  def test_renders_accordion
    result = render_inline(LightningUiKit::AccordionComponent.new) do |accordion|
      accordion.with_item(title: "Section 1") { "Content 1" }
      accordion.with_item(title: "Section 2") { "Content 2" }
    end

    assert_includes result.to_html, "lui-accordion"
    assert_includes result.to_html, "Section 1"
    assert_includes result.to_html, "Section 2"
  end

  def test_renders_item_content
    result = render_inline(LightningUiKit::AccordionComponent.new) do |accordion|
      accordion.with_item(title: "Title") { "Item content" }
    end

    assert_includes result.to_html, "Item content"
  end

  def test_renders_with_open_first_value
    result = render_inline(LightningUiKit::AccordionComponent.new(open_first: false)) do |accordion|
      accordion.with_item(title: "Section") { "Content" }
    end

    assert_includes result.to_html, 'data-lui-accordion-open-first-value="false"'
  end

  def test_renders_accordion_targets
    result = render_inline(LightningUiKit::AccordionComponent.new) do |accordion|
      accordion.with_item(title: "Section") { "Content" }
    end

    assert_includes result.to_html, 'data-lui-accordion-target="item"'
    assert_includes result.to_html, 'data-lui-accordion-target="content"'
    assert_includes result.to_html, 'data-lui-accordion-target="arrow"'
  end
end
