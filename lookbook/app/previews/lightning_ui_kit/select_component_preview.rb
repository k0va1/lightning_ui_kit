class LightningUiKit::SelectComponentPreview < Lookbook::Preview
  include ActionView::Helpers::FormOptionsHelper

  def default
    render LightningUiKit::SelectComponent.new(
      name: :user_type,
      label: "User type",
      description: "Select the user type",
      options_for_select: options_for_select(["customer", "admin", "manager"].map { |t| [t.humanize, t] })
    )
  end
end
