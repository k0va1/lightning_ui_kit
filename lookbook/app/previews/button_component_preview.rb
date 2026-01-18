class ButtonComponentPreview < Lookbook::Preview
  def default
    render(LightningUiKit::ButtonComponent.new) do
      "Press me"
    end
  end

  def link
    render LightningUiKit::ButtonComponent.new(url: "https://www.google.com") do
      "Press me"
    end
  end

  def disabled
    render LightningUiKit::ButtonComponent.new(disabled: true) do
      "Press me"
    end
  end

  # @group Styles

  def outline
    render LightningUiKit::ButtonComponent.new(style: :outline) do
      "Press me"
    end
  end

  def destructive
    render LightningUiKit::ButtonComponent.new(style: :destructive) do
      "Press me"
    end
  end
  # @endgroup

  # @group Sizes

  def regular
    render LightningUiKit::ButtonComponent.new do |component|
      "Press me"
    end
  end

  def small
    render LightningUiKit::ButtonComponent.new(size: :small) do
      "Press me"
    end
  end
  # @endgroup

  # @group Icons

  def with_leading_icon
    render LightningUiKit::ButtonComponent.new(icon: "plus") do
      "Add Item"
    end
  end

  def with_trailing_icon
    render LightningUiKit::ButtonComponent.new(icon: "arrow-right", icon_position: :trailing) do
      "Next"
    end
  end

  def with_solid_icon
    render LightningUiKit::ButtonComponent.new(icon: "check", icon_variant: :solid) do
      "Save"
    end
  end

  def outline_with_icon
    render LightningUiKit::ButtonComponent.new(style: :outline, icon: "pencil") do
      "Edit"
    end
  end

  def destructive_with_icon
    render LightningUiKit::ButtonComponent.new(style: :destructive, icon: "trash") do
      "Delete"
    end
  end

  def icon_only
    render LightningUiKit::ButtonComponent.new(icon: "plus", icon_variant: :solid)
  end
  # @endgroup
end
