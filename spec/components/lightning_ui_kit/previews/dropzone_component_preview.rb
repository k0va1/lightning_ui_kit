# frozen_string_literal: true

class DropzoneComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::DropzoneComponent.new(
      name: "file",
      label: "Upload a file",
      description: "Select a file to upload",
      placeholder: "PNG, JPG or PDF, smaller than 15MB"
    )
  end

  def multiple
    render LightningUiKit::DropzoneComponent.new(
      name: "file",
      label: "Upload files",
      description: "Select files to upload",
      placeholder: "PNG, JPG or PDF, smaller than 15MB",
      multiple: true
    )
  end
end
