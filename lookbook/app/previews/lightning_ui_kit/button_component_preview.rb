class LightningUiKit::ButtonComponentPreview < Lookbook::Preview
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
end
