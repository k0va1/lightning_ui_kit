require "test_helper"

class LightningUiKit::DescriptionListComponentTest < ViewComponent::TestCase
  def test_renders_component
    result = render_inline(LightningUiKit::DescriptionListComponent.new)

    assert_includes result.to_html, "<dl"
  end

  def test_renders_items
    result = render_inline(LightningUiKit::DescriptionListComponent.new) do |dl|
      dl.with_item(label: "Balance", value: "$100.00")
      dl.with_item(label: "Status", value: "Active")
    end

    assert_equal ["Balance", "Status"], result.css("dt").map(&:text).map(&:strip)
    assert_equal ["$100.00", "Active"], result.css("dd").map(&:text).map(&:strip)
  end

  def test_renders_non_string_values
    result = render_inline(LightningUiKit::DescriptionListComponent.new) do |dl|
      dl.with_item(label: "Seats", value: 42)
      dl.with_item(label: "Admin", value: false)
    end

    assert_equal ["42", "false"], result.css("dd").map(&:text).map(&:strip)
  end

  def test_renders_block_content
    result = render_inline(LightningUiKit::DescriptionListComponent.new) do |dl|
      dl.with_item(label: "Owner") { "<em>jane</em>".html_safe }
    end

    assert_equal "jane", result.css("dd em").text
  end

  def test_renders_non_string_block_content
    result = render_inline(LightningUiKit::DescriptionListComponent.new) do |dl|
      dl.with_item(label: "Seats") { 42 }
    end

    assert_equal "42", result.css("dd").text.strip
  end

  def test_values_wrap_instead_of_overflowing
    result = render_inline(LightningUiKit::DescriptionListComponent.new) do |dl|
      dl.with_item(label: "Customer", value: "ctm_01m02bkaayj8qwjjtm4jzab")
    end

    assert_includes result.css("dd").first["class"], "lui:break-words"
    assert_includes result.css("dd").first["class"], "lui:min-w-0"
    assert_includes result.css("dl").first["class"], "minmax(0,auto)"
  end

  def test_merges_custom_classes
    result = render_inline(LightningUiKit::DescriptionListComponent.new(class: "lui:mt-4", data: {controller: "billing"})) do |dl|
      dl.with_item(label: "Customer", value: "ctm_01", class: "lui:font-mono", label_class: "lui:text-destructive")
    end

    assert_includes result.css("dl").first["class"], "lui:mt-4"
    assert_equal "billing", result.css("dl").first["data-controller"]
    assert_includes result.css("dd").first["class"], "lui:font-mono"
    assert_includes result.css("dt").first["class"], "lui:text-destructive"
  end
end
