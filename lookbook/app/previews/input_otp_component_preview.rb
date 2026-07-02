class InputOtpComponentPreview < Lookbook::Preview
  # @param length number
  def default(length: 6)
    render LightningUiKit::InputOtpComponent.new(name: :code, length: length)
  end

  def prefilled
    render LightningUiKit::InputOtpComponent.new(name: :code, length: 4, value: "12")
  end
end
