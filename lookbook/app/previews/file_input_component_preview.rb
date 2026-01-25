class FileInputComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::FileInputComponent.new(
      name: "file",
      label: "Upload a file",
      description: "Select a file to upload",
      accept: "image/*"
    )
  end

  def multiple
    render LightningUiKit::FileInputComponent.new(
      name: "file",
      label: "Upload files",
      description: "Select files to upload",
      multiple: true
    )
  end
end
