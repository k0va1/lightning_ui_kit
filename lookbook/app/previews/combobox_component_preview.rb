class ComboboxComponentPreview < Lookbook::Preview
  # @label Default (Single Selection)
  def default
    render LightningUiKit::ComboboxComponent.new(
      name: :country,
      label: "Country",
      description: "Select your country",
      placeholder: "Search countries...",
      options: [
        {value: "us", label: "United States"},
        {value: "uk", label: "United Kingdom"},
        {value: "ca", label: "Canada"},
        {value: "au", label: "Australia"},
        {value: "de", label: "Germany"},
        {value: "fr", label: "France"},
        {value: "jp", label: "Japan"},
        {value: "br", label: "Brazil"},
        {value: "in", label: "India"},
        {value: "mx", label: "Mexico"}
      ]
    )
  end

  # @label With Pre-selected Value
  def preselected
    render LightningUiKit::ComboboxComponent.new(
      name: :status,
      label: "Status",
      placeholder: "Select status...",
      selected: "active",
      options: [
        {value: "active", label: "Active"},
        {value: "inactive", label: "Inactive"},
        {value: "pending", label: "Pending"},
        {value: "archived", label: "Archived"}
      ]
    )
  end

  # @label Multiple Selection
  def multiple
    render LightningUiKit::ComboboxComponent.new(
      name: :tags,
      label: "Tags",
      description: "Select multiple tags",
      placeholder: "Search tags...",
      multiple: true,
      selected: ["ruby", "rails"],
      options: [
        {value: "ruby", label: "Ruby"},
        {value: "rails", label: "Rails"},
        {value: "javascript", label: "JavaScript"},
        {value: "typescript", label: "TypeScript"},
        {value: "python", label: "Python"},
        {value: "go", label: "Go"},
        {value: "rust", label: "Rust"},
        {value: "elixir", label: "Elixir"}
      ]
    )
  end

  # @label Allow Custom Values
  def allow_custom
    render LightningUiKit::ComboboxComponent.new(
      name: :category,
      label: "Category",
      description: "Select or create a category",
      placeholder: "Search or create...",
      allow_custom: true,
      options: [
        {value: "electronics", label: "Electronics"},
        {value: "clothing", label: "Clothing"},
        {value: "books", label: "Books"},
        {value: "home", label: "Home & Garden"},
        {value: "sports", label: "Sports & Outdoors"}
      ]
    )
  end

  # @label Multiple with Custom Values
  def multiple_with_custom
    render LightningUiKit::ComboboxComponent.new(
      name: :skills,
      label: "Skills",
      description: "Select existing or add new skills",
      placeholder: "Search or add skills...",
      multiple: true,
      allow_custom: true,
      options: [
        {value: "ruby", label: "Ruby"},
        {value: "python", label: "Python"},
        {value: "javascript", label: "JavaScript"},
        {value: "sql", label: "SQL"},
        {value: "docker", label: "Docker"}
      ]
    )
  end

  # @label Disabled State
  def disabled
    render LightningUiKit::ComboboxComponent.new(
      name: :status,
      label: "Status",
      disabled: true,
      selected: "active",
      options: [
        {value: "active", label: "Active"},
        {value: "inactive", label: "Inactive"}
      ]
    )
  end

  # @label With Error
  def with_error
    render LightningUiKit::ComboboxComponent.new(
      name: :required_field,
      label: "Required Field",
      placeholder: "Please select...",
      error: "This field is required",
      options: [
        {value: "opt1", label: "Option 1"},
        {value: "opt2", label: "Option 2"},
        {value: "opt3", label: "Option 3"}
      ]
    )
  end

  # @label With Disabled Options
  def with_disabled_options
    render LightningUiKit::ComboboxComponent.new(
      name: :plan,
      label: "Subscription Plan",
      placeholder: "Select a plan...",
      options: [
        {value: "free", label: "Free"},
        {value: "basic", label: "Basic"},
        {value: "pro", label: "Pro (Coming Soon)", disabled: true},
        {value: "enterprise", label: "Enterprise (Coming Soon)", disabled: true}
      ]
    )
  end

  # @label Server-Side Filtering (Demo)
  # @note This preview demonstrates the async filtering UI. In production, configure the `url` parameter to point to your API endpoint.
  def async_filtering
    render LightningUiKit::ComboboxComponent.new(
      name: :user_id,
      label: "User",
      description: "Search for a user (type at least 2 characters)",
      placeholder: "Type to search users...",
      url: "/api/users/search",
      min_chars: 2,
      debounce: 300
    )
  end
end
