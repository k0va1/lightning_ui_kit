class BreadcrumbComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::BreadcrumbComponent.new do |breadcrumb|
      breadcrumb.with_item(href: "/") { "Home" }
      breadcrumb.with_item(href: "/components") { "Components" }
      breadcrumb.with_item(current: true) { "Breadcrumb" }
    end
  end

  def with_slash_separator
    render LightningUiKit::BreadcrumbComponent.new(separator: "slash") do |breadcrumb|
      breadcrumb.with_item(href: "/") { "Docs" }
      breadcrumb.with_item(href: "/building") { "Building" }
      breadcrumb.with_item(current: true) { "Data Fetching" }
    end
  end
end
