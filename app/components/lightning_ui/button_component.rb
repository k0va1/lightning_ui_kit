# frozen_string_literal: true

class LightningUi::ButtonComponent < LightningUi::BaseComponent
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
      class_list << "text-xs"
    when :default
      class_list << "text-base/6 font-semibold sm:text-sm/6"
    end

    merge_classes(class_list.compact.join(" "))
  end

  def destructive_classes
    "text-white border-red-500 hover:bg-red-600 active:bg-red-700\
      [--btn-bg:var(--color-red-600)]\
      [--btn-border:var(--color-red-950)]/90
      [--btn-hover-overlay:var(--color-white)]/10\
      [--btn-icon:var(--color-red-400)]\
      active:[--btn-icon:var(--color-zinc-300)] hover:[--btn-icon:var(--color-zinc-300)] cursor-pointer"
  end

  # TODO:
  def default_classes
    "relative isolate rounded-lg border inline-flex items-baseline justify-center gap-x-2 px-4 py-2 sm:px-[calc(--spacing(3)-1px)]\
      sm:py-[calc(--spacing(1.5)-1px)] focus:outline-hidden *:data-[slot=icon]:-mx-0.5 *:data-[slot=icon]:my-0.5\
      *:data-[slot=icon]:size-5 *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:self-center *:data-[slot=icon]:text-(--btn-icon)\
      sm:*:data-[slot=icon]:my-1 sm:*:data-[slot=icon]:size-4 border-transparent bg-(--btn-border) before:absolute before:inset-0\
      before:-z-10 before:rounded-[calc(var(--radius-lg)-1px)] before:bg-(--btn-bg) before:shadow-sm after:absolute after:inset-0
      after:-z-10 after:rounded-[calc(var(--radius-lg)-1px)] after:shadow-[shadow:inset_0_1px_--theme(--color-white/15%)]\
      active:after:bg-(--btn-hover-overlay) hover:after:bg-(--btn-hover-overlay) disabled:before:shadow-none disabled:after:shadow-none\
      text-white\
      [--btn-bg:var(--color-zinc-900)]\
      [--btn-border:var(--color-zinc-950)]/90
      [--btn-hover-overlay:var(--color-white)]/10\
      [--btn-icon:var(--color-zinc-400)]\
      active:[--btn-icon:var(--color-zinc-300)] hover:[--btn-icon:var(--color-zinc-300)] cursor-pointer"
  end

  def outline_classes
    "relative isolate inline-flex items-baseline justify-center gap-x-2 rounded-lg border px-[calc(--spacing(3.5)-1px)] py-[calc(--spacing(2.5)-1px)] sm:px-[calc(--spacing(3)-1px)]\
      sm:py-[calc(--spacing(1.5)-1px)] focus:outline-hidden focus:outline focus:outline-2 focus:outline-offset-2\
      focus:outline-blue-500 disabled:opacity-50 *:data-[slot=icon]:-mx-0.5 *:data-[slot=icon]:my-0.5 *:data-[slot=icon]:size-5\
      *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:self-center *:data-[slot=icon]:text-(--btn-icon) sm:*:data-[slot=icon]:my-1\
      sm:*:data-[slot=icon]:size-4 border-zinc-950/10 text-zinc-950 active:bg-zinc-950/[2.5%] hover:bg-zinc-950/[2.5%]\
      [--btn-icon:var(--color-zinc-500)] active:[--btn-icon:var(--color-zinc-700)] hover:[--btn-icon:var(--color-zinc-700)] cursor-pointer"
  end
end
