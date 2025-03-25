module LightningUiKit
  module Errors
    def has_errors?
      error_messages.present?
    end

    # TODO: simplify this code
    def error_messages
      return @error if @error.present?
      return @error_messages if @error_messages.present?

      if @form.present?
        @error_messages = @form.object.errors.full_messages_for(@name.to_sym)
        if @error_messages.blank?
          @error_messages = infer_errors_from_association
        end
      end
      @error_messages = @error_messages&.to_a&.join(". ")
    end

    def infer_errors_from_association
      association = if @name.to_s.end_with?("_ids")
        @form.object.class.reflect_on_association(@name.to_s.chomp("_ids").pluralize.to_sym)
      else
        @form.object.class.reflect_on_all_associations.find do |a|
          a.macro == :belongs_to && a.foreign_key.to_s == @name.to_s
        end
      end
      @form.object.errors.full_messages_for(association&.name&.to_sym) if association
    end
  end
end
