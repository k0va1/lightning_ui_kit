module LightningUiKit
  # Controller mixin for server-side table sorting:
  #
  #   class OrdersController < ApplicationController
  #     include LightningUiKit::Sortable
  #
  #     def index
  #       @orders = lui_sort(Order.all, allowed: %w[number total created_at], default: :created_at)
  #     end
  #   end
  module Sortable
    private

    def lui_sort(scope, **options)
      LightningUiKit::Sorting.apply(scope, params, **options)
    end
  end
end
