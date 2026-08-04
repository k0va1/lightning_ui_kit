class LightningUiKit::TableComponent < LightningUiKit::BaseComponent
  renders_many :columns, ->(title, sort_key: nil, align: :left, &block) do
    LightningUiKit::Table::ColumnComponent.new(title, sort_key: sort_key, align: align, &block)
  end
  renders_many :actions, ->(&block) do
    LightningUiKit::Table::ActionComponent.new(&block)
  end
  renders_one :bulk_actions

  def initialize(
    data:,
    selectable: false,
    select_name: "ids[]",
    row_id: :id,
    row_url: nil,
    sort_key: nil,
    sort_direction: nil,
    sort_param: :sort,
    direction_param: :direction,
    selected_label: "selected",
    actions_title: "Actions",
    empty_message: "No data available"
  )
    @data = data
    @selectable = selectable
    @select_name = select_name
    @row_id = row_id
    @row_url = row_url
    @sort_key = sort_key
    @sort_direction = sort_direction
    @sort_param = sort_param
    @direction_param = direction_param
    @selected_label = selected_label
    @actions_title = actions_title
    @empty_message = empty_message
  end

  def selectable?
    @selectable
  end

  def interactive?
    selectable? || !@row_url.nil?
  end

  def row_value(row)
    case @row_id
    when Proc
      @row_id.call(row)
    else
      if row.is_a?(Hash)
        row[@row_id] || row[@row_id.to_s]
      elsif row.respond_to?(@row_id)
        row.public_send(@row_id)
      elsif row.respond_to?(:[])
        row[@row_id] || row[@row_id.to_s]
      end
    end
  end

  def row_url_for(row)
    @row_url&.call(row)
  end

  def sorted_by?(column)
    column.sortable? && column.sort_key.to_s == current_sort_key
  end

  def sort_url(column)
    direction = (sorted_by?(column) && current_sort_direction == "asc") ? "desc" : "asc"
    query = current_query_parameters.merge(
      @sort_param.to_s => column.sort_key.to_s,
      @direction_param.to_s => direction
    )
    "#{current_path}?#{query.to_query}"
  end

  def sort_icon(column)
    return "chevron-up-down" unless sorted_by?(column)

    (current_sort_direction == "desc") ? "chevron-down" : "chevron-up"
  end

  def aria_sort(column)
    return unless sorted_by?(column)

    (current_sort_direction == "desc") ? "descending" : "ascending"
  end

  # Current sort state: the sort/direction request params when present
  # (validated), otherwise the explicit sort_key:/sort_direction: defaults.
  def current_sort_key
    sort_state[0]
  end

  def current_sort_direction
    sort_state[1]
  end

  def colspan
    columns.size + (selectable? ? 1 : 0) + (actions.present? ? 1 : 0)
  end

  def checkbox_input_classes
    <<~CLASSES.squish
      lui:peer lui:size-[1.125rem] lui:shrink-0 lui:cursor-pointer lui:appearance-none
      lui:rounded-[0.3125rem] lui:border lui:border-border-strong lui:bg-surface-input lui:shadow-sm
      lui:hover:border-border-hover lui:sm:size-4
      lui:checked:border-border-invert lui:checked:bg-surface-invert lui:checked:hover:border-border-invert
      lui:indeterminate:border-border-invert lui:indeterminate:bg-surface-invert lui:indeterminate:hover:border-border-invert
      lui:focus-visible:outline lui:focus-visible:outline-2 lui:focus-visible:outline-offset-2 lui:focus-visible:outline-focus
      lui:disabled:cursor-not-allowed lui:disabled:opacity-50
    CLASSES
  end

  def checkbox_icon_classes
    <<~CLASSES.squish
      lui:pointer-events-none lui:absolute lui:inset-0 lui:m-auto lui:size-4
      lui:stroke-foreground-invert lui:opacity-0
      lui:peer-checked:opacity-100 lui:peer-indeterminate:opacity-100 lui:sm:size-3.5
    CLASSES
  end

  private

  def sort_state
    @sort_state ||= begin
      url_key = current_query_parameters[@sort_param.to_s].to_s
      if url_key.empty?
        [@sort_key.to_s, normalize_direction(@sort_direction.to_s)]
      else
        [url_key, normalize_direction(current_query_parameters[@direction_param.to_s].to_s)]
      end
    end
  end

  def normalize_direction(direction)
    LightningUiKit::Sorting::DIRECTIONS.include?(direction) ? direction : "asc"
  end

  def current_query_parameters
    request&.query_parameters || {}
  end

  def current_path
    request&.path || ""
  end
end
