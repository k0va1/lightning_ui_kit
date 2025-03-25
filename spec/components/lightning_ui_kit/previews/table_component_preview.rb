class TableComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper

  def default
    data = [
      {"username" => "John Doe", "group_type" => "Public", "total_members" => 10},
      {"username" => "Jane Doe", "group_type" => "Private", "total_members" => 20}
    ]

    render LightningUiKit::TableComponent.new(data:) do |table|
      table.with_column("Name") { |user| user["username"] }
      table.with_column("Group Type") { |user| user["group_type"] }
      table.with_column("Total members") { |user| user["total_members"].to_s }
      table.with_action do |user|
        link_to("Edit", "#")
      end
    end
  end
end
