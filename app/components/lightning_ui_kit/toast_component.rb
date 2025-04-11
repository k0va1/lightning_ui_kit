# frozen_string_literal: true

class LightningUiKit::ToastComponent < LightningUiKit::BaseComponent
  def initialize(autodismiss: true, dismiss_after: 3000)
    @autodismiss = autodismiss
    @dismiss_after = dismiss_after
  end
end
