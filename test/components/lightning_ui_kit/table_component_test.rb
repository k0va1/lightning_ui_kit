require "test_helper"
require "ostruct"

class LightningUiKit::TableComponentTest < ViewComponent::TestCase
  def sample_data
    [
      OpenStruct.new(id: 1, name: "John", email: "john@example.com"),
      OpenStruct.new(id: 2, name: "Jane", email: "jane@example.com")
    ]
  end

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

  def test_does_not_attach_controller_for_plain_table
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data)) do |table|
      table.with_column("Name") { |row| row.name }
    end

    assert_empty result.css("[data-controller=lui-table]")
    assert_empty result.css("input[type=checkbox]")
  end

  def test_renders_row_checkboxes_when_selectable
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data, selectable: true)) do |table|
      table.with_column("Name") { |row| row.name }
    end

    assert result.css("[data-controller=lui-table]").any?
    checkboxes = result.css("tbody input[type=checkbox]")
    assert_equal 2, checkboxes.size
    assert_equal "ids[]", checkboxes.first["name"]
    assert_equal "1", checkboxes.first["value"]
  end

  def test_renders_custom_select_name_and_row_id
    data = [{"uuid" => "abc-123", "name" => "John"}]
    result = render_inline(LightningUiKit::TableComponent.new(data: data, selectable: true, select_name: "user_ids[]", row_id: "uuid")) do |table|
      table.with_column("Name") { |row| row["name"] }
    end

    checkbox = result.css("tbody input[type=checkbox]").first
    assert_equal "user_ids[]", checkbox["name"]
    assert_equal "abc-123", checkbox["value"]
  end

  def test_renders_select_all_checkbox_in_header
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data, selectable: true)) do |table|
      table.with_column("Name") { |row| row.name }
    end

    assert result.css("thead input[type=checkbox][data-lui-table-target=selectAll]").any?
  end

  def test_renders_bulk_actions_bar
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data, selectable: true)) do |table|
      table.with_column("Name") { |row| row.name }
      table.with_bulk_actions { "Delete selected" }
    end

    bar = result.css("[data-lui-table-target=bulkBar]").first
    assert bar
    assert_includes bar.to_html, "Delete selected"
    assert_includes bar["class"], "lui:hidden"
  end

  def test_does_not_render_bulk_actions_bar_without_selectable
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data)) do |table|
      table.with_column("Name") { |row| row.name }
      table.with_bulk_actions { "Delete selected" }
    end

    assert_empty result.css("[data-lui-table-target=bulkBar]")
  end

  def test_renders_sortable_column_as_link
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data)) do |table|
      table.with_column("Name", sort_key: :name) { |row| row.name }
    end

    link = result.css("thead a").first
    assert link
    assert_includes link["href"], "sort=name"
    assert_includes link["href"], "direction=asc"
  end

  def test_sort_link_toggles_direction_when_active
    component = LightningUiKit::TableComponent.new(data: sample_data, sort_key: "name", sort_direction: "asc")
    result = render_inline(component) do |table|
      table.with_column("Name", sort_key: :name) { |row| row.name }
    end

    link = result.css("thead a").first
    assert_includes link["href"], "direction=desc"
    assert_equal "ascending", result.css("thead th").first["aria-sort"]
  end

  def test_selectable_row_click_toggles_selection
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data, selectable: true)) do |table|
      table.with_column("Name") { |row| row.name }
    end

    row = result.css("tbody tr").first
    assert_includes row["data-action"], "toggleRow"
  end

  def test_row_url_takes_precedence_over_row_click_selection
    component = LightningUiKit::TableComponent.new(data: sample_data, selectable: true, row_url: ->(row) { "/users/#{row.id}" })
    result = render_inline(component) do |table|
      table.with_column("Name") { |row| row.name }
    end

    row = result.css("tbody tr").first
    assert_includes row["data-action"], "visitRow"
    refute_includes row["data-action"], "toggleRow"
  end

  def test_sort_state_read_from_url_params
    vc_test_request.env["QUERY_STRING"] = "sort=name&direction=desc"

    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data)) do |table|
      table.with_column("Name", sort_key: :name) { |row| row.name }
    end

    assert_equal "descending", result.css("thead th").first["aria-sort"]
    assert_includes result.css("thead a").first["href"], "direction=asc"
  end

  def test_url_params_override_explicit_sort_defaults
    vc_test_request.env["QUERY_STRING"] = "sort=email&direction=asc"

    component = LightningUiKit::TableComponent.new(data: sample_data, sort_key: "name", sort_direction: "desc")
    result = render_inline(component) do |table|
      table.with_column("Name", sort_key: :name) { |row| row.name }
      table.with_column("Email", sort_key: :email) { |row| row.email }
    end

    email_th = result.css("thead th")[1]
    assert_equal "ascending", email_th["aria-sort"]
    assert_nil result.css("thead th").first["aria-sort"]
  end

  def test_renders_clickable_rows
    component = LightningUiKit::TableComponent.new(data: sample_data, row_url: ->(row) { "/users/#{row.id}" })
    result = render_inline(component) do |table|
      table.with_column("Name") { |row| row.name }
    end

    assert result.css("[data-controller=lui-table]").any?
    row = result.css("tbody tr").first
    assert_equal "/users/1", row["data-url"]
    assert_includes row["data-action"], "visitRow"
  end

  def test_renders_row_actions
    result = render_inline(LightningUiKit::TableComponent.new(data: sample_data, actions_title: "Operations")) do |table|
      table.with_column("Name") { |row| row.name }
      table.with_action { |row| "Edit #{row.name}" }
    end

    assert_includes result.to_html, "Operations"
    assert_includes result.to_html, "Edit John"
  end

  def test_empty_state_colspan_accounts_for_selection_and_actions
    result = render_inline(LightningUiKit::TableComponent.new(data: [], selectable: true)) do |table|
      table.with_column("Name") { |row| row.name }
      table.with_column("Email") { |row| row.email }
      table.with_action { |row| "Edit" }
    end

    assert_equal "4", result.css("tbody td").first["colspan"]
  end
end
