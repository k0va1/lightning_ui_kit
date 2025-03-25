class PaginationComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::PaginationComponent.new(
      current_page: 5,
      total_pages: 20,
      total_count: 100,
      path: "/tasks"
    )
  end

  def with_arrows
    render LightningUiKit::PaginationComponent.new(
      current_page: 6,
      total_pages: 10,
      with_arrows: true,
      page_param: "p",
      path: "/tasks"
    )
  end
end
