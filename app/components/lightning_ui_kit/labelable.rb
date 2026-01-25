module LightningUiKit
  module Labelable
    # Returns the effective label text.
    # - If @label is explicitly false, returns nil (no label)
    # - If @label is a string, returns that string
    # - If @label is nil (not provided), generates a label from @name
    def effective_label
      return nil if @label == false

      @label.presence || humanized_name
    end

    # Returns true if a label should be rendered
    def render_label?
      @label != false
    end

    private

    def humanized_name
      @name.to_s.humanize
    end
  end
end
