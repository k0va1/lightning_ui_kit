class JsonbComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::JsonbComponent.new(
      name: :metadata,
      label: "Metadata",
      description: "Add key-value pairs"
    )
  end

  def with_object_value
    render LightningUiKit::JsonbComponent.new(
      name: :settings,
      label: "Settings",
      description: "Edit configuration values",
      value: {name: "John Doe", city: "New York", role: "Admin"}
    )
  end

  def with_array_value
    render LightningUiKit::JsonbComponent.new(
      name: :tags,
      label: "Tags",
      description: "Manage your tags",
      value: ["ruby", "rails", "javascript", "tailwind"]
    )
  end

  def disabled
    render LightningUiKit::JsonbComponent.new(
      name: :config,
      label: "Configuration",
      description: "These settings are locked",
      value: {theme: "dark", language: "en"},
      disabled: true
    )
  end
end
