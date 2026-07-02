class AlertDialogComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::AlertDialogComponent.new(
      title: "Are you absolutely sure?",
      description: "This action cannot be undone. This will permanently delete your account and remove your data from our servers."
    ) do |dialog|
      dialog.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :outline).with_content("Show dialog")
      end
    end
  end

  def destructive
    render LightningUiKit::AlertDialogComponent.new(
      title: "Delete project?",
      description: "This permanently removes the project and all of its contents.",
      confirm_text: "Delete",
      confirm_style: :destructive
    ) do |dialog|
      dialog.with_trigger do
        render LightningUiKit::ButtonComponent.new(style: :destructive).with_content("Delete project")
      end
    end
  end
end
