class BadgeComponentPreview < Lookbook::Preview
  def default
    render LightningUi::BadgeComponent.new do
      "Badge"
    end
  end

  # @group Statuses
  def success
    render LightningUi::BadgeComponent.new(status: :success) do
      "Success"
    end
  end

  def warning
    render LightningUi::BadgeComponent.new(status: :warning) do
      "Warning"
    end
  end

  def error
    render LightningUi::BadgeComponent.new(status: :error) do
      "Error"
    end
  end
  # @endgroup

  # @group Progress
  def complete
    render LightningUi::BadgeComponent.new(status: :success, progress: :complete) do
      "Complete"
    end
  end

  def partially_complete
    render LightningUi::BadgeComponent.new(status: :success, progress: :partialy_complete) do
      "Partially Complete"
    end
  end

  def incomplete
    render LightningUi::BadgeComponent.new(status: :success, progress: :incomplete) do
      "Incomplete"
    end
  end

  def default_complete
    render LightningUi::BadgeComponent.new(progress: :complete) do
      "Complete"
    end
  end

  def default_partially_complete
    render LightningUi::BadgeComponent.new(progress: :partialy_complete) do
      "Partially Complete"
    end
  end

  def default_incomplete
    render LightningUi::BadgeComponent.new(progress: :incomplete) do
      "Incomplete"
    end
  end

  def warning_complete
    render LightningUi::BadgeComponent.new(status: :warning, progress: :complete) do
      "Complete"
    end
  end

  def warning_partially_complete
    render LightningUi::BadgeComponent.new(status: :warning, progress: :partialy_complete) do
      "Partially Complete"
    end
  end

  def warning_incomplete
    render LightningUi::BadgeComponent.new(status: :warning, progress: :incomplete) do
      "Incomplete"
    end
  end

  def error_complete
    render LightningUi::BadgeComponent.new(status: :error, progress: :complete) do
      "Complete"
    end
  end

  def error_partially_complete
    render LightningUi::BadgeComponent.new(status: :error, progress: :partialy_complete) do
      "Partially Complete"
    end
  end

  def error_incomplete
    render LightningUi::BadgeComponent.new(status: :error, progress: :incomplete) do
      "Incomplete"
    end
  end
  # @endgroup
end
