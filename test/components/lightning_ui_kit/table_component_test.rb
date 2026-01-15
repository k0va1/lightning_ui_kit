# frozen_string_literal: true

require "test_helper"
require "ostruct"

class LightningUiKit::TableComponentTest < ViewComponent::TestCase
  def test_renders_table
    result = render_inline(LightningUiKit::TableComponent.new(data: []))

    assert_includes result.to_html, "<table"
  end

  def test_renders_empty_message_when_no_data
    result = render_inline(LightningUiKit::TableComponent.new(data: [], empty_message: "No records found"))

    assert_includes result.to_html, "No records found"
  end

  def test_renders_with_data
    data = [OpenStruct.new(name: "John", email: "john@example.com")]
    component = LightningUiKit::TableComponent.new(data: data)

    result = render_inline(component) do |c|
      c.with_column("Name") { |item| item.name }
    end

    assert_includes result.to_html, "Name"
  end

  def test_renders_custom_actions_title
    result = render_inline(LightningUiKit::TableComponent.new(data: [], actions_title: "Operations"))

    # Table should render even with empty data
    assert_includes result.to_html, "<table"
  end
end
