class InputComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::InputComponent.new(
      name: :text,
      label: "Text",
      description: "Enter some text"
    )
  end

  def email
    render LightningUiKit::InputComponent.new(
      name: :email,
      type: :email,
      label: "Email",
      description: "Enter your email address",
      placeholder: "you@example.com"
    )
  end

  def password
    render LightningUiKit::InputComponent.new(
      name: :password,
      type: :password,
      label: "Password",
      description: "Enter your password"
    )
  end

  def number
    render LightningUiKit::InputComponent.new(
      name: :quantity,
      type: :number,
      label: "Quantity",
      description: "Enter a number",
      min: 0,
      max: 100,
      step: 1
    )
  end

  def date
    render LightningUiKit::InputComponent.new(
      name: :birthday,
      type: :date,
      label: "Birthday",
      description: "Select your date of birth"
    )
  end

  def datetime
    render LightningUiKit::InputComponent.new(
      name: :scheduled_at,
      type: :datetime,
      label: "Scheduled At",
      description: "Select date and time"
    )
  end

  def month
    render LightningUiKit::InputComponent.new(
      name: :birth_month,
      type: :month,
      label: "Birth Month",
      description: "Select a month"
    )
  end

  def week
    render LightningUiKit::InputComponent.new(
      name: :week_number,
      type: :week,
      label: "Week",
      description: "Select a week"
    )
  end

  def time
    render LightningUiKit::InputComponent.new(
      name: :start_time,
      type: :time,
      label: "Start Time",
      description: "Select a time"
    )
  end

  def url
    render LightningUiKit::InputComponent.new(
      name: :website,
      type: :url,
      label: "Website",
      description: "Enter your website URL",
      placeholder: "https://example.com"
    )
  end

  def search
    render LightningUiKit::InputComponent.new(
      name: :query,
      type: :search,
      label: "Search",
      description: "Search for something",
      placeholder: "Type to search..."
    )
  end

  def telephone
    render LightningUiKit::InputComponent.new(
      name: :phone,
      type: :telephone,
      label: "Phone Number",
      description: "Enter your phone number",
      placeholder: "+1 (555) 123-4567"
    )
  end

  def range
    render LightningUiKit::InputComponent.new(
      name: :volume,
      type: :range,
      label: "Volume",
      description: "Adjust the volume",
      min: 0,
      max: 100,
      step: 10
    )
  end
end
