module LightningUiKit
  # Server-side sorting for TableComponent. Reads the sort/direction request
  # params, validates them against a whitelist, and orders the given scope —
  # an ActiveRecord relation (via #order) or a plain enumerable (via #sort_by).
  #
  #   @orders = LightningUiKit::Sorting.apply(Order.all, params, allowed: %w[number total], default: :number)
  #
  # Controllers can use the Sortable concern for a shorter form:
  #
  #   include LightningUiKit::Sortable
  #   @orders = lui_sort(Order.all, allowed: %w[number total], default: :number)
  module Sorting
    DIRECTIONS = %w[asc desc].freeze

    module_function

    def apply(scope, params, allowed:, default: nil, default_direction: :asc, sort_param: :sort, direction_param: :direction)
      allowed = Array(allowed).map(&:to_s)
      key = params[sort_param].to_s
      key = default.to_s unless allowed.include?(key)
      return scope if key.empty?

      direction = params[direction_param].to_s
      direction = default_direction.to_s unless DIRECTIONS.include?(direction)

      if scope.respond_to?(:order)
        scope.order(key => direction.to_sym)
      else
        sorted = scope.sort_by { |row| sort_value(row, key) }
        (direction == "desc") ? sorted.reverse : sorted
      end
    end

    # Hash lookup must come before respond_to? — Hash responds to methods
    # like #count that would shadow same-named keys.
    def sort_value(row, key)
      if row.is_a?(Hash)
        row[key] || row[key.to_sym]
      elsif row.respond_to?(key)
        row.public_send(key)
      elsif row.respond_to?(:[])
        row[key] || row[key.to_sym]
      end
    end
  end
end
