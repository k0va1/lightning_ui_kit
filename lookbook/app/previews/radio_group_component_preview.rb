class RadioGroupComponentPreview < Lookbook::Preview
  def default
    render LightningUiKit::RadioGroupComponent.new(name: :plan, label: "Plan", selected: "pro") do |group|
      group.with_option(value: "free", label: "Free", description: "Up to 5 projects")
      group.with_option(value: "pro", label: "Pro", description: "Unlimited projects, priority support")
      group.with_option(value: "enterprise", label: "Enterprise", description: "Custom limits, dedicated support")
    end
  end

  def with_description
    render LightningUiKit::RadioGroupComponent.new(
      name: :notification,
      label: "Notification preference",
      description: "How would you like to be notified?",
      selected: "email"
    ) do |group|
      group.with_option(value: "email", label: "Email")
      group.with_option(value: "sms", label: "SMS")
      group.with_option(value: "push", label: "Push notification")
    end
  end

  def without_selection
    render LightningUiKit::RadioGroupComponent.new(name: :color, label: "Favorite color") do |group|
      group.with_option(value: "red", label: "Red")
      group.with_option(value: "blue", label: "Blue")
      group.with_option(value: "green", label: "Green")
    end
  end
end
