# frozen_string_literal: true

class LightningUiKit::ButtonComponent < LightningUiKit::BaseComponent
  def initialize(type: :button, style: :default, size: :default, disabled: false, url: nil, **options)
    @type = type
    @style = style
    @size = size
    @disabled = disabled
    @url = url
    @options = options
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
    "lui:text-white lui:border-red-500 lui:hover:bg-red-600 lui:active:bg-red-700\
      lui:[--btn-bg:var(--lui-color-red-600)]\
      lui:[--btn-border:var(--lui-color-red-950)]/90
      lui:[--btn-hover-overlay:var(--lui-color-white)]/10\
      lui:[--btn-icon:var(--lui-color-red-400)]\
      lui:active:[--btn-icon:var(--lui-color-zinc-300)] lui:hover:[--btn-icon:var(--lui-color-zinc-300)] lui:cursor-pointer"
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
      lui:text-white lui:cursor-pointer\
      lui:[--btn-bg:var(--lui-color-zinc-900)]\
      lui:[--btn-border:var(--lui-color-zinc-950)]/90
      lui:[--btn-hover-overlay:var(--lui-color-white)]/10\
      lui:[--btn-icon:var(--lui-color-zinc-400)]\
      lui:active:[--btn-icon:var(--lui-color-zinc-300)]\
      lui:hover:[--btn-icon:var(--lui-color-zinc-300)]"
  end

  def outline_classes
    "lui:relative lui:isolate lui:inline-flex lui:items-baseline lui:justify-center lui:gap-x-2 lui:rounded-lg lui:border lui:px-[calc(--spacing(3.5)-1px)] lui:py-[calc(--spacing(2.5)-1px)] sm:lui:px-[calc(--spacing(3)-1px)]\
      lui:sm:py-[calc(--spacing(1.5)-1px)] lui:focus:outline-hidden lui:focus:outline lui:focus:outline-2 lui:focus:outline-offset-2\
      lui:focus:outline-blue-500 lui:disabled:opacity-50 lui:*:data-[slot=icon]:-mx-0.5 lui:*:data-[slot=icon]:my-0.5 lui:*:data-[slot=icon]:size-5\
      lui:*:data-[slot=icon]:shrink-0 lui:*:data-[slot=icon]:self-center lui:*:data-[slot=icon]:text-(--btn-icon) lui:sm:*:data-[slot=icon]:my-1\
      lui:sm:*:data-[slot=icon]:size-4 lui:border-zinc-950/10 lui:text-zinc-950 lui:active:bg-zinc-950/[2.5%] lui:hover:bg-zinc-950/[2.5%]\
      lui:[--btn-icon:var(--lui-color-zinc-500)] lui:active:[--btn-icon:var(--lui-color-zinc-700)] lui:hover:[--btn-icon:var(--lui-color-zinc-700)] lui:cursor-pointer"
  end
end
