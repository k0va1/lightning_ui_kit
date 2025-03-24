class ButtonComponentPreview < Lookbook::Preview
  def default
    render(LightningUi::ButtonComponent.new) do
      "Press me"
    end
  end

  def link
    render LightningUi::ButtonComponent.new(url: "https://www.google.com") do
      "Press me"
    end
  end

  def disabled
    render LightningUi::ButtonComponent.new(disabled: true) do
      "Press me"
    end
  end

  # @group Styles

  def outline
    render LightningUi::ButtonComponent.new(style: :outline) do
      "Press me"
    end
  end

  def destructive
    render LightningUi::ButtonComponent.new(style: :destructive) do
      "Press me"
    end
  end
  # @endgroup

  # @group Sizes

  def regular
    render LightningUi::ButtonComponent.new do |component|
      "Press me"
    end
  end

  def small
    render LightningUi::ButtonComponent.new(size: :small) do
      "Press me"
    end
  end
  # @endgroup
end
