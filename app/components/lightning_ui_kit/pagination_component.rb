class LightningUiKit::PaginationComponent < LightningUiKit::BaseComponent
  def initialize(current_page:, total_pages:, path:, page_param: "page", with_arrows: false, **options)
    @current_page = current_page
    @total_pages = total_pages
    @with_arrows = with_arrows
    @path = path
    @page_param = page_param
    @options = options
  end

  def data(disabled: false, active: false)
    {}.tap do |data|
      data[:disabled] = true if disabled
      data[:active] = true if active
    end
  end

  def link_classes
    "lui:min-w-[2.25rem] lui:flex lui:items-center lui:justify-center lui:rounded-lg lui:border lui:text-base/6 lui:font-semibold lui:px-[calc(--spacing(3.5)-1px)] \
     lui:py-[calc(--spacing(2.5)-1px)] lui:sm:px-[calc(--spacing(3)-1px)] lui:sm:py-[calc(--spacing(1.5)-1px)] lui:sm:text-sm/6 \
     lui:focus:outline-hidden lui:focus:outline lui:focus:outline-2 lui:focus:outline-offset-2 lui:focus:outline-focus \
     lui:data-[disabled]:opacity-50 lui:data-[disabled]:pointer-events-none lui:border-transparent lui:text-foreground \
     lui:data-[active]:bg-surface-hover lui:hover:bg-surface-hover"
  end

  def arrow_link_classes
    "lui:min-w-[2.25rem] lui:aspect-square lui:flex lui:items-center lui:justify-center lui:rounded-lg lui:border \
     lui:focus:outline-hidden lui:focus:outline lui:focus:outline-2 lui:focus:outline-offset-2 lui:focus:outline-focus \
     lui:data-[disabled]:opacity-50 lui:data-[disabled]:pointer-events-none lui:border-transparent lui:text-foreground \
     lui:hover:bg-surface-hover"
  end

  def pages_with_gaps
    return (1..@total_pages).to_a if @total_pages <= 7

    (1..@total_pages).to_a.each_with_object([]) do |page, pages|
      if page == 1 || page == @total_pages || page == @current_page || (page - @current_page).abs <= 2
        pages << page
      elsif pages.last != :gap
        pages << :gap
      end
    end
  end

  def url(page)
    "#{@path}?#{@page_param}=#{page}"
  end
end
