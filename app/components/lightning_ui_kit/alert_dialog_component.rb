class LightningUiKit::AlertDialogComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body
  # Optional custom confirm action (e.g. a `button_to`/form). When absent a
  # default confirm button is rendered that dispatches `lui-alert-dialog:confirm`.
  renders_one :confirm

  def initialize(title:, id: nil, description: nil, confirm_text: "Continue", cancel_text: "Cancel", confirm_style: :default, **options)
    @id = id
    @title = title
    @description = description
    @confirm_text = confirm_text
    @cancel_text = cancel_text
    @confirm_style = confirm_style
    @options = options
  end

  attr_reader :title, :description, :confirm_text, :cancel_text

  def panel_closed_class
    "lui:opacity-0 lui:scale-95"
  end

  def overlay_closed_class
    "lui:opacity-0"
  end

  def confirm_button_classes
    base = "lui:inline-flex lui:items-center lui:justify-center lui:rounded-lg lui:px-3.5 lui:py-2 lui:text-sm lui:font-semibold lui:transition-colors lui:focus:outline-focus lui:cursor-pointer"
    style =
      if @confirm_style == :destructive
        "lui:bg-destructive lui:text-foreground-invert lui:hover:bg-destructive/90"
      else
        "lui:bg-interactive lui:text-foreground-invert lui:hover:bg-interactive/90"
      end
    "#{base} #{style}"
  end

  def cancel_button_classes
    "lui:inline-flex lui:items-center lui:justify-center lui:rounded-lg lui:border lui:border-border lui:bg-surface lui:px-3.5 lui:py-2 lui:text-sm lui:font-semibold lui:text-foreground lui:transition-colors lui:hover:bg-surface-hover lui:focus:outline-focus lui:cursor-pointer"
  end

  def data
    {controller: "lui-alert-dialog"}.merge(@options[:data] || {})
  end
end
