# frozen_string_literal: true

class LightningUiKit::DropdownComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_many :items

  def initialize(trigger_text: nil, anchor: :bottom_right, position: :bottom)
    @trigger_text = trigger_text
    @anchor = anchor
    @position = position
  end

  def menu_classes
    classes = %w[hidden transition transform p-1 origin-top-left absolute left-0 w-56 rounded-md shadow-lg bg-white ring-1 ring-zinc-950/10 focus:outline-none]
    case @position.to_s
    when "top"
      classes << "mb-2 top-auto bottom-full"
    when "bottom"
      classes << "mt-2"
    end
    classes.join(" ")
  end
end
