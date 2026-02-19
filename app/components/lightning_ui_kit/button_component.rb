class LightningUiKit::ButtonComponent < LightningUiKit::BaseComponent
  def initialize(type: :button, style: :default, size: :default, disabled: false, url: nil, icon: nil, icon_position: :leading, icon_variant: :outline, **options)
    @type = type
    @style = style
    @size = size
    @disabled = disabled
    @url = url
    @icon = icon
    @icon_position = icon_position
    @icon_variant = icon_variant
    @options = options
  end

  def render_icon
    return unless @icon

    heroicon(@icon, variant: @icon_variant, options: {class: icon_classes, data: {slot: "icon"}})
  end

  def icon_classes
    "lui:shrink-0"
  end

  def leading_icon?
    @icon && @icon_position == :leading
  end

  def trailing_icon?
    @icon && @icon_position == :trailing
  end

  def data_attributes
    @options[:data] || {}
  end

  def classes
    class_list = []
    class_list << @options[:class]

    case @style
    when :outline
      class_list << outline_classes
    when :destructive
      class_list << default_classes
      class_list << destructive_classes
    else
      class_list << default_classes
    end

    case @size
    when :small
      class_list << "lui:text-xs"
    when :default
      class_list << "lui:text-base/6 lui:font-semibold lui:sm:text-sm/6"
    end

    merge_classes(class_list.compact.join(" "))
  end

  def destructive_classes
    "lui:text-foreground-invert lui:border-destructive-border lui:hover:bg-destructive lui:active:bg-destructive\
      lui:[--btn-bg:var(--lui-theme-destructive)]\
      lui:[--btn-border:var(--lui-theme-destructive-border)]
      lui:[--btn-hover-overlay:var(--lui-theme-foreground-invert)]/10\
      lui:[--btn-icon:var(--lui-theme-foreground-invert)]\
      lui:active:[--btn-icon:var(--lui-theme-foreground-invert)] lui:hover:[--btn-icon:var(--lui-theme-foreground-invert)] lui:cursor-pointer"
  end

  def default_classes
    "lui:relative lui:isolate lui:rounded-lg lui:border lui:inline-flex lui:items-baseline lui:justify-center lui:gap-x-2 lui:px-4 lui:py-2 lui:sm:px-[calc(--spacing(3)-1px)]\
      lui:sm:py-[calc(--spacing(1.5)-1px)] lui:focus:outline-hidden lui:*:data-[slot=icon]:-mx-0.5 lui:*:data-[slot=icon]:my-0.5\
      lui:*:data-[slot=icon]:size-5 lui:*:data-[slot=icon]:shrink-0 lui:*:data-[slot=icon]:self-center lui:*:data-[slot=icon]:text-(--btn-icon)\
      lui:sm:*:data-[slot=icon]:my-1 lui:sm:*:data-[slot=icon]:size-4 lui:border-transparent lui:bg-(--btn-border) lui:before:absolute lui:before:inset-0\
      lui:before:-z-10 lui:before:rounded-[calc(var(--lui-radius-lg)-1px)] lui:before:bg-(--btn-bg) lui:before:shadow-sm lui:after:absolute lui:after:inset-0
      lui:after:-z-10 lui:after:rounded-[calc(var(--lui-radius-lg)-1px)] lui:after:shadow-[shadow:inset_0_1px_--theme(--color-white/15%)]\
      lui:active:after:bg-(--btn-hover-overlay) lui:hover:after:bg-(--btn-hover-overlay)\
      lui:disabled:opacity-50 lui:disabled:before:shadow-none lui:disabled:after:shadow-none lui:disabled:hover:after:bg-transparent\
      lui:text-foreground-invert lui:cursor-pointer\
      lui:[--btn-bg:var(--lui-theme-surface-invert)]\
      lui:[--btn-border:var(--lui-theme-border-invert)]
      lui:[--btn-hover-overlay:var(--lui-theme-foreground-invert)]/10\
      lui:[--btn-icon:var(--lui-theme-foreground-faint)]\
      lui:active:[--btn-icon:var(--lui-theme-foreground-muted)]\
      lui:hover:[--btn-icon:var(--lui-theme-foreground-muted)]"
  end

  def outline_classes
    "lui:relative lui:isolate lui:inline-flex lui:items-baseline lui:justify-center lui:gap-x-2 lui:rounded-lg lui:border lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] sm:lui:px-[calc(--spacing(3)-1px)]\
      lui:sm:py-[calc(--spacing(1.5)-1px)] lui:focus:outline-hidden lui:focus:outline lui:focus:outline-2 lui:focus:outline-offset-2\
      lui:focus:outline-focus lui:disabled:opacity-50 lui:*:data-[slot=icon]:-mx-0.5 lui:*:data-[slot=icon]:my-0.5 lui:*:data-[slot=icon]:size-5\
      lui:*:data-[slot=icon]:shrink-0 lui:*:data-[slot=icon]:self-center lui:*:data-[slot=icon]:text-(--btn-icon) lui:sm:*:data-[slot=icon]:my-1\
      lui:sm:*:data-[slot=icon]:size-4 lui:border-border lui:text-foreground lui:active:bg-surface-hover lui:hover:bg-surface-hover\
      lui:[--btn-icon:var(--lui-theme-foreground-muted)] lui:active:[--btn-icon:var(--lui-theme-foreground-secondary)] lui:hover:[--btn-icon:var(--lui-theme-foreground-secondary)] lui:cursor-pointer"
  end
end
