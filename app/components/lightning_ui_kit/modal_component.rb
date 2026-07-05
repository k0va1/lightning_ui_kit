class LightningUiKit::ModalComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_one :body
  renders_many :actions
  # Alert variant: optional custom confirm action (e.g. a `button_to`/form).
  # When absent a default confirm button is rendered that dispatches `lui-modal:confirm`.
  renders_one :confirm

  VARIANTS = %i[default alert].freeze

  def initialize(id: nil, title: nil, description: nil, open: false, variant: :default,
    confirm_text: "Continue", cancel_text: "Cancel", confirm_style: :default, **options)
    @id = id
    @title = title
    @description = description
    @open = open
    @variant = VARIANTS.include?(variant) ? variant : :default
    @confirm_text = confirm_text
    @cancel_text = cancel_text
    @confirm_style = confirm_style
    @options = options
  end

  attr_reader :confirm_text, :cancel_text

  def alert?
    @variant == :alert
  end

  def dialog_role
    alert? ? "alertdialog" : nil
  end

  def panel_width_class
    alert? ? "lui:sm:max-w-lg" : "lui:sm:max-w-3xl"
  end

  def confirm_button_style
    (@confirm_style == :destructive) ? :destructive : :default
  end

  def panel_closed_class
    "lui:opacity-0 lui:scale-95"
  end

  def overlay_closed_class
    "lui:opacity-0"
  end

  def data
    {
      controller: "lui-modal",
      lui_modal_open_value: @open,
      lui_modal_dismissable_value: !alert?,
      lui_modal_panel_closed_class: panel_closed_class,
      lui_modal_overlay_closed_class: overlay_closed_class
    }.merge(@options[:data] || {})
  end
end
