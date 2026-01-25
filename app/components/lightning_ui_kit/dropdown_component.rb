class LightningUiKit::DropdownComponent < LightningUiKit::BaseComponent
  renders_one :trigger
  renders_many :items

  def initialize(trigger_text: nil, anchor: :bottom_right, position: :bottom)
    @trigger_text = trigger_text
    @anchor = anchor
    @position = position
  end

  def menu_classes
    classes = %w[lui:hidden lui:transition lui:transform lui:p-1 lui:origin-top-left lui:absolute lui:left-0 lui:rounded-md lui:shadow-lg lui:bg-white lui:ring-1 lui:ring-zinc-950/10 lui:focus:outline-none lui:z-50]
    case @position.to_s
    when "top"
      classes << "lui:mb-2 lui:top-auto lui:bottom-full"
    when "bottom"
      classes << "lui:mt-2"
    end
    classes.join(" ")
  end
end
